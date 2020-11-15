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
    
    var detailViewController: detail? = nil
    @IBOutlet var tableview: UITableView!
    var fetchResultController: NSFetchedResultsController<Story>!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        // Récupération des données dans la base de données
        let request: NSFetchRequest<Story> = Story.fetchRequest()
       
        guard let stori = try? AppDelegate.viewContext.fetch(request)else {
            return
        }
        annonces=stori
        
       
    }
    
    
    
    //pour recharcher les données
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showLocal" {
                print("segue")
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
        let annce = annonces[indexPath.row]
 
        cell.configure(withEvent: annce)
        return cell
    }
    

  
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
            case .insert:
                tableview.insertSections(IndexSet(integer: sectionIndex), with: .fade)
            case .delete:
                tableview.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
            default:
                return
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
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
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake{
            //print("téléphone secouer")
            tableview.beginUpdates()
        }
    }
    /*
    override  func  motionEnded ( _  motion : UIEvent .EventSubtype , with  event : UIEvent ?) {
         if  motion == .motionShake {
            // shakeLabel .text = "Secoué, pas agité"
        }
    }
  */
}
