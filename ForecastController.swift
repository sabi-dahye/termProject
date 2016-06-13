//
//  ForecastController.swift
//  forecast
//
//  Created by kpugame on 2016. 6. 6..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import UIKit

class FoodPoision{
    var areaNo = NSMutableString()
    var date = NSMutableString()
    var today = NSMutableString()
    var tomorrow = NSMutableString()
    var dayAfterTomorrow = NSMutableString()
    
    init ()
    {
         initData()
    }
    
    func initData()
    {
        areaNo = ""
        date = ""
        today = ""
        tomorrow = ""
        dayAfterTomorrow = ""
    }
}

class UltraViolet{
    var areaNo = NSMutableString()
    var date = NSMutableString()
    var today = NSMutableString()
    var tomorrow = NSMutableString()
    var dayAfterTomorrow = NSMutableString()
    
    init ()
    {
        initData()
    }
    
    func initData()
    {
        areaNo = ""
        date = ""
        today = ""
        tomorrow = ""
        dayAfterTomorrow = ""
    }
}

class Discomfort{
    var areaNo = NSMutableString()
    var date = NSMutableString()
    var posts = NSMutableArray()
    
    init ()
    {
        initData()
    }
    
    func initData()
    {
        areaNo = ""
        date = ""
        posts = NSMutableArray()
        posts = []
    }
}

class FDust{
    
    var X = NSMutableString()
    var Y = NSMutableString()
    var StationName = NSMutableString()
    
    var date = NSMutableString()
    var pm10val = NSMutableString()
    var khaival = NSMutableString()
    var khaiGrade = NSMutableString()
    var pm10Grade = NSMutableString()
    var o3Grade = NSMutableString()
    var coGrade = NSMutableString()
    var no2Grade = NSMutableString()
    var so20Grade = NSMutableString()
    
    init ()
    {
        initData()
    }
    
    func initData()
    {
        StationName = ""
        date = ""
        X = ""
        Y = ""
        date = ""
        pm10val = ""
        khaival = ""
        pm10Grade = ""
        o3Grade = ""
        no2Grade = ""
        coGrade = ""
        so20Grade = ""
    }
}

class ForecastController: UIViewController, NSXMLParserDelegate  {

    //FP
    let bastTimeData = ["0200","0500","0800","1100","1400","1700","2000","2300" ]
    
    
    @IBOutlet weak var TodayData: UILabel!
    @IBOutlet weak var TomorrowData: UILabel!
    @IBOutlet weak var MoreaData: UILabel!
    @IBOutlet weak var DetailInfo: UILabel!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var naviItem: UINavigationItem!
    
    //discomfort
    @IBOutlet weak var containerView : UIView!
    @IBOutlet weak var InfoView : UIView!
    @IBOutlet weak var graphView : GraphView!
    @IBOutlet weak var averageofValue: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
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
    
    //Forecast
    @IBOutlet weak var Pop: UILabel!
    @IBOutlet weak var Pty: UILabel!
    @IBOutlet weak var Reh: UILabel!
    @IBOutlet weak var Sky: UILabel!
    @IBOutlet weak var T3h: UILabel!
    @IBOutlet weak var Tmx: UILabel!
    @IBOutlet weak var Uuu: UILabel!
    @IBOutlet weak var Vvv: UILabel!
    @IBOutlet weak var Vec: UILabel!
    @IBOutlet weak var Wsd: UILabel!
    
    var isGraphViewShowing = false
   
    @IBAction func counterViewTap(gesture: UITapGestureRecognizer?){
        if isGraphViewShowing {
            
            UIView.transitionFromView(graphView,
            toView: InfoView,
            duration: 1.0,
            options: [UIViewAnimationOptions.TransitionFlipFromLeft,
            UIViewAnimationOptions.ShowHideTransitionViews],
            completion:nil)
            
        } else {
            
            //show Graph
            UIView.transitionFromView(InfoView,
                                      toView: graphView,
                                      duration: 1.0,
                                      options: [UIViewAnimationOptions.TransitionFlipFromRight,
                                        UIViewAnimationOptions.ShowHideTransitionViews],
                                      completion: nil)
        }
        isGraphViewShowing = !isGraphViewShowing
    }


    var city : CityData! = nil

    var elements = NSMutableDictionary()

