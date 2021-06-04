
//
//  qrScanController.swift
//  ContactDemo
//
//  Created by Siva on 02/06/21.

//


import Foundation
import UIKit
import AVFoundation
import AVKit
import Photos

class qrScanController: UIViewController ,AVCaptureMetadataOutputObjectsDelegate ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var output = AVCaptureMetadataOutput()
    var previewLayer: AVCaptureVideoPreviewLayer!
    var captureSession = AVCaptureSession()
      // scan header
    
    @IBOutlet weak var scantitle: UILabel!
    
    @IBOutlet weak var scnView: UIView!

    @IBOutlet weak var customView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

          DispatchQueue.main.async {
            
             self.checkPermissions()

              }
        
              self.title = "QR Scan"
               scantitle.text = "Scan a QR code"
              scantitle.textColor = UIColor.black
       
              self.scnView.backgroundColor = UIColor.black
              self.view.backgroundColor = UIColor.white
        
    }

     func checkPermissions() {
                let authStatus = AVCaptureDevice.authorizationStatus(for:AVMediaType.video)

                 switch authStatus {
                  case .authorized:
                   self.setupCamera()
                  case .denied:
                 alertPromptToAllowCameraAccessViaSetting()
                  default:
         
                setupCamera()
            }
        }
        func alertPromptToAllowCameraAccessViaSetting() {
            let alert = UIAlertController(title: "Error", message: "Camera access required to letpay", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "Cancel", style: .default))
            alert.addAction(UIAlertAction(title: "Settings", style: .cancel) { (alert) -> Void in
                UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
            })

            present(alert, animated: true)
        }
       
        override func viewWillAppear(_ animated: Bool) {
                       super.viewWillAppear(animated)
            self.navigationController?.isNavigationBarHidden = false
           
                  
                       DispatchQueue.global(qos: .userInitiated).async {
                           if !self.captureSession.isRunning {
                               self.captureSession.startRunning()
                           }
                       }
                   }

           override  func viewWillDisappear(_ animated: Bool) {
                       super.viewWillDisappear(animated)

                       DispatchQueue.global(qos: .userInitiated).async {
                           if self.captureSession.isRunning {
                               self.captureSession.stopRunning()
                           }
                       }
                   }

        func setupCamera() {
                       guard let device = AVCaptureDevice.default(for: .video),
                           let input = try? AVCaptureDeviceInput(device: device) else {
                           return
                       }
                   
        
                       DispatchQueue.global(qos: .userInitiated).async {
                           if self.captureSession.canAddInput(input) {
                               self.captureSession.addInput(input)
                    
                           }

                           let metadataOutput = AVCaptureMetadataOutput()

                if self.captureSession.canAddOutput(metadataOutput) {
                    self.captureSession.addOutput(metadataOutput)
                     
                    metadataOutput.setMetadataObjectsDelegate(self, queue: .global(qos: .userInitiated))

                if Set([.qr,.ean13]).isSubset(of: metadataOutput.availableMetadataObjectTypes) {
                                   metadataOutput.metadataObjectTypes = [.qr, .ean13]
                          
                               }
                           } else {
                               print("Could not add metadata output")
                           }

                           self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
                           self.previewLayer.videoGravity = .resizeAspectFill

                           DispatchQueue.main.async {
                               self.previewLayer.frame = self.scnView.bounds
                               self.scnView.layer.addSublayer(self.previewLayer)
                           }
                       }
                   }
        
        

        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            
            self.captureSession.stopRunning()
            
                for metadata in metadataObjects {
                if let readableObject = metadata as? AVMetadataMachineReadableCodeObject,
                            
                let code:String = readableObject.stringValue {
                    
                let base64Str:String = (code.data(using: .utf8)?.base64EncodedString())!
            

                        dismiss(animated: true)
                              
                        }
                    }

}
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
                guard
                    let qrcodeImg = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage,
                    let detector: CIDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh]),
                    let ciImage: CIImage = CIImage(image:qrcodeImg),
                    let features = detector.features(in: ciImage) as? [CIQRCodeFeature]
                else {
                    print("Something went wrong")
                    return
                }
                var qrCodeLink = ""
                features.forEach { feature in
                    if let messageString = feature.messageString {
                        qrCodeLink += messageString
                    }
                }
                if qrCodeLink.isEmpty {
                    print("qrCodeLink is empty!")
                } else {
                    print("message: \(qrCodeLink)")
                }
                self.dismiss(animated: true, completion: nil)
        
    }
  
    
    @IBAction func galleryQr(_ sender: Any) {
        
        
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


        
