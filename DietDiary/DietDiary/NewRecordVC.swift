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

protocol NewRecordVCDelegate : class{
    func didFinishUpdate(record : Record)
}

enum Meal: Int {
    case Breakfast = 1
    case Lunch = 2
    case Dinner = 3
    case Dessert = 4
}

class NewRecordVC: UIViewController {
   
    @IBOutlet weak var foodImageView: UIImageView!

    @IBOutlet weak var noteTextView: UITextView!
    
    @IBOutlet weak var dayTxt: UITextField!
    
    @IBOutlet weak var timeTxt: UITextField!
    
    @IBOutlet weak var addFoodView: TagListView!
    
    @IBOutlet weak var nutrientsSuperView: NutrientsSuperView!
    
    @IBOutlet weak var caloriesSuperView: CaloriesSuperView!
    
    weak var delegate : NewRecordVCDelegate?
    
    var date = Date()
    
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 184/255, alpha: 1)
        
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
        
        createDatePicker()
        createTimePicker()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addNewFood()
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
    
    // MARK: - Choose date and time.
    
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
        self.title = self.date.getFormattedDate(format: "MM/dd")
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

    
    // MARK: - Prepare camera.
    @IBAction func camera(_ sender: Any) {
        
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
        
        photoSourceRequestController.addAction(cameraAction)
        photoSourceRequestController.addAction(photoLibraryAction)
        
        present(photoSourceRequestController, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Add selected foods.
    func addNewFood() {

        addFoodView.textFont = UIFont.systemFont(ofSize: 15)
        addFoodView.alignment = .left 
        addFoodView.removeAllTags()
        addFoodView.addTags(MemoryData.record.foodNames)
        
        print(MemoryData.record.foodNames)

        self.nutrientsSuperView.nutrientsView.dailyCaloriesLabel.text = "已攝取\(Int(MemoryData.record.eatenCalories))大卡"
        self.nutrientsSuperView.nutrientsView.grainsLabel.text = "\(MemoryData.record.eatenGrains)份"
        self.nutrientsSuperView.nutrientsView.meatsLabel.text = "\(MemoryData.record.eatenMeats)份"
        self.nutrientsSuperView.nutrientsView.milkLabel.text = "\(MemoryData.record.eatenMilk)份"
        self.nutrientsSuperView.nutrientsView.vegetablesLabel.text = "\(MemoryData.record.eatenVegetables)份"
        self.nutrientsSuperView.nutrientsView.fruitsLabel.text = "\(MemoryData.record.eatenFruits)份"
        self.nutrientsSuperView.nutrientsView.oilsLabel.text = "\(MemoryData.record.eatenOils)份"

        self.caloriesSuperView.caloriesView.caloriesLabel.text = "\(Int(MemoryData.record.eatenThreeCalories))大卡"
        self.caloriesSuperView.caloriesView.carbohydrateLabel.text = "醣類\n\(Int(MemoryData.record.eatenCarbohydrate))公克"
        self.caloriesSuperView.caloriesView.proteinLabel.text = "蛋白質\n\(Int(MemoryData.record.eatenProtein))公克"
        self.caloriesSuperView.caloriesView.fatLabel.text = "脂肪\n\(Int(MemoryData.record.eatenFat))公克"
        
        //addFoodView.insertTag("This should be the second tag", at: 1)
    }
    
    // MARK: - Post to database.
    @IBAction func done(_ sender: Any) {
        
        // 準備要存的資料
        MemoryData.record.user_unique_id = MemoryData.userInfo?.unique_id
        //有問題
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
            mealImage.image_content = imageBase64
            MemoryData.record.meal_images?.append(mealImage)
        }


//        MemoryData.record.delete_meal_records = [3]
//        MemoryData.record.meal_records?.removeAll(where: { (mr) -> Bool in
//            return mr.id == 3
//        })
        
        let parameters = MemoryData.record.toJSON()
//        print(parameters)
        
        // 呼叫API
        Alamofire.request(URLs.mealRecordsURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<BaseResponseData>) in
            if response.result.isSuccess {
                print(response.result.value?.toJSON())
                self.delegate?.didFinishUpdate(record: MemoryData.record)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "foodListSegue" {
//            if let vc = segue.destination as? FoodListViewController {
//                vc.delegate = self
//            }
//        }
    }

}


extension NewRecordVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        self.foodImageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
}
