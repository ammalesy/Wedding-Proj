//
//  PhotosProvider.swift
//  NYTPhotoViewer
//
//  Created by Mark Keefe on 3/20/15.
//  Copyright (c) 2015 The New York Times. All rights reserved.
//

import UIKit

/**
*   In Swift 1.2, the following file level constants can be moved inside the class for better encapsulation
*/

class PhotosProvider: NSObject {
    
    let photos: [NZPhoto] = {
        
        let animationImages = [UIImage(named: "1")!,UIImage(named: "5")!,UIImage(named: "7")!,UIImage(named: "3")!,UIImage(named: "rr")]
        let titles = ["Marry me!","You and me with the sky.","Love this moment","Feel good.","วันที่ผมจะยอมคุกเข่าให้ ผู้หญิงคนอื่น นอกจากคุณ\nคือ วันที่ผมผูกเชือกรองเท้าให้ ลูกสาวของเรา"]

        
        var mutablePhotos: [NZPhoto] = []
        var image = animationImages[0]
        let NumberOfPhotos = animationImages.count
        
        func shouldSetImageOnIndex(photoIndex: Int) -> Bool {
            return true
        }
        
        for photoIndex in 0 ..< NumberOfPhotos {
            let title = NSAttributedString(string: titles[photoIndex], attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
            
            let photo = shouldSetImageOnIndex(photoIndex) ? NZPhoto(image: animationImages[photoIndex], attributedCaptionTitle: title) : NZPhoto(attributedCaptionTitle: title)

            
            mutablePhotos.append(photo)
        }
        
        return mutablePhotos
    }()    
}
