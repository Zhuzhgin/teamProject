//
//  MainViewController.swift
//  teamProject
//
//  Created by Artem Zhuzhgin on 04.01.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var cityName: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    
    var city: City!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cityName.text = city.usersCity
        userName.text = city.userName
    }
    


}
