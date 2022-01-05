//
//  ViewController.swift
//  teamProject
//
//  Created by Artem Zhuzhgin on 03.01.2022.
//

import UIKit

class StartViewController: UIViewController, UITextFieldDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    var cityesArray = City.returnCityesArray()
    var сitiesArraySorting = City.returnCityesArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        searchBar.delegate = self
    }
    
    //MARK: - функция сортировки по тексту из searchBar
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
    
    //MARK: -  автоматическое обновление таблице при вводе поискового запроса
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        сitiesArraySorting = sortedArrayOfCities(searchText: searchText)
        tableViewOutlet.reloadData()
    }
    //MARK: - кнопка "Cancel"
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        сitiesArraySorting = cityesArray
        tableViewOutlet.reloadData()
    }
    
    //MARK: - скрывает клавиатуру по кнопке Done
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    
    //MARK: - скрывает клавиатуру по клику
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        self.view.endEditing(true)
     }
    
    //MARK: - navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let mainVC = segue.destination as? MainViewController else {return}
        guard let indexPath = tableViewOutlet.indexPathForSelectedRow?.row else {return}
        let city = сitiesArraySorting[indexPath]
        mainVC.city = city
    }
}
//MARK: - tableView
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
        content.secondaryText = city.userName
        cell.contentConfiguration = content
        return cell
    }
}
