//
//  NutrientsTableViewCell.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/18.
//

import UIKit

class NutrientsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var detailBtn: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
            detailBtn.layer.cornerRadius = 15.0
            detailBtn.layer.shadowColor = UIColor.systemGray6.cgColor
            detailBtn.layer.shadowOpacity = 0.8
            detailBtn.layer.shadowOffset = CGSize(width: 2, height: 2)
            detailBtn.layer.masksToBounds = false


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    


}
