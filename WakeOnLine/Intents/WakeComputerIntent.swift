import AppIntents
import Foundation

struct ComputerEntity: AppEntity {
    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Ordinateur")
    var id: UUID
    var name: String
    var macAddress: String
    var ipAddress: String

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: name)
    }

    static var defaultQuery = ComputerQuery()
}

struct ComputerQuery: EntityQuery {
    func entities(for identifiers: [UUID]) async throws -> [ComputerEntity] {
        let comps = ComputerStore.shared.computers.filter { identifiers.contains($0.id) }
        return comps.map { $0.toEntity() }
    }

    func suggestedEntities() async throws -> [ComputerEntity] {
        ComputerStore.shared.computers.map { $0.toEntity() }
    }
}

extension Computer {
    func toEntity() -> ComputerEntity {
        ComputerEntity(id: id, name: name, macAddress: macAddress, ipAddress: ipAddress)
    }
}

struct WakeComputerIntent: AppIntent {
    static var title: LocalizedStringResource = "Allume un ordinateur"

    @Parameter(title: "Ordinateur")
    var computer: ComputerEntity

    static var parameterSummary: some ParameterSummary {
        Summary("Allume \(\.$computer)")
    }

    func perform() async throws -> some IntentResult {
        let store = ComputerStore.shared
        if let comp = store.computers.first(where: { $0.id == computer.id }) {
            store.wake(comp)
        }
        return .result()
    }
}

struct WakeShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        [
            AppShortcut(intent: WakeComputerIntent(), phrases: [
                "Allume \\(.applicationName) \\(.computer)",
                "Allume \\(.computer)"
            ])
        ]
    }
}
