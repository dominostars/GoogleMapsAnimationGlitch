//
//  ViewController.swift
//  GoogleMapsAnimationGlitch
//
//  Created by Gilad Gurantz on 8/8/15.
//  Copyright (c) 2015 Lazy Arcade. All rights reserved.
//

import UIKit
import GoogleMaps

public func executeAfter(delay: Double, queue: dispatch_queue_t? = nil, closure: () -> Void) {
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
    dispatch_after(time, queue ?? dispatch_get_main_queue(), closure)
}

class ViewController: UIViewController, GMSMapViewDelegate {
    @IBOutlet var mapView: GMSMapView!
    var markers: [GMSMarker] = []
    // Temp array to keep removed markers alive for a short while.
    var markersDelayedDelete: [GMSMarker] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.mapView.delegate = self
        self.mapView.settings.indoorPicker = false
        self.mapView.settings.myLocationButton = false
        self.mapView.settings.rotateGestures = false
        self.mapView.settings.tiltGestures = false
        self.mapView.setMinZoom(0, maxZoom: 20)
        self.mapView.moveCamera(GMSCameraUpdate.zoomTo(17))
        self.mapView.settings.allowScrollGesturesDuringRotateOrZoom = false

        for var i = 0; i < 10; i++ {
            var originalPoint = CGPoint(x: self.mapView.bounds.size.width * (CGFloat(i)/10), y: self.mapView.bounds.size.height/2)
            let marker = GMSMarker(position: self.mapView.projection.coordinateForPoint(originalPoint))
            marker.icon = UIImage(named: "AppIcon")
            marker.map = self.mapView
            self.markers.append(marker)

            CATransaction.setAnimationDuration(2)
            originalPoint.y = self.mapView.bounds.size.height / 3
            _ = self.mapView.projection.coordinateForPoint(originalPoint)
            marker.position = self.mapView.projection.coordinateForPoint(originalPoint)
        }
    }

    @IBAction func button() {
        let limit = Int(arc4random() % UInt32(self.markers.count))
//        executeAfter(0.0) {
            for (var i = limit; i >= 0; i--) {
                self.markers[i].map = nil
                markersDelayedDelete.append(self.markers[i])
                self.markers.removeAtIndex(i)
            }
//        }

        // Free all removed markers 1 second later.
        executeAfter(1) {
          self.markersDelayedDelete.removeAll(keepCapacity: false)
        }

        for (i, marker) in markers.enumerate() {
            var originalPoint = CGPoint(x: self.mapView.bounds.size.width * (CGFloat(i)/10), y: self.mapView.bounds.size.height/2)
            CATransaction.setAnimationDuration(5)
            originalPoint.y = self.mapView.bounds.size.height
            _ = self.mapView.projection.coordinateForPoint(originalPoint)
            marker.position = self.mapView.projection.coordinateForPoint(originalPoint)
            markers.append(marker)
        }

        for var i = 0; i < 10; i++ {
            var originalPoint = CGPoint(x: self.mapView.bounds.size.width * (CGFloat(i)/10), y: self.mapView.bounds.size.height/2)
            let marker = GMSMarker(position: self.mapView.projection.coordinateForPoint(originalPoint))
            marker.icon = UIImage(named: "AppIcon")
            marker.map = self.mapView

            CATransaction.setAnimationDuration(5)
            originalPoint.y = self.mapView.bounds.size.height / 3
            _ = self.mapView.projection.coordinateForPoint(originalPoint)
            marker.position = self.mapView.projection.coordinateForPoint(originalPoint)
            markers.append(marker)
        }
    }
}

