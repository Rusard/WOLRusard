import Foundation
import Network

enum WakeOnLAN {
    static func send(mac: String, ip: String, port: UInt16 = 9) {
        guard let macBytes = parse(mac: mac) else { return }
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
    }

    private static func parse(mac: String) -> [UInt8]? {
        let parts = mac.split(separator: ":")
        guard parts.count == 6 else { return nil }
        return parts.compactMap { UInt8($0, radix: 16) }
    }
}
