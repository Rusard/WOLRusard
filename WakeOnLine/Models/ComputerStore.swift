import Foundation
import Combine

final class ComputerStore: ObservableObject {
    static let shared = ComputerStore()

    @Published var computers: [Computer] = [] {
        didSet { save() }
    }

    private let defaults: UserDefaults
    private let key = "computers"

    private init() {
        defaults = UserDefaults(suiteName: "group.wakeonline") ?? .standard
        load()
    }

    private func load() {
        guard let data = defaults.data(forKey: key) else { return }
        do {
            computers = try JSONDecoder().decode([Computer].self, from: data)
        } catch {
            print("Failed to decode computers: \(error)")
        }
    }

    private func save() {
        do {
            let data = try JSONEncoder().encode(computers)
            defaults.set(data, forKey: key)
        } catch {
            print("Failed to encode computers: \(error)")
        }
    }

    func add(_ computer: Computer) {
        computers.append(computer)
    }

    func update(_ computer: Computer) {
        if let idx = computers.firstIndex(where: { $0.id == computer.id }) {
            computers[idx] = computer
        }
    }

    func remove(at offsets: IndexSet) {
        computers.remove(atOffsets: offsets)
    }

    func wake(_ computer: Computer) {
        WakeOnLAN.send(mac: computer.macAddress, ip: computer.ipAddress)
    }
}
