import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authState: AuthState
    @State private var email = ""
    @State private var password = ""
    @State private var showRegister = false

    var body: some View {
        ZStack {
            Color.rrNavy.ignoresSafeArea()

            VStack(spacing: 0) {
                // Logo / header
                VStack(spacing: 12) {
                    Image(systemName: "star.circle.fill")
                        .font(.system(size: 56))
                        .foregroundColor(.rrGold)

                    Text("RodeoRanch")
                        .font(.rrDisplay)
                        .foregroundColor(.white)

                    Text("Rider & Judge Portal")
                        .font(.rrBodySm)
                        .foregroundColor(.white.opacity(0.6))
                }
                .padding(.top, 60)
                .padding(.bottom, 48)

                // Form card
                VStack(spacing: 20) {
                    VStack(spacing: 12) {
                        RRTextField(label: "Email", text: $email,
                                    placeholder: "you@example.com",
                                    keyboardType: .emailAddress)
                        RRTextField(label: "Password", text: $password,
                                    placeholder: "Your password",
                                    isSecure: true)
                    }

                    if let error = authState.errorMessage {
                        Text(error)
                            .font(.rrCaption)
                            .foregroundColor(.rrDanger)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    RRButton(title: "Sign in", icon: "arrow.right",
                             isLoading: authState.isLoading) {
                        Task { await authState.login(email: email, password: password) }
                    }

                    // Demo note
                    Text("Demo mode: tap Sign in with any credentials")
                        .font(.rrCaption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(24)
                .background(Color(UIColor.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 24)

                // Register
                Button { showRegister = true } label: {
                    Text("Don\'t have an account? ")
                        .foregroundColor(.white.opacity(0.5))
                    + Text("Register")
                        .foregroundColor(.rrGold)
                        .fontWeight(.semibold)
                }
                .font(.rrBodySm)
                .padding(.top, 24)

                Spacer()
            }
        }
        .sheet(isPresented: $showRegister) {
            RegisterView()
        }
    }
}

// MARK: - Reusable text field
struct RRTextField: View {
    let label: String
    @Binding var text: String
    var placeholder: String = ""
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.rrLabel)
                .foregroundColor(.secondary)

            Group {
                if isSecure {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                        .keyboardType(keyboardType)
                        .autocapitalization(.none)
                }
            }
            .padding(12)
            .background(Color(UIColor.tertiarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(UIColor.separator), lineWidth: 0.5)
            )
        }
    }
}
