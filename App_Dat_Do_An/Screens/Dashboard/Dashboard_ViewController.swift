import UIKit

class Dashboard_ViewController: UIViewController {
    
    
    @IBOutlet weak var img_Avatar: UIImageView!
    @IBOutlet weak var lbl_HoTen: UILabel!
  
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        img_Avatar.layer.cornerRadius = img_Avatar.frame.size.width/2
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Check check login
        
        if let UserToken = defaults.string(forKey: "UserToken") {
            
            //Verify
            let url = URL(string: Config.ServerURL +  "/verifyToken")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            
            let sData = "Token=" + UserToken
            
            
            let postData = sData.data(using: .utf8)
            request.httpBody = postData
            
            let taskUserRegister = URLSession.shared.dataTask(with: request, completionHandler: { data , response, error in
                guard error == nil else { print("error"); return }
                guard let data = data else { return }
                
                do{
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else { return }
                    
                    if( json["kq"] as! Int == 1 ){
                        
                        print("Okay")
                        let user = json["User"] as?  [String:Any]
                        let imgString = user!["Image"] as? String
                        let urlHinh = Config.ServerURL + "/upload/" + imgString!
                      
                      
                           
                        DispatchQueue.main.async {
                            let queueLoadHinh = DispatchQueue(label: "Osin")
                            queueLoadHinh.async {
                                do{
                                    let imgData = try! Data(contentsOf: URL(string: urlHinh)!)
                                    DispatchQueue.main.async {
                                        self.img_Avatar.image = UIImage(data: imgData)
                                        let username = user!["Username"] as! String
                                        self.lbl_HoTen.text = "Username: " + username
                                    }
                                }
                                catch{}
                            }
                                                
                                                 
                                             }
                            
                        }
                        
                        
                        
                    else{
                        DispatchQueue.main.async {
                            let sb = UIStoryboard(name: "Main", bundle: nil)
                            let login_VC = sb.instantiateViewController(identifier: "LOGIN") as! Login_ViewController
                            self.navigationController?.pushViewController(login_VC, animated: false)
                        }
                    }
                    
                }catch let error { print(error.localizedDescription) }
            })
            taskUserRegister.resume()
            
        }else{
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let login_VC = sb.instantiateViewController(identifier: "LOGIN") as! Login_ViewController
            self.navigationController?.pushViewController(login_VC, animated: false)
        }
        
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
    @IBAction func Logout(_ sender: Any) {
        
        
        if let UserToken = defaults.string(forKey: "UserToken") {
            
            let url = URL(string: Config.ServerURL +  "/logout")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            
            let sData = "Token=" + UserToken
            
            let postData = sData.data(using: .utf8)
            request.httpBody = postData
            
            let taskUserRegister = URLSession.shared.dataTask(with: request, completionHandler: { data , response, error in
                guard error == nil else { print("error"); return }
                guard let data = data else { return }
                
                do{
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else { return }
                    
                    if( json["kq"] as! Int == 1 ){
                        // Thanh cong
                        
                        self.defaults.removeObject(forKey: "UserToken")
                        
                        DispatchQueue.main.async {
                            let sb = UIStoryboard(name: "Main", bundle: nil)
                            let login_VC = sb.instantiateViewController(identifier: "LOGIN") as! Login_ViewController
                            self.navigationController?.pushViewController(login_VC, animated: false)
                        }
                        
                        
                    }else{
                        DispatchQueue.main.async {
                            let alertView = UIAlertController(title: "Thong bao", message: (json["errMsg"] as! String), preferredStyle: .alert)
                            alertView.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                            self.present(alertView, animated: true, completion: nil)
                        }
                    }
                    
                }catch let error { print(error.localizedDescription) }
            })
            taskUserRegister.resume()
            
        }else{
            
        }
        
        
       
    }
}
