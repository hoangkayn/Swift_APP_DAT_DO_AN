//
//  ds_post_ViewController.swift
//  App_Dat_Do_An
//
//  Created by Nguyễn Khánh Hoàng on 28/11/2022.
//

import UIKit
var Gia:String?
var TieuDe:String?
var Sdt:String?
var NoiBan:String?
var Nhom:String?
var Image:String?
class ds_post_ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    var arr_Post:[Post] = []
    @IBOutlet weak var table_post: UITableView!
    @IBOutlet weak var lbl_ds: UILabel!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        table_post.delegate = self
        table_post.dataSource = self
       
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
          let url = URL(string: Config.ServerURL +  "/post")
                 var request = URLRequest(url: url!)
                 request.httpMethod = "POST"
                 
                 let taskUserRegister = URLSession.shared.dataTask(with: request, completionHandler: { data , response, error in
                     guard error == nil else { print("error"); return }
                     guard let data = data else { return }
                     
                     let jsonDecoder = JSONDecoder()
                     let List_Post = try? jsonDecoder.decode(PostRoute.self, from: data)
                     
                     self.arr_Post = List_Post!.post_List
                     
                     DispatchQueue.main.async {
                         self.table_post.reloadData()
                     }
                     
                 })
                 taskUserRegister.resume()
    }
    
    @IBAction func move_ds_post(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let tt_post_VC = sb.instantiateViewController(withIdentifier: "POST") as! ds_post_ViewController
        self.navigationController?.pushViewController(tt_post_VC, animated: false)
    }
    
    @IBAction func move_category(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let tt_post_VC = sb.instantiateViewController(withIdentifier: "CATEGORY") as! Category_ViewController
        self.navigationController?.pushViewController(tt_post_VC, animated: false)
    }
    
    @IBAction func move_dashboard(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let tt_post_VC = sb.instantiateViewController(withIdentifier: "DASHBOARD") as! Dashboard_ViewController
        self.navigationController?.pushViewController(tt_post_VC, animated: false)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let tt_post_VC = sb.instantiateViewController(withIdentifier: "TT_POST") as! tt_postViewController
        self.navigationController?.pushViewController(tt_post_VC, animated: false)
        Gia = arr_Post[indexPath.row].Gia
        Nhom = arr_Post[indexPath.row].TenNhom
        NoiBan = arr_Post[indexPath.row].TenCity
        TieuDe = arr_Post[indexPath.row].TieuDe
        Sdt = arr_Post[indexPath.row].Sdt
        Image = arr_Post[indexPath.row].Image
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_Post.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell_Post = table_post.dequeueReusableCell(withIdentifier: "CELL_POST") as! cell_post_TableViewCell
        cell_Post.lbl_cellPost.text = arr_Post[indexPath.row].TieuDe
        let queueLoadCateImg = DispatchQueue(label: "queueLoadCateImg")
        queueLoadCateImg.async { [self] in
            let urlPostImg = URL(string: Config.ServerURL + "/upload/" + arr_Post[indexPath.row].Image)
            do{
                let data = try Data(contentsOf: urlPostImg!)
                DispatchQueue.main.async {
                    cell_Post.img_cellPost.image = UIImage(data: data)
                }
                  
            }catch{}
        }
        return cell_Post
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.height/4
    }
    

 
}
