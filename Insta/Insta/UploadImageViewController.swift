//
//  UploadImageViewController.swift
//  Insta
//
//  Created by yy on 2023/4/21.
//

import UIKit
import CoreLocation

class UploadImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    var uploadProtocol: UploadImageProtocol?
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters

        // Do any additional setup after loading the view.
    }
    

    @IBAction func uploadAction(_ sender: Any) {
        
        guard let image = imgView.image else {return}
        guard let location = lblLocation.text else {return}
        guard let title = txtTitle.text else {return}
        
        uploadProtocol?.uploadedImageDelegate(img: image, locationImg: location, titleImg: title)
        self.tabBarController?.selectedIndex = 0
    }
    
    @IBAction func getLocationAction(_ sender: Any) {
        locationManager.requestLocation()
    }
    
    
    @IBAction func takeAPictureAction(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: "Take a picture", message: "Something", preferredStyle: .alert)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.camera;
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true)
            }
            
        }
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { action in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary;
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            print("user selected cancel")
            
        }
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoLibraryAction)
        actionSheet.addAction(cancel)
        
        self.present(actionSheet, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgView.image = image
        }
        picker.dismiss(animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
//        let lat = location.coordinate.latitude
//        let lng = location.coordinate.longitude
//        let address = getAddressFromLocation(location: location)
        getAddressFromLocation(location: location) { address in
            if let address = address {
                print(address)
                self.lblLocation.text = "\(address)"
            } else {
                print("Unable to retrieve address.")
            }
        }
    }

    
    func getAddressFromLocation(location: CLLocation, completion: @escaping (String?) -> Void) {
        let geoCoder = CLGeocoder()

        geoCoder.reverseGeocodeLocation(location) { placemarks, error in
            if error != nil {
                print(error as Any)
                completion(nil)
                return
            }
            var address = ""
            guard let place = placemarks?.first else {
                completion(nil)
                return
            }

            if place.name != nil {
                address += place.name! + ", "
            }
            if place.locality != nil {
                address += place.locality! + ", "
            }
            if place.subLocality != nil {
                address += place.subLocality!
            }
//            if place.country != nil {
//                address += place.country! + ", "
//            }
//            if place.postalCode != nil {
//                address += place.postalCode! + ", "
//            }
            completion(address)
        }
    }

}
