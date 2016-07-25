//
//  API.swift
//  Solution
//
//  Created by Nick Adcock on 7/19/16.
//  Copyright © 2016 NEA. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class API {
    
    static let sharedInstance = API()
    
    
    enum loadURL: String {
        case Users = "https://jsonplaceholder.typicode.com/users"
        case Photos = "https://jsonplaceholder.typicode.com/photos"
        
        var completionHandler: (parsedResult: [[String:AnyObject]]!, context: NSManagedObjectContext) -> Void {
            switch self {
                case Users: return { (parsedResult: [[String:AnyObject]]!, context: NSManagedObjectContext) -> Void in
                    for user in parsedResult {
                        let alert = Alert.sharedInstance
                        
                        /* GUARD: Does user have a key for 'id'? */
                        guard let userID = user["id"] as? Int else {
                            alert.displayAlert(.jsonMissingKey)
                            print("Cannot find key 'id' in \(user)")
                            return
                        }
                        
                        /* GUARD: Does user have a key for 'name'? */
                        guard let name = user["name"] as? String else {
                            alert.displayAlert(.jsonMissingKey)
                            print("Cannot find key 'name' in \(user)")
                            return
                        }
                        
                        /* GUARD: Does user have a key for 'username'? */
                        guard let username = user["username"] as? String else {
                            alert.displayAlert(.jsonMissingKey)
                            print("Cannot find key 'username' in \(user)")
                            return
                        }
                        
                        /* GUARD: Does user have a key for 'email'? */
                        guard let email = user["email"] as? String else {
                            alert.displayAlert(.jsonMissingKey)
                            print("Cannot find key 'email' in \(user)")
                            return
                        }
                        
                        /* GUARD: Does user have a key for 'phone'? */
                        guard let phone = user["phone"] as? String else {
                            alert.displayAlert(.jsonMissingKey)
                            print("Cannot find key 'phone' in \(user)")
                            return
                        }
                        
                        /* GUARD: Does user have a key for 'website'? */
                        guard let website = user["website"] as? String else {
                            alert.displayAlert(.jsonMissingKey)
                            print("Cannot find key 'website' in \(user)")
                            return
                        }
                        
                        /* GUARD: Does user have a key for 'address'? */
                        guard let address = user["address"] as? [String: AnyObject] else {
                            alert.displayAlert(.jsonMissingKey)
                            print("Cannot find key 'address' in \(user)")
                            return
                        }
                        
                        /* GUARD: Does user have a key for 'address'? */
                        guard let company = user["company"] as? [String: AnyObject] else {
                            alert.displayAlert(.jsonMissingKey)
                            print("Cannot find key 'comapny' in \(user)")
                            return
                        }
                        
                        /* GUARD: Does company have a key for 'name'? */
                        guard let companyName = company["name"] as? String else {
                            alert.displayAlert(.jsonMissingKey)
                            print("Cannot find key 'name' in \(company)")
                            return
                        }
                        
                        /* GUARD: Does company have a key for 'catchPhrase'? */
                        guard let companyPhrase = company["catchPhrase"] as? String else {
                            alert.displayAlert(.jsonMissingKey)
                            print("Cannot find key 'catchPhrase' in \(company)")
                            return
                        }
                        
                        /* GUARD: Does company have a key for 'catchPhrase'? */
                        guard let companyBS = company["bs"] as? String else {
                            alert.displayAlert(.jsonMissingKey)
                            print("Cannot find key 'bs' in \(company)")
                            return
                        }
                        
                        /* GUARD: Does address have a key for 'street'? */
                        guard let addressStreet = address["street"] as? String else {
                            alert.displayAlert(.jsonMissingKey)
                            print("Cannot find key 'street' in \(address)")
                            return
                        }
                        
                        /* GUARD: Does address have a key for 'suite'? */
                        guard let addressSuite = address["suite"] as? String else {
                            alert.displayAlert(.jsonMissingKey)
                            print("Cannot find key 'suite' in \(address)")
                            return
                        }
                        
                        /* GUARD: Does address have a key for 'city'? */
                        guard let addressCity = address["city"] as? String else {
                            alert.displayAlert(.jsonMissingKey)
                            print("Cannot find key 'city' in \(address)")
                            return
                        }
                        
                        /* GUARD: Does address have a key for 'zipcode'? */
                        guard let addressZip = address["zipcode"] as? String else {
                            alert.displayAlert(.jsonMissingKey)
                            print("Cannot find key 'zipcode' in \(address)")
                            return
                        }
                        
                        /* GUARD: Does address have a key for 'geo'? */
                        guard let coords = address["geo"] as? [String: AnyObject] else {
                            alert.displayAlert(.jsonMissingKey)
                            print("Cannot find key 'geo' in \(address)")
                            return
                        }
                        
                        /* GUARD: Does coords have a key for 'lat'? */
                        guard let coordsLat = coords["lat"] as? String else {
                            alert.displayAlert(.jsonMissingKey)
                            print("Cannot find key 'lat' in \(coords)")
                            return
                        }
                        
                        /* GUARD: Does coords have a key for 'lng'? */
                        guard let coordsLng = coords["lng"] as? String else {
                            alert.displayAlert(.jsonMissingKey)
                            print("Cannot find key 'lng' in \(coords)")
                            return
                        }
                        
                        let geoModel = Geo(lat: coordsLat, lng: coordsLng, context: context)
                        let addressModel = Address(street: addressStreet, suite: addressSuite, city: addressCity, zip: addressZip, geo: geoModel, context: context)
                        let companyModel = Company(name: companyName, catchPhrase: companyPhrase, bs: companyBS, context: context)
                        _ = User(id: userID, name: name, username: username, email: email, address: addressModel, phone: phone, website: website, company: companyModel, context: context)
                        do{
                            try context.save()
                        }catch{
                            fatalError("Error while saving backgroundContext: \(error)")
                        }
                    }
                }
                case Photos: return { (parsedResult: [[String:AnyObject]]!, context: NSManagedObjectContext) -> Void in
                    var albums = [Int: AnyObject]()
                    let alert = Alert.sharedInstance
                    
                    for photo in parsedResult {
                        
                        /* GUARD: Does photo have a key for 'albumId'? */
                        guard let albumID = photo["albumId"] as? Int else {
                            alert.displayAlert(.jsonMissingKey)
                            print("Cannot find key 'albumId' in \(photo)")
                            return
                        }
                        
                        var album = albums[albumID] as? Album
                        
                        if album == nil {
                            album = Album(albumID: albumID, context: context)
                            albums[albumID] = album!
                        }
                        
                        /* GUARD: Does photo have a key for 'id'? */
                        guard let id = photo["id"] as? Int else {
                            alert.displayAlert(.jsonMissingKey)
                            print("Cannot find key 'id' in \(photo)")
                            return
                        }
                        
                        /* GUARD: Does photo have a key for 'title'? */
                        guard let title = photo["title"] as? String else {
                            alert.displayAlert(.jsonMissingKey)
                            print("Cannot find key 'title' in \(photo)")
                            return
                        }
                        
                        /* GUARD: Does photo have a key for 'url'? */
                        guard let url = photo["url"] as? String else {
                            alert.displayAlert(.jsonMissingKey)
                            print("Cannot find key 'url' in \(photo)")
                            return
                        }
                        
                        /* GUARD: Does photo have a key for 'thumbnailUrl'? */
                        guard let thumbnailURL = photo["thumbnailUrl"] as? String else {
                            alert.displayAlert(.jsonMissingKey)
                            print("Cannot find key 'thumbnailUrl' in \(photo)")
                            return
                        }
                        
                        
                        _ = Photo(album: album!, id: id, title: title, url: url, thumbnailURL: thumbnailURL, context: context)
                        
                        do{
                            try context.save()
                        }catch{
                            fatalError("Error while saving backgroundContext: \(error)")
                        }
                    }
                }
            }
        }
    }
    
    func loadData(loadURLtype: loadURL) {
        let batch = {(context: NSManagedObjectContext) -> () in
            let session = NSURLSession.sharedSession()
            let url = NSURL(string: loadURLtype.rawValue)!
            
            let task = session.dataTaskWithURL(url) {
                (data, response, error) -> Void in
                
                if error != nil {
                    print(error!.localizedDescription)
                }
                else {
                    /* GUARD: Was there an error? */
                    let alert = Alert.sharedInstance
                    guard (error == nil) else {
                        alert.displayAlert(.NetworkError)
                        print("There was an error with your request: \(error)")
                        return
                    }
                    
                    /* GUARD: Was there any data returned? */
                    guard let data = data else {
                        alert.displayAlert(.NetworkError)
                        print("No data was returned by the request!")
                        return
                    }
                    
                    /* Parse the data! */
                    let parsedResult: [[String: AnyObject]]!
                    do {
                        parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! [[String: AnyObject]]
                    } catch {
                        parsedResult = nil
                        alert.displayAlert(.JSONParseError)
                        print("Could not parse the data as JSON: '\(data)'")
                        return
                    }
                    
                    loadURLtype.completionHandler(parsedResult: parsedResult, context: context)
                }
            }
            
            task.resume()
            
        }
        
        CoreDataStack.stack.performBackgroundBatchOperation(batch)
    }
    
    func downloadPhoto(url: String, handler: (NSData) -> Void) {
        let imageURL = NSURL(string: url)
        
        NSURLSession.sharedSession().dataTaskWithURL(imageURL!) { data, response, error in
            if (data != nil && error == nil) {
                dispatch_async(dispatch_get_main_queue()) {
                    handler(data!)
                }
            }
        }.resume()
        
    }

}
