//
//  Songs.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/4/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import Foundation
import Firebase

class Songs {
    
    var top10SongArray = [Song]()
    var hot10SongArray = [Song]()
    
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadTop10SongData(user: MusicUser, completed: @escaping () -> ()) {
        user.documentID = (Auth.auth().currentUser?.uid)!
        
        db.collection("users").document(user.documentID).collection("top-ten-playlist").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.top10SongArray = []
            // there are querySnapshot!.documents.count documents in the spots snapshot
            for document in querySnapshot!.documents {
                let song = Song(dictionary: document.data())
                song.documentID = document.documentID
                self.top10SongArray.append(song)
//                print(song)
            }
            completed()
        }
    }
    
    func loadHot10SongData(user: MusicUser, completed: @escaping () -> ()) {
        user.documentID = (Auth.auth().currentUser?.uid)!
        
        db.collection("users").document(user.documentID).collection("hot-ten-playlist").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.hot10SongArray = []
            // there are querySnapshot!.documents.count documents in the spots snapshot
            for document in querySnapshot!.documents {
                let song = Song(dictionary: document.data())
                song.documentID = document.documentID
                self.hot10SongArray.append(song)
            }
            completed()
        }
    }
}

