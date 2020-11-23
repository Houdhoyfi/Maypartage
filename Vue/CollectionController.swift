//
//  CollectionController.swift
//  Maypartage
//
//  Created by YOUSSOUF HOUDHOYFI on 21/11/2020.
//

import UIKit
import CoreData
class CollectionController : UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, NSFetchedResultsControllerDelegate{
    
    @IBOutlet var collectView: UICollectionView!
    var annonces:[Story]=[]
    var fetchResultController: NSFetchedResultsController<Story>!
    
    var detailViewController: ViewStoriController? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        let w = collectView.frame.size.width
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = w/15
        layout.minimumInteritemSpacing = w/15
        layout.itemSize = CGSize(width: w/3, height: w/2)
        collectView.collectionViewLayout=layout
        let fetchRequest: NSFetchRequest<Story> = Story.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "pseudo", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    annonces =  fetchedObjects // Objets trouvés
                    //print("anonce deb",annonces.count)
                }
            } catch {
                print(error)
            }
        }
   
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout
            collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = collectionView.frame.size.width
        return CGSize(width: w/3, height: w/2)
    }
    

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectView.collectionViewLayout.invalidateLayout();
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return annonces.count
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "StorieVue" {
                if let indexPath = collectView.indexPathsForSelectedItems?.first{
                    let controller = segue.destination as! ViewStoriController
                    controller.detailItem = annonces[indexPath.row]
                    detailViewController = controller
                    print("shown")
                    
                }
            
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectView.dequeueReusableCell(withReuseIdentifier: "cellCo", for: indexPath) as! CollectionViewCell
        cell.layer.cornerRadius = cell.layer.frame.height/10
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.blue.cgColor
        let annce = annonces[indexPath.row]
        cell.configure(withEvent: annce)
        return cell
    }
    
 
    
}
