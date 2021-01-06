//
//  DiaryTableViewCell.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/19.
//

import UIKit

protocol DiaryTableViewCellDelegate {
    func editting(record: Record)
}
class DiaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mealLabel: UILabel!
    
    @IBOutlet weak var foodPicture: UIImageView!
    
    @IBOutlet weak var noteTextView: UITextView!
    
    @IBOutlet weak var foodLabel: UILabel!
    
    var record: Record!
    
    var delegate: DiaryTableViewCellDelegate?
    
    func loadCellContent(_ data: Record) {
        
        self.record = data
        
        let mealName = data.getMealName()
        let time = data.date?.substring(with: 11..<16)
        self.mealLabel.text = mealName + "  " + time!
        let image = data.meal_images?.first?.image_content?.convertBase64StringToImage()
        
        if image != nil {
            self.foodLabel.isHidden = true
            self.foodPicture.image = image
        } else {
            self.foodLabel.isHidden = false
            var foodNames = ""
            data.getEatenFoodDetails()
            for t in data.foodNames {
                foodNames = foodNames + "\n" + t
            }
            print(foodNames)
            self.foodLabel.text = foodNames
            self.foodPicture.image = UIImage(named: "defult")
        }
        
        if data.note != nil {
            self.noteTextView.text = data.note
            self.noteTextView.isHidden = false
        }else{
            self.noteTextView.text = nil
            self.noteTextView.isHidden = true
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Edit record

    @IBAction func edittingBtnPressed(_ sender: UIButton) {
        self.delegate?.editting(record: self.record)
    }

}
