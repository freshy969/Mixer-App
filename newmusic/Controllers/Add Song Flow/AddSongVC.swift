//
//  AddSongVC.swift
//  newmusic
//
//  Created by Joe Langenderfer on 11/30/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit
import Firebase

protocol isAbleToReceiveData {
    func pass(data: Playlist)
}

class AddSongVC: UIViewController, isAbleToReceiveData {
    
    var song: Song!
    var user: MusicUser!
    var selectedPlaylist: Playlist!
    
    var top10ButtonClicked = false
    var hot10buttonClicked = false
    var otherButtonClicked = false
    
    func pass(data: Playlist) {
        // set up the button text
        selectedPlaylist = data
        otherPlaylistLabel.otherPlaylistLabel.setTitle(selectedPlaylist.name, for: .normal)
        otherButtonClicked = true
    }
    
    let playlistInstructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Pick a Playlist"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let top10PlaylistLabel: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Top 10 Playlist", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        //        button.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0, blue: 0.3254901961, alpha: 1)
        button.backgroundColor = UIColor.lightText
        button.isEnabled = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(handleTop10Tap), for: .touchUpInside)
        return button
    }()
    
    let hot10PlaylistLabel: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Hot 10 Playlist", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        //        button.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0, blue: 0.3254901961, alpha: 1)
        button.backgroundColor = UIColor.lightText
        button.isEnabled = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(handleHot10Tap), for: .touchUpInside)
        return button
    }()
    
    let otherPlaylistLabel = OtherPlaylistButton()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Share something cool"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let quitIcon: UIButton = {
        let iv = UIButton()
        iv.setImage(UIImage(named: "quitBlack"), for: .normal)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.addTarget(self, action: #selector(handleQuit), for: .touchUpInside)
        return iv
    }()
    
    let addSongTextField: CustomTextField = {
        let tf = CustomTextField(padding: 18, height: 48)
        tf.placeholder = "Add a Song"
        tf.backgroundColor = .white
        tf.textAlignment = .center
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let addArtistTextField: CustomTextField = {
        let tf = CustomTextField(padding: 18, height: 48)
        tf.placeholder = "Add the Artist?"
        tf.backgroundColor = .white
        tf.textAlignment = .center
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()

    
    let addSongButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Song", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        //        button.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0, blue: 0.3254901961, alpha: 1)
        button.backgroundColor = UIColor.lightText
        button.isEnabled = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(handleAddSong), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupOtherPlaylistLabel()
        setupTapGesture()
        setupGradientLayer()
        setupView()
        fetchCurrentUser()
        
        if song == nil {
            song = Song()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTapGesture()
        print(selectedPlaylist?.name ?? "")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNotificationObservers()
    }
    
    fileprivate func setupOtherPlaylistLabel() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleOtherTap))
        otherPlaylistLabel.addGestureRecognizer(tap)
        otherPlaylistLabel.otherPlaylistLabel.addTarget(self, action: #selector(handleOtherTap), for: .touchUpInside)
        otherPlaylistLabel.downIcon.addTarget(self, action: #selector(handleOtherTap), for: .touchUpInside)
    }
    
    @objc fileprivate func handleAddSong() {
        // Need to fetch current user, then stuff the song in a new collection (playlist) in that user
        // store song
        
        if top10ButtonClicked == true {
            // Save song to Top 10 Playlist
            // Check to see how many songs are in playlist
            song.name = addSongTextField.text!
            song.artist = addArtistTextField.text!
            self.song.saveTop10Song(user: self.user) { (success) in
//                print(self.user?.dictionary)
            }
            print("Saving song to top 10...")
        }
        
        if hot10buttonClicked == true {
            // Save song to Hot 10 Playlist
            song.name = addSongTextField.text!
            song.artist = addArtistTextField.text!
            self.song.saveHot10Song(user: self.user) { (success) in
//                print(self.user?.dictionary)
            }

            print("Saving song to hot 10...")
        }
        
        if otherButtonClicked == true {
            song.name = addSongTextField.text!
            song.artist = addArtistTextField.text!
            self.song.saveCustomPlaylistSong(user: self.user, playlist: self.selectedPlaylist) { (success) in
            }
        }
        print("Song was Added")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func handleQuit() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleTextInputChange() {
        handleViewInput()
    }
    
    fileprivate func handleViewInput() {
        let isFormValid = self.addSongTextField.text?.isEmpty != true && self.addArtistTextField.text?.isEmpty != true && (top10ButtonClicked == true || hot10buttonClicked == true || otherButtonClicked == true)
        
        if isFormValid {
            self.addSongButton.isEnabled = true
            self.addSongButton.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0, blue: 0.3254901961, alpha: 1)
        } else {
            self.addSongButton.isEnabled = false
            self.addSongButton.backgroundColor = UIColor.lightText
        }
    }
    
    fileprivate func fetchCurrentUser() {
        // fetch some Firestore Data
        guard let uid = Auth.auth().currentUser?.uid else { return }
        user.documentID = uid
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, err) in
            if let err = err {
                print(err)
                return
            }
            
            // fetched our user here
            guard let dictionary = snapshot?.data() else { return }
            self.user = MusicUser(dictionary: dictionary)
        }
    }
    
    fileprivate func setupTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    @objc fileprivate func handleTop10Tap() {
        top10ButtonClicked = true
        hot10buttonClicked = false
        otherButtonClicked = false
        handleViewInput()
        self.top10PlaylistLabel.backgroundColor = .white
        self.top10PlaylistLabel.setTitleColor(.black, for: .normal)
        self.hot10PlaylistLabel.backgroundColor = UIColor.lightText
        self.hot10PlaylistLabel.setTitleColor(.white, for: .normal)
        otherPlaylistLabel.backgroundColor = UIColor.lightText
        otherPlaylistLabel.otherPlaylistLabel.setTitleColor(.white, for: .normal)
        otherPlaylistLabel.downIcon.setImage(UIImage(named: "downArrowWhite"), for: .normal)
        // playlist chosen = .text
    }
    
    @objc fileprivate func handleHot10Tap() {
        hot10buttonClicked = true
        top10ButtonClicked = false
        otherButtonClicked = false
        handleViewInput()
        self.hot10PlaylistLabel.backgroundColor = .white
        self.hot10PlaylistLabel.setTitleColor(.black, for: .normal)
        self.top10PlaylistLabel.backgroundColor = UIColor.lightText
        self.top10PlaylistLabel.setTitleColor(.white, for: .normal)
        otherPlaylistLabel.backgroundColor = UIColor.lightText
        otherPlaylistLabel.otherPlaylistLabel.setTitleColor(.white, for: .normal)
        otherPlaylistLabel.downIcon.setImage(UIImage(named: "downArrowWhite"), for: .normal)
    }
    
    @objc fileprivate func handleOtherTap() {
//        otherButtonClicked needs to be set to true after another playlist is selected
//        otherButtonClicked = true
        handleOtherButton()
        hot10buttonClicked = false
        top10ButtonClicked = false
        otherPlaylistLabel.backgroundColor = .white
        otherPlaylistLabel.otherPlaylistLabel.setTitleColor(.black, for: .normal)
        otherPlaylistLabel.downIcon.setImage(UIImage(named: "downArrowBlack"), for: .normal)
        self.top10PlaylistLabel.backgroundColor = UIColor.lightText
        self.top10PlaylistLabel.setTitleColor(.white, for: .normal)
        self.hot10PlaylistLabel.backgroundColor = UIColor.lightText
        self.hot10PlaylistLabel.setTitleColor(.white, for: .normal)
    }
    
    fileprivate func handleOtherButton() {
        let selectPlaylistController = SelectPlaylistVC()
        selectPlaylistController.delegate = self
        present(selectPlaylistController, animated: true)
    }
    
    @objc fileprivate func handleTapDismiss() {
        self.view.endEditing(true)
    }
    
    fileprivate func setupView() {
        navigationItem.title = "Add a Song"
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        view.addSubview(quitIcon)
        quitIcon.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        
        setupStackView()
    }
    
    lazy var stackView = UIStackView(arrangedSubviews: [
        playlistInstructionLabel,
        SpacerViewHeight(space: 10),
        top10PlaylistLabel,
        hot10PlaylistLabel,
        otherPlaylistLabel,
        SpacerViewHeight(space: 50),
        subtitleLabel,
        SpacerViewHeight(space: 10),
        addSongTextField,
        addArtistTextField,
        addSongButton
        ])
    
    fileprivate func setupStackView() {
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
        stackView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 50, paddingBottom: 0, paddingRight: 50, width: 0, height: 0)
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    fileprivate func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc fileprivate func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        })
    }
    
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        
        let bottomSpace = view.frame.height - stackView.frame.origin.y - stackView.frame.height
        
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
    }
    
    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        let topColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1)
        // make sure to user cgColor
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }

}
