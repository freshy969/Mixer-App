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
    
    var name: String
    var artist: String
    var playlist: String
    var albumImage: String //URL
    var dateAdded: Int64
    var documentID: String
    
    var dictionary: [String: Any] {
        return ["name": name, "artist": artist, "playlist": playlist, "albumImage": albumImage, "dateAdded": dateAdded, "documentID": documentID]
    }
    
    init(name: String, artist: String, playlist: String, albumImage: String, dateAdded: Int64, documentID: String) {
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
        let dateAdded = dictionary["dateAdded"] as! Int64? ?? 0
        self.init(name: name, artist: artist, playlist: playlist, albumImage: albumImage, dateAdded: dateAdded,
                  documentID: "")
    }
    
    convenience init() {
        self.init(name: "", artist: "", playlist: "", albumImage: "", dateAdded: 0, documentID: "")
    }
    
    func saveTop10Song(user: MusicUser, completed: @escaping (Bool) -> ()) {
        
        user.documentID = (Auth.auth().currentUser?.uid)!
        
        let db = Firestore.firestore()
        let dataToSave = self.dictionary
        
        if self.documentID != "" {
            let ref = db.collection("users").document(user.documentID).collection("top-ten-playlist").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                if let error = error {
                    print("ERROR: updating document \(self.documentID) for user \(user.documentID) \(error.localizedDescription)")
                    completed(false)
                }
                else {
                    print("Document updated with ref ID \(ref.documentID)")
                    // song updated
                }
            }
        }
        else {
            var ref: DocumentReference? = nil
            ref = db.collection("users").document(user.documentID).collection("top-ten-playlist").addDocument(data: dataToSave) { error in
                // now going to need to go into playlists then into whatever the playlist is (going to need to pass in a Playlist? )
                if let error = error {
                    print("ERROR: updating user \(user.documentID) for new song documentID \(self.documentID) \(error.localizedDescription)")
                    completed(false)
                }
                else {
                    print("New document created with ref ID \(ref?.documentID ?? "unknown")")
                }
            }
        }
    }
    
    func saveHot10Song(user: MusicUser, completed: @escaping (Bool) -> ()) {
        
        user.documentID = (Auth.auth().currentUser?.uid)!
        
        let db = Firestore.firestore()
        
        let dataToSave = self.dictionary
        if self.documentID != "" {
            let ref = db.collection("users").document(user.documentID).collection("hot-ten-playlist").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                if let error = error {
                    print("ERROR: updating document \(self.documentID) in user \(user.documentID) \(error.localizedDescription)")
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
            ref = db.collection("users").document(user.documentID).collection("hot-ten-playlist").addDocument(data: dataToSave) { error in
                if let error = error {
                    print("ERROR: updating user \(user.documentID) for new song documentID \(self.documentID) \(error.localizedDescription)")
                    completed(false)
                }
                else {
                    print("New document created with ref ID \(ref?.documentID ?? "unknown")")
                    // new song added
                    
                }
            }
        }
    }
    
    func saveCustomPlaylistSong(user: MusicUser, playlist: Playlist, completed: @escaping (Bool) -> ()) {
        
        user.documentID = (Auth.auth().currentUser?.uid)!
        let db = Firestore.firestore()
        
        let dataToSave = self.dictionary
        if self.documentID != "" {
            let ref = db.collection("users").document(user.documentID).collection("custom-playlists").document(playlist.documentID).collection("songs").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                if let error = error {
                    print("ERROR: updating document \(self.documentID) in user \(user.documentID) \(error.localizedDescription)")
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
            ref = db.collection("users").document(user.documentID).collection("custom-playlists").document(playlist.documentID).collection("songs").addDocument(data: dataToSave) { error in
                if let error = error {
                    print("ERROR: updating user \(user.documentID) for new song documentID \(self.documentID) \(error.localizedDescription)")
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

