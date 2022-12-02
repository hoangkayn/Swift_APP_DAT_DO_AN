//
//  Welcome_ViewController.swift
//  App_Dat_Do_An
//
//  Created by Nguyễn Khánh Hoàng on 02/11/2022.
//

import UIKit

class Welcome_ViewController: UIViewController {
    
    @IBOutlet weak var logo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        logo.alpha = 0
        UIView.animate(withDuration: 5) { [self] in
            logo.alpha = 1
        } completion: { (done) in
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let tabbar = sb.instantiateViewController(identifier: "POST") as! ds_post_ViewController
            self.navigationController?.pushViewController(tabbar, animated: false)
        }
        
    }
    
}
