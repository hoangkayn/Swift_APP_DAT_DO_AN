//
//  post.swift
//  App_Dat_Do_An
//
//  Created by Nguyễn Khánh Hoàng on 28/11/2022.
//

import Foundation
struct PostRoute:Decodable{
   
        var result:Int
            var post_List:[Post]
    
}
struct Post:Decodable{
   

   var _id: String
           var     TieuDe:String
              var  Gia: String
    var  Sdt:String
              var  Image: String
             var   TenNhom: String
    var  TenCity:String
    
    init(_id:String,TieuDe:String,Gia: String,Sdt:String,Image: String,TenNhom: String,TenCity:String){
        self._id = _id
        self.TieuDe = TieuDe
        self.Gia = Gia
        self.Sdt = Sdt
        self.Image = Image
        self.TenNhom = TenNhom
        self.TenCity = TenCity
    }
}
