//
//  StationInfoViewController.swift
//  GPSMap
//
//  Created by kpugame on 2016. 5. 30..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import UIKit


class StationInfoViewController: UIViewController, NSXMLParserDelegate {

    //fdust
    @IBOutlet weak var COImage: UIImageView!
    @IBOutlet weak var O3Image: UIImageView!
    @IBOutlet weak var NO2Image: UIImageView!
    @IBOutlet weak var SO2Image: UIImageView!
    @IBOutlet weak var PM10Image: UIImageView!
    
    @IBOutlet weak var SO2label: UILabel!
    @IBOutlet weak var O3label: UILabel!
    @IBOutlet weak var NO2label: UILabel!
    @IBOutlet weak var PM10label: UILabel!
    @IBOutlet weak var COlabel: UILabel!
    
    @IBOutlet weak var Totallabel: UILabel!
    @IBOutlet weak var Totalval: UILabel!
    @IBOutlet weak var Time: UILabel!
       @IBOutlet weak var topNaviBar: UINavigationItem!
    
    var fdust = FDust()
     var element = NSString()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if gSelected == nil
        {
            Totallabel.text = "데이터가 없습니다"
            return
        }
        
        //fdust.initData()
        updateFineDust()
        
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        
        //print("Element's name is \(elementName)")
        //print("Element's attributes are \(attributeDict)")
        
