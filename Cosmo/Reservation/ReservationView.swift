//
//  ReservationView.swift
//
//  Created by D K on 04.12.2024.
//

import SwiftUI

struct ReservationView: View {
    
    init() {
        UIDatePicker.appearance().backgroundColor = UIColor.init(.clear) // changes bg color
        UIDatePicker.appearance().tintColor = UIColor.init(.clear) // changes font color
    }
    
    @Environment(\.dismiss) var dismiss
    @State private var date = Date()
    @State private var time = Date()
    @State private var duration = 1
    @State private var players = 1
    @State private var number = ""
    @State private var room = "PC"
    
    @State private var isAlerted = false
    
    var rooms = ["Football", "PC", "Console", "BootCamp"]
    
    
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
                    
                    Text("RESERVATION")
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .black))
                }
                .padding(.horizontal)
                
                ScrollView {
                    VStack {
                        Text("Date")
                            .foregroundStyle(.gray)
                            .frame(width: size().width - 40, alignment: .leading)
                        
                        HStack {
                            Spacer()
                            
                            DatePicker("", selection: $date, in: Date()..., displayedComponents: [.date])
                                .datePickerStyle(.compact)
                                .tint(.white)
                                .foregroundColor(.white)
                                .colorMultiply(.white)
                                .accentColor(.white)
                                .padding(.vertical)
                                .colorScheme(.dark)
                                .frame(width: 150)
                                .padding(.trailing, 30)
                                .background {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(.semiPurple)
                                }
                                .padding(.trailing)
                        }
                    }
                    .padding(.top)
                    
                    VStack {
                        Text("Time")
                            .foregroundStyle(.gray)
                            .frame(width: size().width - 40, alignment: .leading)
                        
                        HStack {
                            Spacer()
                            
                            DatePicker("", selection: $time, in: Date()..., displayedComponents: [.hourAndMinute])
                                .datePickerStyle(.compact)
                                .tint(.white)
                                .foregroundColor(.white)
                                .colorMultiply(.white)
                                .accentColor(.white)
                                .padding(.vertical)
                                .colorScheme(.dark)
                                .frame(width: 80)
                                .padding(.trailing, 10)
                                .background {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(.semiPurple)
                                }
                                .padding(.trailing)
                        }
                    }
                    .padding(.top)
                    
                    VStack {
                        Text("Duration")
                            .foregroundStyle(.gray)
                            .frame(width: size().width - 40, alignment: .leading)
                        
                        HStack {
                            Spacer()
                            
                            Picker("Hour", selection: $duration) {
                                ForEach(1..<13, id: \.self) { hour in
                                    Text("\(hour)")
                                        
                                }
                            }
                            .tint(.white)
                            .padding(10)
                            .background {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.semiPurple)
                            }
                            .padding(.trailing)
                        }
                    }
                    .padding(.top)
                    
                    VStack {
                        Text("Players")
                            .foregroundStyle(.gray)
                            .frame(width: size().width - 40, alignment: .leading)
                        
                        HStack {
                            Spacer()
                            
                            Picker("", selection: $players) {
                                ForEach(1..<13, id: \.self) { hour in
                                    Text("\(hour)")
                                }
                            }
                            .tint(.white)
                            .padding(10)
                            .background {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.semiPurple)
                            }
                            .padding(.trailing)
                        }
                    }
                    .padding(.top)
                    
                    VStack {
                        Text("Room")
                            .foregroundStyle(.gray)
                            .frame(width: size().width - 40, alignment: .leading)
                        
                        HStack {
                            Spacer()
                            
                            Picker("", selection: $players) {
                                ForEach(0..<rooms.count, id: \.self) { index in
                                    Text("\(rooms[index])")
                                }
                            }
                            .tint(.white)
                            .padding(10)
                            .background {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.semiPurple)
                            }
                            .padding(.trailing)
                        }
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
                            .padding(.top, 10)
                    }
                    .padding(.top)
                    
                    Button {
                        
                        StorageManager.shared.saveReserv(date: formattedDate(date), room: room, persons: players, time: formattedTime(time))
                        isAlerted.toggle()
                    } label: {
                        Text("RESERVATION")
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
                    .disabled(number.isEmpty)
                    .opacity(number.isEmpty ? 0.2 : 1)
                }
                .scrollIndicators(.hidden)
            }
        }
        .onAppear {
            if let user = StorageManager.shared.persons.first {
                number = user.number
            }
        }
        .alert("The reserve has been created!", isPresented: $isAlerted) {
            Button {
                dismiss()
            } label: {
                Text("OK")
            }
        } message: {
            Text("You will be contacted by phone to confirm your reservation.")
        }

    }
    
    
    func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        dateFormatter.locale = Locale(identifier: "en_US") // Устанавливаем английский язык
        return dateFormatter.string(from: date)
    }
    
    func formattedTime(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm" // Часы и минуты в 24-часовом формате
        return dateFormatter.string(from: date)
    }
}

#Preview {
    ReservationView()
}
