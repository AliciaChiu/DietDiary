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
    
    var diary: DiaryTableViewCell?
    
    weak var delegate : NewRecordVCDelegate?
   
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 184/255, alpha: 1)
        let today = Date()
        self.title = today.getFormattedDate(format: "今天MM/dd")
        self.dayTxt.text = today.getFormattedDate(format: "yyyy-MM-dd")
        self.timeTxt.text = today.getFormattedDate(format: "HH:mm")
        
        
        MemoryData.record = Record()
        MemoryData.record.meal = Meal.Breakfast.rawValue
        MemoryData.record.meal_images = []
        MemoryData.record.meal_records = []
        MemoryData.record.delete_meal_images = []
        MemoryData.record.delete_meal_records = []
        
    }

    //準備相機
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
    

    @IBAction func done(_ sender: Any) {
        
        // 準備要存的資料
        MemoryData.record.user_unique_id = MemoryData.userInfo?.unique_id
        MemoryData.record.note = self.noteTextView.text
        MemoryData.record.date = self.dayTxt.text! + " " + self.timeTxt.text!
        
        if let image = self.foodImageView.image {
            let thumbImage = image.wxCompress()
            let imageBase64 = thumbImage.jpegData(compressionQuality: 0.0)?.base64EncodedString() ?? ""

            let mealImage = MealImage()
            mealImage.image_content = imageBase64
            MemoryData.record.meal_images?.append(mealImage)
        }

        
        let mealRecord = MealRecord()
        mealRecord.food_name = "珍珠奶茶"
        mealRecord.eaten_calories = 120.0
        mealRecord.grains = 1.0
        mealRecord.meats = 2.0
        mealRecord.oils = 3.0
        mealRecord.milk = 1.1
        mealRecord.vegetables = 2.2
        mealRecord.fruits = 1.1
        mealRecord.threeCalories = 2.2
        mealRecord.carbohydrate = 1.1
        mealRecord.protein = 2.2
        mealRecord.fat = 1.1

        MemoryData.record.meal_records?.append(mealRecord)

//        MemoryData.record.delete_meal_records = [3]
//        MemoryData.record.meal_records?.removeAll(where: { (mr) -> Bool in
//            return mr.id == 3
//        })
        
        let parameters = MemoryData.record.toJSON()
//        print(parameters)
        // 呼叫API
        
        Alamofire.request(URLs.mealRecordsURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<BaseResponseData>) in
            
            //self.indicatorView.stopAnimating()

            if response.result.isSuccess {
                print(response.result.value?.toJSON())
                self.delegate?.didFinishUpdate(record: MemoryData.record)
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        
        
        
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewRecordVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        self.foodImageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
}
