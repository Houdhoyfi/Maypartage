//
//  Ajouter.swift
//  Maypartage
//
//  Created by YOUSSOUF HOUDHOYFI on 10/30/20.
//

import UIKit
import CoreData
class Ajouter :UIViewController,UITextFieldDelegate, UINavigationControllerDelegate{
    var fetch:NSFetchedResultsController<Story>?=nil
    @IBOutlet weak var photo: UIImageView!
    var mStory: Story? = nil
    @IBOutlet weak var lieu: UITextField!
    @IBOutlet weak var pseudo: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func annuler(_ sender: Any) {
       dismiss(animated: true, completion:nil)

    }
   
    @IBAction func prendrePhoto(_ sender: Any) {
    }
    
    @IBAction func fggr(_ sender: Any) {
        print("jhjbjhbjhb")
        print("ergerger")
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func envoyer(_ sender: Any) {
        //print(NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).last!);
        print("ergerger")
        if let mfetch = fetch{
            let context = mfetch.managedObjectContext
            let pseud = pseudo.text
            let lie = lieu.text

            if let story = mStory{
                story.pseudo=pseud
                story.lieu=lie
                
            }else {
                let nouStory = Story(context: context)
                nouStory.lieu=lie
                nouStory.pseudo=pseud

            }
            
            do {
                       try context.save()
                   } catch {
                       let nserror = error as NSError
                       fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                   }
        
    }


    }
    
}
