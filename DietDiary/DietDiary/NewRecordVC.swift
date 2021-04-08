//
//  NewRecordVC.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2020/12/17.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import WXImageCompress
import TagListView
import Kingfisher
import StoreKit

protocol NewRecordVCDelegate : class{
    func didFinishUpdate(record : Record)
}

enum Meal: Int {
    case Breakfast = 1
    case Lunch = 2
    case Dinner = 3
    case Dessert = 4
}

class NewRecordVC: UIViewController, TagListViewDelegate {
   
    @IBOutlet weak var foodImageView: UIImageView!

    @IBOutlet weak var noteTextView: UITextView!
    
    @IBOutlet weak var dayTxt: UITextField!
    
    @IBOutlet weak var timeTxt: UITextField!
    
    @IBOutlet weak var addFoodView: TagListView!
    
    @IBOutlet weak var nutrientsSuperView: NutrientsSuperView!
    
    @IBOutlet weak var caloriesSuperView: CaloriesSuperView!
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    @IBOutlet weak var finishBarButtonItem: UIBarButtonItem!
    
    weak var delegate : NewRecordVCDelegate?
    
    var date = Date()
    
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
   
    var record: Record?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.noteTextView.layer.cornerRadius = 10
        self.noteTextView.layer.shadowColor = UIColor.lightGray.cgColor
        self.noteTextView.layer.shadowOpacity = 0.8
        self.noteTextView.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.noteTextView.layer.masksToBounds = false //系統預設為true，要關掉
        
        if let navigationController = self.navigationController {
                    // 修改返回鍵
                    if navigationController.viewControllers.count > 1 && self.navigationItem.hidesBackButton == false {
                        let cancelBtn = UIButton()
                        cancelBtn.setTitle("取消", for: .normal)
                        cancelBtn.titleLabel?.font = UIFont(name: "jf-openhuninn-1.1", size: 17)
                        cancelBtn.addTarget(self, action: #selector(self.backBtnPressed), for: .touchUpInside)
                        let item = UIBarButtonItem(customView: cancelBtn)
                        self.navigationItem.leftBarButtonItem = item
                    }
                }
        
        // 顯示所選record的資料
        if let record = self.record {
            MemoryData.record = record
            addNewFood()
            self.noteTextView.text = MemoryData.record.note
            
            let imageContent = MemoryData.record.meal_images?.first?.image_content ?? ""
            let url = URL(string: imageContent)
            self.foodImageView.kf.setImage(with: url)

            let dateString = MemoryData.record.date?.getDate(format: "yyyy-MM-dd HH:mm:ss")?.getFormattedDate(format: "MM/dd")
            self.title = dateString
            self.dayTxt.text = MemoryData.record.date?.substring(with: 0..<10)
            self.timeTxt.text = MemoryData.record.date?.substring(with: 11..<16)
            let mealName = MemoryData.record.getMealName()
            switch mealName {
            case "早餐":
                self.segmentedControl.selectedSegmentIndex = 0
            case "午餐":
                self.segmentedControl.selectedSegmentIndex = 1
            case "晚餐":
                self.segmentedControl.selectedSegmentIndex = 2
            case "點心":
                self.segmentedControl.selectedSegmentIndex = 3
            default:
                self.segmentedControl.selectedSegmentIndex = 0
            }
        } else {
            

            self.title = self.date.getFormattedDate(format: "今天MM/dd")
            self.dayTxt.text = self.date.getFormattedDate(format: "yyyy-MM-dd")
            self.timeTxt.text = self.date.getFormattedDate(format: "HH:mm")
            
            self.nutrientsSuperView.nutrientsView.dailyCaloriesLabel.text = "已攝取0大卡"
            self.nutrientsSuperView.nutrientsView.grainsLabel.text = "0份"
            self.nutrientsSuperView.nutrientsView.meatsLabel.text = "0份"
            self.nutrientsSuperView.nutrientsView.milkLabel.text = "0份"
            self.nutrientsSuperView.nutrientsView.vegetablesLabel.text = "0份"
            self.nutrientsSuperView.nutrientsView.fruitsLabel.text = "0份"
            self.nutrientsSuperView.nutrientsView.oilsLabel.text = "0份"
            self.caloriesSuperView.caloriesView.setLabel()

            MemoryData.record = Record()
            MemoryData.record.meal = Meal.Breakfast.rawValue
            MemoryData.record.meal_images = []
            MemoryData.record.meal_records = []
            MemoryData.record.delete_meal_images = []
            MemoryData.record.delete_meal_records = []
        }
        
        createDatePicker()
        createTimePicker()
        
        addFoodView.delegate = self
        
        //MARK: - 點擊刪除照片
        
        // 單指輕點
        let singleFinger = UITapGestureRecognizer(target:self, action:#selector(singleTap))

        // 點幾下才觸發 設置 1 時 則是要點兩下才會觸發 依此類推
        singleFinger.numberOfTapsRequired = 1

        // 幾根指頭觸發
        singleFinger.numberOfTouchesRequired = 1

        // 為視圖加入監聽手勢
        self.foodImageView.addGestureRecognizer(singleFinger)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addNewFood()
    }
    
    // MARK: - Back button alertController
    @objc func backBtnPressed() {
        let alertController = UIAlertController(title: "確定要返回上一頁嗎？", message: "返回將不會保留您所做的編輯", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "是的", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            alertController.resignFirstResponder()
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
        }
    
    // MARK: - Choose meal.
    
    @IBAction func mealMayValueChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            MemoryData.record.meal = Meal.Breakfast.rawValue
        case 1:
            MemoryData.record.meal = Meal.Lunch.rawValue
        case 2:
            MemoryData.record.meal = Meal.Dinner.rawValue
        case 3:
            MemoryData.record.meal = Meal.Dessert.rawValue
        default:
            MemoryData.record.meal = Meal.Breakfast.rawValue
        }
    }
    
