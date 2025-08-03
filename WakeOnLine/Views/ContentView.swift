import SwiftUI

struct ContentView: View {
    @StateObject private var store = ComputerStore.shared
    @State private var showingAdd = false
    @State private var editingComputer: Computer?

    var body: some View {
        NavigationView {
            List {
                ForEach(store.computers) { computer in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(computer.name).font(.headline)
                            Text(computer.macAddress).font(.caption)
                            Text(computer.ipAddress).font(.caption)
                        }
                        Spacer()
                        Button("Allumer") {
                            store.wake(computer)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        editingComputer = computer
                    }
                }
                .onDelete(perform: store.remove)
            }
            .navigationTitle("Ordinateurs")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAdd = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAdd) {
                AddEditComputerView()
            }
            .sheet(item: $editingComputer) { comp in
                AddEditComputerView(computer: comp)
            }
        }
    }
}

#Preview {
    ContentView()
}
