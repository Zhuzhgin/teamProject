//
//  DataManager.swift
//  teamProject
//
//  Created by Artem Zhuzhgin on 03.01.2022.
//

import Foundation

class DataManager {
    
    static var shared = DataManager()
    
    var cityNames: [String] = ["Санкт-Петербург","Москва","Тюмень","Уфа","Новосибирск"]
    var userNames = ["Дмитрий Онегин","Владислав","Артем","Динар","Дмитрий"]
    private init() {}

}
