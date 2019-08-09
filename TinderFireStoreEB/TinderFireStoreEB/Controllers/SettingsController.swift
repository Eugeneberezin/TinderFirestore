//
//  SettingsController.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 8/6/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD
import SDWebImage

class CustomImagePickerController: UIImagePickerController {
    var imageButton: UIButton?
    
}


class SettingsController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //instance properties
    lazy var image1Button = createButton(selector: #selector(handleSelectPhoto))
    lazy var image2Button = createButton(selector: #selector(handleSelectPhoto))
    lazy var image3Button = createButton(selector: #selector(handleSelectPhoto))

    func createButton(selector: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        tableView.backgroundColor = #colorLiteral(red: 0.8894340479, green: 0.8894340479, blue: 0.8894340479, alpha: 1)
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .interactive
        fetchCurrentUser()
        
    }
    
    
    lazy var header: UIView = {
        let header = UIView()
        header.addSubview(image1Button)
        let padding: CGFloat = 16
        setupSelectPhotoLargeButton(header, padding)
        setUpStackViewOfRightHandButtons(padding, header)
        return header
    }()
    
    class HeaderLable: UILabel {
        override func drawText(in rect: CGRect) {
            super.drawText(in: rect.insetBy(dx: 16, dy: 0))
        }
    }
        
        
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return header
        }
        let headerLabel = HeaderLable()
        
        switch section {
        case 1:
            headerLabel.text = "Name"
        case 2:
            headerLabel.text = "Profession"
        case 3:
            headerLabel.text = "Age"
        default:
            headerLabel.text = "Bio"
        }
        
        headerLabel.isAccessibilityElement = true
        
        return headerLabel
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 300
        }
         return 40
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 0 : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingsCell(style: .default, reuseIdentifier: nil)
        
        switch indexPath.section {
        case 1:
            cell.textField.placeholder = "Name"
            cell.textField.text = user?.name
            cell.textField.addTarget(self, action: #selector(handleNameChange), for: .editingChanged)
        case 2:
            cell.textField.placeholder = "Profession"
            cell.textField.text = user?.profession
            cell.textField.addTarget(self, action: #selector(handleProfessionChange), for: .editingChanged)
        case 3:
            cell.textField.placeholder = "Age"
            if let age = user?.age {
              cell.textField.text = String(age)
            }
            cell.textField.addTarget(self, action: #selector(handleAgeChange), for: .editingChanged)
            
        default:
            cell.textField.placeholder = "Bio"
            
        } 
        
        return cell
    }
    
    var user: User?
    
    fileprivate func fetchCurrentUser() {
        //fatch current logged in user
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, err) in
            if let err = err {
                print(err)
            }
            
            //fetched user
            
            guard let userDictionary = snapshot?.data() else {return}
            self.user = User(dictionary: userDictionary)
            self.loadUserPhotos()


            self.tableView.reloadData()
            
            
            
        }
        
    }
    
    
    fileprivate func loadUserPhotos() {
        guard let imageUrl = user?.imageUrl1, let url = URL(string: imageUrl) else { return }
        // why exactly do we use this SDWebImageManager class to load our images?
        SDWebImageManager.shared().loadImage(with: url, options: .continueInBackground, progress: nil) { (image, _, _, _, _, _) in
            self.image1Button.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
    }
    
    fileprivate func setUpStackViewOfRightHandButtons(_ padding: CGFloat, _ header: UIView) {
        let stackView = UIStackView(arrangedSubviews: [image2Button, image3Button])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = padding
        header.addSubview(stackView)
        stackView.anchor(top: header.topAnchor, leading: image1Button.trailingAnchor, bottom: header.bottomAnchor, trailing: header.trailingAnchor, padding: .init(top: padding, left: padding, bottom: padding, right: padding))
    }
    
    fileprivate func setupSelectPhotoLargeButton(_ header: UIView, _ padding: CGFloat) {
        image1Button.anchor(top: header.topAnchor, leading: header.leadingAnchor, bottom: header.bottomAnchor, trailing: nil, padding: .init(top: padding, left: padding, bottom: padding, right: 0))
        image1Button.widthAnchor.constraint(equalTo: header.widthAnchor, multiplier: 0.45).isActive = true
    }
    
    fileprivate func setupNavigationItems() {
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave)),
            UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleCancel))
        ]
    }
    
    @objc fileprivate func handleSelectPhoto(button: UIButton) {
        let imagePicker = CustomImagePickerController()
        imagePicker.delegate = self
        imagePicker.imageButton = button
        present(imagePicker, animated: true)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.originalImage] as? UIImage
        let imageButton = (picker as? CustomImagePickerController)?.imageButton
        imageButton?.setImage(selectedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func handleSave() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        //setting user's data that I want to save in Firebase
        let docData: [String: Any] = [
            "uid": uid,
            "fullName": user?.name ?? "",
            "imageUrl1": user?.imageUrl1 ?? "",
            "age": user?.age ?? "",
            "profession": user?.profession ?? ""
        ]
        
        //show HUD as user saving info
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Saving your profile"
        hud.show(in: view, animated: true)
        
        Firestore.firestore().collection("users").document(uid).setData(docData) { (err) in
            hud.dismiss(animated: true)
            if let err = err {
                print(">>FAILED TO SAVE<<", err)
                hud.textLabel.text = "Failed to save data"
                hud.detailTextLabel.text = err.localizedDescription
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 5, animated: true)
                return
            }
            
            print(">>FINISHED SAVIG USER INFO")
        }
        
    }
    
    @objc fileprivate func handleNameChange(textField: UITextField) {
        self.user?.name = textField.text
    }
    
    @objc fileprivate func handleProfessionChange(textField: UITextField) {
        self.user?.profession = textField.text
    }
    
    @objc fileprivate func handleAgeChange(textField: UITextField) {
        self.user?.age = Int(textField.text ?? "")
    }
    
    @objc fileprivate func handleCancel() {
        dismiss(animated: true, completion: nil)
    }

    
}
