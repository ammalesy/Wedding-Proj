//
//  MapViewController.swift
//  NMWedding
//
//  Created by Apple on 1/30/16.
//  Copyright © 2016 dev.com. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    let coord = CLLocationCoordinate2DMake(13.854985, 100.840753)
    let dropPin = MKPointAnnotation()
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
//    let routeLine:MKPolyline!
//    let routeLineView:MKPolylineView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        mapView.showsUserLocation = true;
        mapView.mapType = MKMapType.Standard;
        mapView.delegate = self;
        
        
        // Drop a pin
        
        dropPin.coordinate = coord
        dropPin.title = "Arnut & Dameeya Wedding"
        dropPin.subtitle = "40/1 ถ.เลียบวารี หนองจอก กรุงเทพฯ 10530"
        mapView.addAnnotation(dropPin)
        
        
        // Do any additional setup after loading the view.
    }
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        // Button
        let annotationView:MKAnnotationView = MKAnnotationView(annotation: dropPin, reuseIdentifier: "loc")
        let button:UIButton = UIButton(type: UIButtonType.DetailDisclosure)
        button.addTarget(self, action: Selector("openAppleMap"), forControlEvents: UIControlEvents.TouchUpInside)
        button.frame = CGRectMake(0, 0, 23, 23);
        annotationView.rightCalloutAccessoryView = button;
        annotationView.leftCalloutAccessoryView = UIImageView(image: UIImage(named: "hrt"))
        annotationView.image = UIImage(named: "pin56-2")
        annotationView.canShowCallout = true
        return annotationView
    }
    func openAppleMap(){
        let placemark:MKPlacemark = MKPlacemark(coordinate: self.coord, addressDictionary: nil)
        let mapItem:MKMapItem = MKMapItem(placemark: placemark)
        mapItem.name = dropPin.title
        mapItem.openInMapsWithLaunchOptions(nil)
    }
    func zooming(){
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(coord, span)
        mapView.setRegion(region, animated: true)
        mapView.regionThatFits(region)
        mapView.selectAnnotation(dropPin, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        self.zooming()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
