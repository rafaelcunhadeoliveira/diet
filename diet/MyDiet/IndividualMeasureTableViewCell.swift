//
//  IndividualMeasureTableViewCell.swift
//  MyDiet
//
//  Created by Rafael Cunha de Oliveira on 22/03/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class IndividualMeasureTableViewCell: UITableViewCell {

    @IBOutlet weak var measureLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
