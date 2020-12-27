//
//  NutrientsSuperView.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/18.
//

import UIKit

class NutrientsSuperView: UIView {
    
    var nutrientsView: NutrientsView!
    
    override func prepareForInterfaceBuilder() {
          super.prepareForInterfaceBuilder()
          addXibView()
       }

    func addXibView() {
        if let nutrientsView = Bundle(for: NutrientsView.self).loadNibNamed("\(NutrientsView.self)", owner: nil, options: nil)?.first as? NutrientsView {
            addSubview(nutrientsView)
            nutrientsView.frame = bounds
            self.nutrientsView = nutrientsView
        }
    }
    
    override func awakeFromNib() {
       super.awakeFromNib()
       addXibView()
    }

}
