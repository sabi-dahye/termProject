//
//  ViewController.swift
//  GPSMap
//
//  Created by kpugame on 2016. 5. 26..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewControllerGps: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, NSXMLParserDelegate {

    @IBOutlet weak var Mapview: MKMapView!
    
    var locationManager: CLLocationManager = CLLocationManager()
    var xCoord : Double! = nil
    var yCoord : Double! = nil
    
    var elements = NSMutableDictionary()
    var stationName = NSMutableString()
    var addr = NSMutableString()
    var posts = NSMutableArray()
    var stations = NSMutableArray()
    var stationelements = NSMutableDictionary()
    var Xcoord = NSMutableString()
    var Ycoord = NSMutableString()
    
    var year = NSMutableString()
    var mangName = NSMutableString()
    var oper = NSMutableString()
    var item = NSMutableString()
    var photo = NSMutableString()
    var map = NSMutableString()
    
    var element = NSString()
    
    enum parseTarget : Int{
       case TransCoord = 0
       case CloseStation
       case StationCoord
    }
    var parsingTarget = parseTarget(rawValue: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
       self.Mapview.showsUserLocation = true
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
       if posts.count > 0
       {
        return
        }
        
        parsingTarget = parseTarget.TransCoord
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)

        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        
        self.Mapview.setRegion(region, animated:  true)
        
        let url = NSURL(string: "https://apis.daum.net/local/geo/transcoord?apikey=87bf0a8e43c2d479e7ac5ded88d91e1e&fromCoord=WGS84&y=\(center.latitude)&x=\(center.longitude)&toCoord=TM&output=XML")
        
        xCoord = nil
        yCoord = nil
        
        if url != nil
        {
            //print("url : \(url)")
            parsingTarget = .TransCoord
            let MapCoordparser = NSXMLParser(contentsOfURL: url!)!
            MapCoordparser.delegate = self
            MapCoordparser.parse()
        }
        
        if xCoord != nil && yCoord != nil{
            let url2 = NSURL(string: "http://openapi.airkorea.or.kr/openapi/services/rest/MsrstnInfoInqireSvc/getNearbyMsrstnList?ServiceKey=FP%2FiwwjB77fb91p8thmSHdCSUwA2HYXngb4%2BASF0gpCZGiLtBkjfIllK9ELIuJ8knLVdl3Ay9mIWSjMYfC5GsQ%3D%3D&tmX=\(xCoord)&tmY=\(yCoord)&numOfRows=999&pageSize=999&pageNo=1&startPage=1")
            
            
            if url2 != nil
            {
                parsingTarget = .CloseStation
                posts = []
                let xmlParser = NSXMLParser(contentsOfURL: url2!)!
                xmlParser.delegate = self
                xmlParser.parse()
                if posts.count > 0 {
                    //print(posts)
                    stations = []
                    addAttractionPins()
                }
            }
        }
        
        self.locationManager.stopUpdatingLocation()
    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Errors : " + error.localizedDescription)
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        
        //print("Element's name is \(elementName)")
        //print("Element's attributes are \(attributeDict)")
        
        element = elementName
        if elementName == "result"
        {
            xCoord = Double(attributeDict["x"]!)
            yCoord = Double(attributeDict["y"]!)
        }
        else if elementName == "item"
        {
            if parsingTarget == parseTarget.CloseStation{
                elements = NSMutableDictionary()
                elements = [:]
                stationName = NSMutableString()
                stationName = ""
                addr = NSMutableString()
                addr = ""
            }else if parsingTarget == parseTarget.StationCoord{
            
                stationelements = NSMutableDictionary()
                stationelements = [:]
                Xcoord = NSMutableString()
                Ycoord = NSMutableString()
                Xcoord = ""
                Ycoord = ""
                stationName = NSMutableString()
                stationName = ""
                year = NSMutableString()
                year = ""
                oper =  NSMutableString()
                oper = ""
                item =  NSMutableString()
                item = ""
                map =  NSMutableString()
                map = ""
                photo =  NSMutableString()
                photo = ""
                mangName =  NSMutableString()
                mangName = ""
                addr = NSMutableString()
                addr = ""
            }
        }
        
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName
        qName: String?) {

        if elementName == "item"{
            if parsingTarget == parseTarget.CloseStation
            {
                if !stationName.isEqual(nil) {
                    elements.setObject(stationName, forKey: "stationName")
                }
                if !addr.isEqual(nil) {
                    elements.setObject(addr, forKey: "addr")
                }
                posts.addObject(elements)
            }
            else if parsingTarget == parseTarget.StationCoord{
                
                if !stationName.isEqual(nil) {
                    stationelements.setObject(stationName, forKey: "stationName")
                }
                if !addr.isEqual(nil) {
                    stationelements.setObject(addr, forKey: "addr")
                }
                if !Xcoord.isEqual(nil){
                    stationelements.setObject(Xcoord, forKey: "dmX")
                }
                if !Ycoord.isEqual(nil){
                    stationelements.setObject(Ycoord, forKey: "dmY")
                }
                if !year.isEqual(nil){
                    stationelements.setObject(year, forKey: "year")
                }
                if !mangName.isEqual(nil){
                    stationelements.setObject(mangName, forKey: "mangName")
                }
                if !oper.isEqual(nil){
                    stationelements.setObject(oper, forKey: "oper")
                }
                if !map.isEqual(nil){
                    stationelements.setObject(map, forKey: "map")
                }
                if !photo.isEqual(nil){
                    stationelements.setObject(photo, forKey: "photo")
                }
                if !item.isEqual(nil){
                    stationelements.setObject(item, forKey: "item")
                }
                
                stations.addObject(stationelements)
            }
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if parsingTarget == parseTarget.CloseStation
        {
            //print(string)
            if element.isEqualToString("stationName"){
                stationName.appendString(string)
            }
            if element.isEqualToString("addr"){
                addr.appendString(string)
            }
        }
        else if parsingTarget == parseTarget.StationCoord
        {
            if element.isEqualToString("stationName"){
                stationName.appendString(string)
            }
            if element.isEqualToString("addr"){
                addr.appendString(string)
            }
            if element.isEqualToString("dmX"){
                Xcoord.appendString(string)
            }
            if element.isEqualToString("dmY"){
                Ycoord.appendString(string)
            }
            if element.isEqualToString("year"){
                year.appendString(string)
            }
            if element.isEqualToString("mangName"){
                mangName.appendString(string)
            }
            if element.isEqualToString("oper"){
                oper.appendString(string)
            }
            if element.isEqualToString("item"){
                item.appendString(string)
            }
            if element.isEqualToString("photo"){
                photo.appendString(string)
            }
            if element.isEqualToString("map"){
                map.appendString(string)
            }
            
        }
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print("1Errors : " + parseError.localizedDescription)
    }
    
    func addAttractionPins(){
        
        parsingTarget = .StationCoord
        
        //print(posts.count)
        
        for i in 0...posts.count - 1 {
           
            let station = posts.objectAtIndex(i).valueForKey("stationName")
            let address = posts.objectAtIndex(i).valueForKey("addr")
            let addtok = address!.componentsSeparatedByString(" ")
            let statok = station!.componentsSeparatedByString("\n")
            
            let addrstr = addtok[0].stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
            let stastr = statok[0].stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
            
            var urlstr = String("http://openapi.airkorea.or.kr/openapi/services/rest/MsrstnInfoInqireSvc/getMsrstnList?ServiceKey=FP%2FiwwjB77fb91p8thmSHdCSUwA2HYXngb4%2BASF0gpCZGiLtBkjfIllK9ELIuJ8knLVdl3Ay9mIWSjMYfC5GsQ%3D%3D&numOfRows=10&pageSize=10&pageNo=1&startPage=1&addr=" + addrstr! + "&stationName=" + stastr! )
        
            
            let url3 = NSURL(string: urlstr)

            if url3 != nil
            {
                stations = []
                let xmlParser = NSXMLParser(contentsOfURL: url3!)!
                xmlParser.delegate = self
                xmlParser.parse()
                
                if stations.count == 0
                {
                    return
                }
                
                let cx = stations.objectAtIndex(0).valueForKey("dmX")?.componentsSeparatedByString("\n")
                let cy = stations.objectAtIndex(0).valueForKey("dmY")?.componentsSeparatedByString("\n")
                let coorx = Double(cx![0])
                let coory = Double(cy![0])
                
                //print(stations)
                
                let coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(coorx!), CLLocationDegrees(coory!))
                
                let title = statok[0]
                let subtitle = address as! String
                let annotation = LocationAnnotation(coordinate: coordinate, title: title, subtitle: subtitle)
                Mapview.addAnnotation(annotation)
            }
        
        }
        
    }
    
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView!
    {
        let annotationView = LocationAnnotationView(annotation: annotation, reuseIdentifier: "SMapPin")
        //print(annotation.title)
        
        if annotation.title! == String("Current Location")
        {
            annotationView.image = UIImage(named: "MyPosition")
        }
        else
        {
            annotationView.image = UIImage(named: "Flag")
        }
        
        annotationView.canShowCallout = true
        annotationView.selected = false
        
        return annotationView
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        view.selected = false;
        gSelected = view.annotation as? LocationAnnotation
        //print(gSelected?.title)
    }
    
    
    @IBAction func doneToPlayersViewController(segue:UIStoryboardSegue) {
    }
}

