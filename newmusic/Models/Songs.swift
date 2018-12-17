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
    var customPlaylistSongArray = [Song]()
    
    var selectedPlaylist: Playlist!
    var currentUser: MusicUser!
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
    
    func loadCustomPlaylistSongs(user: MusicUser, playlist: Playlist, completed: @escaping () -> ()) {
        user.documentID = (Auth.auth().currentUser?.uid)!
        
        db.collection("users").document(user.documentID).collection("custom-playlists").document(playlist.documentID).collection("songs").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.customPlaylistSongArray = []
            self.selectedPlaylist = playlist
            self.currentUser = user
            // there are querySnapshot!.documents.count documents in the spots snapshot
            for document in querySnapshot!.documents {
                let song = Song(dictionary: document.data())
                song.documentID = document.documentID
                self.customPlaylistSongArray.append(song)
                self.selectedPlaylist.numberOfSongs += 1
            }
//            self.addNumberOfSongs()
            completed()
        }
    }
    
//    fileprivate func addNumberOfSongs() {
//        // need to set the number of songs in a playlist right here
//        db.collection("users").document(currentUser.documentID).collection("custom-playlists").document(selectedPlaylist.documentID).setData(self.selectedPlaylist.numberOfSongs) { (error) in
//            if let error = error {
//                print("ERROR: updating document \(currentUser.documentID) \(error.localizedDescription)")
//                completed(false)
//            }
//            else {
//                print("Document updated with ref ID \(ref.documentID)")
//                completed(true)
//            }
//        }
//    }
}

