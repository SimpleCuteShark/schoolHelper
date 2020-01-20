//
//  PostModel.swift
//  wer2
//
//  Created by Alexandr Romantsov on 10.01.2020.
//  Copyright © 2020 Alexandr Romantsov. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct PostModel {
    var name: String;
    var tags: String;
    var text: String;
    
    static func fetchPost() -> [PostModel] {
        let result = [PostModel]()
        /*
        db.collection("Post").getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    result.append(PostModel(name: (document.get("name")) as! String, tags: (document.get("tags")) as! String, text: (document.get("text")) as! String))
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        print("1231")
        print(result)
 */
        return result
    }
}
