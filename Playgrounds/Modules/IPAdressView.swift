//
//  IPAdressView.swift
//  Playgrounds
//
//  Created by Madoka Suzuki on 2025/12/24.
//

import SwiftUI

struct IPAdressView: View {
    @State var globalIPv4: String?
    @State var globalIPv6: String?
    
    var body: some View {
        List {
            HStack {
                Text("Loacl IP Adress v4")
                Spacer()
                Text(getLocalIPv4Address() ?? "not found")
                    .foregroundStyle(.secondary)
                    .textSelection(.enabled)
            }
            HStack {
                Text("Global IP Adress v4")
                Spacer()
                Text(globalIPv4 ?? "not found")
                    .foregroundStyle(.secondary)
                    .textSelection(.enabled)
            }
            HStack {
                Text("Global IP Adress v6")
                Spacer()
                Text(globalIPv6 ?? "not found")
                    .foregroundStyle(.secondary)
                    .textSelection(.enabled)
            }
        }
        .navigationTitle("IP Adress")
        .onAppear {
            Task {
                do {
                    globalIPv4 = try await fetchGlobalIPv4Adress()
                    globalIPv6 = try await fetchGlobalIPv6Adress()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func getLocalIPv4Address() -> String? {
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        defer { freeifaddrs(ifaddr) }
        
        let preferredIfNames = ["en0", "pdp_ip0"] // Wi-Fi, Cellular
        
        var best: String?
        var ptr = ifaddr
        
        while ptr != nil {
            let interface = ptr!.pointee
            
            guard let sa = interface.ifa_addr else {
                ptr = interface.ifa_next
                continue
            }
            
            if sa.pointee.sa_family == UInt8(AF_INET) { // IPv4
                let name = String(cString: interface.ifa_name)
                if preferredIfNames.contains(name) {
                    var addr = sa.pointee
                    var host = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(
                        &addr,
                        socklen_t(sa.pointee.sa_len),
                        &host,
                        socklen_t(host.count),
                        nil,
                        0,
                        NI_NUMERICHOST
                    )
                    best = String(cString: host)
                    // en0 を優先したいなら en0 を見つけたら即 return
                    if name == "en0" { return best }
                }
            }
            
            ptr = interface.ifa_next
        }
        
        return best
    }
    
    
    func fetchGlobalIPv4Adress() async throws -> String {
        let url = URL(string: "https://api.ipify.org")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return String(decoding: data, as: UTF8.self)
    }
    
    func fetchGlobalIPv6Adress() async throws -> String {
        let url = URL(string: "https://api64.ipify.org")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return String(decoding: data, as: UTF8.self)
    }
}

#Preview {
    IPAdressView()
}
