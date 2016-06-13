//
//  DetailViewController.swift
//  project00
//
//  Created by moktaesu on 2016. 5. 22..
//  Copyright © 2016년 Sabi Park. All rights reserved.
//  back버튼(버튼 나중에 이미지 씌울 예정) 05.22
// 피커뷰 내용 변경할 예정 05.30
import UIKit

class DetailViewController: UIViewController,UIPickerViewDataSource {

    var left = ["봄","여름","가을","겨울"]
    var tips:[String] = []
    var tipsImage:[String] = []
    
    let spring = ["황사예보","황사특보"]
    let springImages = ["K-135.png","K-136.png"]

    let summer = ["폭염대비","폭염주의보"]
    let summerImages = ["K-137.png","K-138.png"]

    let autumn = ["호우주의보","호우경보"]
    let autumnImages = ["K-139.png","K-140.png"]

    let winter = ["대설주의보","한파건강관리"]
    let winterImages = ["K-141.png","K-142.png"]

    @IBOutlet weak var imageView: UIImageView!
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    
    @IBOutlet weak var myPicker: UIPickerView!
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return left.count
        }
        else {
            return tips.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row:Int, forComponent component: Int) -> String? {
        if component == 0 {
            return left[row]
        }
        else {
            return tips[row]
        }
        
        print("**************")
        print(1)
        print(row)
        print(component)
        print("-------------")
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if component == 0 && row == 0 {
            tips = spring
            tipsImage = springImages
            
        }
        else if component == 0 && row == 1 {
            tips = summer
            tipsImage = summerImages
        }
            
        else if component == 0 && row == 2 {
            tips = autumn
            tipsImage = autumnImages
        }
            
        else if component == 0 && row == 3 {
            tips = winter
            tipsImage = winterImages
        }
        
        pickerView.reloadAllComponents()
        
        imageView.image = UIImage(named: tipsImage[pickerView.selectedRowInComponent(1)])
        
    }

    @IBAction func backButtonAction(sender: AnyObject) {
        //self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tips = spring
        // Do any additional setup after loading the view.
        tipsImage = springImages
        //myPicker.reloadAllComponents()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
