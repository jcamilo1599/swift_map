//
//  MapView.swift
//  Map
//
//  Created by Juan Camilo Marín Ochoa on 29/08/22.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var directions: [String]
    
    private let source = CLLocationCoordinate2D(
        latitude: 43.7181552,
        longitude: -79.5184814
    )
    
    private let destiny = CLLocationCoordinate2D(
        latitude: 45.837159,
        longitude: -78.3833457
    )
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 43.7181552,
                longitude: -79.5184814
            ),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
        
        let sourcePin = MKPointAnnotation()
        sourcePin.coordinate = source
        sourcePin.title = "Inicio"
        
        let destinyPin = MKPointAnnotation()
        destinyPin.coordinate = destiny
        destinyPin.title = "Destino"
        
        mapView.setRegion(region, animated: true)
        mapView.addAnnotations([sourcePin, destinyPin])
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: source))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destiny))
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let route = response?.routes.first else { return }
            
            mapView.addOverlay(route.polyline)
            mapView.setVisibleMapRect(
                route.polyline.boundingMapRect,
                edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
                animated: true
            )
            
            self.directions = route.steps.map { $0.instructions }.filter { !$0.isEmpty }
        }
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {}
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .orange
            renderer.lineWidth = 4
            
            return renderer
        }
    }
}
