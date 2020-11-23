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
        //view.backgroundColor=UIColor.red
        //view.isOpaque=true
        configureView()
    }
    
    
    func configureView() {
        if let detail = detailItem {
            print("config")
            if let imagee = self.photo {
                imagee.image = UIImage(data: (detail.photo as Data?)!)
            }
            
        }
    }
    
    var detailItem: Story2? {
        didSet {
            configureView()
            
        }
    }
}
