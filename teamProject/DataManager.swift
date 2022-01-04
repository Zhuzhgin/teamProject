//
//  DataManager.swift
//  teamProject
//
//  Created by Artem Zhuzhgin on 03.01.2022.
//

import Foundation

class DataManager {
    
    static var shared = DataManager()
    
    var cityNames: [String] = ["Москва","Санкт-Петербург","Тюмень","Уфа","Новосибирск"]
    var userNames = ["Дмитрий Онегин","Дмитрий","Владислав","Динар","Артем"]
    private init() {}

}
