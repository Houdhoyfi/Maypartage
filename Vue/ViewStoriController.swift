//
//  ViewStoriController.swift
//  Maypartage
//
//  Created by YOUSSOUF HOUDHOYFI on 23/11/2020.
//

import UIKit
import CoreData
class ViewStoriController : UIViewController{
    
    @IBOutlet weak var vue: UIView!
    @IBOutlet weak var navigat: UINavigationBar!
    @IBOutlet weak var photo: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    //Configuration de la vue pour afficher la photo correspondante
    //de la Collection Viewcell
    func configureView() {
        if let phot = PhotoStorie {
            if let imagee = self.photo {
                imagee.image = UIImage(data: (phot.photo as Data?)!)
            }
        }
    }
    
    var PhotoStorie: Story2? {
        didSet {
            configureView()
            
        }
    }
    
}
