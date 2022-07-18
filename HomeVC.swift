//
//  HomeVC.swift
//  FoodWorld

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var colCuisuine: SelfSizedCollectionView!
    @IBOutlet weak var tblList: SelfSizedTableView!
    
    
    var array = [CuisineModel]()
    var arrayRes = [CuisineModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getData()
        self.getRestaurantData()
        // Do any additional setup after loading the view.
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout & UINavigationControllerDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "CuisineCell", for: indexPath) as! CuisineCell
        item.configCell(data: self.array[indexPath.item])
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == colCuisuine {
            return CGSize(width: UIScreen.main.bounds.width - 40, height: ((220/812) * UIScreen.main.bounds.height))
        }
        return CGSize(width: ((UIScreen.main.bounds.width - 50) / 2), height: ((122/812) * self.view.frame.height))
    }
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arrayRes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCell
        cell.configCell(data: self.arrayRes[indexPath.row])
        return cell
    }
    
    func setUPData(){
//        var array = [CuisineModel]()
//        array.append(CuisineModel(docID: "", name: "South Indian", address: "South Indian Dosa Mahal, Toronto, ON, Canada", imageURL: "https://firebasestorage.googleapis.com/v0/b/foodworld-69239.appspot.com/o/cuisine%2FSouthIndian%20Food.jpeg?alt=media&token=c8ea7de4-b776-4e2d-9c7d-06e42c6e4b8d"))
//        array.append(CuisineModel(docID: "", name: "Gujarati", address: "Govardhan Thal Restaurant, Scarborough, ON, Canada", imageURL: "https://firebasestorage.googleapis.com/v0/b/foodworld-69239.appspot.com/o/cuisine%2Fdhokla.jpg?alt=media&token=29722b91-e758-484c-b88a-3f1824d9cba8"))
//        array.append(CuisineModel(docID: "", name: "Punjabi", address: "Punjab Palace, Montréal, Canada", imageURL: "https://firebasestorage.googleapis.com/v0/b/foodworld-69239.appspot.com/o/cuisine%2Fjpg.jpeg?alt=media&token=b18e029d-f96f-4a93-ba78-c3f95374b947"))
//        array.append(CuisineModel(docID: "", name: "Chinese", address: "Beijing Restaurant, Montréal, Canada", imageURL: "https://firebasestorage.googleapis.com/v0/b/foodworld-69239.appspot.com/o/cuisine%2Fphoto-1585032226651-759b368d7246.jpeg?alt=media&token=8a1c640f-e2ac-4372-8b9d-011dfdd2f0aa"))
        
//        for data in array {
//            self.addCuisine(data: data)
//        }
    }
    
    func addCuisine(data: CuisineModel){
        var ref : DocumentReference? = nil
        ref = AppDelegate.shared.db.collection(fCuisine).addDocument(data:
                                                                        [
                                                                            fName: data.name,
                                                                            fAddress : data.address,
                                                                            fImageURL: data.imageURL,
                                                                        ])
        {  err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func getData(){
        _ = AppDelegate.shared.db.collection(fCuisine).addSnapshotListener{ querySnapshot, error in
            
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            self.array.removeAll()
            if snapshot.documents.count != 0 {
                for data in snapshot.documents {
                    let data1 = data.data()
                    if let name: String = data1[fName] as? String, let address: String = data1[fAddress] as? String, let imagePath: String = data1[fImageURL] as? String {
                        print("Data Count : \(self.array.count)")
                        self.array.append(CuisineModel(docID: data.documentID, name: name, address: address, imageURL: imagePath))
                    }
                }
               
                self.colCuisuine.delegate = self
                self.colCuisuine.dataSource = self
                self.colCuisuine.reloadData()
            }else{
                Alert.shared.showAlert(message: "No Data Found !!!", completion: nil)
            }
        }
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
                        print("Data Count : \(self.array.count)")
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

class CuisineCell:  UICollectionViewCell {
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var vwCell: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var consWidth: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vwCell.layer.cornerRadius = 10.0
    }
    
    func configCell(data: CuisineModel) {
        self.lblTitle.text = data.name.description
        self.lblAddress.text = data.address.description
        self.imgLogo.setImgWebUrl(url: data.imageURL, isIndicator: true)
    }
}

class RestaurantCell:  UITableViewCell {
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var vwCell: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnBook: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vwCell.layer.cornerRadius = 10.0
        self.btnBook.layer.cornerRadius = 5.0
    }
    
        func configCell(data: CuisineModel) {
            self.lblTitle.text = data.name.description
            self.lblAddress.text = data.address.description
            self.imgLogo.setImgWebUrl(url: data.imageURL, isIndicator: true)
        }
}
