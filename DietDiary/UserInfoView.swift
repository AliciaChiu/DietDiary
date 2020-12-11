//
//  UserInfoView.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/11.
//

import Foundation
import UIKit

class UserInfoView: UIView {
    
    var titleLabel: UILabel!
    
    var infotextField: UITextField?
    
    var unitLabel: UILabel?
    
    
    //MARK: 位置
    let interval: CGFloat = 40.0 //間隔
    var userInfoViewY: CGFloat = 0
    let maxWidthRate: CGFloat = 0.7 //對話框的寬度為螢幕寬的70%
    let sidePadingRate: CGFloat = 0.02 //對話框與左右邊緣的距離
    let contentMargin: CGFloat = 2.0 //titleLabel與userInfoView的間距
    let textFontSize: CGFloat = 14.0
    let titleLabelWidthRate: CGFloat = 0.25
    
    
    

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
   init(offsetY: CGFloat, fullWidth: CGFloat) {
        
        super.init(frame: .zero)
        
        //MARK: - UserInfoView的寬高
        func caculateFrame(offsetY: CGFloat, fullWidth: CGFloat) -> CGRect {
            
            let sidePadding = fullWidth * sidePadingRate
            let maxWidth = fullWidth * maxWidthRate
            let offsetX = fullWidth - sidePadding - maxWidth
            return CGRect(x: offsetX, y: offsetY, width: maxWidth, height: 60)
        
        }
        let offsetY = userInfoViewY + interval
        let fullWidth = self.widthAnchor as! CGFloat
        self.frame = caculateFrame(offsetY: offsetY, fullWidth: fullWidth)
        
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor(red: 255/255, green: 167/255, blue: 38/255, alpha: 1).cgColor
        self.clipsToBounds = true
            
    
        let titleLabelWidth = fullWidth * titleLabelWidthRate
        let displayFrame1 = CGRect(x: contentMargin, y: interval, width: titleLabelWidth, height: self.frame.height - 2 * contentMargin)
        let titleLabel = UILabel(frame: displayFrame1)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .white
        titleLabel.backgroundColor = UIColor(red: 254/255, green: 198/255, blue: 97/255, alpha: 1)
        self.addSubview(titleLabel)
    
        let infotextFieldWidth: CGFloat = fullWidth - titleLabelWidth
        let displayFrame2 = CGRect(x: contentMargin + fullWidth + 2, y: interval - 2, width: infotextFieldWidth, height: self.frame.height - 2 * contentMargin)
        let infotextField = UITextField(frame: displayFrame2)
        infotextField.textColor = .black
        infotextField.backgroundColor = .white
        self.addSubview(infotextField)
    }
}
