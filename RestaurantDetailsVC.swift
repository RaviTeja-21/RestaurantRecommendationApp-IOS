//
//  RestaurantDetailsVC.swift
//  FoodWorld


import UIKit
import SwiftyJSON

class RestaurantDetailsVC: UIViewController {

    @IBOutlet weak var vwTop: UIView!
    @IBOutlet weak var vwBottom: UIView!
    @IBOutlet weak var vwDetails: UIView!
    @IBOutlet weak var btnBooking: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblAddress: UILabel!
    
    var data: CuisineModel!
    var arrayData:  JSON!
    
    
    @IBAction func btnClick(_ sender: UIButton) {
        if let vc = UIStoryboard.main.instantiateViewController(withClass: RateAndReviewVC.self) {
            vc.data = self.arrayData
            self.navigationController?.present(vc, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.vwTop.layer.cornerRadius = 16.0
        self.vwTop.layer.maskedCorners = CACornerMask(rawValue: 12)
        self.vwBottom.layer.cornerRadius = 16.0
        self.vwBottom.layer.maskedCorners = CACornerMask(rawValue: 3)
        self.vwDetails.layer.cornerRadius = 10.0
        self.btnBooking.layer.cornerRadius = 10.0
        
        
        if arrayData != nil {
            self.getImageURL(photoRef: self.arrayData["photos"][0]["photo_reference"].stringValue, image: self.imgProfile)
            self.lblName.text = self.arrayData["name"].stringValue
            self.lblAddress.text = self.arrayData["vicinity"].stringValue
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

    
    func getImageURL(photoRef: String, image: UIImageView) {
        var stringURL = ""
        stringURL = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=\(photoRef)&key=\(APIKEYID)"
        
        let request = URLRequest(url: URL(string: stringURL)!)
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard error == nil, let url = response?.url else{
                debugPrint(error.debugDescription)
                return
            }
            
            DispatchQueue.main.async {
                image.setImgWebUrl(url: url.description, isIndicator: true)
            }
            
        })
        task.resume()
    }
}
