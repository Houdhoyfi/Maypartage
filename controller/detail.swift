//
//  detail.swift
//  Maypartage
//
//  Created by YOUSSOUF HOUDHOYFI on 11/1/20.
//

import UIKit
import CoreLocation
import MapKit
import CoreMotion
class detail: UIViewController , CLLocationManagerDelegate {
    var long:Double=0.0
    var lat:Double=0.0
    //@IBOutlet weak var carte: MKMapView!
    @IBOutlet weak var mymap: MKMapView!
    @IBOutlet weak var descri: UITextView!
    @IBOutlet weak var psedo: UILabel!
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        motion()
        configureView()
        locationManager.delegate = self
        if CLLocationManager.locationServicesEnabled() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        //demande de l'autorisation pour localistaion
         locationManager.requestWhenInUseAuthorization();
        //demarrage de mongps
        locationManager.startUpdatingLocation()
        }
    }
    
    //localisation
    func locationManager(_ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]) {
        let span : MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let maylocation :CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: lat, longitude: long)
        let region : MKCoordinateRegion = MKCoordinateRegion.init(center: maylocation,span: span)
        mymap.setRegion(region, animated: true)
        //permet d'afficher le point bleu sur la carte
        self.mymap.showsUserLocation=true
        
    }
    
    func locationManager(_ manager: CLLocationManager,
    didFailWithError error: Error) {
    print(error)
    }
    
    func configureView() {
        
        //permet de configurer et mettre à jour le détail des publications
        if let detail = detailItem {
            
            long=detail.longi
            lat=detail.lati
            if let descrip = self.descri {
                descrip.text = detail.desc
            }
                if let pseudo = self.psedo {
                    pseudo.text = detail.pseudo
                }
            
        }
            
    }
    
    let motionManager = CMMotionManager()
    // permet de détecter si la gravitation du téléphone
    func motion(){
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.01
            motionManager.startDeviceMotionUpdates(to: .main) {
                
                (data, error) in
                guard let data = data, error == nil else {
                    return
                }
                
                let rotation = data.gravity.x
                //si la graviation de x > 0.30
                //on retourne à la vue de départ
                if rotation > 0.30{
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    var detailItem: Story? {
        didSet {
            configureView()
            
        }
    }
    
}
