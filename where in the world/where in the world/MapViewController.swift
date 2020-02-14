//
//  ViewController.swift
//  where in the world
//
//  Created by Li Zhang on 2020-02-11.
//  Copyright © 2020 Li Zhang. All rights reserved.
//

import UIKit
import MapKit

protocol FavToMapDelegate: class{
    func goToFavPlace(placeName: String)
}

class MapViewController: UIViewController, FavToMapDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!{
        didSet {mapView.delegate = self}
    }
    
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var infoPlate: UIView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeDescript: UILabel!
    @IBOutlet weak var Favorites: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // wrap text in description UILabel
        placeDescript.numberOfLines = 0
        
        infoPlate.alpha = 0
        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll

        DataManager.sharedInstance.loadAnnotitionFromPlist()
        
        let zoomLocation = CLLocationCoordinate2DMake(DataManager.sharedInstance.startLat!, DataManager.sharedInstance.startLong!)
        
        let locationSpan = MKCoordinateSpan(latitudeDelta: DataManager.sharedInstance.startDimension1!, longitudeDelta: DataManager.sharedInstance.startDimension2!)
        
        let viewRegion = MKCoordinateRegion.init(center: zoomLocation, span: locationSpan)
        // set initial view
        mapView.setRegion(viewRegion, animated: true)
        // add all location pins to the map
        addPlaces()
        
    }
    
    func addPlaces(){
        var placesArray = [Place]()
        for locDict in DataManager.sharedInstance.allPlaces{
            let place = Place()
            place.name = locDict.key
            place.longDescription = locDict.value.description
            place.coordinate = CLLocationCoordinate2DMake(locDict.value.lat, locDict.value.long)
            placesArray.append(place)
        }
        
        mapView.addAnnotations(placesArray)
//        mapView.showAnnotations(placesArray, animated: true)
    }
    
    @objc func starButtonTapped(_ button: UIButton!){
        if starButton.isSelected{
            DataManager.sharedInstance.deleteFavorite(currentPlace: placeName.text!)
            starButton.isSelected = false
        } else {
            DataManager.sharedInstance.saveFavorite(currentPlace: placeName.text!)
            starButton.isSelected = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FavoritesViewController{
            destination.delegate = self
        }
    }
    
    // zoom to the selected favorite place
    func goToFavPlace(placeName: String){
        print("enter focus function")
        let placeDict = DataManager.sharedInstance.allPlaces[placeName]
        let zoomLocation = CLLocationCoordinate2DMake(placeDict!.lat, placeDict!.long)
        let locationSpan = MKCoordinateSpan(latitudeDelta: DataManager.sharedInstance.startDimension1!, longitudeDelta: DataManager.sharedInstance.startDimension2!)
        let newViewRegion = MKCoordinateRegion.init(center: zoomLocation, span: locationSpan)
        mapView.setRegion(newViewRegion, animated: true)
    }
    
}

extension MapViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Place{
            let identifier = "CustomPin"

            var view: PlaceMarkerView

            if let dequeuedView =
                mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? PlaceMarkerView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = PlaceMarkerView(annotation: annotation, reuseIdentifier: identifier)
                annotation.title = annotation.name
                view.canShowCallout = true
                view.leftCalloutAccessoryView = UIImageView(image: #imageLiteral(resourceName: "mapPin"))
            }
            return view
        }
        return nil
        
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let favPlaces = UserDefaults.standard.object(forKey: "favPlaces") as! [String]
        if let annotation = view.annotation as? Place{
            infoPlate.alpha = 0.8
            placeName.text = annotation.name
            placeDescript.text = annotation.longDescription
            
            if favPlaces.contains(placeName.text!){
                starButton.isSelected = true
            } else {
                starButton.isSelected = false
            }
            
            starButton.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
            
        }
        
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        infoPlate.alpha = 0
    }
    
}

