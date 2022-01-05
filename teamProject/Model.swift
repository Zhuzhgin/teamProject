//
//  Model.swift
//  teamProject
//
//  Created by Artem Zhuzhgin on 03.01.2022.
//

import Foundation

struct City {
    var usersCity: String
    var userName: String

}
extension City {
    static func returnCityesArray() -> [City] {
        let names = DataManager.shared.userNames
        let cityes = DataManager.shared.cityNames
        
        var cityesArray:[City] = []
        
        for index in 0..<cityes.count {
        let city = City(
            usersCity: cityes[index],
            userName: names[index])
            cityesArray.append(city)
        }
    return cityesArray
        
    }
    
    
    
}
