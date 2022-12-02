//
//  category.swift
//  App_Dat_Do_An
//
//  Created by Nguyễn Khánh Hoàng on 26/11/2022.
//

import Foundation
struct CityPostRoute:Decodable{
    var result:Int
        var List:[City]
}
struct City:Decodable{
 var _id:String
 var Name:String

    init(_id:String,Name:String){
        self._id = _id
        self.Name = Name
        
    }
}

