//
//  CuisineDetailsVC.swift
//  FoodWorld


import UIKit

class CuisineDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arrayRes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCell
        cell.configCell(data: self.arrayRes[indexPath.row])
        let tap = UITapGestureRecognizer()
        tap.addAction {
            if let vc = UIStoryboard.main.instantiateViewController(withClass: RestaurantDetailsVC.self){
                vc.data = self.arrayRes[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        cell.vwCell.isUserInteractionEnabled = true
        cell.vwCell.addGestureRecognizer(tap)
        return cell
    }
    

    @IBOutlet weak var vwTop: UIView!
    @IBOutlet weak var vwBottom: UIView!
    @IBOutlet weak var tblList: SelfSizedTableView!
    @IBOutlet weak var vwCuisine: UIView!
    @IBOutlet weak var vwRestaurant: UIView!
    @IBOutlet weak var btnBooking: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    
    var data: CuisineModel!
    var arrayRes = [CuisineModel]()
    
    
    @IBAction func btnBooking(_ sender: Any) {
    }
    
    @IBAction func btnSeeAll(_ sender: Any) {
        if let vc = UIStoryboard.main.instantiateViewController(withClass: RestaurantListVC.self) {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.vwTop.layer.cornerRadius = 16.0
        self.vwTop.layer.maskedCorners = CACornerMask(rawValue: 12)
        self.vwTop.layer.masksToBounds = true
        // Do any additional setup after loading the view.
        self.vwBottom.layer.cornerRadius = 16.0
        self.vwBottom.layer.maskedCorners = CACornerMask(rawValue: 3)
        
        self.vwCuisine.layer.cornerRadius = 10.0
        self.vwRestaurant.layer.cornerRadius = 10.0
        self.btnBooking.layer.cornerRadius = 10.0
        self.tblList.delegate = self
        self.tblList.dataSource = self
        
        if data != nil {
            self.lblName.text = data.name.description.capitalized
            self.imgProfile.setImgWebUrl(url: data.imageURL, isIndicator: true)
        }
        
        self.getRestaurantData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
    }

    
    func getRestaurantData(){
        _ = AppDelegate.shared.db.collection(fRestaurant).addSnapshotListener{ querySnapshot, error in
            
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            self.arrayRes.removeAll()
            if snapshot.documents.count != 0 {
                for data in snapshot.documents {
                    let data1 = data.data()
                    if let name: String = data1[fName] as? String, let address: String = data1[fAddress] as? String, let imagePath: String = data1[fImageURL] as? String {
                        
                        self.arrayRes.append(CuisineModel(docID: data.documentID, name: name, address: address, imageURL: imagePath))
                    }
                }
                
                self.tblList.delegate = self
                self.tblList.dataSource = self
                self.tblList.reloadData()
            }else{
                Alert.shared.showAlert(message: "No Data Found !!!", completion: nil)
            }
        }
    }
}
