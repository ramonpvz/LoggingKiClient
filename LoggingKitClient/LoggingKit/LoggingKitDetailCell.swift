//
//  LoggingKitDetailCell.swift
//  LoggingKitClient
//
//  Created by ramon.pineda on 2/16/17.
//  Copyright © 2017 Home. All rights reserved.
//

import UIKit

class LoggingKitDetailCell : UITableViewCell
{

    @IBOutlet weak var level_img: UIImageView!
    @IBOutlet weak var service_lab: UILabel!
    @IBOutlet weak var timestamp_lab: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
