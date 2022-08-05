//
//  ProfileVC.swift
//  FoodWorld

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    
    
    
    @IBAction func btnClick(_ sender: UIButton) {
        UIApplication.shared.setStart()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnLogout.layer.cornerRadius = 10.0
        
        
        if let user = GFunction.user {
            self.txtAddress.text = user.address
            self.txtEmail.text = user.email
            self.txtFullName.text = user.name.capitalized
            
            
            self.txtEmail.isUserInteractionEnabled = false
        }
        // Do any additional setup after loading the view.
    }
}
