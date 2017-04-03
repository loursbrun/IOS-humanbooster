//
//  FlickrService.swift
//  ImageGallery
//
//  Created by Fabien Brun on 24/03/2017.
//  Copyright © 2017 fabienbrun. All rights reserved.
//
//  Ce service permet de récupérer des photos en utilisant l'API Flikr
//  Attention l'api_key est temporaire
//

/* ----------------------------------------- */
/* ==           Flikr Api Sources            */
/* ----------------------------------------- */

/*     https://www.flickr.com/services/api/explore/flickr.photos.search    */
/*                                                                         */
/*     https://www.flickr.com/services/api/misc.urls.html                  */



import Foundation


class FlickrService {
    
    static let sharedInstance = FlickrService()

    
    var ids: [String] = []
    var secrets: [String] = []
    var servers: [String] = []
    var farms: [Int] = []
    var titles: [String] = []
    
    var imagesUrl: [String] = []
    var key = ""
    
    
    
    func getUrlImg(callBack:@escaping ([String])-> Void) {
    

        let session = URLSession.shared
        
        
         print("****************  API KEY  *****************")
        
        
        
        if let path = Bundle.main.path(forResource: "API_KEY", ofType: "plist"),
            let data = NSDictionary(contentsOfFile: path) {
             key = data["flikr_api_key"] as! String
            print(key)
            
        }


        
        
        
        // URL API Flikr
        let imagesGetURL = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(key)&text=sport&format=json&nojsoncallback=1&api_sig=a2adb144d9d94727064938568327cce7")!
        
        
        
        
        
        
        //var requestImages = URLRequest(url: imagesGetURL)
        //requestImages.httpMethod = "GET"
        
        
        let getImagesTask = session.dataTask(with: imagesGetURL){
            (data, response, error) in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("missing data")
                return
            }
            
            //print(data)
            //print(String(data: data, encoding: String.Encoding.utf8)!)
            
            // Test
            let allPhotos = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            
            if let arrJSON = allPhotos?["photos"]?["photo"] as? [[String: Any]]{
                for index in 0...arrJSON.count-1 {
                    
                    let aObject = arrJSON[index]
                    
                    self.ids.append(aObject["id"] as! String)
                    self.secrets.append(aObject["secret"] as! String)
                    self.servers.append(aObject["server"] as! String)
                    self.farms.append(aObject["farm"] as! Int)
                    self.titles.append(aObject["title"] as! String)
                    
                    // https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
                    self.imagesUrl.append("https://farm\(self.farms[index]).staticflickr.com/\(self.servers[index])/\(self.ids[index])_\(self.secrets[index]).jpg")
                                                     }
            }
            //print(self.imagesUrl)
            
            callBack(self.imagesUrl)
        
        
        }
        
        getImagesTask.resume()
        
        
    }
    

}
