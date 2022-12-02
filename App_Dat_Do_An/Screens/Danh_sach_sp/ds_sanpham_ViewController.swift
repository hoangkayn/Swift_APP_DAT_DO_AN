//
//  ds_sanpham_ViewController.swift
//  App_Dat_Do_An
//
//  Created by Nguyễn Khánh Hoàng on 26/11/2022.
//

import UIKit
protocol Category_Delegate {
    func chonNhom(idNhom:String, tenNhom:String)
}
class ds_sanpham_ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var delegate:Category_Delegate?
    var arr_Cate:[Category] = []
    @IBOutlet weak var table_view: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        table_view.delegate = self
        table_view.dataSource = self
      //load Cate
        let url = URL(string: Config.ServerURL +  "/category")
               var request = URLRequest(url: url!)
               request.httpMethod = "POST"
               
               let taskUserRegister = URLSession.shared.dataTask(with: request, completionHandler: { data , response, error in
                   guard error == nil else { print("error"); return }
                   guard let data = data else { return }
                   
                   let jsonDecoder = JSONDecoder()
                   let List = try? jsonDecoder.decode(CategoryPostRoute.self, from: data)
                   
                   self.arr_Cate = List!.List
                   
                   DispatchQueue.main.async {
                       self.table_view.reloadData()
                   }
                   
               })
               taskUserRegister.resume()
                                  }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.chonNhom(idNhom: arr_Cate[indexPath.row]._id, tenNhom: arr_Cate[indexPath.row].Name)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arr_Cate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cateCell = table_view.dequeueReusableCell(withIdentifier: "CATE_CELL") as! Cate_Cell_TableViewCell
               
               cateCell.lbl_cell.text = arr_Cate[indexPath.row].Name
               
               let queueLoadCateImg = DispatchQueue(label: "queueLoadCateImg")
        queueLoadCateImg.async { [self] in
                  
            let urlCateImmg = URL(string: Config.ServerURL+"/upload/"+arr_Cate[indexPath.row].Image)
                   print(Config.ServerURL +  "/upload/" +  self.arr_Cate[indexPath.row].Image)
                   do{
                       let dataCateImg = try Data(contentsOf: urlCateImmg!)
                       DispatchQueue.main.async {
                           cateCell.img_cell.image = UIImage(data: dataCateImg)
                       }
                   }catch{ }
                   
               }
               
               return cateCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.height/4
    }
}
