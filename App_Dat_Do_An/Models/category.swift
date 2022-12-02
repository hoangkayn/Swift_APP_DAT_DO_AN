//
//  category.swift
//  App_Dat_Do_An
//
//  Created by Nguyễn Khánh Hoàng on 26/11/2022.
//

import Foundation
struct CategoryPostRoute:Decodable{
    var result:Int
        var List:[Category]
}
struct Category:Decodable{
 var _id:String
 var Name:String
var Image:String
    init(_id:String,Name:String,Image:String){
        self._id = _id
        self.Name = Name
        self.Image = Image
    }
}
