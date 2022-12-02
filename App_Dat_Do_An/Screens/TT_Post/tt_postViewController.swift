//
//  tt_postViewController.swift
//  App_Dat_Do_An
//
//  Created by Nguyễn Khánh Hoàng on 28/11/2022.
//

import UIKit

    
class tt_postViewController: UIViewController {
    @IBOutlet weak var img_sp: UIImageView!
    @IBOutlet weak var lbl_nhomsp: UILabel!
    
    @IBOutlet weak var lbl_sdt: UILabel!
    @IBOutlet weak var lbl_gia: UILabel!
    @IBOutlet weak var lbl_tieude: UILabel!
    @IBOutlet weak var lbl_noiban: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_gia.text = Gia
        lbl_nhomsp.text = Nhom
        lbl_sdt.text = Sdt
        lbl_noiban.text = NoiBan
        lbl_tieude.text = TieuDe
       let queueloadHing = DispatchQueue(label: "osin")
        queueloadHing.async {
            let urlLoadImg = URL(string: Config.ServerURL+"/upload/" + Image!)
            do{
                let data = try Data(contentsOf: urlLoadImg!)
                DispatchQueue.main.async { [self] in
                    img_sp.image = UIImage(data: data)
                }
            
            }catch{}
        }
          
       
    }
    
    @IBAction func back(_ sender: Any) {
       
            self.navigationController?.popViewController(animated: true)
        }
      
    
    

}
