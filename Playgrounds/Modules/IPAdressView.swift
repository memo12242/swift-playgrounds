//
//  IPAdressView.swift
//  Playgrounds
//
//  Created by Madoka Suzuki on 2025/12/24.
//

import SwiftUI

struct IPAdressView: View {
    var body: some View {
        List {
            HStack {
                Text("Loacl IP Adress v4")
                Spacer()
                Text(getLocalIPv4Address() ?? "not found")
                    .foregroundStyle(.secondary)
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
}

#Preview {
    IPAdressView()
}
