//
//  APIHitViewController.swift
//  APIHIt
//
//  Created by Macbook Pro on 29/12/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import MBProgressHUD

class APIHitViewController: UIViewController {

    @IBOutlet weak var postTableView: UITableView!
    
    var apiDataArray:[PostData] = []
    var page :Int = 1
    
    var isLoading : Bool = false
    var indicator: MBProgressHUD!
    var finalpage :Int!
    var isFinalPage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        postTableView.tableFooterView = UIView()
        
        indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        indicator.mode = .indeterminate
        indicator.label.text = "Loading"
        
        self.title = "Total Posts 0"
       
        getAPi(page: page)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func refreshData()  {

        if self.page != self.finalpage {
            page += 1
            getAPi(page: page)
        }else{
            Utilities.setAlertWith(title: "No more posts are available.", message: "", controller: self)
        }
    
    }
    
    func getAPi(page: Int){
        APIManager.shared.showPostAPI(tag: "story", page: page) { (response, success, error) in
            
            self.indicator.hide(animated: true)
            
            if success! && error == nil {
                let obj = response
                self.apiDataArray.append(contentsOf: obj.postArray)
                self.postTableView.reloadData()
                self.finalpage = obj.finalPage
                
                self.title = "Total Posts \(self.apiDataArray.count)"
                
            }else{
                Utilities.setAlertWith(title: error, message: "", controller: self)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension APIHitViewController:UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HitAPITableViewCell
        
        let object = apiDataArray[indexPath.row]
        cell.lblTitle.text = object.strGetTitle
        let strDate = object.strGetCreatedAt
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let dateCreatedAt = dateFormatter.date(from: strDate) {
            
            dateFormatter.dateFormat = "dd, MMM yyyy hh:mm:ss a"
            cell.lblCreatedAtDate.text = dateFormatter.string(from: dateCreatedAt)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == apiDataArray.count - 1 && apiDataArray.count > 0 {
            self.refreshData()
        }
    }
    
}
