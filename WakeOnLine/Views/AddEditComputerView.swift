import SwiftUI

struct AddEditComputerView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var store = ComputerStore.shared

    @State private var name: String = ""
    @State private var macAddress: String = ""
    @State private var ipAddress: String = ""

    var computer: Computer?

    init(computer: Computer? = nil) {
        self.computer = computer
        _name = State(initialValue: computer?.name ?? "")
        _macAddress = State(initialValue: computer?.macAddress ?? "")
        _ipAddress = State(initialValue: computer?.ipAddress ?? "")
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Nom", text: $name)
                TextField("Adresse MAC", text: $macAddress)
                TextField("Adresse IP", text: $ipAddress)
                    .keyboardType(.numbersAndPunctuation)
            }
            .navigationTitle(computer == nil ? "Ajouter" : "Modifier")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Enregistrer") {
                        let comp = Computer(id: computer?.id ?? UUID(), name: name, macAddress: macAddress, ipAddress: ipAddress)
                        if computer == nil {
                            store.add(comp)
                        } else {
                            store.update(comp)
                        }
                        dismiss()
                    }
                    .disabled(name.isEmpty || macAddress.isEmpty || ipAddress.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddEditComputerView()
}
