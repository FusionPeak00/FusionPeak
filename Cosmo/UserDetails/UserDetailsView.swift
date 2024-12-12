//
//  UserDetailsView.swift
//
//  Created by D K on 04.12.2024.
//

import SwiftUI

struct UserDetailsView: View {
    
    @Environment(\.dismiss) var dismiss
    var icons = ["cosmo1","cosmo4", "cosmo2", "cosmo3"]
    @State private var currentIndex: Int = 1
    @State private var iconIndex: Int = 1
    @State private var selectedImage = ""
    
    @State private var name = ""
    @State private var surname = ""
    @State private var email = ""
    @State private var birthday = ""
    @State private var number = ""
    
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
                    
                    Text("USER DETAILS")
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .black))
                }
                .padding(.horizontal)
                
                ScrollView {
                    
                    //MARK: - Images
                    ZStack {
                        ForEach(0..<icons.count, id: \.self) { index in
                            Image(icons[index])
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .scaleEffect( currentIndex == index ? 1 : 0.8)
                                .offset(x: CGFloat(index - currentIndex) * size().width / 3 )
                                .opacity(index == iconIndex ? 1 : 0.2)
                        }
                    }
                    .frame(width: size().width)
                    .padding(.top)
                    .gesture(
                        DragGesture()
                            .onEnded({ value in
                                let threshold: CGFloat = 50
                                if value.translation.width > threshold {
                                    withAnimation {
                                        currentIndex = max(0, currentIndex - 1)
                                        iconIndex = currentIndex
                                        selectedImage = icons[iconIndex]
                                    }
                                } else if value.translation.width < -threshold {
                                    withAnimation {
                                        currentIndex = min(icons.count - 1, currentIndex + 1)
                                        iconIndex = currentIndex
                                        selectedImage = icons[iconIndex]
                                        
                                    }
                                }
                            })
                    )
                    
                    //MARK: - Fields
                    
                    VStack {
                        Text("Name")
                            .foregroundStyle(.gray)
                            .frame(width: size().width - 40, alignment: .leading)
                        
                        TextField("", text: $name, prompt: Text("Write your name").foregroundColor(.white))
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.semiPurple)
                            }
                            .padding(.horizontal)
                            .foregroundColor(.white)
                            .tint(.white)
                    }
                    .padding(.top)
                    
                    VStack {
                        Text("Surname")
                            .foregroundStyle(.gray)
                            .frame(width: size().width - 40, alignment: .leading)
                        
                        TextField("", text: $surname, prompt: Text("Write your surname").foregroundColor(.white))
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.semiPurple)
                            }
                            .padding(.horizontal)
                            .foregroundColor(.white)
                            .tint(.white)
                    }
                    .padding(.top)
                    
                    VStack {
                        Text("Email")
                            .foregroundStyle(.gray)
                            .frame(width: size().width - 40, alignment: .leading)
                        
                        TextField("", text: $email, prompt: Text("Write your email").foregroundColor(.white))
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.semiPurple)
                            }
                            .padding(.horizontal)
                            .foregroundColor(.white)
                            .tint(.white)
                    }
                    .padding(.top)
                    
                    VStack {
                        Text("Birthday")
                            .foregroundStyle(.gray)
                            .frame(width: size().width - 40, alignment: .leading)
                        
                        TextField("", text: $birthday, prompt: Text("Write your birthday date").foregroundColor(.white))
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.semiPurple)
                            }
                            .padding(.horizontal)
                            .foregroundColor(.white)
                            .tint(.white)
                    }
                    .padding(.top)
                    
                    VStack {
                        Text("Phone number")
                            .foregroundStyle(.gray)
                            .frame(width: size().width - 40, alignment: .leading)
                        
                        TextField("", text: $number, prompt: Text("Write your phone number").foregroundColor(.white))
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.semiPurple)
                            }
                            .padding(.horizontal)
                            .foregroundColor(.white)
                            .tint(.white)
                    }
                    .padding(.top)
                    
                    Button {
                        let user = RealmPerson()
                        user.name = name
                        user.surname = surname
                        user.email = email
                        user.birthday = birthday
                        user.number = number
                        user.image = selectedImage
                        
                        StorageManager.shared.saveOrUpdateUser(user)
                        
                        dismiss()
                    } label: {
                        Text("SAVE")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                    }
                    .padding(20)
                    .frame(width: size().width - 60)
                    .background {
                        RoundedRectangle(cornerRadius: 18)
                            .foregroundColor(.lightPurple)
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 150)
                }
            }
        }
        .onAppear {
            if let user = StorageManager.shared.getFirstUser() {
                name = user.name
                surname = user.surname
                email = user.email
                birthday = user.birthday
                number = user.number
                selectedImage = user.image
                
                let index = indexOfIcon(named: selectedImage, in: icons)
                currentIndex = index ?? 1
                iconIndex = index ?? 1
                
                print(selectedImage)
            }
        }
    }
    
    func indexOfIcon(named iconName: String, in icons: [String]) -> Int? {
        return icons.firstIndex(of: iconName)
    }
}

#Preview {
    UserDetailsView()
}
