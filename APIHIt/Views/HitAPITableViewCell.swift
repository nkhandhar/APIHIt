//
//  HitAPITableViewCell.swift
//  APIHIt
//
//  Created by Macbook Pro on 29/12/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class HitAPITableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCreatedAtDate: UILabel!
    @IBOutlet weak var setSelectionSwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
