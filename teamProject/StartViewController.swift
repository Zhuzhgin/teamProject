//
//  ViewController.swift
//  teamProject
//
//  Created by Artem Zhuzhgin on 03.01.2022.
//

import UIKit

class StartViewController: UIViewController, UITextFieldDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTextLabel: UILabel!
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    var cityesArray = City.returnCityesArray()
       var сitiesArraySorting = City.returnCityesArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        searchTextLabel.text = ""
        searchBar.delegate = self
    }
    func sortedArrayOfCities(searchText: String) -> [City] {
        
        let text = searchText
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
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        сitiesArraySorting = sortedArrayOfCities(searchText: searchText)
        tableViewOutlet.reloadData()
        if сitiesArraySorting.count == 1 {
            searchTextLabel.text = "Житель города: \(сitiesArraySorting[0].userName)"
        }
        
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        tableViewOutlet.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let mainVC = segue.destination as? MainViewController else {return}
        guard let indexPath = tableViewOutlet.indexPathForSelectedRow?.row else {return}
        let city = сitiesArraySorting[indexPath]
        mainVC.city = city
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
        cell.contentConfiguration = content
        return cell
    }
   
 
}
