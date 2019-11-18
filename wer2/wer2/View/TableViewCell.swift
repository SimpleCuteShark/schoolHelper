//
//  TableViewCell.swift
//  wer2
//
//  Created by Alexandr Romantsov on 06.11.2019.
//  Copyright © 2019 Alexandr Romantsov. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