    // MARK: - Add selected foods.
    func addNewFood() {

        addFoodView.alignment = .left
        addFoodView.removeAllTags()
        self.displayEatenDetail()
        addFoodView.addTags(MemoryData.record.foodNames)
        

    }
    
    func displayEatenDetail(){
        
        MemoryData.record.getEatenFoodDetails()
        
        let eatenCalories = MemoryData.record.eatenCalories.rounding(toDecimal: 1)
        
        self.nutrientsSuperView.nutrientsView.dailyCaloriesLabel.text = "已攝取\(eatenCalories)大卡"
        self.nutrientsSuperView.nutrientsView.grainsLabel.text = "\(MemoryData.record.eatenGrains.rounding(toDecimal: 1))份"
        self.nutrientsSuperView.nutrientsView.meatsLabel.text = "\(MemoryData.record.eatenMeats.rounding(toDecimal: 1))份"
        self.nutrientsSuperView.nutrientsView.milkLabel.text = "\(MemoryData.record.eatenMilk.rounding(toDecimal: 1))份"
        self.nutrientsSuperView.nutrientsView.vegetablesLabel.text = "\(MemoryData.record.eatenVegetables.rounding(toDecimal: 1))份"
        self.nutrientsSuperView.nutrientsView.fruitsLabel.text = "\(MemoryData.record.eatenFruits.rounding(toDecimal: 1))份"
        self.nutrientsSuperView.nutrientsView.oilsLabel.text = "\(MemoryData.record.eatenOils.rounding(toDecimal: 1))份"

        let eatenThreeCalories = MemoryData.record.eatenThreeCalories.rounding(toDecimal: 1)
        if eatenThreeCalories > eatenCalories {
            self.caloriesSuperView.caloriesView.caloriesLabel.text = "\(eatenCalories)大卡"
        }else{
            self.caloriesSuperView.caloriesView.caloriesLabel.text = "\(eatenThreeCalories)大卡"
        }
        
        self.caloriesSuperView.caloriesView.carbohydrateLabel.text = "醣類\n\(MemoryData.record.eatenCarbohydrate.rounding(toDecimal: 1))公克"
        self.caloriesSuperView.caloriesView.proteinLabel.text = "蛋白質\n\(MemoryData.record.eatenProtein.rounding(toDecimal: 1))公克"
        self.caloriesSuperView.caloriesView.fatLabel.text = "脂肪\n\(MemoryData.record.eatenFat.rounding(toDecimal: 1))公克"
    }
    
    
    
