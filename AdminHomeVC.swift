//
//  AdminHomeVC.swift
//  FoodWorld


import UIKit

class AdminHomeVC: UIViewController {

    @IBOutlet weak var btnRestaurant: UIButton!
    @IBOutlet weak var btnCuisines: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    
    @IBAction func btnAdd(_ sender: UIButton) {
        if sender == btnRestaurant {
            if let vc = UIStoryboard.main.instantiateViewController(withClass: AddRestaurantVC.self){
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else if sender == btnCuisines {
            if let vc = UIStoryboard.main.instantiateViewController(withClass: AddCuisinesVC.self){
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if sender == btnLogout {
            UIApplication.shared.setStart()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnCuisines.layer.cornerRadius = 10.0
        self.btnRestaurant.layer.cornerRadius = 10.0

        // Do any additional setup after loading the view.
    }
}
