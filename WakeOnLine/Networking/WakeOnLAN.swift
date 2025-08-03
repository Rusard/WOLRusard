import Foundation
#if canImport(Network)
import Network
#else
#if canImport(Darwin)
import Darwin
#else
import Glibc
#endif
#endif

public enum WakeOnLAN {
    public static func send(mac: String, ip: String, port: UInt16 = 9) {
        guard let macBytes = parse(mac: mac) else { return }

        #if canImport(Network)
        var packet = Data(repeating: 0xFF, count: 6)
        for _ in 0..<16 {
            packet.append(contentsOf: macBytes)
        }
        let host = NWEndpoint.Host(ip)
        let port = NWEndpoint.Port(rawValue: port)!
        let connection = NWConnection(host: host, port: port, using: .udp)
        connection.stateUpdateHandler = { state in
            if case .ready = state {
                connection.send(content: packet, completion: .contentProcessed { _ in
                    connection.cancel()
                })
            }
        }
        connection.start(queue: .global())
        #else
        var packet = [UInt8](repeating: 0xFF, count: 6)
        for _ in 0..<16 {
            packet.append(contentsOf: macBytes)
        }
        #if os(Linux)
        let sock = socket(AF_INET, Int32(SOCK_DGRAM.rawValue), Int32(IPPROTO_UDP))
        #else
        let sock = socket(AF_INET, Int32(SOCK_DGRAM), Int32(IPPROTO_UDP))
        #endif
        guard sock >= 0 else { return }
        var addr = sockaddr_in()
        addr.sin_family = sa_family_t(AF_INET)
        addr.sin_port = port.bigEndian
        _ = ip.withCString { inet_pton(AF_INET, $0, &addr.sin_addr) }
        _ = packet.withUnsafeBytes { ptr in
            withUnsafePointer(to: &addr) { adr in
                adr.withMemoryRebound(to: sockaddr.self, capacity: 1) { sa in
                    sendto(sock, ptr.baseAddress, ptr.count, 0, sa, socklen_t(MemoryLayout<sockaddr_in>.size))
                }
            }
        }
        close(sock)
        #endif
    }

    private static func parse(mac: String) -> [UInt8]? {
        let parts = mac.split(separator: ":")
        guard parts.count == 6 else { return nil }
        return parts.compactMap { UInt8($0, radix: 16) }
    }
}
