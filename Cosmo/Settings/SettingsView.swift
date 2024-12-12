//
//  SettingsView.swift
//
//  Created by D K on 04.12.2024.
//

import SwiftUI
import MessageUI
import StoreKit

struct SettingsView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var isAlertShown = false
    @State var isSuggestionShown = false
    @State var isErrorShown = false
    @State private var isDeleteAlertShown = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.darkPurple)
                .ignoresSafeArea()
            
            VStack {
                Text("SETTINGS")
                    .foregroundColor(.white)
                    .font(.system(size: 28, weight: .black))
                    .frame(width: size().width - 40, alignment: .leading)
                
                ScrollView {
                    
                    VStack {
                        Text("SUPPORT")
                            .foregroundColor(.gray)
                            .frame(width: size().width - 40, alignment: .leading)
                        
                        Button {
                            if MFMailComposeViewController.canSendMail() {
                                isErrorShown.toggle()
                            } else {
                                isAlertShown.toggle()
                            }
                        } label: {
                            Text("Report a bug")
                                .foregroundStyle(.white)
                                .frame(width: size().width - 40)
                                .padding(.vertical)
                                .background {
                                    RoundedRectangle(cornerRadius: 24)
                                        .foregroundColor(.semiPurple)
                                }
                        }
                        .sheet(isPresented: $isErrorShown) {
                            MailComposeView(isShowing: $isErrorShown, subject: "Bug Message", recipientEmail: "FusionPeakClub@icloud.com", textBody: "")
                        }
                        
                        Button {
                            if MFMailComposeViewController.canSendMail() {
                                isSuggestionShown.toggle()
                            } else {
                                isAlertShown.toggle()
                            }
                        } label: {
                            Text("Suggest improvement")
                                .foregroundStyle(.white)
                                .frame(width: size().width - 40)
                                .padding(.vertical)
                                .background {
                                    RoundedRectangle(cornerRadius: 24)
                                        .foregroundColor(.semiPurple)
                                }
                        }
                        .padding(.top, 10)
                        .sheet(isPresented: $isSuggestionShown) {
                            MailComposeView(isShowing: $isSuggestionShown, subject: "Suggest Message", recipientEmail: "FusionPeakClub@icloud.com", textBody: "")
                        }
                    }
                    
                    VStack {
                        Text("USAGE")
                            .foregroundColor(.gray)
                            .frame(width: size().width - 40, alignment: .leading)
                            .padding(.top)
                        Button {
                            openPrivacyPolicy()
                        } label: {
                            Text("Privacy Policy")
                                .foregroundStyle(.white)
                                .frame(width: size().width - 40)
                                .padding(.vertical)
                                .background {
                                    RoundedRectangle(cornerRadius: 24)
                                        .foregroundColor(.semiPurple)
                                }
                        }
                    }
                    
                    VStack {
                        Text("ACCOUNT")
                            .foregroundColor(.gray)
                            .frame(width: size().width - 40, alignment: .leading)
                            .padding(.top)
                        
                        Button {
                            authViewModel.signOut()
                        } label: {
                            Text("Leave account")
                                .foregroundStyle(.white)
                                .frame(width: size().width - 40)
                                .padding(.vertical)
                                .background {
                                    RoundedRectangle(cornerRadius: 24)
                                        .foregroundColor(.semiPurple)
                                }
                        }
                        
                        if authViewModel.currentuser != nil {
                            Button {
                                isDeleteAlertShown.toggle()
                            } label: {
                                Text("Delete account")
                                    .foregroundStyle(.red)
                                    .frame(width: size().width - 40)
                                    .padding(.vertical)
                                    .background {
                                        RoundedRectangle(cornerRadius: 24)
                                            .foregroundColor(.semiPurple)
                                    }
                            }
                            .padding(.top, 10)
                        }
                    }
                    .alert("Are you sure you want to delete your account?", isPresented: $isDeleteAlertShown) {
                        Button {
                            authViewModel.deleteUserAccount { result in
                                switch result {
                                case .success():
                                    print("Account deleted successfully.")
                                    authViewModel.userSession = nil
                                    authViewModel.currentuser = nil
                                case .failure(let error):
                                    print("ERROR DELELETING: \(error.localizedDescription)")
                                }
                            }
                        } label: {
                            Text("Yes")
                        }
                        
                        Button {
                            isDeleteAlertShown.toggle()
                        } label: {
                            Text("No")
                        }
                    } message: {
                        Text("To access your reserves you will need to create a new account.")
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .alert("Unable to send email", isPresented: $isAlertShown) {
            Button {
                isAlertShown.toggle()
            } label: {
                Text("Ok")
            }
        } message: {
            Text("Your device does not have a mail client configured. Please configure your mail or contact support on our website.")
        }
    }
    
    func openPrivacyPolicy() {
        if let url = URL(string: "https://sites.google.com/view/fusionpeak/privacy-policy") {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    SettingsView()
}


struct MailComposeView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    let subject: String
    let recipientEmail: String
    let textBody: String
    var onComplete: ((MFMailComposeResult, Error?) -> Void)?
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposer = MFMailComposeViewController()
        mailComposer.setSubject(subject)
        mailComposer.setToRecipients([recipientEmail])
        mailComposer.setMessageBody(textBody, isHTML: false)
        mailComposer.mailComposeDelegate = context.coordinator
        return mailComposer
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let parent: MailComposeView
        
        init(_ parent: MailComposeView) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.isShowing = false
            parent.onComplete?(result, error)
        }
    }
}
