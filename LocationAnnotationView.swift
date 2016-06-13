
import UIKit
import MapKit

class LocationAnnotationView: MKAnnotationView{
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier:String?){
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        image = UIImage(named: "tasty")
    }

}
