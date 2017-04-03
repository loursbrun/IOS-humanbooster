//
//  ImageDetailViewController.swift
//  ImageGallery
//
//  Created by Fabien Brun on 23/03/2017.
//  Copyright © 2017 fabienbrun. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    var image : UIImage?
    var urlImg : String?

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        //let url = URL(string: "https://dummyimage.com/100x100/123456/fff&text=lorem")
        
        
        //urlImg = "https://dummyimage.com/100x100/123456/fff&text=lorem"
        let url = URL(string: urlImg!)
        let data = try? Data(contentsOf: url!)
        imageView.image = UIImage(data: data!)
 
        
        //imageView.image = image
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
