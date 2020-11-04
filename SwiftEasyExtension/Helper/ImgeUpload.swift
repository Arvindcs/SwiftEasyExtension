//
//  ImgeUpload.swift
//  Agritz
//
//  Created by Jack Ily on 26/04/2020.
//  Copyright © 2020 Jack Ily. All rights reserved.
//

import UIKit
//import Alamofire

public let clientID = ""

class ImgeUpload {
    
    static let sharedInstance = ImgeUpload()
    
    func uploadImageToImgur(_ image: UIImage, completion: @escaping (String) -> Void) {
        getBase64Image(image) { (base64Image) in
            let boundary = "Boundary-\(UUID().uuidString)"
            let url = URL(string: "https://api.imgur.com/3/image")!
            var request = URLRequest(url: url)
            request.addValue("Client-ID \(clientID)", forHTTPHeaderField: "Authorization")
            request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            var body = ""
            body += "--\(boundary)\r\n"
            body += "Content-Disposition:form-data; name=\"image\""
            body += "\r\n\r\n\(base64Image ?? "")\r\n"
            body += "--\(boundary)--\r\n"
            
            let postData = body.data(using: .utf8)
            request.httpBody = postData
            
        
            let session = URLSession.shared
            session.dataTask(with: request, completionHandler: { (data, response, error) in
                if let error = error { print("Error: \(error.localizedDescription)") }
                guard let response = response as? HTTPURLResponse,
                    (200...299).contains(response.statusCode) else {
                        print("Server Error"); return
                }
                
                if let mimeType = response.mimeType,
                    mimeType == "application/json",
                    let data = data
                    /*let str = String(data: data, encoding: .utf8)*/ {
                    //print("Umgur Upload Result: \(str)")
                    
                    let parseResult: [String: AnyObject]
                    do {
                        parseResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: AnyObject]
                        if let dataJSON = parseResult["data"] as? [String: Any] {
                            print("Link: \(dataJSON["link"] as? String ?? "Link Not Found")")
                            if let link = dataJSON["link"] as? String {
                                completion(link)
                            }
                        }
                        
                    } catch {}
                }
                
            }).resume()
            
            
            // TODO:- If you are using Alamofire then uncomment below code
 
            /*
            Alamofire.request(request).responseJSON { (response) in
                switch response.result {
                case .success:
                    guard let res = response.response, (200...299).contains(res.statusCode) else {
                            print("Server Error"); return
                    }
                    
                    if let mimeType = res.mimeType,
                        mimeType == "application/json",
                        let data = response.data {
                        let parseResult: [String: AnyObject]
                        do {
                            parseResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: AnyObject]
                            if let dataJSON = parseResult["data"] as? [String: Any] {
                                print("Link: \(dataJSON["link"] as? String ?? "Link Not Found")")
                                if let link = dataJSON["link"] as? String {
                                    completion(link)
                                }
                            }
                            
                        } catch {}
                    }
                    
                case .failure(let error): print("Error: \(error.localizedDescription)"); break
                }
            }
 */
        }
    }
    
    private func getBase64Image(_ image: UIImage, complete: @escaping (String?) -> Void) {
        DispatchQueue.main.async {
            let imageData = image.pngData()
            let base64Image = imageData?.base64EncodedString(options: .lineLength64Characters)
            complete(base64Image)
        }
    }
}
