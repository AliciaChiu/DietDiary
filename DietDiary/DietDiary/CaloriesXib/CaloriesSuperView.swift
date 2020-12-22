//
//  CaloriesSuperView.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/19.
//

import UIKit

@IBDesignable class CaloriesSuperView: UIView {

    override func prepareForInterfaceBuilder() {
          super.prepareForInterfaceBuilder()
          addXibView()
       }

    func addXibView() {
       if let caloriesView = Bundle(for: CaloriesView.self).loadNibNamed("\(CaloriesView.self)", owner: nil, options: nil)?.first as? UIView {
          addSubview(caloriesView)
          caloriesView.frame = bounds
       }
    }
    
    override func awakeFromNib() {
       super.awakeFromNib()
       addXibView()
    }

}
