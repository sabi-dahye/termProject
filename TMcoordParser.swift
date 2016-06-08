//
//  Parser.swift
//  GPSMap
//
//  Created by kpugame on 2016. 5. 28..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import UIKit

class TMCoordParser{
    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var x = NSMutableString()
    var y = NSMutableString()
    
    func beginParsing(delegate: NSXMLParserDelegate)
    {
        parser = NSXMLParser(contentsOfURL: (NSURL(string: "https://apis.daum.net/local/geo/transcoord?apikey=87bf0a8e43c2d479e7ac5ded88d91e1e&fromCoord=WGS84&y=126.879299157299&x=37.37729270622&toCoord=TM&output=XML"))!)!
        parser.delegate = delegate
        parser.parse()
    }
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: NSDictionary!) {
        print("Element's name is \(elementName)")
        print("Element's attributes are \(attributeDict)")
    }
    
}