    var posts = NSMutableArray()
    var stations = NSMutableArray()
    var categoryitem = NSString()
    var element = NSString()
    
    var foodPoision = FoodPoision()
    var discomfort = Discomfort()
    var ultra = UltraViolet()
    var fdust = FDust()
    var townforecast = ForecastData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CityDatas.count != 0 && CurrCityData == nil
        {
            city = CityDatas[0]
            CurrCityData = city
            print(city.Do)
        }
    }
    
    override func setNeedsFocusUpdate()
    {
        if self.title != nil
        {
            if self.title == "TownForecast"
            {
                CurrTab = TabID.forecast
            }
            else if self.title == "UV"
            {
                CurrTab = TabID.UV
            }
            else if self.title == "FineDust"
            {
                CurrTab = TabID.dust
            }
            else if self.title == "FoodPoision"
            {
               CurrTab = TabID.FP
            }
            else if self.title == "Uncomfort"
            {
               CurrTab = TabID.discomfort
                isGraphViewShowing = true
                counterViewTap(nil)
            }
        }
       updateThisView()

    }

    @IBAction func doneToPlayersViewController(segue:UIStoryboardSegue) {
        
        if let playerDetailsViewController = segue.sourceViewController as? ForecastController {
            //add the new player to the players array
            if let player = playerDetailsViewController.city {
               self.city = player
                CurrCityData = player
            }
        }
        
    }
    
    @IBAction func cancleToPlayersViewController(segue:UIStoryboardSegue) {
        
    }
    
    func updateThisView()
    {
        //print(CurrCityData)
        
        if CurrTab == TabID.forecast
        {
            updateForecast()
        }
        else if CurrTab == TabID.FP
        {
            updateFoodPoision()
        }
        else if CurrTab == TabID.discomfort
        {
            updateDiscomfort()
        }
        else if CurrTab == TabID.dust
        {
            updateFineDust()
        }
        else if CurrTab == TabID.UV
        {
            updateUV()
        }
        
        var titletext = ""
        if CurrCityData.Do != ""
        {
            titletext = titletext + " " + CurrCityData.Do
        }
        if CurrCityData.Si != ""
        {
            titletext = titletext + " " + CurrCityData.Si
        }
        if CurrCityData.Dong != ""
        {
            titletext = titletext + " " + CurrCityData.Dong
        }
        
        naviItem.title = titletext
    }
    
    
    func updateForecast()
    {
        
        townforecast.initData()
        
        categoryitem = ""
        
        let now=NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd HHmm"
        dateFormatter.locale = NSLocale(localeIdentifier: "ko_KR")
        //currDate.text=
        let datetime = dateFormatter.stringFromDate(now).componentsSeparatedByString(" ")
    
        var index : Int? = nil
        for i in 0...7{
             index = i
            if  Int(datetime[1]) < Int(bastTimeData[i])! + 30
            {
                break
            }
        }
        
        if index != nil && index != 0
        {
            let url = NSURL(string: "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastSpaceData?serviceKey=FP%2FiwwjB77fb91p8thmSHdCSUwA2HYXngb4%2BASF0gpCZGiLtBkjfIllK9ELIuJ8knLVdl3Ay9mIWSjMYfC5GsQ%3D%3D&base_date=\(datetime[0])&base_time=\(bastTimeData[index!-1])&nx=\(CurrCityData.CoordX)&ny=\(CurrCityData.Coordy)")
            
            
            let MapCoordparser = NSXMLParser(contentsOfURL: url!)!
            MapCoordparser.delegate = self
            MapCoordparser.parse()
            

           setupForecastView()
        }
        else{
            return
        }
    
    }
    
    func updateFoodPoision()
    {
       // print(CurrCityData)
        //print(CityDatas)
        if (foodPoision.areaNo == "") || (Int(foodPoision.areaNo as String) == nil ) || (foodPoision.areaNo as String != CurrCityData.LocalCode)
        {
            foodPoision.initData()
            
            let url = NSURL(string: "http://203.247.66.146/iros/RetrieveLifeIndexService/getFsnLifeList?ServiceKey=FP%2FiwwjB77fb91p8thmSHdCSUwA2HYXngb4%2BASF0gpCZGiLtBkjfIllK9ELIuJ8knLVdl3Ay9mIWSjMYfC5GsQ%3D%3D&AreaNo=\(CurrCityData.LocalCode)&numOfRows=999&pageSize=999&pageNo=1&startPage=1")
            
            //print(url)
            
            let MapCoordparser = NSXMLParser(contentsOfURL: url!)!
            MapCoordparser.delegate = self
            MapCoordparser.parse()
        }
        
        
       // foodPoision.today = "40"
        
        if(foodPoision.today == "")
        {
            foodPoision.today = foodPoision.tomorrow;
        }
        
        
        if (foodPoision.today == "") || (Int(foodPoision.today as String) == nil){
            TodayData.text = "데이터 없음"
            DetailInfo.text = "아직 측정된 정보가 없습니다."
            view.backgroundColor = UIColor(red: CGFloat(156.0/255.0), green: CGFloat(170.0/255.0), blue: CGFloat(236.0/255.0), alpha: CGFloat(1.0))
            
        }else if(Int(foodPoision.today as String) < 35)
        {
            TodayData.text = "관심"
            DetailInfo.text = "식중독 발생가능성은 낮으나\n식중독 예방에 지속적인 관심요망"
            view.backgroundColor = UIColor(red: CGFloat(118.0/255.0), green: CGFloat(213.0/255.0), blue: CGFloat(138.0/255.0), alpha: CGFloat(1.0))
        }else if(Int(foodPoision.today as String) < 70)
        {
            TodayData.text = "주의"
            DetailInfo.text = "식중독 발생가능성이 중간단계입니다\n식중독예방에 주의요망"
            view.backgroundColor = UIColor(red: CGFloat(236.0/255.0), green: CGFloat(205.0/255.0), blue: CGFloat(105.0/255.0), alpha: CGFloat(1.0))
        }else if(Int(foodPoision.today as String) < 95)
        {
            TodayData.text = "경고"
            DetailInfo.text = "식중독 발생가능성이 높습니다\n식중독예방에 경계요망"
            view.backgroundColor = UIColor(red: CGFloat(226.0/255.0), green: CGFloat(114.0/255.0), blue: CGFloat(134.0/255.0), alpha: CGFloat(1.0))
        }else
        {
            TodayData.text = "위험"
            DetailInfo.text = "식중독 발생가능성이 매우 높습니다\n식중독예방에 각별한 경계요망"
            view.backgroundColor = UIColor(red: CGFloat(178.0/255.0), green: CGFloat(35.0/255.0), blue: CGFloat(47.0/255.0), alpha: CGFloat(1.0))
        }
        
        if (foodPoision.tomorrow == "") || (Int(foodPoision.tomorrow as String) == nil){
            TomorrowData.text = "데이터 없음"
        }else if(Int(foodPoision.tomorrow as String) < 35)
        {
            TomorrowData.text = "관심"
        }else if(Int(foodPoision.tomorrow as String) < 70)
        {
            TomorrowData.text = "주의"
        }else if(Int(foodPoision.tomorrow as String) < 95)
        {
            TomorrowData.text = "경고"
        }else
        {
            TomorrowData.text = "위험"
        }
        
        if (foodPoision.dayAfterTomorrow == "") || (Int(foodPoision.dayAfterTomorrow as String) == nil){
            MoreaData.text = "데이터 없음"
        }else if(Int(foodPoision.today as String) < 35)
        {
            MoreaData.text = "관심"
        }else if(Int(foodPoision.today as String) < 70)
        {
            MoreaData.text = "주의"
        }else if(Int(foodPoision.today as String) < 95)
        {
            MoreaData.text = "경고"
        }else
        {
            MoreaData.text = "위험"
        }
        
    
        if foodPoision.date.length < 11
        {
            foodPoision.date.insertString("-", atIndex: 4)
            foodPoision.date.insertString("-", atIndex: 7)
            foodPoision.date.insertString(" ", atIndex: 10)
            foodPoision.date.insertString(":", atIndex: 13)
            foodPoision.date.insertString("0", atIndex: 14)
            foodPoision.date.insertString("0", atIndex: 15)
        }
        
        
        Time.text = foodPoision.date as String
        
        
    }
    
    func updateDiscomfort()
    {
        if (discomfort.areaNo == "") || (Int(discomfort.areaNo as String) == nil ) || (discomfort.areaNo as String != CurrCityData.LocalCode)
        {
            
            discomfort.initData()
            
            let url = NSURL(string: "http://203.247.66.146/iros/RetrieveLifeIndexService/getDsplsLifeList?ServiceKey=FP%2FiwwjB77fb91p8thmSHdCSUwA2HYXngb4%2BASF0gpCZGiLtBkjfIllK9ELIuJ8knLVdl3Ay9mIWSjMYfC5GsQ%3D%3D&AreaNo=\(CurrCityData.LocalCode)&numOfRows=999&pageSize=999&pageNo=1&startPage=1")
            
            //print(url)
            
            let MapCoordparser = NSXMLParser(contentsOfURL: url!)!
            MapCoordparser.delegate = self
            MapCoordparser.parse()
            
            setupGraphDisplay()
        }
        
    }
    
    func updateFineDust()
    {
        //좌표 변경
        fdust.initData()
        
        let url = NSURL(string: "https://apis.daum.net/local/geo/transcoord?apikey=87bf0a8e43c2d479e7ac5ded88d91e1e&fromCoord=WGS84&y=\(CurrCityData.Longtitude)&x=\(CurrCityData.Latitude)&toCoord=TM&output=XML")
        
        
        if url != nil
        {
            //print("url : \(url)")
            let MapCoordparser = NSXMLParser(contentsOfURL: url!)!
            MapCoordparser.delegate = self
            MapCoordparser.parse()
        }
        else
        {
            return
        }
        
        
        //가까운 측정소 찾기
        if (fdust.X != "") && (fdust.Y != ""){
            let url2 = NSURL(string: "http://openapi.airkorea.or.kr/openapi/services/rest/MsrstnInfoInqireSvc/getNearbyMsrstnList?ServiceKey=FP%2FiwwjB77fb91p8thmSHdCSUwA2HYXngb4%2BASF0gpCZGiLtBkjfIllK9ELIuJ8knLVdl3Ay9mIWSjMYfC5GsQ%3D%3D&tmX=\(fdust.X)&tmY=\(fdust.Y)&numOfRows=999&pageSize=999&pageNo=1&startPage=1")
            
            
            if url2 != nil
            {
                let xmlParser = NSXMLParser(contentsOfURL: url2!)!
                xmlParser.delegate = self
                xmlParser.parse()
                //측정소 정보 받기
                
                if fdust.StationName != ""
                {
                    
                    let statok = fdust.StationName.componentsSeparatedByString("\n")
                    let stastr = statok[0].stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
                    
                    let url3 = NSURL(string: "http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?ServiceKey=FP%2FiwwjB77fb91p8thmSHdCSUwA2HYXngb4%2BASF0gpCZGiLtBkjfIllK9ELIuJ8knLVdl3Ay9mIWSjMYfC5GsQ%3D%3D&numOfRows=10&pageSize=10&pageNo=1&startPage=1&stationName=" + stastr! + "&dataTerm=DAILY")
                    
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
        }
    }
    
    func updateUV()
    {
        if (ultra.areaNo == "") || (Int(ultra.areaNo as String) == nil ) || (ultra.areaNo as String != CurrCityData.LocalCode)
        {
            
            ultra.initData()
            
            let url = NSURL(string: "http://203.247.66.146/iros/RetrieveLifeIndexService/getUltrvLifeList?ServiceKey=FP%2FiwwjB77fb91p8thmSHdCSUwA2HYXngb4%2BASF0gpCZGiLtBkjfIllK9ELIuJ8knLVdl3Ay9mIWSjMYfC5GsQ%3D%3D&AreaNo=\(CurrCityData.LocalCode)&numOfRows=999&pageSize=999&pageNo=1&startPage=1")
            
            //print(url)
            
            let MapCoordparser = NSXMLParser(contentsOfURL: url!)!
            MapCoordparser.delegate = self
            MapCoordparser.parse()
        }
        
        //ultra.today = "8"
        
        if (ultra.today == "")
        {
            ultra.today = ultra.tomorrow
        }
        
        if (ultra.today == "") || (Int(ultra.today as String) == nil){
            TodayData.text = "데이터 없음"
            DetailInfo.text = "아직 측정된 정보가 없습니다."
            view.backgroundColor = UIColor(red: CGFloat(156.0/255.0), green: CGFloat(170.0/255.0), blue: CGFloat(236.0/255.0), alpha: CGFloat(1.0))
        }else if(Int(ultra.today as String) < 3)
        {
            TodayData.text = "낮음"
            DetailInfo.text = "햇볕 노출에 대한 보호조치가 필요하지 않습니다\n햇빛에 민감한 피부를 가진분은 자외선 차단제를 발라야 합니다"
            view.backgroundColor = UIColor(red: CGFloat(118.0/255.0), green: CGFloat(213.0/255.0), blue: CGFloat(138.0/255.0), alpha: CGFloat(1.0))
        }else if(Int(ultra.today as String) < 6)
        {
            TodayData.text = "보통"
            DetailInfo.text = "2~3시간 내에도 햇볕에 노출 시 피부 화상을 입을 수 있습니다\n모자, 선글라스를 이용하고 자외선 차단제를 바르세요"
            view.backgroundColor = UIColor(red: CGFloat(236.0/255.0), green: CGFloat(205.0/255.0), blue: CGFloat(105.0/255.0), alpha: CGFloat(1.0))
        }else if(Int(ultra.today as String) < 8)
        {
            TodayData.text = "높음"
            DetailInfo.text = "1~2시간 내에도 피부화상을 입을 수 있습니다\n한낮에는 그늘에 머무르세요\n외출 시 긴소매옷, 모자, 선글라스, 자외선차단제를 이용하세요"
            view.backgroundColor = UIColor(red: CGFloat(226.0/255.0), green: CGFloat(114.0/255.0), blue: CGFloat(134.0/255.0), alpha: CGFloat(1.0))
        }else if(Int(ultra.today as String) < 11)
        {
            TodayData.text = "매우높음"
            DetailInfo.text = "햇볕에 노출 시 수십 분 이내에도 피부 화상을 입을 수 있어 매우 위험합니다\n오전10시 ~ 오후3시까지 외출을 피하고 실내나 그늘에 머무르세요\n외출 시 긴소매옷, 모자, 선글라스를 이용하고 자외선 차단제를 정기적으로 바르세요"
            view.backgroundColor = UIColor(red: CGFloat(226.0/255.0), green: CGFloat(114.0/255.0), blue: CGFloat(134.0/255.0), alpha: CGFloat(1.0))
        }else
        {
            TodayData.text = "위험"
            DetailInfo.text = "햇볕에 노출 시 수십분 이내에도 피부 화상을 입을 수 있어 매우 위험합니다\n가능한 실내에 머무르세요\n외출 시 긴소매옷, 모자, 선글라스를 이용하고 자외선 차단제를 정기적으로 바르세요"
            view.backgroundColor = UIColor(red: CGFloat(255.0/255.0), green: CGFloat(35.0/255.0), blue: CGFloat(47.0/255.0), alpha: CGFloat(1.0))
        }
        
        if (ultra.tomorrow == "") || (Int(ultra.tomorrow as String) == nil){
            TomorrowData.text = "데이터 없음"
        }else if(Int(ultra.tomorrow as String) < 3)
        {
            TomorrowData.text = "낮음"
        }else if(Int(ultra.tomorrow as String) < 6)
        {
            TomorrowData.text = "보통"
        }else if(Int(ultra.tomorrow as String) < 8)
        {
            TomorrowData.text = "높음"
        }else if(Int(ultra.tomorrow as String) < 11)
        {
            TomorrowData.text = "매우높음"
        }else
        {
            TomorrowData.text = "위험"
        }
        
        if (ultra.dayAfterTomorrow == "") || (Int(ultra.dayAfterTomorrow as String) == nil){
            MoreaData.text = "데이터 없음"
        }else if(Int(foodPoision.today as String) < 3)
        {
            MoreaData.text = "낮음"
        }else if(Int(foodPoision.today as String) < 6)
        {
            MoreaData.text = "보통"
        }else if(Int(foodPoision.today as String) < 8)
        {
            MoreaData.text = "높음"
        }else if(Int(foodPoision.today as String) < 11)
        {
            MoreaData.text = "매우높음"
        }else
        {
            MoreaData.text = "위험"
        }
        
       
        
        if ultra.date.length < 11
        {
            ultra.date.insertString("-", atIndex: 4)
            ultra.date.insertString("-", atIndex: 7)
            ultra.date.insertString(" ", atIndex: 10)
            ultra.date.insertString(":", atIndex: 13)
            ultra.date.insertString("0", atIndex: 14)
            ultra.date.insertString("0", atIndex: 15)
        }
        
         Time.text = ultra.date as String
        
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        
        //print("Element's name is \(elementName)")
        //print("Element's attributes are \(attributeDict)")
        
        element = elementName
        elements = NSMutableDictionary()
        elements = [:]
        
        if self.title == "FineDust"
        {
            if elementName == "result"
            {
                fdust.X.appendString(attributeDict["x"]!)
                fdust.Y.appendString(attributeDict["y"]!)
            }
        }
        
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName
        qName: String?) {
        
    }
    
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if self.title != nil
        {
            if self.title == "TownForecast"
            {
                if element.isEqualToString("category")
                {
                    categoryitem = string
                }
                if element.isEqualToString("fcstValue")
                {
                    if categoryitem == "POP"
                    {
                        townforecast.POP.appendString(string)
                    }
                    else if categoryitem == "PTY"
                    {
                         townforecast.PTY.appendString(string)
                    }
                    else if categoryitem == "REH"
                    {
                         townforecast.REH.appendString(string)
                    }
                    else if categoryitem == "SKY"
                    {
                         townforecast.SKY.appendString(string)
                    }
                    else if categoryitem == "T3H"
                    {
                         townforecast.T3H.appendString(string)
                    }
                    else if categoryitem == "TMX"
                    {
                         townforecast.TMX.appendString(string)
                    }
                    else if categoryitem == "UUU"
                    {
                         townforecast.UUU.appendString(string)
                    }
                    else if categoryitem == "VEC"
                    {
                         townforecast.VEC.appendString(string)
                    }
                    else if categoryitem == "VVV"
                    {
                         townforecast.VVV.appendString(string)
                    }
                    else if categoryitem == "WSD"
                    {
                         townforecast.WSD.appendString(string)
                    }
                }
                if element.isEqualToString("fcstDate")
                {
                    if townforecast.date == ""
                    {
                        townforecast.date.appendString(string)
                    }
                }
                if element.isEqualToString("fcstTime")
                {
                    if townforecast.time == ""
                    {
                        townforecast.time.appendString(string)
                    }
                }
                
                
            }
            else if self.title == "UV"
            {
                if element.isEqualToString("areaNo"){
                    ultra.areaNo.appendString(string)
                }
                if element.isEqualToString("today"){
                    ultra.today.appendString(string)
                }
                if element.isEqualToString("tomorrow"){
                    ultra.tomorrow.appendString(string)
                }
                if element.isEqualToString("theDayAfterTomorrow"){
                    ultra.dayAfterTomorrow.appendString(string)
                }
                if element.isEqualToString("date"){
                    ultra.date.appendString(string)
                }
            }
            else if self.title == "FineDust"
            {
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
            else if self.title == "FoodPoision"
            {
                if element.isEqualToString("areaNo"){
                    foodPoision.areaNo.appendString(string)
                }
                if element.isEqualToString("today"){
                    foodPoision.today.appendString(string)
                }
                if element.isEqualToString("tomorrow"){
                    foodPoision.tomorrow.appendString(string)
                }
                if element.isEqualToString("theDayAfterTomorrow"){
                    foodPoision.dayAfterTomorrow.appendString(string)
                }
                if element.isEqualToString("date"){
                    foodPoision.date.appendString(string)
                }
            }
            else if self.title == "Uncomfort"
            {
                if element.isEqualToString("areaNo"){
                    discomfort.areaNo.appendString(string)
                }
                if element.isEqualToString("date"){
                    discomfort.date.appendString(string)
                }
                if element.isEqualToString("h3"){
                    discomfort.posts.insertObject(string, atIndex: 0)
                }
                if element.isEqualToString("h6"){
                    discomfort.posts.insertObject(string, atIndex: 1)
                }
                if element.isEqualToString("h9"){
                   discomfort.posts.insertObject(string, atIndex: 2)
                }
                if element.isEqualToString("h12"){
                    discomfort.posts.insertObject(string, atIndex: 3)
                }
                if element.isEqualToString("h15"){
                    discomfort.posts.insertObject(string, atIndex: 4)
                }
                if element.isEqualToString("h18"){
                    discomfort.posts.insertObject(string, atIndex: 5)
                }
                if element.isEqualToString("h21"){
                    discomfort.posts.insertObject(string, atIndex: 6)
                }
                if element.isEqualToString("h24"){
                   discomfort.posts.insertObject(string, atIndex: 7)
                }
                //print(discomfort.posts)
            }
        }
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print("1Errors : " + parseError.localizedDescription)
    }
    
    func setupGraphDisplay() {
        
        if discomfort.posts.count == 0
        {
            return
        }
        
        var avg  = 0
        var count = 0
        var max = 0
        
        for i in (0...7) {
            if discomfort.posts[i] as? String != nil
            {
                let data =  Int((discomfort.posts[i] as? String)!)
                if data != nil
                {
                    graphView.graphPoints[i] = data!
                    avg += data!
                    count += 1
                    if data > max
                    {
                        max = data!
                    }
                }
            }
        }
        
        //2 - indicate that the graph needs to be redrawn
        graphView.setNeedsDisplay()
        
       let maxtext = "\(graphView.graphPoints.maxElement()!)"
        if maxtext != ""
        {
            maxLabel.text =  "\(100)"
        }
        
        avg = avg / count
        
        //3 - calculate average from graphPoints
        let average = graphView.graphPoints.reduce(0, combine: +)/graphView.graphPoints.count
        let averagetext = "\(average)"
        if averagetext != ""
        {
            averageofValue.text = maxtext
        }
        
        
        if discomfort.date.length < 11
        {
            discomfort.date.insertString("-", atIndex: 4)
            discomfort.date.insertString("-", atIndex: 7)
            discomfort.date.insertString(" ", atIndex: 10)
            discomfort.date.insertString(":", atIndex: 13)
            discomfort.date.insertString("0", atIndex: 14)
            discomfort.date.insertString("0", atIndex: 15)
        }
        
        Time.text = discomfort.date as String
        
        
    }
    
    
    func setupDustView() {
        
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
    
      func setupForecastView()
      {
        if townforecast.date != ""
        {
            Time.text = townforecast.date as String
        }
        if townforecast.time != ""
        {
            Time.text = Time.text! + " " + (townforecast.time as String)
        }
        

        if townforecast.POP != ""
        {
            Pop.text = townforecast.POP as String + " %"
        }else{
            Pop.text = "정보없음"
        }
        
        
        if townforecast.PTY != ""
        {
            if townforecast.PTY == "1"
            {
                Pty.text = "비"
            }
            else if townforecast.PTY == "2"
            {
                Pty.text = "비/눈"
            }
            else if townforecast.PTY == "3"
            {
                Pty.text = "눈"
            }else if townforecast.PTY == "0"
            {
                Pty.text = "없음"
            }
        }else{
            Pty.text = "정보없음"
        }
        
        
        if townforecast.REH != ""
        {
            Reh.text = townforecast.REH as String + " %"
        }else{
            Reh.text = "정보없음"
        }
        
        
        if townforecast.SKY != ""
        {
            if townforecast.SKY == "1"
            {
                Sky.text = "맑음"
            }
            else if townforecast.SKY == "2"
            {
                Sky.text = "구름조금"
            }
            else if townforecast.SKY == "3"
            {
                Sky.text = "구름많음"
            }
            else if townforecast.SKY == "4"
            {
                Sky.text = "흐림"
            }
            
        }else{
            Sky.text = "정보없음"
        }
        
        
        if townforecast.T3H != ""
        {
            T3h.text = townforecast.T3H as String + " ℃"
        }else{
            T3h.text = "정보없음"
        }
        
        if townforecast.TMX != ""
        {
            Tmx.text = townforecast.TMX as String + " ℃"
        }else{
            Tmx.text = "정보없음"
        }
        
        if townforecast.UUU != ""
        {
            Uuu.text = townforecast.UUU as String + " m/s"
        }else{
            Uuu.text = "정보없음"
        }
        
        if townforecast.VVV != ""
        {
            Vvv.text = townforecast.VVV as String + " m/s"
        }else{
            Vvv.text = "정보없음"
        }
        
        if townforecast.VEC != ""
        {
            Vec.text = townforecast.VEC as String
        }else{
            Vec.text = "정보없음"
        }
        
        if townforecast.WSD != ""
        {
            Wsd.text = townforecast.WSD as String + " m/s"
        }else{
            Wsd.text = "정보없음"
        }
        
        
      }
    
}
