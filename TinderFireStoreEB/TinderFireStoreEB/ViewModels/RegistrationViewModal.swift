//
//  RegistrationViewModal.swift
//  TinderFireStoreEB
//
//  Created by Eugene Berezin on 7/27/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class RegistrationViewModel {
    
    var bindableImage = Bindable<UIImage>()
    

    var bindableIsRegistering = Bindable<Bool>()
    var fullName: String? {didSet {checkFormValidity()}}
    var email: String? {didSet {checkFormValidity()}}
    var password: String? {didSet {checkFormValidity()}}
    
    
     func performRegistration(completion: @escaping (Error?) -> ()) {
        guard let email = email, let password = password else { return }
        bindableIsRegistering.value = true
        Auth.auth().createUser(withEmail: email, password: password) {[unowned self](res, err) in
            if let err = err {
                print(err)
                completion(err)
                return
            }
            
            print("Successfully register user", res?.user.uid ?? "")
            //You can only upload an image to the firebase once you're authenticated/
            let filename = UUID().uuidString
            let ref = Storage.storage().reference(withPath: "/images/\(filename)")
            let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.75)
            ref.putData(imageData ?? Data(), metadata: nil, completion: { (_, err) in
                
                if let err = err {
                    completion(err)
                    return // bail
                }
                
                print("***********FINISHED UPLOADING TO THE FIREBASE**************")
                ref.downloadURL(completion: { (url, err) in
                    if let err = err {
                        completion(err)
                        return
                    }
                    
                    //self.registeringHUD.dismiss()
                    self.bindableIsRegistering.value = false
                    print("Download url of the immage is    ", url?.absoluteString ?? "")
                })
            })
            
            //self.present(homeController, animated: true)
        }
        
    }
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty ?? true == false && password?.isEmpty == false
        
        bindableIsFormValid.value = isFormValid
        
    }
    
    var bindableIsFormValid = Bindable<Bool>()
    //Reactive programming
    
   // var isFormValidObserver: ((Bool) -> ())?
    
    
}
