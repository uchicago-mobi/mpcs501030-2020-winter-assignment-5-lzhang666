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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll
        
    }


}

