//
//  NutrientsSuperView.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/18.
//

import UIKit

@IBDesignable class NutrientsSuperView: UIView {
    
    override func prepareForInterfaceBuilder() {
          super.prepareForInterfaceBuilder()
          addXibView()
       }

    func addXibView() {
       if let nutrientsView = Bundle(for: NutrientsView.self).loadNibNamed("\(NutrientsView.self)", owner: nil, options: nil)?.first as? UIView {
          addSubview(nutrientsView)
          nutrientsView.frame = bounds
       }
    }
    
    override func awakeFromNib() {
       super.awakeFromNib()
       addXibView()
    }

}
