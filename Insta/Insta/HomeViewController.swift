//
//  HomeViewController.swift
//  Insta
//
//  Created by yy on 2023/4/21.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UploadImageProtocol {
    
    
    var images : [UIImage] = [UIImage]()
    var locations : [String] = [String]()
    var imageTitles : [String] = [String]()

    @IBOutlet weak var tblView: UITableView!
    var uploadImageVC : UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.rowHeight = 50
        let controller = navigationController?.tabBarController
        uploadImageVC = navigationController?.tabBarController?.viewControllers?[0]
        print(uploadImageVC?.title)
        
        

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        imageTitles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
//        cell.textLabel?.text = imageTitles[indexPath.row]
//        cell.imageView?.image = images[indexPath.row]
//        cell.detailTextLabel?.text = locations[indexPath.row]
        cell.imgContainer.image = images[indexPath.row]
        cell.lblPlace.text = imageTitles[indexPath.row]
        cell.lblLocation.text = locations[indexPath.row]
        return cell
    }
    
    func uploadedImageDelegate(img: UIImage, locationImg: String, titleImg: String) {
        images.append(img)
        locations.append(locationImg)
        imageTitles.append(titleImg)
        
        tblView.reloadData()
    }

}
