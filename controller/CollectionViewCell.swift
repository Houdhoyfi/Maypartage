//
//  CollectionViewCell.swift
//  Maypartage
//
//  Created by YOUSSOUF HOUDHOYFI on 21/11/2020.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pseudo: UILabel!
    
    @IBOutlet weak var imageStorie: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageStorie.layer.masksToBounds=true
       imageStorie.layer.cornerRadius = 100
        
    }
    
    
    func configure(withEvent event: Story2){
        if let data = event.photo as Data?{
            imageStorie.image = UIImage(data: data)
        }
    }
    
    
}
