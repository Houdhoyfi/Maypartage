//
//  AcceuilController.swift
//  Maypartage
//
//  Created by YOUSSOUF HOUDHOYFI on 10/31/20.
//

import UIKit
import CoreData

class AccueilController: UITableViewController,NSFetchedResultsControllerDelegate{
    
    var annonces:[Story]=[]
    var detailViewController: detail? = nil
    @IBOutlet var tableview: UITableView!
    var fetchResultController: NSFetchedResultsController<Story>!

    override func viewDidLoad() {
        super.viewDidLoad()

                // Do any additional setup after loading the view.
        // Récupération des données dans la base de données
        let request: NSFetchRequest<Story> = Story.fetchRequest()
        //let sortDescriptor = NSSortDescriptor(key: "pseudo", ascending: true)
        //fetchRequest.sortDescriptors = [sortDescriptor]
        
        guard let stori = try? AppDelegate.viewContext.fetch(request)
        
        else {
            return
       }
        annonces=stori
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showLocal" {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let controller = (segue.destination as! UINavigationController).topViewController as! detail
                    
                    controller.navigationItem.leftItemsSupplementBackButton = true
                    detailViewController = controller
                }
   
            }
        }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return annonces.count;
        

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AcceuilCell", for: indexPath) as!  TableViewCell
        /*for an in annonces{
            print(an.lieu)
        }*/
        //let annonce =  annonces[5]
        print(indexPath.row)
        
        //cell.configure(withEvent: annonce)
        return cell
   }
    //pour recharcher les données
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }


    
  
}
