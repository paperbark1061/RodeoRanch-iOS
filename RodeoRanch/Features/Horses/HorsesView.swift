import SwiftUI

struct HorsesView: View {
    @State private var showAddHorse = false
    @State private var selectedHorse: Horse?
    @State private var horses: [Horse] = MockData.horses

    var body: some View {
        NavigationStack {
            List(horses) { horse in
                Button { selectedHorse = horse } label: {
                    HorseRow(horse: horse)
                }
                .listRowBackground(Color.white)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("My Horses")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { showAddHorse = true } label: {
                        Image(systemName: "plus").foregroundColor(.rrNavy)
                    }
                }
            }
            .sheet(isPresented: $showAddHorse) { AddHorseView(horses: $horses) }
            .sheet(item: $selectedHorse)        { HorseDetailView(horse: $0) }
        }
    }
}

struct HorseRow: View {
    let horse: Horse
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle().fill(Color.rrNavy.opacity(0.10))
                HorseIcon(size: 22, color: .rrNavy)
            }
            .frame(width: 44, height: 44)

            VStack(alignment: .leading, spacing: 4) {
                Text(horse.name).font(.rrTitle3).foregroundColor(.rrTextPrimary)
                HStack(spacing: 8) {
                    if let breed = horse.breed  { Text(breed).font(.rrCaption) }
                    Text(horse.sex.displayName).font(.rrCaption)
                    if let year = horse.yearOfBirth { Text(String(year)).font(.rrCaption) }
                }
                .foregroundColor(.rrTextSecondary)
            }
            Spacer()
            if let reg = horse.registrationNumber {
                Text(reg).font(.rrCaption).foregroundColor(.rrGold)
            }
        }
        .padding(.vertical, 4)
    }
}

struct HorseDetailView: View {
    let horse: Horse
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    LabeledContent("Name",   value: horse.name)
                    LabeledContent("Sex",    value: horse.sex.displayName)
                    if let breed  = horse.breed  { LabeledContent("Breed",  value: breed) }
                    if let colour = horse.colour { LabeledContent("Colour", value: colour) }
                    if let year   = horse.yearOfBirth { LabeledContent("Year", value: String(year)) }
                }
                if let reg = horse.registrationNumber {
                    Section("Registration") { LabeledContent("Number", value: reg) }
                }
                if let notes = horse.notes {
                    Section("Notes") {
                        Text(notes).font(.rrBodySm).foregroundColor(.rrTextSecondary)
                    }
                }
            }
            .navigationTitle(horse.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }.foregroundColor(.rrNavy)
                }
            }
        }
    }
}

struct AddHorseView: View {
    @Binding var horses: [Horse]
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var breed = ""
    @State private var colour = ""
    @State private var sex: HorseSex = .gelding
    @State private var yearOfBirth = ""
    @State private var regNumber = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Name", text: $name)
                    Picker("Sex", selection: $sex) {
                        ForEach(HorseSex.allCases, id: \.self) { Text($0.displayName).tag($0) }
                    }
                    TextField("Breed",         text: $breed)
                    TextField("Colour",         text: $colour)
                    TextField("Year of birth",  text: $yearOfBirth).keyboardType(.numberPad)
                }
                Section("Registration") {
                    TextField("Registration number (optional)", text: $regNumber)
                }
                Section {
                    RRButton(title: "Save horse") {
                        let h = Horse(
                            id: UUID().uuidString, name: name,
                            registrationNumber: regNumber.isEmpty ? nil : regNumber,
                            breed: breed.isEmpty ? nil : breed,
                            colour: colour.isEmpty ? nil : colour,
                            sex: sex, yearOfBirth: Int(yearOfBirth),
                            ownerId: MockData.currentUser.id,
                            ownerName: MockData.currentUser.fullName,
                            notes: nil, isActive: true, photoURL: nil
                        )
                        horses.append(h)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                    .listRowInsets(EdgeInsets())
                }
            }
            .navigationTitle("Add horse")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }.foregroundColor(.rrNavy)
                }
            }
        }
    }
}
