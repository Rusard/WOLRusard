import Foundation

struct Computer: Identifiable, Codable, Hashable {
    var id: UUID
    var name: String
    var macAddress: String
    var ipAddress: String

    init(id: UUID = UUID(), name: String, macAddress: String, ipAddress: String) {
        self.id = id
        self.name = name
        self.macAddress = macAddress
        self.ipAddress = ipAddress
    }
}
