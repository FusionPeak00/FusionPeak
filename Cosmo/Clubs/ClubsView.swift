//
//  ClubsView.swift
//
//  Created by D K on 04.12.2024.
//

import SwiftUI

struct Club: Codable, Hashable {
    let id: String
    let name: String
    let adress: String
    let latitude: Double
    let longtitude: Double
}


struct ClubsView: View {
    
    @State var currentIndex: Int = 0
    @State var clubIndex: Int = 0
    @State var isShown = false
    @State var offset: CGFloat = 0
    
    let clubs: [Club] = [
    Club(id: "club1", name: "Fusion Peak", adress: "Volendammerweg, 1024 JK Amsterdam", latitude: 52.39150230918754, longtitude: 4.952511000542639),
    Club(id: "club2", name: "Fusion Peak", adress: "Duivenvoordestraat 7B, 3021 PA Rotterdam", latitude: 51.920919363308954, longtitude: 4.460221127892884),
    Club(id: "club4", name: "Fusion Peak", adress: "Langerak, 3544 RR Utrecht", latitude: 52.08478560829501, longtitude: 5.056908019291146),
    Club(id: "club3", name: "Fusion Peak", adress: "Sinaasappelstraat 15, 1326 GN Almere", latitude: 52.36941197537303, longtitude: 5.2454857752955535)
    ]
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.darkPurple)
                .ignoresSafeArea()
            
            VStack {
                Text("CLUBS")
                    .foregroundColor(.white)
                    .font(.system(size: 28, weight: .black))
                    .frame(width: size().width - 40, alignment: .leading)
                
                ZStack {
                    ForEach(0..<clubs.count, id: \.self) { index in
                        ClubCell(club: clubs[index]) {
                            withAnimation {
                                isShown.toggle()
                                self.offset = 0
                            }
                        }
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .scaleEffect( currentIndex == index ? 1 : 0.8)
                            .offset(x: CGFloat(index - currentIndex) * size().width / 1.2 )
                    }
                }
                .padding(.bottom, 80)
                .gesture(
                    DragGesture()
                        .onEnded({ value in
                            let threshold: CGFloat = 50
                            if value.translation.width > threshold {
                                withAnimation {
                                    currentIndex = max(0, currentIndex - 1)
                                    clubIndex = currentIndex
                                }
                            } else if value.translation.width < -threshold {
                                withAnimation {
                                    currentIndex = min(clubs.count - 1, currentIndex + 1)
                                    clubIndex = currentIndex
                                    
                                }
                            }
                        })
                )
                
                Spacer()
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ClubsView()
}
