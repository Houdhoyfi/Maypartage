//
//  AddPStorie.swift
//  Maypartage
//
//  Created by YOUSSOUF HOUDHOYFI on 11/1/20.
//
/* cette classe permet de récupérer les informations saisi et les coordonnées
    de la location et ensuite d'enregistrer les informations dans coreData */
import UIKit
import CoreData
import CoreLocation
import CoreMotion
class AddPStorie: UIViewController,UIImagePickerControllerDelegate,UITextFieldDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate  {
    
    //Déclarations des différentes varibles
    var longitude:Double=0.0
    var latitude:Double=0.0
    var imgpicker = UIImagePickerController()
    let locationManager = CLLocationManager()
    var mStory: Story? = nil
    var imageData:Data?=nil
    var fetch:NSFetchedResultsController<Story>?=nil
    
    @IBOutlet var vue: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var photo: UIImageView!
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
    
    //récupérartion des coordonnées pour la localisation
    func locationManager(_ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        latitude=location.coordinate.latitude
        longitude=location.coordinate.longitude
    }
    
    //permet d'annuler l'ajout d'une publication
    //et revenir sur la page d'accueil
    @IBAction func annuler(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //permet d'ouvrir l'application camera du téléphone
    @IBAction func inserer(_ sender: Any) {
        imgpicker.sourceType = .camera
        imgpicker.allowsEditing = true
        present(imgpicker, animated: true, completion: nil)
    }
    
    //permet d'afficher la photo prise l'utilisateur à l'écran
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        guard let chosenImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
             return
           }
        img.image=chosenImage
        self.imageData = chosenImage.jpegData(compressionQuality: 3)
    }
    
    //enregistre les informations dans Coredata
    @IBAction func envoyer(_ sender: Any) {
        enreg()
       
    }
    
    func enreg(){
       // print(NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).last!);
        
        //teste si un des champs de saisi est vide
        if pseudo.text == "" || descripti.text == "" {
              let alertController = UIAlertController(title: "Oups", message: "Vous ne pouvez pas enregistrer cette storie car tous les champs ne sont pas renseignés. Merci de réessayer.", preferredStyle: .alert)
              let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
              
              alertController.addAction(alertAction)
              present(alertController, animated: true, completion: nil)
              
              return
          }
          
        let dateFormatter = DateFormatter()
        let date = Date()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .medium
        let story = Story(context: AppDelegate.viewContext)
        story.pseudo=pseudo.text
        story.desc=descripti.text
        story.photo=self.imageData
        story.heure=dateFormatter.string(from: date)
        story.lati=latitude
        story.longi=longitude
        try? AppDelegate.viewContext.save()
        print("save reussi")
        
        dismiss(animated: true, completion: nil)

    }
    
    //permet la disparition du clavier au tap sur l'ecran
    @IBAction func DisparitionClavier(_ sender: UITapGestureRecognizer) {
        pseudo.resignFirstResponder()
        descripti.resignFirstResponder()
    }
    
    
}
