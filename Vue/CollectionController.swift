//
//  CollectionController.swift
//  Maypartage
//
//  Created by YOUSSOUF HOUDHOYFI on 21/11/2020.
//

import UIKit
import CoreData
class CollectionController : UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, NSFetchedResultsControllerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet var collectView: UICollectionView!
    //Declaration des variables
    var collec:[Story2]=[]
    var imgpicker = UIImagePickerController()
    var fetchResultController: NSFetchedResultsController<Story2>!
    var imageData:Data?=nil
    var detailViewController: ViewStoriController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgpicker.delegate = self
        let w = collectView.frame.size.width
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = w/15
        layout.minimumInteritemSpacing = w/15
        layout.itemSize = CGSize(width: w/4, height: w/2)
        collectView.collectionViewLayout=layout
        //requete vers coreData pour ensuite
        //ajouter les éléméents dans le tableau annonces
        let fetchRequest: NSFetchRequest<Story2> = Story2.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "photo", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    collec =  fetchedObjects // Objets trouvés
                    
                }
            } catch {
                print(error)
            }
        }
    }
    //définir la taille des items de la CollectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = collectionView.frame.size.width
        return CGSize(width: w/3, height: w/2)
    }
    

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectView.collectionViewLayout.invalidateLayout();
    }
    
    // Permet de définir le nombre d'items dans la CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collec.count
    }
    
    
    //pour faire les transitions vers la page
    //qui affiche la photo des storie qui sont dans collectionView
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "StorieVue" {
                if let indexPath = collectView.indexPathsForSelectedItems?.first{
                    let controller = segue.destination as! ViewStoriController
                    controller.PhotoStorie = collec[indexPath.row]
                    detailViewController = controller
                }
            }
        }
    //permet la configuration des items dans
    //la collectionVue
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectView.dequeueReusableCell(withReuseIdentifier: "cellCo", for: indexPath) as! CollectionViewCell
        cell.layer.cornerRadius = cell.layer.frame.height/10
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.blue.cgColor
        let sto = collec[indexPath.row]
        cell.configure(withEvent: sto)
        return cell
    }
    
    //permet d'ouvrir l'application camera du téléphone
    @IBAction func prendrePhoto(_ sender: Any) {
        imgpicker.sourceType = .camera
        imgpicker.allowsEditing = true
        present(imgpicker, animated: true, completion: nil)
        
    }
    //pour presenter la photo prise par l'utilisateur sur la vue
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        guard let chosenImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
             return
           }
        self.imageData = chosenImage.jpegData(compressionQuality: 3)
        //print(NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).last!);
        
        let story = Story2(context: AppDelegate.viewContext)
        story.photo=self.imageData
        //enregistrement de la photo dans coreData
        try? AppDelegate.viewContext.save()
        
        print("save reussi")
        
        self.navigationController?.popViewController(animated: true)
        
        let alert = UIAlertController(title: "", message: "storie ajouté ", preferredStyle: .alert)
              self.present(alert, animated: true, completion: nil)
        // le délai : on attend 3 seconde et ensuite
        //on affiche l'alerte
              let when = DispatchTime.now() + 3
              DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
    }
    
    
    
 
    
}
