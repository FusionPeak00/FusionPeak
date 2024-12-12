//
//  LogInView.swift
//
//  Created by D K on 04.12.2024.
//

import SwiftUI

struct LogInView: View {
    @ObservedObject var viewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var isAlerted = false
    @State private var isSwitched = true
    @State private var isProgressShown = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.darkPurple)
                    .ignoresSafeArea()
                
                VStack {
                    Image("cosmo1")
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
                    
                    Button {
                        Task {
                            try await viewModel.signIn(email: email, password: password)
                        }
                        withAnimation {
                            isAlerted.toggle()
                        }
                    } label: {
                        Text("LOG IN")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                    }
                    .padding(20)
                    .frame(width: size().width - 60)
                    .background {
                        RoundedRectangle(cornerRadius: 36)
                            .foregroundColor(.lightPurple)
                    }
                    .padding(.top, 40)
                    
                    Button {
                        Task {
                            await viewModel.signInAnonymously()
                        }
                        
                        withAnimation {
                            isAlerted.toggle()
                        }
                    } label: {
                        Text("Log In without registration").underline()
                            .foregroundStyle(.white)
                    }
                    .padding(.top, 30)
                    
                    NavigationLink {
                        RegistrationView(viewModel: viewModel).navigationBarBackButtonHidden()
                    } label: {
                        Text("You don't have an account yet?")
                            .foregroundColor(.white)
                    }
                    .padding(.top, 40)
                    
                    Spacer()

                }
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
                                    Text("Incorrect email or password.")
                                        .foregroundStyle(.black)
                                        .font(.system(size: 24, weight: .semibold, design: .monospaced))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                                    
                                    Button {
                                        withAnimation {
                                            isAlerted = false
                                            isProgressShown = true
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

//#Preview {
//    LogInView()
//}
