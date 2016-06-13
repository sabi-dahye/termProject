
import UIKit
import MapKit

class LocationAnnotation: NSObject, MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init (coordinate : CLLocationCoordinate2D, title : String, subtitle: String)
    {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}

var gSelected:LocationAnnotation? = nil