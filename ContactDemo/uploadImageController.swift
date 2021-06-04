
//
//  qrScanController.swift
//  ContactDemo
//
//  Created by Siva on 02/06/21.

//

import UIKit
import AVKit

class uploadImageController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var uploadImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func upload_Action(_ sender: Any) {
        
          if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
                                                       //already authorized
                                                
            DispatchQueue.main.async {
                
                let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                self.camera()
                                 
                }))

                alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                self.Gallery()
                }))
                       
                alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

               self.present(alert, animated: true, completion: nil)
                                                                  

                }
                                                      
            } else {
                    AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                    if granted {
                                                               
                    DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
                   alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                    self.camera()
                    }))

                   alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                    self.Gallery()
                    }))
                
                    alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

                   self.present(alert, animated: true, completion: nil)
                                                                

                    }
                                        
                                                               
                  } else {
                                           
                                    
                    DispatchQueue.main.async {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                        if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                                        })
                                    
                        } else{
                                    
                        UIApplication.shared.openURL(url)
                        }
           
                       }
    
                       }
                   }
              })
             }
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         //  if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
           
           
         
               
       guard let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
                   return
               }
        
        self.uploadImage.image = pickedImage
    
    dismiss(animated: true, completion: nil)

}
    func camera()
        {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
          let cameraPicker = UIImagePickerController()
                cameraPicker.delegate = self
                cameraPicker.allowsEditing = true
                cameraPicker.sourceType = UIImagePickerController.SourceType.camera
                self.present(cameraPicker, animated: true, completion: nil)
            }
            else
            {
                let alert  = UIAlertController(title: "Warning", message: "Simulator not support to open Camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        func Gallery()
        {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
          let galleryPicker = UIImagePickerController()
                galleryPicker.delegate = self
                galleryPicker.allowsEditing = true
                galleryPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(galleryPicker, animated: true, completion: nil)
            }
            else
            {
                let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
       
}

