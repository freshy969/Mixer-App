//
//  Playlist.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/13/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import Foundation
import Firebase

class Playlist {
    
    var name: String
    var description: String // length needs to be limited
//    var createdDate: Date
    var numberOfSongs: Int
    var documentID: String
    
    var dictionary: [String: Any] {
        return ["name": name, "description": description,
//                "createdDate", createdDate
            "numberOfSongs": numberOfSongs, "documentID": documentID
        ]
    }
    
    init(name: String, description: String,
//        , createdDate: Date
        numberOfSongs: Int, documentID: String) {
        self.name = name
        self.description = description
        self.numberOfSongs = numberOfSongs
        self.documentID = documentID
    }
    
    convenience init(dictionary: [String: Any]) {
        let name = dictionary["name"] as! String? ?? ""
        let description = dictionary["description"] as! String? ?? ""
        let numberOfSongs = dictionary["numberOfSongs"] as! Int
        
        self.init(name: name, description: description, numberOfSongs: numberOfSongs, documentID: "")
    }
    
    convenience init() {
        self.init(name: "", description: "", numberOfSongs: 0, documentID: "")
    }
    
    func savePlaylist(user: MusicUser, completed: @escaping (Bool) -> ()) {
        user.documentID = (Auth.auth().currentUser?.uid)!
        
        let db = Firestore.firestore()
        let dataToSave = self.dictionary
        
        if self.documentID != "" {
            // the playlist already exists (so we are just updating it)
            let ref = db.collection("users").document(user.documentID).collection("custom-playlists").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                if let error = error {
                    print("ERROR: updating document \(self.documentID) for user \(user.documentID) \(error.localizedDescription)")
                    completed(false)
                }
                else {
                    print("Document updated with ref ID \(ref.documentID)")
                    // playlist updated
                }
            }
        } else {
            // adding the playlist for the first time
            var ref: DocumentReference? = nil
            ref = db.collection("users").document(user.documentID).collection("custom-playlists").addDocument(data: dataToSave) { error in
                if let error = error {
                    print("ERROR: updating user \(user.documentID) for new playlist documentID \(self.documentID) \(error.localizedDescription)")
                    completed(false)
                }
                else {
                    // Playlist added
                    print("New document created with ref ID \(ref?.documentID ?? "unknown")")
                }
            }
        }
    }
    
    func deletePlaylist(user: MusicUser, completed: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        db.collection("users").document(user.documentID).collection("custom-playlists").document(self.documentID).delete() { error in
            if let error = error {
                print("ERROR: Deleting playlist documentID \(self.documentID) \(error.localizedDescription)")
            }
            completed(true)
        }
    }
}
