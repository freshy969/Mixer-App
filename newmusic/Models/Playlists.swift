//
//  Playlists.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/13/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import Foundation
import Firebase

class Playlists {
    
    var playlistArray = [Playlist]()
    
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadPlaylists(user: MusicUser, completed: @escaping () -> ()) {
        user.documentID = (Auth.auth().currentUser?.uid)!
        
        db.collection("users").document(user.documentID).collection("custom-playlists").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.playlistArray = []
            for document in querySnapshot!.documents {
                let playlist = Playlist(dictionary: document.data())
                playlist.documentID = document.documentID
                self.playlistArray.append(playlist)
            }
            completed()
        }
    }
}
