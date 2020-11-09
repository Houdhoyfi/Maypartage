//
//  TableViewCell.swift
//  Maypartage
//
//  Created by YOUSSOUF HOUDHOYFI on 10/31/20.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var heure: UILabel!
    @IBOutlet weak var lieu: UILabel!
    @IBOutlet weak var imagee: UIImageView!
    @IBOutlet weak var pseudo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(withEvent event: Story){
        self.pseudo.text=event.pseudo
        self.lieu.text=event.lieu
        
        if let data = event.photo as Data?{
            imagee.image = UIImage(data: data)
        }

        /*
        if let data = event.photo as Data?{
            imagee.image = UIImage(data: data)
        }*/
        
      }

}