        element = elementName
       
        
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName
        qName: String?) {
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
            
            if fdust.StationName == "" && element.isEqualToString("stationName"){
                fdust.StationName.appendString(string)
            }
            if fdust.khaival == "" && element.isEqualToString("khaiValue")
            {
                fdust.khaival.appendString(string)
            }
            if fdust.pm10val == "" && element.isEqualToString("pm10Value")
            {
                fdust.khaival.appendString(string)
            }
            if fdust.coGrade == "" && element.isEqualToString("coGrade")
            {
                fdust.coGrade.appendString(string)
            }
            if fdust.khaiGrade == "" && element.isEqualToString("khaiGrade")
            {
                fdust.khaiGrade.appendString(string)
            }
            if fdust.pm10Grade == "" && element.isEqualToString("pm10Grade")
            {
                fdust.pm10Grade.appendString(string)
            }
            if fdust.so20Grade == "" && element.isEqualToString("so2Grade")
            {
                fdust.so20Grade.appendString(string)
            }
            if fdust.no2Grade == "" && element.isEqualToString("no2Grade")
            {
                fdust.no2Grade.appendString(string)
            }
            if fdust.o3Grade == "" && element.isEqualToString("o3Grade")
            {
                fdust.o3Grade.appendString(string)
            }
            if fdust.date == "" && element.isEqualToString("dataTime")
            {
                fdust.date.appendString(string)
            }
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print("1Errors : " + parseError.localizedDescription)
    }
    
    func updateFineDust()
    {
        //좌표 변경
        
        
        fdust.initData()
        
        let statok = gSelected?.title
        if statok != nil
        {
        
            let stastr = statok!.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
                    
            let url3 = NSURL(string: "http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?ServiceKey=FP%2FiwwjB77fb91p8thmSHdCSUwA2HYXngb4%2BASF0gpCZGiLtBkjfIllK9ELIuJ8knLVdl3Ay9mIWSjMYfC5GsQ%3D%3D&numOfRows=10&pageSize=10&pageNo=1&startPage=1&stationName=" + stastr! + "&dataTerm=DAILY")
        
            fdust.StationName.appendString(statok!)
            
            if url3 != nil
            {
                let xmlParser = NSXMLParser(contentsOfURL: url3!)!
                xmlParser.delegate = self
                xmlParser.parse()
                //측정소 정보 받기
                
                setupDustView()
            }
        }
    
    }
    
    func setupDustView() {
        
        if fdust.StationName != ""
        {
            topNaviBar.title = "측정소 : " + ((fdust.StationName) as String)
        }
        
        if fdust.khaival != ""
        {
            Totalval.text = fdust.khaival as String
        }else{
            Totalval.text = "???"
        }
        
        if fdust.khaiGrade == "1"
        {
            Totallabel.text  = "좋음"
            view.backgroundColor = UIColor(red: CGFloat(156.0/255.0), green: CGFloat(170.0/255.0), blue: CGFloat(236.0/255.0), alpha: CGFloat(1.0))
        }else if fdust.khaiGrade == "2"
        {
            Totallabel.text  = "보통"
            view.backgroundColor = UIColor(red: CGFloat(118.0/255.0), green: CGFloat(213.0/255.0), blue: CGFloat(138.0/255.0), alpha: CGFloat(1.0))
        }else if fdust.khaiGrade == "3"
        {
            Totallabel.text  = "나쁨"
            view.backgroundColor = UIColor(red: CGFloat(236.0/255.0), green: CGFloat(205.0/255.0), blue: CGFloat(105.0/255.0), alpha: CGFloat(1.0))
        }else if fdust.khaiGrade == "4"
        {
            Totallabel.text  = "매우나쁨"
            view.backgroundColor = UIColor(red: CGFloat(226.0/255.0), green: CGFloat(114.0/255.0), blue: CGFloat(134.0/255.0), alpha: CGFloat(1.0))
        }else{
            Totallabel.text  = "정보없음"
            view.backgroundColor = UIColor(red: CGFloat(156.0/255.0), green: CGFloat(170.0/255.0), blue: CGFloat(236.0/255.0), alpha: CGFloat(1.0))
        }
        
        if fdust.date != ""
        {
            Time.text = fdust.date as String
        }
        
        
        if fdust.no2Grade != ""
        {
            if fdust.no2Grade == "1"
            {
                NO2label.text = "좋음"
                NO2Image.image = UIImage(named: "1")
            }else if fdust.no2Grade == "2"
            {
                NO2label.text = "보통"
                NO2Image.image = UIImage(named: "2")
            }else if fdust.no2Grade == "3"
            {
                NO2label.text = "나쁨"
                NO2Image.image = UIImage(named: "3")
            }else if fdust.no2Grade == "4"
            {
                NO2label.text = "매우나쁨"
                NO2Image.image = UIImage(named: "4")
            }else
            {
                NO2label.text = "정보없음"
                NO2Image.image = UIImage(named: "1")
            }
        }else{
            NO2label.text = "정보없음"
        }
        
        
        if fdust.coGrade != ""
        {
            if fdust.coGrade == "1"
            {
                COlabel.text = "좋음"
                COImage.image = UIImage(named: "1")
            }else if fdust.coGrade == "2"
            {
                COlabel.text = "보통"
                COImage.image = UIImage(named: "2")
            }else if fdust.coGrade == "3"
            {
                COlabel.text = "나쁨"
                COImage.image = UIImage(named: "3")
            }else if fdust.coGrade == "4"
            {
                COlabel.text = "매우나쁨"
                COImage.image = UIImage(named: "4")
            }else
            {
                COlabel.text = "정보없음"
            }
        }else{
            COlabel.text = "정보없음"
        }
        
        
        if fdust.o3Grade != ""
        {
            if fdust.o3Grade == "1"
            {
                O3label.text = "좋음"
                O3Image.image = UIImage(named: "1")
            }else if fdust.o3Grade == "2"
            {
                O3label.text = "보통"
                O3Image.image = UIImage(named: "2")
            }else if fdust.o3Grade == "3"
            {
                O3label.text = "나쁨"
                O3Image.image = UIImage(named: "3")
            }else if fdust.o3Grade == "4"
            {
                O3label.text = "매우나쁨"
                O3Image.image = UIImage(named: "4")
            }else
            {
                O3label.text = "정보없음"
            }
        }else{
            O3label.text = "정보없음"
        }
        
        
        if fdust.pm10Grade != ""
        {
            if fdust.pm10Grade == "1"
            {
                PM10label.text = "좋음"
                PM10Image.image = UIImage(named: "1")
            }else if fdust.pm10Grade == "2"
            {
                PM10label.text = "보통"
                PM10Image.image = UIImage(named: "2")
            }else if fdust.pm10Grade == "3"
            {
                PM10label.text = "나쁨"
                PM10Image.image = UIImage(named: "3")
            }else if fdust.pm10Grade == "4"
            {
                PM10label.text = "매우나쁨"
                PM10Image.image = UIImage(named: "4")
            }else
            {
                PM10label.text = "정보없음"
                PM10Image.image = UIImage(named: "1")
            }
        }else{
            PM10label.text = "정보없음"
        }
        
        
        if fdust.so20Grade != ""
        {
            if fdust.so20Grade == "1"
            {
                SO2label.text = "좋음"
                SO2Image.image = UIImage(named: "1")
            }else if fdust.so20Grade == "2"
            {
                SO2label.text = "보통"
                SO2Image.image = UIImage(named: "2")
            }else if fdust.so20Grade == "3"
            {
                SO2label.text = "나쁨"
                SO2Image.image = UIImage(named: "3")
            }else if fdust.so20Grade == "4"
            {
                SO2label.text = "매우나쁨"
                SO2Image.image = UIImage(named: "4")
            }else
            {
                SO2label.text = "정보없음"
            }
        }else{
            SO2label.text = "정보없음"
        }
        
        
    }
    
}
