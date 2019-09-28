//
//  MapViewController.swift
//  climate
//
//  Created by Roland Michelberger on 27.09.19.
//  Copyright © 2019 hack zurich. All rights reserved.
//

import UIKit
import TomTomOnlineSDKRouting
import TomTomOnlineSDKMaps
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet private weak var mapView: TTMapView!
    
    @IBOutlet private weak var fromTextField: UITextField!
    @IBOutlet private weak var toTextField: UITextField!
    
    @IBOutlet private weak var stackView: UIStackView!
    
    @IBOutlet private weak var bikeStackView: UIStackView!
    @IBOutlet private weak var carStackView: UIStackView!
    @IBOutlet private weak var walkStackView: UIStackView!
    @IBOutlet private weak var trainStackView: UIStackView!
    
    @IBOutlet private weak var carCo2Label: UILabel!
    @IBOutlet private weak var carTimeLabel: UILabel!
    @IBOutlet private weak var carPointsLabel: UILabel!
    
    @IBOutlet private weak var trainCo2Label: UILabel!
    @IBOutlet private weak var trainTimeLabel: UILabel!
    @IBOutlet private weak var trainPointsLabel: UILabel!
    
    @IBOutlet private weak var bikeCo2Label: UILabel!
    @IBOutlet private weak var bikeTimeLabel: UILabel!
    @IBOutlet private weak var bikePointsLabel: UILabel!
    
    @IBOutlet private weak var walkCo2Label: UILabel!
    @IBOutlet private weak var walkTimeLabel: UILabel!
    @IBOutlet private weak var walkPointsLabel: UILabel!
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    
    let routePlanner = TTRoute()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        stackView.isHidden = true
        
        fromTextField.delegate = self
        toTextField.delegate = self
      
        let alpha: CGFloat = 0.9
        bikeStackView.addBackground(color: UIColor.oceanBlue.withAlphaComponent(alpha))
        carStackView.addBackground(color: UIColor.pomegranate.withAlphaComponent(alpha))
        trainStackView.addBackground(color: UIColor.carrot.withAlphaComponent(alpha))
        walkStackView.addBackground(color: UIColor.greenSea.withAlphaComponent(alpha))
        
//        let sum = Summary(length: 4, travelTime: 4000)
        let origin = CLLocationCoordinate2D(latitude: CLLocationDegrees(47.376888), longitude: CLLocationDegrees(8.541694))
