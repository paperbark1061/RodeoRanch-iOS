import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var region: Region = .nsw

    var body: some View {
        NavigationStack {
            Form {
                Section("Personal details") {
                    TextField("First name", text: $firstName)
                    TextField("Last name", text: $lastName)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    SecureField("Password", text: $password)
                }

                Section("Region") {
                    Picker("Region", selection: $region) {
                        ForEach(Region.allCases, id: \.self) { r in
                            Text(r.displayName).tag(r)
                        }
                    }
                }

                Section {
                    RRButton(title: "Create account", icon: "person.badge.plus") {
                        // TODO: call register endpoint
                        dismiss()
                    }
                    .listRowInsets(EdgeInsets())
                }
            }
            .navigationTitle("Register")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
