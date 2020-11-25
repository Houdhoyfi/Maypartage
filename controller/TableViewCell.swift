//
//  TableViewCell.swift
//  Maypartage
//
//  Created by YOUSSOUF HOUDHOYFI on 10/31/20.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var heure: UILabel!
    @IBOutlet weak var imagee: UIImageView!
    @IBOutlet weak var pseudo: UILabel!
    
    @IBOutlet weak var MiniDesc: UILabel!
    @IBOutlet weak var vue: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

  //configuration de la tableview cell
    func configure(withEvent event: Story){
        self.pseudo.text=event.pseudo
        self.heure.text=event.heure
        self.MiniDesc.text=event.desc
        
        if let data = event.photo as Data?{
            imagee.image = UIImage(data: data)
        }
      }

}
