//
//  DiaryTableViewCell.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/19.
//

import UIKit
import Kingfisher

protocol DiaryTableViewCellDelegate {
    func editting(record: Record)
}
class DiaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var diaryView: UIView!
    
    @IBOutlet weak var mealLabel: UILabel!
    
    @IBOutlet weak var foodPicture: UIImageView!
    
    @IBOutlet weak var noteTextView: UITextView!
    
    @IBOutlet weak var foodLabel: UILabel!
    
    var record: Record!
    
    var delegate: DiaryTableViewCellDelegate?
    
    func loadCellContent(_ data: Record) {
        
        self.diaryView.layer.cornerRadius = 15
        self.diaryView.layer.shadowColor = UIColor.lightGray.cgColor
        self.diaryView.layer.shadowOpacity = 0.8
        self.diaryView.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.diaryView.layer.masksToBounds = false //系統預設為true，要關掉
        
        self.record = data
        
        let mealName = data.getMealName()
        let time = data.date?.substring(with: 11..<16)
        self.mealLabel.text = mealName + "  " + time!
        
        let imageContent = data.meal_images?.first?.image_content ?? ""
        let url = URL(string: imageContent)
        
        if url != nil {
            self.foodLabel.isHidden = true
            let path = Bundle.main.path(forResource: "loading", ofType: "gif")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            self.foodPicture.kf.indicatorType = .image(imageData: data)
            self.foodPicture.kf.setImage(with: url)
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
        
        if self.record.note != nil && self.record.note != "記錄一下心情吧＾_ ^" {
            self.noteTextView.text = self.record.note
            self.noteTextView.isHidden = false
        }else{
            self.noteTextView.text = ""
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
