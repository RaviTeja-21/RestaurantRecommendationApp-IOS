//
//  RestaurantDetailsVC.swift
//  FoodWorld


import UIKit

class RestaurantDetailsVC: UIViewController {

    @IBOutlet weak var vwTop: UIView!
    @IBOutlet weak var vwBottom: UIView!
    @IBOutlet weak var vwDetails: UIView!
    @IBOutlet weak var btnBooking: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblAddress: UILabel!
    
    var data: CuisineModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.vwTop.layer.cornerRadius = 16.0
        self.vwTop.layer.maskedCorners = CACornerMask(rawValue: 12)
        self.vwBottom.layer.cornerRadius = 16.0
        self.vwBottom.layer.maskedCorners = CACornerMask(rawValue: 3)
        self.vwDetails.layer.cornerRadius = 10.0
        self.btnBooking.layer.cornerRadius = 10.0
        
        
        if data != nil {
            self.imgProfile.setImgWebUrl(url: data.imageURL.description, isIndicator: true)
            
            self.lblName.text = data.name.description
            
            self.lblAddress.text = data.address.description
        }
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
    }

}
