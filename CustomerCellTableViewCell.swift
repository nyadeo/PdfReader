//
//  CustomerCellTableViewCell.swift
//  AssProject
//
//  Created by Jeph B on 17/02/2017.
//  Copyright © 2017 DEO NYAMPETA. All rights reserved.
//

import UIKit

class CustomerCellTableViewCell: UITableViewCell {
    @IBOutlet weak var pdfview: UIImageView!
    @IBOutlet weak var bookTile: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func costomizeCell(title : String?,image : String?){
        
        self.bookTile.text = title
        self.pdfview.image = UIImage(named: image!)
        
    }


}
