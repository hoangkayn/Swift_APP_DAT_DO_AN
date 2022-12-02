//
//  CreatPost_ViewController.swift
//  App_Dat_Do_An
//
//  Created by Nguyễn Khánh Hoàng on 21/11/2022.
//

import UIKit
extension CreatPost_ViewController:City_Delegate{
    func chonCity(idCity: String, tenCity: String) {
        self.navigationController?.popViewController(animated: false)
        lbl_noi_ban.text = tenCity
        idCity_Upd = idCity
    }
}
extension CreatPost_ViewController:Category_Delegate{
    func chonNhom(idNhom: String, tenNhom: String) {
        lbl_nhomsp.text = tenNhom
        idNhom_Upd = idNhom
        self.navigationController?.popViewController(animated: false)
    }
}
class CreatPost_ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var sdt: UITextField!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var img_sanpham: UIImageView!
    @IBOutlet weak var lbl_nhomsp: UILabel!
    
    @IBOutlet weak var txt_tieu_de: UITextField!
    @IBOutlet weak var lbl_noi_ban: UILabel!
    
    @IBOutlet weak var txt_gia: UITextField!
    var idNhom_Upd: String?
    var idCity_Upd : String?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    @IBAction func nhom_sp(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let ds_sanpham_VC = sb.instantiateViewController(withIdentifier: "CATE") as! ds_sanpham_ViewController
        ds_sanpham_VC.delegate = self
        self.navigationController?.pushViewController(ds_sanpham_VC, animated: false)
    }
    
 
    @IBAction func move_ds_city(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let ds_city_VC = sb.instantiateViewController(withIdentifier: "CREAT_CITY") as! ds_city_ViewController
        ds_city_VC.delegate = self
        self.navigationController?.pushViewController(ds_city_VC, animated: false)
    }
    @IBAction func bnt_dang_tin(_ sender: Any) {
        var url = URL(string: Config.ServerURL + "/uploadFile")
        let boundary = UUID().uuidString
        let session = URLSession.shared
        
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"hinhdaidien\"; filename=\"avatar.png\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append((img_sanpham.image?.pngData())!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let json  = jsonData as? [String: Any]{
                    if(json["kq"] as! Int == 1){
                        let urlFile = json["urlFile"] as? [String:Any]
                        
                        DispatchQueue.main.async {
                            
                            url = URL(string: Config.ServerURL +  "/post/add")
                            var request = URLRequest(url: url!)
                            request.httpMethod = "POST"
                            
                            let fileName = urlFile!["filename"] as! String
                            var sData = "TieuDe=" + self.txt_tieu_de.text!
                            sData += "&Gia=" + self.txt_gia.text!
                           
                            sData += "&Image=" + fileName
                            sData += "&Sdt=" + self.sdt.text!
                            sData += "&TenNhom=" + self.idNhom_Upd!
                            sData += "&TenCity=" + self.idCity_Upd!
                            
                            let postData = sData.data(using: .utf8)
                            request.httpBody = postData
                            
                            let taskUserRegister = URLSession.shared.dataTask(with: request, completionHandler: { [self] data , response, error in
                                guard error == nil else { print("error"); return }
                                guard let data = data else { return }
                                
                                do{
                                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else { return }
                                    
                                   
                                    
                                    
                                    if( json["result"] as! Int == 1 ){
                                        DispatchQueue.main.async {
                                            let alertView = UIAlertController(title: "thong bao", message: "dang thanh cong", preferredStyle: .alert)
                                            alertView.addAction(UIAlertAction(title: "ok", style: .default,handler:{(active:UIAlertAction) in
                                                let sb = UIStoryboard(name: "Main", bundle: nil)
                                                let Post_VC = sb.instantiateViewController(withIdentifier: "POST") as! ds_post_ViewController
                                                self.navigationController?.pushViewController(Post_VC, animated: false)
                                            }
                                             
                                            ))
                                            self.present(alertView, animated: false)
                                        }
                                    }
                                    
                                }catch let error { print(error.localizedDescription) }
                            })
                            taskUserRegister.resume()
                        }
                        
                        
                     }else{
                        print("Upload failed!")
                    }
                }
            }
        }).resume()
    
                }
           
    
    
    @IBAction func tap_img(_ sender: Any) {
        let image = UIImagePickerController()
              image.delegate = self
              image.sourceType = UIImagePickerController.SourceType.photoLibrary
              image.allowsEditing = false
              self.present(image, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage {
                img_sanpham.image = image
            }else{  }
            self.dismiss(animated: true, completion: nil)
        }
}
