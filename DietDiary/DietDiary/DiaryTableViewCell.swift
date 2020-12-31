//
//  DiaryTableViewCell.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/19.
//

import UIKit

class DiaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mealLabel: UILabel!
    
    @IBOutlet weak var foodPicture: UIImageView!
    
    @IBOutlet weak var noteTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
