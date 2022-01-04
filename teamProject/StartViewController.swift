//
//  ViewController.swift
//  teamProject
//
//  Created by Artem Zhuzhgin on 03.01.2022.
//

import UIKit

class StartViewController: UIViewController, UITextFieldDelegate, UISearchDisplayDelegate {
   
    

    var cityesArray = City.returnCityesArray()
    var сitiesArraySorting = City.returnCityesArray()

    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchTextLabel: UILabel!
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    //var search = UISearchController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        searchTextLabel.text = ""
       
        
    }

    
    func sortedArrayOfCities() -> [City] {
        guard let text = searchTF.text else { return cityesArray }
        guard text != "" else {return cityesArray}
        var sortedArray: [City] = []
        for index in 0..<cityesArray.count {
            let city = cityesArray[index]
            
            guard city.usersCity.lowercased().contains(text.lowercased()) || city.userName.lowercased().hasPrefix(text.lowercased()) else {continue}
            sortedArray.append(city)
        }
        guard !sortedArray.isEmpty else {return cityesArray}
        return sortedArray
    }
    

       
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        сitiesArraySorting = sortedArrayOfCities()
        searchTF.text = ""
        
        if сitiesArraySorting.count == 1 {
            searchTextLabel.text = "Житель города: \(сitiesArraySorting[0].userName)"
        }
        else {
            searchTextLabel.text = ""
        }
        tableViewOutlet.reloadData()
    }
    
}

extension StartViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        сitiesArraySorting.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       let city = сitiesArraySorting[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = city.usersCity
        //  print(content.text)
        cell.contentConfiguration = content
        return cell
    }
    
//    extension StartViewController: UISearchResultsUpdating {
//
//
//    }
    
    
}