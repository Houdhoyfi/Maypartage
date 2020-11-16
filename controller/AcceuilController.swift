//
//  AcceuilController.swift
//  Maypartage
//
//  Created by YOUSSOUF HOUDHOYFI on 10/31/20.
//

import UIKit
import CoreData
import AVFoundation
class AccueilController:UITableViewController,NSFetchedResultsControllerDelegate,AVAudioPlayerDelegate{
    
    var annonces:[Story]=[]
    var fetchResultController: NSFetchedResultsController<Story>!
    var detailViewController: detail? = nil
    @IBOutlet var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        // Récupération des données dans la base de données
       // let request: NSFetchRequest<Story> = Story.fetchRequest()
        //guard let stori = try? AppDelegate.viewContext.fetch(request)else {
          //  return
       //}
        //annonces=stori
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
    
    //pour recharcher les données
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showLocal" {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let controller = segue.destination as! detail
                    controller.detailItem =  annonces[indexPath.row]
                    detailViewController = controller
                }
            }
        }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return annonces.count;
            }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AcceuilCell", for: indexPath) as! TableViewCell
        cell.layer.cornerRadius = cell.layer.frame.height/6
        
        let annce = annonces[indexPath.row]
 
        cell.configure(withEvent: annce)
        return cell
    }

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
        print("sdczdc")
    }
    
    

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
            case .insert:
                tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
            case .delete:
                tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
            default:
                return
        }
        print("sdcsd")
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        print("annonce fetch ",annonces.count)

        switch type {
            case .insert:
                tableView.insertRows(at: [newIndexPath!], with: .fade)
            case .delete:
                tableView.deleteRows(at: [indexPath!], with: .fade)
            case .update:
                tableView.reloadRows(at: [indexPath!], with: .fade)
            default:
                tableView.reloadData()
        }
        
        guard let fetchedObjects = controller.fetchedObjects else {
            return
        }
        annonces = fetchedObjects as! [Story]
        print("annonce fetch ",annonces.count)
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        print("recharge endup")
    }


    


}
