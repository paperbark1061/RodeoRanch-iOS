import SwiftUI

struct EventEntryFormView: View {
    let event: Event
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authState: AuthState

    @State private var selectedHorse: Horse? = MockData.horses.first
    @State private var selectedDivision = "Open"
    @State private var teamMate1 = ""
    @State private var teamMate2 = ""
    @State private var agreedToTerms = false
    @State private var isSubmitting = false
    @State private var submitted = false

    private var divisions: [String] { ["Open", "Non-Pro", "Youth", "Senior"] }
    private var needsTeam: Bool { event.discipline == .teamPenning || event.discipline == .sorting }

    var body: some View {
        NavigationStack {
            if submitted {
                EntryConfirmedView(event: event)
            } else {
                Form {
                    Section("Event") {
                        LabeledContent("Event", value: event.name)
                        LabeledContent("Discipline", value: event.discipline.displayName)
                        LabeledContent("Fee", value: String(format: "$%.2f", event.entryFee))
                    }

                    Section("Your horse") {
                        Picker("Horse", selection: $selectedHorse) {
                            ForEach(MockData.horses) { horse in
                                Text(horse.name).tag(Optional(horse))
                            }
                        }
                    }

                    Section("Division") {
                        Picker("Division", selection: $selectedDivision) {
                            ForEach(divisions, id: \.self) { Text($0) }
                        }
                    }

                    if needsTeam {
                        Section("Team mates") {
                            TextField("Team mate 1 name / member #", text: $teamMate1)
                            TextField("Team mate 2 name / member # (optional)", text: $teamMate2)
                        }
                    }

                    Section("Payment") {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Payment is processed securely via Stripe.")
                                .font(.rrBodySm)
                                .foregroundColor(.secondary)
                            Text("Saved cards and Apple Pay are supported.")
                                .font(.rrCaption)
                                .foregroundColor(.secondary)
                        }
                        Toggle("I agree to the entry conditions", isOn: $agreedToTerms)
                    }

                    Section {
                        RRButton(
                            title: String(format: "Pay & enter — $%.2f", event.entryFee),
                            icon: "creditcard.fill",
                            isLoading: isSubmitting
                        ) {
                            submitEntry()
                        }
                        .disabled(!agreedToTerms)
                        .listRowInsets(EdgeInsets())
                    }
                }
                .navigationTitle("Enter event")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { dismiss() }
                    }
                }
            }
        }
    }

    private func submitEntry() {
        isSubmitting = true
        Task {
            try? await Task.sleep(nanoseconds: 1_200_000_000)
            await MainActor.run {
                isSubmitting = false
                submitted = true
            }
        }
    }
}

struct EntryConfirmedView: View {
    let event: Event
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 72))
                .foregroundColor(.rrSuccess)
            Text("Entry confirmed!").font(.rrTitle)
            Text(event.name)
                .font(.rrBody)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            Text("You\'ll receive a notification when the draw is released.")
                .font(.rrBodySm)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            RRButton(title: "Done") { dismiss() }
                .padding(.horizontal, 32)
            Spacer()
        }
    }
}
