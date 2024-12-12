//
//  ClubService.swift
//
//  Created by D K on 04.12.2024.
//

import SwiftUI

struct ClubService: View {
    
    @State private var isLVLShown = false
    @State private var isScannerShown = false
    @State private var isBookingsShown = false
    
    @State private var code = "14 13 53 12"
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.darkPurple)
                .ignoresSafeArea()
            
            VStack {
                Text("CLUB SERVICE")
                    .foregroundColor(.white)
                    .font(.system(size: 28, weight: .black))
                    .frame(width: size().width - 40, alignment: .leading)
                
                Rectangle()
                    .foregroundColor(.semiPurple)
                    .frame(width: size().width - 40, height: 220)
                    .cornerRadius(24)
                    .overlay {
                        HStack {
                            VStack(spacing: 2) {
                                Text("Your Code:")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 20, weight: .regular))
                                
                                Text(code)
                                    .foregroundColor(.white)
                                    .font(.system(size: 20, weight: .black))
                                
                                Text("Your LvL:")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 20, weight: .regular))
                                    .padding(.top, 10)
                                
                                Text("1")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20, weight: .black))
                                
                                Button {
                                    isLVLShown.toggle()
                                } label: {
                                    Text("Learn more")
                                        .foregroundStyle(.white)
                                        .padding(10)
                                        .background {
                                            Rectangle()
                                                .foregroundColor(.lightPurple)
                                                .cornerRadius(24)
                                        }
                                }
                                .padding(.top)
                            }
                            
                            Spacer()
                            
                            RoundedRectangle(cornerRadius: 24)
                                .frame(width: 150, height: 150)
                                .foregroundColor(.darkPurple)
                                .overlay {
                                   Image("qr")
                                        .resizable()
                                        .frame(width: 120, height: 120)
                                }
                        }
                        .padding(.horizontal, 15)
                    }
                
                ScrollView {
                    VStack(spacing: 0) {
//                        Button {
//                            isScannerShown.toggle()
//                        } label: {
//                            ZStack {
//                                Rectangle()
//                                    .frame(width: size().width - 40, height: 120)
//                                    .cornerRadius(24)
//                                    .foregroundColor(.semiPurple)
//                                    .padding(.top)
//                                VStack {
//                                    Image("qr-code")
//                                        .resizable()
//                                        .frame(width: 70, height: 70)
//                                        .padding(.top, 10)
//                                    
//                                    Text("QR Scanner")
//                                        .foregroundStyle(.gray)
//                                }
//                                
//                            }
//                        }
                        
                        Button {
                            isBookingsShown.toggle()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: size().width - 40, height: 120)
                                    .cornerRadius(24)
                                    .foregroundColor(.semiPurple)
                                    .padding(.top)
                                VStack {
                                    Image("calendar")
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .padding(.top, 10)
                                    
                                    Text("Your Reservations")
                                        .foregroundStyle(.gray)
                                }
                                
                            }
                        }
                        .padding(.bottom, 150)
                    }
                    
                }
                .scrollIndicators(.hidden)
            }
        }
        .fullScreenCover(isPresented: $isLVLShown) {
            LoyaltyDetailView()
        }
        .fullScreenCover(isPresented: $isScannerShown) {
            ScannerView()
        }
        .fullScreenCover(isPresented: $isBookingsShown) {
            AllBookingsView()
        }
        .onAppear {
            if let code = UserDefaults.standard.string(forKey: "code") {
                self.code = code
            }
        }
    }
}

#Preview {
    ClubService()
}
