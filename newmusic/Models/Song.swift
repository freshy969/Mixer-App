//
//  Song.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/4/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import Foundation
import Firebase

class Song {
    
    // look at how review was added, and how user was passed to the review page
    
    var name: String
    var artist: String
    var playlist: String
    var albumImage: String //URL
    var dateAdded: Date
    var documentID: String
    
    var dictionary: [String: Any] {
        return ["name": name, "artist": artist, "playlist": playlist, "albumImage": albumImage, "dateAdded": dateAdded, "documentID": documentID]
    }
    
    init(name: String, artist: String, playlist: String, albumImage: String, dateAdded: Date, documentID: String) {
        self.name = name
        self.artist = artist
        self.playlist = playlist
        self.albumImage = albumImage
        self.dateAdded = dateAdded
        self.documentID = documentID
    }
    
    convenience init(dictionary: [String: Any]) {
        
        let name = dictionary["name"] as! String? ?? ""
        let artist = dictionary["artist"] as! String? ?? ""
        let playlist = dictionary["playlist"] as! String? ?? ""
        let albumImage = dictionary["albumImage"] as! String? ?? ""
        let dateAdded = dictionary["dateAdded"] as! Date? ?? Date()
        self.init(name: name, artist: artist, playlist: playlist, albumImage: albumImage, dateAdded: dateAdded, documentID: "")
    }
    
    convenience init() {
        //        let currentUserID = Auth.auth().currentUser?.email ?? "Unknown User"
        self.init(name: "", artist: "", playlist: "", albumImage: "",
                  //                  reviewerUserID: currentUserID,
            dateAdded: Date(), documentID: "")
    }
    
    func saveTop10Song(user: MusicUser, completed: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        
        let dataToSave = self.dictionary
        if self.documentID != "" {
            let ref = db.collection("users").document(user.documentID).collection("top10").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                if let error = error {
                    print("ERROR: updating document \(self.documentID) in spot \(user.documentID) \(error.localizedDescription)")
                    completed(false)
                }
                else {
                    print("Document updated with ref ID \(ref.documentID)")
                    // song added
                }
            }
        }
        
        func saveHot10Song(user: MusicUser, completed: @escaping (Bool) -> ()) {
            let db = Firestore.firestore()
            
            let dataToSave = self.dictionary
            if self.documentID != "" {
                let ref = db.collection("users").document(user.documentID).collection("songs").document(self.documentID)
                ref.setData(dataToSave) { (error) in
                    if let error = error {
                        print("ERROR: updating document \(self.documentID) in spot \(user.documentID) \(error.localizedDescription)")
                        completed(false)
                    }
                    else {
                        print("Document updated with ref ID \(ref.documentID)")
                        // song added
                    }
                }
            }
                
            else {
                var ref: DocumentReference? = nil
                ref = db.collection("users").document(user.documentID).collection("songs").addDocument(data: dataToSave) { error in
                    if let error = error {
                        print("ERROR: updating spot \(user.documentID) for new review documentID \(self.documentID) \(error.localizedDescription)")
                        completed(false)
                    }
                    else {
                        print("New document created with ref ID \(ref?.documentID ?? "unknown")")
                        // new song added
                        
                    }
                }
            }
        }
    }
}
