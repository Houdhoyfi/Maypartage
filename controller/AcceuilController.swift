//
//  AcceuilController.swift
//  Maypartage
//
//  Created by YOUSSOUF HOUDHOYFI on 10/31/20.
//
//la classe pour qui gère la fil d'actualité des publications
import UIKit
import CoreData
import AVFoundation
class AccueilController:UITableViewController,NSFetchedResultsControllerDelegate{
    var publication:[Story]=[]
    var fetchResultController: NSFetchedResultsController<Story>!
    var detailViewController: detail? = nil
    @IBOutlet var tableview: UITableView!
    @IBOutlet weak var buttonStorie: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.reloadData()
        //spécifié la taille des cellules de la tableView
        tableView.rowHeight=(UIScreen.main.bounds.width / 1.5)
        // Récupération des données dans la base
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
                    publication =  fetchedObjects // Objets trouvés
                }
            } catch {
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.tableView.reloadData()
       
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLocal" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = segue.destination as! detail
                controller.detailItem =  publication[indexPath.row]
                detailViewController = controller
                }
            }
        }
    
    //nombre de section de la tableview
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    // le nombre de ligne du table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return publication.count;
            }
    
    //permet la configuration et création de la cellule qui se trouve à l'indice indexPath
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AcceuilCell", for: indexPath) as! TableViewCell
        cell.layer.cornerRadius = cell.layer.frame.height/12
        let annce = publication[indexPath.row]
        cell.configure(withEvent: annce)
        return cell
    }

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
       
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
    }
    
    //permet de rendre la tableview editable
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
                   return true
            
    }
    
    // permet la suppression d'une publication
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate =  AppDelegate.self
            let context =  appDelegate.viewContext
            let anoncesuppr = self.fetchResultController.object(at: indexPath)
            context.delete(anoncesuppr)
            do {
                try appDelegate.viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    //permet l'ajout , ou la suppression d'une ligne dans la tableView
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
        publication = fetchedObjects as! [Story]
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        
    }

    

}
