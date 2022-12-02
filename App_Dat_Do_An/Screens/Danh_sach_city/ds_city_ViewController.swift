//
//  ds_city_ViewController.swift
//  App_Dat_Do_An
//
//  Created by Nguyễn Khánh Hoàng on 27/11/2022.
//

import UIKit
protocol City_Delegate{
    func chonCity(idCity:String,tenCity:String)
}
class ds_city_ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
  
    var delegate:City_Delegate?
    var arr_City:[City] = []
    @IBOutlet weak var table_city: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        table_city.delegate = self
        table_city.dataSource = self
        //load
        var url = URL(string: Config.ServerURL +  "/city")
         var request = URLRequest(url: url!)
         request.httpMethod = "POST"
         
        
         
         let taskUserRegister = URLSession.shared.dataTask(with: request, completionHandler: { [self] data , response, error in
             guard error == nil else { print("error"); return }
             guard let data = data else { return }
             let jsonDecoder = JSONDecoder()
             let List = try? jsonDecoder.decode(CityPostRoute.self, from: data)
             arr_City = List!.List
             DispatchQueue.main.sync {
                 table_city.reloadData()
             }
            
     })
       
         taskUserRegister.resume()
                                                     
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.chonCity(idCity: arr_City[indexPath.row]._id, tenCity: arr_City[indexPath.row].Name)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_City.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city_cell = table_city.dequeueReusableCell(withIdentifier: "CITY_CELL") as! City_cell_TableViewCell
        city_cell.lbl_cityname.text = arr_City[indexPath.row].Name
        return city_cell
    }
    

}
