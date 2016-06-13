//
//  ViewController.swift
//  project00
//
//  Created by moktaesu on 2016. 5. 22..
//  Copyright © 2016년 Sabi Park. All rights reserved.
//

import UIKit
class ForecastData{
    
    var POP = NSMutableString()
    var PTY = NSMutableString()
    var REH = NSMutableString()
    
    var date = NSMutableString()
    var time = NSMutableString()
    var SKY = NSMutableString()
    var T3H = NSMutableString()
    var TMX = NSMutableString()
    var UUU = NSMutableString()
    var VEC = NSMutableString()
    var VVV = NSMutableString()
    var WSD = NSMutableString()
    
    init ()
    {
        initData()
    }
    
    func initData()
    {
        POP = ""
        PTY = ""
        REH = ""
        date = ""
        time = ""
        SKY = ""
        T3H = ""
        TMX = ""
        UUU = ""
        VEC = ""
        VVV = ""
        WSD = ""
    }
}



class ViewController: UIViewController,UITableViewDelegate,NSXMLParserDelegate {

    
    var townforecast = ForecastData()
    
    let bastTimeData = ["0200","0500","0800","1100","1400","1700","2000","2300" ]
    var element = NSString()
    var categoryitem = NSString()
    
    var datalist:[[String:String]] = []
    var detaildata:[String:String] = [:]
    var elementTemp:String = ""
    var blank:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateForecast()
        
    }
    
    func updateForecast()
    {
        townforecast.initData()
        
        categoryitem = ""
        
        let now=NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd HHmm"
        dateFormatter.locale = NSLocale(localeIdentifier: "ko_KR")
        
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
            let url = NSURL(string: "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastSpaceData?serviceKey=FP%2FiwwjB77fb91p8thmSHdCSUwA2HYXngb4%2BASF0gpCZGiLtBkjfIllK9ELIuJ8knLVdl3Ay9mIWSjMYfC5GsQ%3D%3D&base_date=\(datetime[0])&base_time=\(bastTimeData[index!-1])&nx=60&ny=127")

                
            let MapCoordparser = NSXMLParser(contentsOfURL: url!)!
                MapCoordparser.delegate = self
                MapCoordparser.parse()
            
            datalist.append(["country":"서울", "weather":townforecast.SKY as String, "temperature":townforecast.T3H as String + " ℃"])

            
             townforecast.initData()
            let url1 = NSURL(string: "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastSpaceData?serviceKey=FP%2FiwwjB77fb91p8thmSHdCSUwA2HYXngb4%2BASF0gpCZGiLtBkjfIllK9ELIuJ8knLVdl3Ay9mIWSjMYfC5GsQ%3D%3D&base_date=\(datetime[0])&base_time=\(bastTimeData[index!-1])&nx=60&ny=120")
            
            
            let MapCoordparser1 = NSXMLParser(contentsOfURL: url!)!
            MapCoordparser1.delegate = self
            MapCoordparser1.parse()
            
            datalist.append(["country":"강원도", "weather":townforecast.SKY as String, "temperature":townforecast.T3H as String + " ℃"])

             townforecast.initData()
            
            let url2 = NSURL(string: "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastSpaceData?serviceKey=FP%2FiwwjB77fb91p8thmSHdCSUwA2HYXngb4%2BASF0gpCZGiLtBkjfIllK9ELIuJ8knLVdl3Ay9mIWSjMYfC5GsQ%3D%3D&base_date=\(datetime[0])&base_time=\(bastTimeData[index!-1])&nx=73&ny=134")
            
            
            let MapCoordparser2 = NSXMLParser(contentsOfURL: url!)!
            MapCoordparser2.delegate = self
            MapCoordparser2.parse()
            
            datalist.append(["country":"경기도", "weather":townforecast.SKY as String, "temperature":townforecast.T3H as String + " ℃"])

             townforecast.initData()
            
            let url3 = NSURL(string: "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastSpaceData?serviceKey=FP%2FiwwjB77fb91p8thmSHdCSUwA2HYXngb4%2BASF0gpCZGiLtBkjfIllK9ELIuJ8knLVdl3Ay9mIWSjMYfC5GsQ%3D%3D&base_date=\(datetime[0])&base_time=\(bastTimeData[index!-1])&nx=52&ny=38")
            
            
             townforecast.initData()
            
            let MapCoordparser3 = NSXMLParser(contentsOfURL: url!)!
            MapCoordparser3.delegate = self
            MapCoordparser3.parse()
            
            datalist.append(["country":"제주도", "weather":townforecast.SKY as String, "temperature":townforecast.T3H as String + " ℃"])

            
        }
        else{
            return
        }
            
    }
        
        func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
        {
            //print(elementName)
            element = elementName
            
            
        }
        
        func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName
            qName: String?) {
            
        }
    
        func parser(parser: NSXMLParser, foundCharacters string: String) {
            
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
                    if string == "1"
                    {
                        townforecast.SKY.appendString("맑음")
                    }
                    else if string == "2"
                    {
                        townforecast.SKY.appendString("구름조금")
                    }
                    else if string == "3"
                    {
                        townforecast.SKY.appendString("구름많음")
                    }
                    else if string == "4"
                    {
                        townforecast.SKY.appendString("흐림")
                    }
                    
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
        
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print("1Errors : " + parseError.localizedDescription)
    }
        
        
    func setupForecastView()
    {
    }
            
            
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datalist.count
    }
            
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! WeatherCell
        
        var dicTemp = datalist[indexPath.row]
        
        cell.countryLabel!.text = dicTemp["country"]
                
        let weatherStr = dicTemp["weather"]
        //print(weatherStr)
                
        cell.weatherLabel!.text = weatherStr
        cell.temperatureLabel!.text = dicTemp["temperature"]
                
        if weatherStr == "맑음" {
            cell.imageView!.image = UIImage(named: "sunny.png");
        }else if weatherStr == "구름조금" {
            cell.imageView!.image = UIImage(named: "cloudy.png");
        }else if weatherStr == "흐림" {
            cell.imageView!.image = UIImage(named: "rainy.png");
        }else if weatherStr == "눈" {
            cell.imageView!.image = UIImage(named: "snow.png");
        }else{
            cell.imageView!.image = UIImage(named: "blizzard.png");
        }
        return cell;
    }
            
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
    }
 
    @IBAction func cancleToPlayersViewController(segue:UIStoryboardSegue) {
        
    }
}
 