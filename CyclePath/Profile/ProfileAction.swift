//
//  ProfileAction.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 29/09/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import UIKit
import Photos
import Firebase

class ProfileAction: UIViewController
{
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var loggedOutTxt: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var orTxtLabel: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var usernameLbl: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        checkAuth()
        
        checkPhotosAccess()
        accessPhotoLibrary()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        checkAuth()
        getActualUserInformations()
    }
    
    @IBAction func registerUser(_ sender: Any)
    {
        guard let registerAction = storyboard?.instantiateViewController(withIdentifier: "RegisterAction") as? RegisterAction else { return }
        
        presentDetails(registerAction)
    }
    
    @IBAction func loginUser(_ sender: Any)
    {
        guard let loginAction = storyboard?.instantiateViewController(withIdentifier: "LoginAction") as? LoginAction else { return }
        
        presentDetails(loginAction)
    }
    
    @IBAction func LogoutUser(_ sender: Any)
    {
        let logoutPopUp = UIAlertController(
            title: "Se déconnecter",
            message: "Etes-vous sûr ?",
            preferredStyle: .actionSheet
        )
        
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { (buttonTaped) in
            do {
                try Auth.auth().signOut()
                self.viewWillAppear(true)
            } catch {
                print(error)
            }
        }
        logoutPopUp.addAction(logoutAction)
        present(logoutPopUp, animated: true, completion: nil)
    }
    
    @IBAction func editprofile(_ sender: Any)
    {
        
    }
}

extension ProfileAction: ProfileActionProtocol
{
    func checkAuth()
    {
        if Auth.auth().currentUser == nil {
            logoutBtn.isHidden = true
            editBtn.isHidden = true
            profileImage.isHidden = true
            usernameLbl.isHidden = true
            loggedOutTxt.isHidden = false
            registerBtn.isHidden = false
            orTxtLabel.isHidden = false
            loginBtn.isHidden = false
        } else {
            logoutBtn.isHidden = false
            editBtn.isHidden = true
            usernameLbl.isHidden = false
            profileImage.isHidden = false
            profileImage.image = #imageLiteral(resourceName: "ProfileImage")
            loggedOutTxt.isHidden = true
            registerBtn.isHidden = true
            orTxtLabel.isHidden = true
            loginBtn.isHidden = true
        }
    }
    
    func getActualUserInformations()
    {
        if Auth.auth().currentUser != nil {
            usernameLbl.text = Auth.auth().currentUser?.email
        }
    }
    
    func checkPhotosAccess()
    {
        if PHPhotoLibrary.authorizationStatus() == .notDetermined {
            PHPhotoLibrary.requestAuthorization({ (authorized) in
                self.accessPhotoLibrary()
            })
        }
    }
    
    func accessPhotoLibrary()
    {
        profileImage.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(pickImageProfile)
            )
        )
        
        profileImage.isUserInteractionEnabled = true
    }
    
    @objc func pickImageProfile()
    {
        let imageController = UIImagePickerController()
        imageController.delegate = self
        imageController.allowsEditing = true
        
        present(imageController, animated: true, completion: nil)
    }
    
    func uploadProfileImage()
    {
        let data = UIImagePNGRepresentation(profileImage.image!)
        
        ProfileWorker().uploadImage(data: data!)
    }
}

extension ProfileAction: UIImagePickerControllerDelegate
{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        // TODO
        var selectedImage: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] {
            selectedImage = editedImage as? UIImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] {
            selectedImage = originalImage as? UIImage
        }
        
        if let finalImage = selectedImage {
            profileImage.image = finalImage
            uploadProfileImage()
        }
        
        dismiss(animated: true, completion: nil)
    }
}

extension ProfileAction: UINavigationControllerDelegate
{
    
}
