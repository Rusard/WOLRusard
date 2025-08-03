import Foundation
import WakeOnLineCore

let args = CommandLine.arguments
if args.count < 3 {
    print("Usage: wakeonlan-cli <MAC-ADDRESS> <IP-ADDRESS> [PORT]")
    exit(1)
}
let mac = args[1]
let ip = args[2]
let port: UInt16
if args.count > 3, let p = UInt16(args[3]) {
    port = p
} else {
    port = 9
}
WakeOnLAN.send(mac: mac, ip: ip, port: port)
print("Magic packet sent to \(mac) at \(ip):\(port)")
