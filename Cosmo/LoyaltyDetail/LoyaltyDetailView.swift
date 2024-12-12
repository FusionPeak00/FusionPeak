//
//  LoyaltyDetailView.swift
//
//  Created by D K on 04.12.2024.
//

import SwiftUI

struct LoyaltyDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
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
                    
                    Text("ABOUT LVL")
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .black))
                }
                .padding(.horizontal)
                
                ScrollView {
                    Text("Customers of the FusionPeak Club can progress through various levels based on their engagement and participation in gaming events. \nTo participate in the loyalty program, show the QR code to the manager when paying for services.")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .semibold))
                        .frame(width: size().width - 40)
                    
                    RoundedRectangle(cornerRadius: 24)
                        .frame(width: size().width - 40, height: 150)
                        .foregroundColor(.semiPurple)
                        .overlay {
                            HStack {
                                VStack {
                                    Text("LEVEL")
                                    
                                    Text("1")
                                        .font(.system(size: 58, weight: .black))
                                        
                                }
                                
                                Spacer()
                                
                                VStack {
                                    Text("NEWBIE")
                                    
                                    Text("Enjoy a 5% discount on room rentals starting from just one hour.")
                                        .font(.system(size: 15, weight: .regular))
                                        .frame(width: size().width / 2)
                                        .padding(.top)
                                        
                                }
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                        }
                        .padding(.top)
                    
                    RoundedRectangle(cornerRadius: 24)
                        .frame(width: size().width - 40, height: 180)
                        .foregroundColor(.semiPurple)
                        .overlay {
                            HStack {
                                VStack {
                                    Text("LEVEL")
                                    
                                    Text("2")
                                        .font(.system(size: 58, weight: .black))
                                        
                                }
                                
                                Spacer()
                                
                                VStack {
                                    Text("HARDCORER")
                                    
                                    Text("Get a 10% discount, exclusive access to gaming events, and priority service. Participate in tournaments for a chance to win additional prizes!")
                                        .font(.system(size: 15, weight: .regular))
                                        .frame(width: size().width / 2)
                                        .padding(.top)
                                        
                                }
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                        }
                        .padding(.top)
                    
                    RoundedRectangle(cornerRadius: 24)
                        .frame(width: size().width - 40, height: 220)
                        .foregroundColor(.semiPurple)
                        .overlay {
                            HStack {
                                VStack {
                                    Text("LEVEL")
                                    
                                    Text("3")
                                        .font(.system(size: 58, weight: .black))
                                        
                                }
                                
                                Spacer()
                                
                                VStack {
                                    Text("VIP")
                                    
                                    Text("Enjoy a 15% discount and access to private gaming rooms with an enhanced game selection and higher stakes. Receive exclusive invitations to club events with privileged access and special bonuses.")
                                        .font(.system(size: 15, weight: .regular))
                                        .frame(width: size().width / 2)
                                        .padding(.top)
                                        
                                }
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                        }
                        .padding(.top)
                        .padding(.bottom, 150)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    LoyaltyDetailView()
}
