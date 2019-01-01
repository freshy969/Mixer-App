//
//  User.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/1/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import Foundation
import Firebase

class MusicUser {
    var email: String
    var firstName: String
    var lastName: String
    var fullName: String
    var displayName: String
    var profileURL: String
//    var userSince: Date
    var documentID: String

    var dictionary: [String : Any] {
        return ["email" : email, "firstName" : firstName, "lastName" : lastName, "fullName" : fullName, "displayName" : displayName, "photoURL": profileURL,
//                "userSince": userSince,
                "documentID": documentID]
    }

    init(email: String, firstName: String, lastName: String, fullName: String, displayName: String, photoURL: String,
//         userSince: Date,
         documentID: String) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = fullName
        self.displayName = displayName
        self.profileURL = photoURL
//        self.userSince = userSince
        self.documentID = documentID
    }
    
    convenience init() {
        self.init(email: "", firstName: "", lastName: "", fullName: "", displayName: "", photoURL: "",
//                  userSince: Date(),
                  documentID: "")
    }

    convenience init(user: User) {
        self.init(email: user.email ?? "", firstName: "", lastName: "", fullName: "", displayName: user.displayName ?? "", photoURL: (user.photoURL != nil ? "\(user.photoURL!)" : ""),
//                  userSince: Date(),
                  documentID: user.uid)
    }

    convenience init(dictionary: [String : Any]) {
        let email = dictionary["email"] as! String? ?? ""
        let firstName = dictionary["firstName"] as! String? ?? ""
        let lastName = dictionary["lastName"] as! String? ?? ""
        let fullName = dictionary["fullName"] as! String? ?? ""
        let displayName = dictionary["displayName"] as! String? ?? ""
        let photoURL = dictionary["photoURL"] as! String? ?? ""
//        let userSince = dictionary["userSince"] as! Date? ?? Date()
        self.init(email: email, firstName: firstName, lastName: lastName, fullName: fullName, displayName: displayName, photoURL: photoURL,
//                  userSince: userSince,
                  documentID: "")
    }

    func saveData() {
        let db = Firestore.firestore()
        let dataToSave: [String : Any] = self.dictionary
        db.collection("users").document(documentID).setData(dataToSave) { error in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            }
        }
    }
}