//        let destination = CLLocationCoordinate2D(latitude: CLLocationDegrees(46.947975), longitude: CLLocationDegrees(7.447447))
//
//        let fullRoute = FullRoute(coordinates: [NSValue(mkCoordinate: origin), NSValue(mkCoordinate: destination)], sum: sum)
//
//        show(routes: [fullRoute], for: .none)
        
        DispatchQueue.main.async { [weak self] in
            self?.mapView.center(on: origin, withZoom: 10)
        }
        
    }
    
    func route(origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D, travelMode: TTOptionTravelMode ) {
        let query = TTRouteQueryBuilder.create(withDest: destination, andOrig: origin).withTravelMode(travelMode).build()
        routePlanner.plan(with: query) { [weak self] (routeResult, error) in
            if let routeResult = routeResult {
                self?.show(routes: routeResult.routes, for: travelMode)
                
                if travelMode == .car {
                    let origin1 = CLLocationCoordinate2D(latitude: CLLocationDegrees(47.310489), longitude: CLLocationDegrees(8.056924))
                    let destination1 = CLLocationCoordinate2D(latitude: CLLocationDegrees(47.092157), longitude: CLLocationDegrees(7.625899))
                    
                    var coordinates = [origin, origin1, destination1, destination]
                    let polyline = TTPolyline(coordinates: &coordinates, count: 4, opacity: 1, width: 8, color: .carrot)
                    self?.mapView.annotationManager.add(polyline)
                    
                    let formatter = DateComponentsFormatter()
                    formatter.zeroFormattingBehavior = .pad
                    formatter.allowedUnits = [.hour, .minute]
                    formatter.unitsStyle = .abbreviated
                    let seconds = 3492
                    let formattedTime = formatter.string(from: TimeInterval(seconds))
                    
                    self?.trainTimeLabel.text = formattedTime
                    let measurementFormatter = MeasurementFormatter()
                    measurementFormatter.numberFormatter.maximumFractionDigits = 3
                    
                    let km = 120.0
                    let measurement = Measurement(value: km * 75, unit: UnitMass.grams)
                    measurementFormatter.numberFormatter.maximumFractionDigits = 1
                    self?.trainCo2Label.text = measurementFormatter.string(from: measurement)
                    
                    let numberFormatter = NumberFormatter()
                    numberFormatter.maximumFractionDigits = 1
                    let kmString = numberFormatter.string(from: NSNumber(value: km))!
                    self?.trainPointsLabel.text = "\(kmString) 🐧"

                    
                    self?.route(origin: origin, destination: destination, travelMode: .bicycle)
                } else if travelMode == .bicycle {
                    self?.route(origin: origin, destination: destination, travelMode: .pedestrian)
                }
            }
        }
    }
    
    func show(routes: [TTFullRoute], for travelMode: TTOptionTravelMode) {
        var activeRoute: TTMapRoute?
        for planedRoute in routes {
            if activeRoute == nil {
                
                let fillColor: UIColor
                let outlineColor: UIColor
                let seconds = planedRoute.summary.travelTimeInSecondsValue
                let formatter = DateComponentsFormatter()
                formatter.zeroFormattingBehavior = .pad
                formatter.allowedUnits = [.hour, .minute]
                formatter.unitsStyle = .abbreviated
                let formattedTime = formatter.string(from: TimeInterval(seconds))
                
                //                let distanceInMeters = Measurement(value: Double(planedRoute.summary.lengthInMetersValue), unit: UnitLength.meters)
                //                let distance = MeasurementFormatter().string(from: distanceInMeters)
                
                let numberFormatter = NumberFormatter()
                numberFormatter.maximumFractionDigits = 0
                let km = Double(planedRoute.summary.lengthInMetersValue) / 1000.0
                
                
                switch travelMode {
                case .bicycle:
                    fillColor = .oceanBlue
                    outlineColor = .oceanBlue
                    bikeTimeLabel.text = formattedTime
                    bikeCo2Label.text = MassFormatter().string(fromValue: 0, unit: .gram)
                    let kmString = numberFormatter.string(from: NSNumber(value: km * 2))!
                    bikePointsLabel.text = "\(kmString) 🐧"
                    
                case .pedestrian:
                    fillColor = .greenSea
                    outlineColor = .greenSea
                    walkTimeLabel.text = formattedTime
                    walkCo2Label.text = MassFormatter().string(fromValue: 0, unit: .gram)
                    let kmString = numberFormatter.string(from: NSNumber(value: km * 3))!
                    walkPointsLabel.text = "\(kmString) 🐧"

                case .car:
                    fillColor = .pomegranate
                    outlineColor = .pomegranate
                    carTimeLabel.text = formattedTime
                    let formatter = MeasurementFormatter()
                    formatter.numberFormatter.maximumFractionDigits = 3
                    let measurement = Measurement(value: km * 120.1, unit: UnitMass.grams)
                    formatter.numberFormatter.maximumFractionDigits = 1
                    carCo2Label.text = formatter.string(from: measurement)
                    carPointsLabel.text = "0 🐧"
                    
                default:
                    fillColor = .carrot
                    outlineColor = .carrot
                    trainTimeLabel.text = formattedTime
                    let formatter = MeasurementFormatter()
                    formatter.numberFormatter.maximumFractionDigits = 3
                    let measurement = Measurement(value: km * 75, unit: UnitMass.grams)
                    formatter.numberFormatter.maximumFractionDigits = 1
                    trainCo2Label.text = formatter.string(from: measurement)
                    let kmString = numberFormatter.string(from: NSNumber(value: km))!
                    trainPointsLabel.text = "\(kmString) 🐧"

                }
                
                let routeStyle = TTMapRouteStyleBuilder().withWidth(1).withFill(fillColor).withOutlineColor(outlineColor).build()
                let mapRoute = TTMapRoute(coordinatesData: planedRoute, with: routeStyle, imageStart: TTMapRoute.defaultImageDeparture(), imageEnd: TTMapRoute.defaultImageDestination())
                mapView.routeManager.add(mapRoute)
                mapRoute.extraData = planedRoute.summary
                activeRoute = mapRoute
                print("------")
                print(travelMode.rawValue)
                //                print(planedRoute.summary.travelTimeInSecondsValue)
                print(planedRoute.summary.fuelConsumptionInLitersValue)
                print("------")
                
                stackView.isHidden = false
                //                etaView.show(summary: planedRoute.summary, style: .plain)
            } else {
                let mapRoute = TTMapRoute(coordinatesData: planedRoute,
                                          with: TTMapRouteStyle.defaultInactive(),
                                          imageStart: TTMapRoute.defaultImageDeparture(),
                                          imageEnd: TTMapRoute.defaultImageDestination())
                mapView.routeManager.add(mapRoute)
                mapRoute.extraData = planedRoute.summary
                
                print("xxxxxxxxxx")
                print(planedRoute.summary.travelTimeInSecondsValue)
                print(planedRoute.summary.lengthInMetersValue)
                print("xxxxxxxxxx")
                
            }
        }
        mapView.routeManager.bring(toFrontRoute: activeRoute!)
        
        let insets = UIEdgeInsets(
            top: 80, left: 30,
            bottom: 120, right: 30)
        mapView.contentInset = insets
        mapView.routeManager.showAllRoutesOverview()
        activityIndicator.stopAnimating()
        
    }
    
    @IBAction func train() {
        
    }
    
    @IBAction func walk() {
        
    }

}


extension MapViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fromTextField {
            fromTextField.resignFirstResponder()
            toTextField.becomeFirstResponder()
        } else {
            
            let origin = CLLocationCoordinate2D(latitude: CLLocationDegrees(47.376888), longitude: CLLocationDegrees(8.541694))
            let destination = CLLocationCoordinate2D(latitude: CLLocationDegrees(46.947975), longitude: CLLocationDegrees(7.447447))
            
            route(origin: origin, destination: destination, travelMode: .car)
            
            activityIndicator.startAnimating()
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == fromTextField {
            if textField.text == "Zu" {
                textField.text = "Zürich"
                return false
            } else if textField.text == "Be" {
                textField.text = "Bern SBB"
                return false
            }
        } else {
            if textField.text == "Be" {
                textField.text = "Bern"
                return false
            } else if textField.text == "Bu" {
                textField.text = "Bundesplatz Bern"
                return false
            }
        }
        return true
    }
    
    
}
