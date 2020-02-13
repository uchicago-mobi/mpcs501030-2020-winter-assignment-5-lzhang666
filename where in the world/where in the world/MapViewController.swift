//
//  ViewController.swift
//  where in the world
//
//  Created by Li Zhang on 2020-02-11.
//  Copyright © 2020 Li Zhang. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeDescript: UILabel!
    @IBOutlet weak var Favorites: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll

        DataManager.sharedInstance.loadAnnotitionFromPlist()
        let zoomLocation = CLLocationCoordinate2DMake(DataManager.sharedInstance.startLat!, DataManager.sharedInstance.startLong!)
        
        let locationSpan = MKCoordinateSpan(latitudeDelta: DataManager.sharedInstance.startDimension1!, longitudeDelta: DataManager.sharedInstance.startDimension2!)
        
        let viewRegion = MKCoordinateRegion.init(center: zoomLocation, span: locationSpan)
        
        mapView.setRegion(viewRegion, animated: true)
        
        addPlaces()
        
    }
    
    
    func addPlaces(){
        for locDict in DataManager.sharedInstance.allPlaces{
            let place = Place()
            place.name = locDict.key
            place.longDescription = locDict.value.description
            place.latitude = locDict.value.lat
            place.latitude = locDict.value.long
            
            mapView.addAnnotation(place)
        }
    }


}

extension MapViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Place{
            let identifier = "CustomPin"
            
            var view: MKMarkerAnnotationView
            
            if let dequeuedView =
                mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: <#T##String?#>)
            }
        }
    }
    
}

