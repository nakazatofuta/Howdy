//
//  SettingTableViewCell.swift
//  Howdy
//
//  Created by 中里楓太 on 2023/11/04.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    @IBOutlet weak var settingItemLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
