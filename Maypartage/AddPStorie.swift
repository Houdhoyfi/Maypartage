//
//  AddPStorie.swift
//  Maypartage
//
//  Created by YOUSSOUF HOUDHOYFI on 11/1/20.
//

import UIKit
import CoreData

class AddPStorie: UIViewController,UIImagePickerControllerDelegate,UITextFieldDelegate, UINavigationControllerDelegate {
    var imgpicker = UIImagePickerController()

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
    }
    @IBAction func annuler(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func inserer(_ sender: Any) {
        imgpicker.sourceType = .camera
        imgpicker.allowsEditing = true
        present(imgpicker, animated: true, completion: nil)
    }
    
    /*
    func openLibrary(){
        if photo.isUserInteractionEnabled==true{
            imgpicker.sourceType = .photoLibrary
            imgpicker.allowsEditing = true
            present(imgpicker, animated: true, completion: nil)
            
        }
    }*/
    
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
        
        
        let story = Story(context: AppDelegate.viewContext)
        story.pseudo=pseudo.text
        story.lieu=lieu.text
        story.desc=descripti.text
        story.photo=self.imageData
        try? AppDelegate.viewContext.save()
        print("save reussi")


        /*
       if let mfetch = fetch{
        print("hbbjb")
        let context = mfetch.managedObjectContext
            let pseud = pseudo.text
            let lie = lieu.text
            let descr = descripti.text
            
            if let story = mStory{
                story.pseudo=pseud
                story.lieu=lie
                story.desc=descr
                
            }else {
                let nouStory = Story(context: context )
                nouStory.lieu=lie
                nouStory.pseudo=pseud
                nouStory.desc=descr
            }
            
            do {
                try context.save()
                    print("save reussi")
                   } catch {
                       let nserror = error as NSError
                       fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
       }
       // dismiss(animated: true, completion: nil)
        
        */
        dismiss(animated: true, completion: nil)
    }
}
