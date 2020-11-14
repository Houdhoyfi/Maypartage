//
//  AddPStorie.swift
//  Maypartage
//
//  Created by YOUSSOUF HOUDHOYFI on 11/1/20.
//

import UIKit
import CoreData
import CoreLocation
class AddPStorie: UIViewController,UIImagePickerControllerDelegate,UITextFieldDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate  {
    var longitude:Double=0.0
    var latitude:Double=0.0

    var imgpicker = UIImagePickerController()
    let locationManager = CLLocationManager()
    @IBOutlet weak var img: UIImageView!
    var fetch:NSFetchedResultsController<Story>?=nil
    @IBOutlet weak var photo: UIImageView!
    var mStory: Story? = nil
    var imageData:Data?=nil
    @IBOutlet var descripti: UITextView!
    @IBOutlet weak var lieu: UITextField!
    @IBOutlet weak var pseudo: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgpicker.delegate = self
        locationManager.delegate = self
        if CLLocationManager.locationServicesEnabled() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.requestWhenInUseAuthorization();
            //demarage de mongps
            locationManager.startUpdatingLocation()
        }
    }
    
    //localisation
    func locationManager(_ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        latitude=location.coordinate.latitude
        longitude=location.coordinate.longitude
        //print("loca l ",(location.coordinate.latitude)+2)
        //print("loca li ",(location.coordinate.longitude)+2)
                
    }
    @IBAction func annuler(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func inserer(_ sender: Any) {
        imgpicker.sourceType = .camera
        imgpicker.allowsEditing = true
        present(imgpicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)

        guard let chosenImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
             return
           }
        img.image=chosenImage
        
        self.imageData = chosenImage.jpegData(compressionQuality: 3)
    }
    
    @IBAction func envoyer(_ sender: Any) {
        enreg()
        

       
    }
    
    func enreg(){
        print(NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).last!);
        let dateFormatter = DateFormatter()
        var date = Date()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .medium
        print(dateFormatter.string(from: date))
        let story = Story(context: AppDelegate.viewContext)
        story.pseudo=pseudo.text
        story.lieu=lieu.text
        story.desc=descripti.text
        story.photo=self.imageData
        story.heure=dateFormatter.string(from: date)
        story.lati=latitude
        story.longi=longitude
        try? AppDelegate.viewContext.save()
        print("save reussi")
        
        dismiss(animated: true, completion: nil)
    }
}