    // MARK: - Delete selected foods.
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title)")
        let alertController = UIAlertController(title: "刪除", message: "確定要刪除這項食物嗎？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "是的", style: .default) { (action) in
            if let index = MemoryData.record.meal_records?.firstIndex(where: { (mealRecord) -> Bool in
                return mealRecord.food_name == title
            }) {
                let mealRecord = MemoryData.record.meal_records?[index]
                if let id = mealRecord?.id {
                    MemoryData.record.delete_meal_records.append(id)
                }
                MemoryData.record.meal_records?.remove(at: index)
                self.displayEatenDetail()
                self.addFoodView.removeTag(title)
                
            }
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            alertController.resignFirstResponder()
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)

    }
    
    //MARK: - Delete picture.
    
    // 觸發單指輕點兩下手勢後 執行的動作
    @objc func singleTap(recognizer:UITapGestureRecognizer){
       
        if self.foodImageView.image != nil {
            let alertController = UIAlertController(title: "刪除", message: "確定要刪除這張照片嗎？", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "是的", style: .default) { (action) in
                
                 if let id = MemoryData.record.meal_images?.first?.id {
                     self.foodImageView.image = nil
                     MemoryData.record.meal_images?.removeAll()
                     MemoryData.record.delete_meal_images = [id]
                     print("刪除成功")

                 }else{
                    self.foodImageView.image = nil
                 }
            }
            let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
                alertController.resignFirstResponder()
            }
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Post to database.
    @IBAction func done(_ sender: Any) {
        
        // 準備要存的資料
        MemoryData.record.user_unique_id = MemoryData.userInfo?.unique_id

        if self.noteTextView.text != "" {
            MemoryData.record.note = self.noteTextView.text
        } else {
            MemoryData.record.note = nil
        }
        
        MemoryData.record.date = self.dayTxt.text! + " " + self.timeTxt.text!
        
        if let image = self.foodImageView.image {
            let thumbImage = image.wxCompress()
            let imageBase64 = thumbImage.jpegData(compressionQuality: 0.0)?.base64EncodedString() ?? ""

            let mealImage = MealImage()
            mealImage.image_content = "data:image/jpeg;base64," + imageBase64
            MemoryData.record.meal_images?.append(mealImage)
        }
        
        let parameters = MemoryData.record.toJSON()
        print(parameters)
        
        // 呼叫API
        self.finishBarButtonItem.isEnabled = false
        Alamofire.request(URLs.mealRecordsURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<BaseResponseData>) in
            if response.result.isSuccess {
                print(response.result.value?.toJSON())
                
                self.delegate?.didFinishUpdate(record: MemoryData.record)
                self.navigationController?.popViewController(animated: true)
            }
            self.finishBarButtonItem.isEnabled = true
        }
        
        if #available(iOS 13.4, *) {
            SKStoreReviewController.requestReview()
        }
        
        
        
    }
    
    // MARK: - Prepare camera.
    @IBAction func camera(_ sender: Any) {
        
        if self.foodImageView.image != nil {
            if let id = MemoryData.record.meal_images?.first?.id {
                //self.foodImageView.image = nil
                MemoryData.record.meal_images?.removeAll()
                MemoryData.record.delete_meal_images = [id]
                print("刪除成功")
            }
        }
        
        let photoSourceRequestController = UIAlertController(title: "", message: "請選擇使用相機或相簿", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "相機", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .camera
                guard UIImagePickerController.isCameraDeviceAvailable(.front) else {
                    print("Invalid camera device.")
                    return
                }
                imagePicker.cameraDevice = .front
                imagePicker.cameraCaptureMode = .photo
                imagePicker.delegate = self
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        
        let photoLibraryAction = UIAlertAction(title: "相簿", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            photoSourceRequestController.resignFirstResponder()
        }
        
        photoSourceRequestController.addAction(cameraAction)
        photoSourceRequestController.addAction(photoLibraryAction)
        photoSourceRequestController.addAction(cancelAction)
        
        present(photoSourceRequestController, animated: true, completion: nil)
        
    }
    
//    // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//    }

}

// MARK: - Choose date and time.

extension NewRecordVC {
    
    //Meal Date.
    func createDatePicker() {
        
        dayTxt.textAlignment = .center
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneAction))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelAction))
        toolbar.setItems([cancelBtn, flexibleSpace, doneBtn], animated: true)
        
        //assign toolbar
        self.dayTxt.inputAccessoryView = toolbar
        
        //assign date picker to the text field.
        self.dayTxt.inputView = datePicker
        
        //date picker mode
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
    }
    
    @objc func doneAction() {
        //formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "zh_TW")
        dayTxt.text = formatter.string(from: datePicker.date)
        self.date = datePicker.date
        
        let dateString = self.date.getFormattedDate(format: "yyyy-MM-dd")
        let todayString = Date().getFormattedDate(format: "yyyy-MM-dd")
        if  dateString == todayString {
            self.title = self.date.getFormattedDate(format: "今天MM/dd")
        }else{
            self.title = self.date.getFormattedDate(format: "MM/dd")
        }
        
        self.view.endEditing(true)
    }
    
    @objc func cancelAction() {
        self.dayTxt.resignFirstResponder()
    }

    
    //Meal Time.
    func createTimePicker() {
        
        timeTxt.textAlignment = .center
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelPressed))
        toolbar.setItems([cancelBtn, flexibleSpace, doneBtn], animated: true)
        
        //assign toolbar
        self.timeTxt.inputAccessoryView = toolbar
        
        //assign date picker to the text field.
        self.timeTxt.inputView = timePicker
        
        //date picker mode
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.datePickerMode = .time
        
    }
    
    @objc func donePressed() {
        //formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "zh_TW")
        
        timeTxt.text = formatter.string(from: timePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelPressed() {
        self.timeTxt.resignFirstResponder()
    }
    
}








extension NewRecordVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        self.foodImageView.image = image
        self.dismiss(animated: true, completion: nil)
        
        
        
        
//        if self.foodImageView.image != nil {
//            if let id = MemoryData.record.meal_images?.first?.id {
//                //self.foodImageView.image = nil
//                MemoryData.record.meal_images?.removeAll()
//                MemoryData.record.delete_meal_images = [id]
//                print("刪除成功")
//
//                let image = info[.originalImage] as! UIImage
//                self.foodImageView.image = image
//                self.dismiss(animated: true, completion: nil)
//            }else{
//                let image = info[.originalImage] as! UIImage
//                self.foodImageView.image = image
//                self.dismiss(animated: true, completion: nil)
//            }
//        }
    }
}
