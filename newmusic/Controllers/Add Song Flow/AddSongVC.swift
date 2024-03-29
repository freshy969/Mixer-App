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
        otherPlaylistLabel.arrowIcon.setImage(nil, for: .normal)
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
        label.text = "Add a Song"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let quitIcon: UIButton = {
        let iv = UIButton()
        iv.setImage(UIImage(named: "light-close-button"), for: .normal)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.addTarget(self, action: #selector(handleQuit), for: .touchUpInside)
        return iv
    }()
    
    let addSongTextField: CustomAddTextField = {
        let tf = CustomAddTextField(padding: 18, height: 48)
        tf.placeholder = "Search"
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

    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        //        button.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0, blue: 0.3254901961, alpha: 1)
        button.backgroundColor = UIColor.lightText
        button.isEnabled = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
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
        navigationController?.isNavigationBarHidden = true
        setupTapGesture()
        handleViewInput()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNotificationObservers()
    }
    
    fileprivate func setupOtherPlaylistLabel() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleOtherTap))
        otherPlaylistLabel.addGestureRecognizer(tap)
        otherPlaylistLabel.otherPlaylistLabel.addTarget(self, action: #selector(handleOtherTap), for: .touchUpInside)
        otherPlaylistLabel.arrowIcon.addTarget(self, action: #selector(handleOtherTap), for: .touchUpInside)
    }
    
    @objc fileprivate func handleNext() {
        // Need to fetch current user, then stuff the song in a new collection (playlist) in that user
        // store song
        
        if top10ButtonClicked == true {
            // Save song to Top 10 Playlist
            // Check to see how many songs are in playlist
            
            let currentTime = Date().toMillis()
            song.name = addSongTextField.text!
            song.artist = addArtistTextField.text!
            song.dateAdded = currentTime!
            
//            if song.checkNumberOfSongs < 10 { still room to add a song so save the song  }
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
        
        // close menu here so that new song in newsfeed shows
        handleHide()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func handleHide() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC)?.closeMenu()
    }
    
    @objc fileprivate func handleQuit() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleTextInputChange() {
        
        if self.addSongTextField.text?.isEmpty != true {
            addSongTextField.searchIcon.setImage(UIImage(named: "rightArrowRed"), for: .normal)
        } else {
            addSongTextField.searchIcon.setImage(UIImage(named: "rightArrowGray"), for: .normal)
        }
        
        handleViewInput()
    }
    
    fileprivate func handleViewInput() {
        let isFormValid = self.addSongTextField.text?.isEmpty != true &&
//            self.addArtistTextField.text?.isEmpty != true &&
            (top10ButtonClicked == true || hot10buttonClicked == true || otherButtonClicked == true)
        
        if isFormValid {
            self.nextButton.isEnabled = true
            self.nextButton.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0, blue: 0.3254901961, alpha: 1)
        } else {
            self.nextButton.isEnabled = false
            self.nextButton.backgroundColor = UIColor.lightText
        }
    }
    
    fileprivate func fetchCurrentUser() {
        // fetch some Firestore Data
        guard let uid = Auth.auth().currentUser?.uid else { return }
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
        otherPlaylistLabel.arrowIcon.setImage(UIImage(named: "rightArrowWhite"), for: .normal)
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
        otherPlaylistLabel.arrowIcon.setImage(UIImage(named: "rightArrowWhite"), for: .normal)
    }
    
    @objc fileprivate func handleOtherTap() {
//        otherButtonClicked needs to be set to true after another playlist is selected
//        otherButtonClicked = true
        handleOtherButton()
        hot10buttonClicked = false
        top10ButtonClicked = false
        handleViewInput()
        otherPlaylistLabel.backgroundColor = .white
        otherPlaylistLabel.otherPlaylistLabel.setTitleColor(.black, for: .normal)
        otherPlaylistLabel.arrowIcon.setImage(UIImage(named: "rightArrowBlack"), for: .normal)
        self.top10PlaylistLabel.backgroundColor = UIColor.lightText
        self.top10PlaylistLabel.setTitleColor(.white, for: .normal)
        self.hot10PlaylistLabel.backgroundColor = UIColor.lightText
        self.hot10PlaylistLabel.setTitleColor(.white, for: .normal)
    }
    
    fileprivate func handleOtherButton() {
        let selectPlaylistController = SelectPlaylistVC()
        selectPlaylistController.delegate = self
        self.navigationController?.pushViewController(selectPlaylistController, animated: true)
    }
    
    @objc fileprivate func handleTapDismiss() {
        self.view.endEditing(true)
    }
    
    fileprivate func setupView() {
        navigationItem.title = "Add a Song"
        
        view.addSubview(quitIcon)
        quitIcon.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 27.5, height: 27.5)
        
        setupStackView()
    }
    
    lazy var stackView = UIStackView(arrangedSubviews: [
        subtitleLabel,
        SpacerViewHeight(space: 10),
        addSongTextField,
        SpacerViewHeight(space: 25),
        playlistInstructionLabel,
        SpacerViewHeight(space: 10),
        top10PlaylistLabel,
        hot10PlaylistLabel,
        otherPlaylistLabel,
        SpacerViewHeight(space: 25),
        nextButton
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
