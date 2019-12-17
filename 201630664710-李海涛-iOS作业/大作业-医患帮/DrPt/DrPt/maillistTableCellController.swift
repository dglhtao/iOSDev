//
//  maillistTableCellController.swift
//  TableView
//
//  Created by 李海涛 on 2019/11/6.
//  Copyright © 2019年 李海涛. All rights reserved.
//

import UIKit

class maillistTableCellController: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var mainTitle: UITextField!
    @IBOutlet weak var subTitle: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
