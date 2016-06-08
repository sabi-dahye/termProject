//
//  CityDataFormat.swift
//  forecast
//
//  Created by kpugame on 2016. 6. 6..
//  Copyright © 2016년 kpugame. All rights reserved.
//

struct CityData{
    var Do : String!
    var Si : String!
    var Dong : String!
    var CoordX : Int!
    var Coordy : Int!
    var Latitude : Double!
    var Longtitude : Double!
    var LocalCode : String!
    
    init (Do: String!, Si: String!, Dong:String!, Coordx : Int!, Coordy:Int!, Latitude : Double!, Longtitude : Double!, Localcode : String!)
    {
        self.Do = Do
        self.Si = Si
        self.Dong = Dong
        self.CoordX = Coordx
        self.Coordy = Coordy
        self.Latitude = Latitude
        self.Longtitude = Longtitude
        self.LocalCode = Localcode
    }
}

enum TabID{
    case forecast
    case UV
    case dust
    case FP
    case discomfort
    
}

var CityDatas = [CityData]()
var CurrTab = TabID.forecast
var CurrCityData : CityData! = nil