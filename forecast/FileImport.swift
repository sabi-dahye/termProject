//
//  FileImport.swift
//  forecast
//
//  Created by kpugame on 2016. 6. 6..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import Foundation

class OpenFile
{
    var fileName : String = String()
    
    var dictCityInfo = [String : String]()
    
    init(fileName:String)
    {
       self.fileName = fileName
        print(fileName)
    }
    
    func OpenData()
    {
        
        if fileName == ""
        {
            return
        }
        
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "txt")
        
        let filemgr = NSFileManager.defaultManager()
        if filemgr.fileExistsAtPath(path!)
        {
            
            do{
                let fullText = try String(contentsOfFile: path!, encoding: NSUTF16StringEncoding)
                
                let readings = fullText.componentsSeparatedByString("\n") as [String]
                
                for i in 1..<readings.count{
                    let Info = readings[i].componentsSeparatedByString("\t")
            

                    let Info1 = Info[7].componentsSeparatedByString("\r")
                    
                    
                    //print(Info)
                    //print(String(Info1[0]))
                    /*
                    print(Info[0])
                    print(Info[1])
                    print(Info[2])
                    print(Int(Info[3]))
                    print(Int(Info[4]))
                    print(Double(Info[5]))
                    print(Double(Info[6]))
                     print(Int(Info1[0]))*/
 
 
                    
                    let Do = Info[0]
                    let Si = Info[1]
                    let Dong = Info[2]
                    let coordx = Int(Info[3])
                    let coordy = Int(Info[4])
                    let latitude = Double(Info[5])
                    let longtitude = Double(Info[6])
                    let localcode = String(Info1[0])
                    
                    let tmp = CityData(Do: Do, Si: Si, Dong: Dong, Coordx: coordx, Coordy: coordy, Latitude: latitude,Longtitude: longtitude, Localcode: localcode)
                    
                   // print(tmp.LocalCode)
                    
                    CityDatas.append(tmp)
                }
                
            }catch let error as NSError{
                print("Error: \(error)")
            }
            
        }
    }
    
   
}

