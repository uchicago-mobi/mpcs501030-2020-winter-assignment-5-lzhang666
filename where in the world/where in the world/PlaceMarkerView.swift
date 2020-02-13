//
//  PlaceMarkerView.swift
//  where in the world
//
//  Created by Li Zhang on 2020-02-11.
//  Copyright © 2020 Li Zhang. All rights reserved.
//

import Foundation
import MapKit


class PlaceMarkerView: MKMarkerAnnotationView{
    override var annotation: MKAnnotation? {
        willSet{
            clusteringIdentifier = "Place"
            displayPriority = .defaultLow
            markerTintColor = .systemRed
            glyphImage = UIImage(systemName: "pin.fill")
        }
    }
}
