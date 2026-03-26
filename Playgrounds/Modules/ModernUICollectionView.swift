//
//  ModernUICollectionView.swift
//  Playgrounds
//
//  Created by Madoka Suzuki on 2026/03/24.
//

import SwiftUI
import Combine

class ModernUICollectionViewModel: ObservableObject {
    @Published var items: [String] = ["アイテム 1", "アイテム 2", "アイテム 3"]
    @Published var isDragging: Bool = false
    
    func addItem() {
        let newItem = "追加アイテム \(Int.random(in: 100...999))"
        items.append(newItem)
    }
    
    func deleteItem(_ item: String) -> Bool {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
            return true
        }
        
        return false
    }
}

struct ModernUICollectionView: View {
    @StateObject var vm = ModernUICollectionViewModel()
    
    var body: some View {
        ZStack {
            ModernUICollectionViewRepresentable(
                items: vm.items,
                isDragging: $vm.isDragging,
                onDelete: { itemToDelete in
                    vm.deleteItem(itemToDelete)
                }
            )
            .ignoresSafeArea()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("isDragging: \(vm.isDragging.description)")
            }
            ToolbarItem(placement: .bottomBar) {
                Button("追加") {
                    vm.addItem()
                }
            }
        }
    }
}


struct ModernUICollectionViewRepresentable: UIViewRepresentable {
    var items: [String]
    @Binding var isDragging: Bool
    var onDelete: ((String) -> Bool)
    
    class Coordinator: NSObject, UICollectionViewDelegate, UIScrollViewDelegate {
        var parent: ModernUICollectionViewRepresentable
        var dataSource: UICollectionViewDiffableDataSource<Int, String>?
        var onDelete: ((String) -> Bool)?
        
        init(parent: ModernUICollectionViewRepresentable) {
            self.parent = parent
        }
        
        func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            DispatchQueue.main.async {
                self.parent.isDragging = true
            }
        }
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            DispatchQueue.main.async {
                self.parent.isDragging = false
            }
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            
            configuration.trailingSwipeActionsConfigurationProvider = { indexPath in
                guard let dataSource = context.coordinator.dataSource,
                      let item = dataSource.itemIdentifier(for: indexPath) else { return nil }
                
                let deleteAction = UIContextualAction(style: .destructive, title: "削除") { action, view, completion in
                    var snapshot = dataSource.snapshot()
                    snapshot.deleteItems([item])
                    dataSource.apply(snapshot, animatingDifferences: true)
                    _ = context.coordinator.onDelete?(item)
                    completion(false)
                }
                
                return UISwipeActionsConfiguration(actions: [deleteAction])
            }
            
            let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
            return section
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String> { cell, indexPath, itemIdentifier in
            cell.contentConfiguration = UIHostingConfiguration {
                HStack {
                    Image(systemName: "star")
                        .foregroundStyle(.yellow)
                    Text(itemIdentifier)
                    Spacer()
                }
            }
        }
        
        let dataSource = UICollectionViewDiffableDataSource<Int, String>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        context.coordinator.dataSource = dataSource
        collectionView.delegate = context.coordinator
        
        return collectionView
    }
    
    func updateUIView(_ collectionView: UICollectionView, context: Context) {
        context.coordinator.onDelete = onDelete
        
        guard let dataSource = context.coordinator.dataSource else { return }
        let currentItems = dataSource.snapshot().itemIdentifiers
        if currentItems == items {
            return
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

#Preview {
    NavigationStack {
        ModernUICollectionView()
    }
}
