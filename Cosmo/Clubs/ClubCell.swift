//
//  ClubCell.swift
//
//  Created by D K on 04.12.2024.
//

import SwiftUI
import MapKit

struct ClubCell: View {
    
    var club: Club
    var completion: () -> ()
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: size().width - 40, height: size().height / 1.3)
                .cornerRadius(24)
                .foregroundColor(.semiPurple)
                .overlay {
                    VStack(alignment: .leading) {
                        Image("\(club.id)")
                            .resizable()
                            .scaledToFill()
                            .frame(width: size().width - 40, height: 200)
                        
                        Text("\(club.name)")
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold))
                            .padding(.leading)
                            .padding(.top, 20)
                        
                        Text("\(club.adress)")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .light))
                            .padding(.leading)
                            .padding(.top, 1)
                        
                        Text("Opening Hours: 12:00 - 24:00")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .light))
                            .padding(.leading)
                            .padding(.top, 1)
                        
                        Spacer()
                        
                        MapView(coordinate: CLLocationCoordinate2D(latitude: club.latitude, longitude: club.longtitude))
                            .preferredColorScheme(.dark)
                            .frame(width: size().width - 40)
                            .padding(.top)
                    }
                    .cornerRadius(24)
                    
                }
        }
    }
}
#Preview {
    ClubCell(club: Club(id: "1", name: "Blaze Game Club", adress: "Volendammerweg, 1024 JK Amsterdam", latitude: 52.39150230918754, longtitude: 4.952511000542639)) {}
}


struct MapView: UIViewRepresentable {
    
    var coordinate: CLLocationCoordinate2D
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate

        view.removeAnnotations(view.annotations)
        view.addAnnotation(annotation)

        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        view.setRegion(region, animated: true)
    }
}
