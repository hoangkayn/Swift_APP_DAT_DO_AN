//
//  cell_post_TableViewCell.swift
//  App_Dat_Do_An
//
//  Created by Nguyễn Khánh Hoàng on 28/11/2022.
//

import UIKit

class cell_post_TableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_cellPost: UILabel!
    @IBOutlet weak var img_cellPost: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
