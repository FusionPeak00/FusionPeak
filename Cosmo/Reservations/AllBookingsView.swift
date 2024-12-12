//
//  AllBookingsView.swift
//
//  Created by D K on 04.12.2024.
//

import SwiftUI

struct AllBookingsView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var reservations: [RealmReservation] = []
    @State private var isReservShown = false
    
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
                    
                    Text("RESERVATIONS")
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .black))
                }
                .padding(.horizontal)
                
                ScrollView {
                    
                    if !reservations.isEmpty {
                        VStack {
                            ForEach(reservations, id: \.id) { reserv in
                                Rectangle()
                                    .frame(width: size().width - 50, height: 100)
                                    .cornerRadius(24)
                                    .foregroundColor(.semiPurple)
                                    .overlay {
                                        HStack {
                                            Text(reserv.date)
                                            
                                            Spacer()
                                            
                                            Text("Persons: \(reserv.persons)")
                                            
                                            Spacer()
                                            
                                            Text(reserv.time)
                                        }
                                        .padding(.horizontal)
                                        .foregroundColor(.white)
                                    }
                            }
                    }
                    } else {
                        VStack {
                            Text("You don't have any reserves yet.")
                                .foregroundColor(.white)
                                .font(.system(size: 32, weight: .ultraLight))
                                .multilineTextAlignment(.center)
                                .padding(.top, 150)
                            
                            VStack {
                                Spacer()
                                
                                Button {
                                    isReservShown.toggle()
                                } label: {
                                    Text("MAKE A RESERVATION")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20, weight: .bold))
                                }
                                .padding(10)
                                .frame(width: size().width - 60)
                                .background {
                                    RoundedRectangle(cornerRadius: 18)
                                        .foregroundColor(.lightPurple)
                                }
                            }
                            .shadow(radius: 10)
                            .padding(.bottom, 70)
                            .padding(.top, 150)
                        }
                        
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .onAppear {
            reservations = Array(StorageManager.shared.reservations)
            print(StorageManager.shared.reservations.count)
        }
        .fullScreenCover(isPresented: $isReservShown) {
            ReservationView()
        }
    }
}

#Preview {
    AllBookingsView()
}
