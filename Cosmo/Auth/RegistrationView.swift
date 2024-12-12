//
//  RegistrationView.swift
//
//  Created by D K on 04.12.2024.
//

import SwiftUI

extension RegistrationView: AuthViewModelProtocol {
    var isValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
    }
}


struct RegistrationView: View {
    @ObservedObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isAlerted = false
    @State private var isNotificationShown = false
    @State private var isProgressShown = true
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.darkPurple)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.system(size: 28, weight: .black))
                    }
                    
                    Spacer()
                    
                    Text("REGISTRATION")
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .black))
                }
                .padding(.horizontal)
                
                ScrollView {
                    VStack {
                        Image("cosmo2")
                            .resizable()
                            .frame(width: 200, height: 200)
                        
                        TextField("", text: $email, prompt: Text("Email...").foregroundColor(.white))
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .padding(20)
                            .background {
                                Rectangle()
                                    .foregroundColor(.semiPurple)
                            }
                            .cornerRadius(36)
                            .padding(.horizontal)
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                            .tint(.white)
                            .padding(.vertical)
                        
                        SecureField("", text: $password, prompt: Text("Password...").foregroundColor(.white))
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .padding(20)
                            .background {
                                Rectangle()
                                    .foregroundColor(.semiPurple)
                            }
                            .cornerRadius(36)
                            .padding(.horizontal)
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                            .tint(.white)
                        
                        SecureField("", text: $confirmPassword, prompt: Text("Confirm Password...").foregroundColor(.white))
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .padding(20)
                            .background {
                                Rectangle()
                                    .foregroundColor(.semiPurple)
                            }
                            .cornerRadius(36)
                            .padding(.horizontal)
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                            .tint(.white)
                            .padding(.vertical)
                        
                        Button {
                            if isValid {
                                Task {
                                    try await viewModel.createUser(withEmail: email, password: password)
                                }
                                withAnimation {
                                    isAlerted.toggle()
                                }
                            } else {
                                withAnimation {
                                    isAlerted.toggle()
                                }
                                isNotificationShown.toggle()
                            }
                        } label: {
                            Text("CONFIRM")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .bold))
                        }
                        .padding(20)
                        .frame(width: size().width - 60)
                        .background {
                            RoundedRectangle(cornerRadius: 36)
                                .foregroundColor(.lightPurple)
                        }
                        .padding(.top, 20)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .overlay {
            if isAlerted {
                ZStack {
                    Rectangle()
                        .ignoresSafeArea()
                        .foregroundColor(.white.opacity(0.1))
                    
                    if isProgressShown {
                        Rectangle()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.white.opacity(0.9))
                            .blur(radius: 5)
                            .cornerRadius(24)
                            .shadow(color: .white.opacity(0.5), radius: 5)
                            .overlay {
                                ProgressView()
                                    .tint(.purple)
                                    .controlSize(.large)
                            }
                    } else {
                        Rectangle()
                            .frame(width: 290, height: 250)
                            .foregroundColor(.white.opacity(0.9))
                            .blur(radius: 5)
                            .cornerRadius(24)
                            .shadow(color: .white.opacity(0.5), radius: 5)
                            .overlay {
                                VStack {
                                    Text("Incorrect data or user with this email already exists.")
                                        .foregroundStyle(.black)
                                        .font(.system(size: 24, weight: .semibold, design: .monospaced))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                                    
                                    Button {
                                        withAnimation {
                                            isAlerted = false
                                            isProgressShown = true
                                            
                                            email = ""
                                            password = ""
                                            confirmPassword = ""
                                        }
                                    } label: {
                                       Image(systemName: "xmark")
                                            .frame(width: 40, height: 40)
                                            .foregroundColor(.black)
                                            .bold()
                                    }
                                    .padding(.top, 30)
                                }
                               
                            }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        isProgressShown = false
                    }
                }
            }
        }
    }
}

#Preview {
    RegistrationView(viewModel: AuthViewModel())
}
