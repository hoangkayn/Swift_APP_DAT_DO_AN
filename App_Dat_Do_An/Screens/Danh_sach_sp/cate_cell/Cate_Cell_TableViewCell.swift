//
//  Cate_Cell_TableViewCell.swift
//  App_Dat_Do_An
//
//  Created by Nguyễn Khánh Hoàng on 26/11/2022.
//

import UIKit

class Cate_Cell_TableViewCell: UITableViewCell {

    @IBOutlet weak var img_cell: UIImageView!
    
    @IBOutlet weak var lbl_cell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
