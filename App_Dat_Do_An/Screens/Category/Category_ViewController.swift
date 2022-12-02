//
//  Category_ViewController.swift
//  App_Dat_Do_An
//
//  Created by Nguyễn Khánh Hoàng on 21/11/2022.
//

import UIKit

class Category_ViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
       
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
    @IBAction func chuyen_MH_creatPost(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        var creat_Post_VC = sb.instantiateViewController(withIdentifier: "CREAT_POST") as! CreatPost_ViewController
        self.navigationController?.pushViewController(creat_Post_VC, animated: true)
    }
    


}
