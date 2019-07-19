//
//  ViewController.swift
//  SearchBar
//
//  Created by Boon on 18/07/19.
//  Copyright © 2019 Boon. All rights reserved.
//

import UIKit


class MyTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    //MARK:- Variables
    let searchController = UISearchController(searchResultsController: nil)
    private var filteredContacts: [Contacts] = []
    var phoneBook:[Character: Any] = [:]
    var segueName:String = ""
    var seguePhone:String = ""
    
    // if key exists, then...... else create a new entry in the dictionary
    var boon = Contacts(name: "Boon Aaron", phone_no: 242)
    var aaron = Contacts(name: "Aaron", phone_no: 435)
    var akhil = Contacts(name: "Akhil Krishna", phone_no: 435)
    var anshuman = Contacts(name: "anshuman Pandey", phone_no: 435)
    var anand = Contacts(name: "Anand Kumar", phone_no: 435)
    var zyan = Contacts(name: "Zyan Malik", phone_no: 435)
    var justin = Contacts(name: "Justin Beiber", phone_no: 435)
    var khaled = Contacts(name: "Khaled", phone_no: 435)
    var sheeran = Contacts(name: "Sheeran", phone_no: 435)
    
    
    //MARK:- IBOutlets
    @IBOutlet weak var myTableView: UITableView!
    
    //mark:- View lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var dataArray = [boon, aaron, akhil, anshuman, anand, zyan, justin, khaled, sheeran]
        dataArray.shuffle()
        
        print("After shuffling ", dataArray)
//            Expected :
//            phoneBook = [
//            "A" : [aaron, akhil, anshuman, anand],
//            "B" : [boon],
//            "J" : [justin],
//            "K" : [khaled],
//            "S" : [sheeran],
//            "Z" : [zyan]
//        ]
        
        phoneBook = Dictionary(grouping: dataArray, by: {$0.name.uppercased().first ?? "A"})
        print(phoneBook)
        
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        searchController.searchResultsUpdater = self as UISearchResultsUpdating // to show the results in the same AKA self VC sunce the default one redirects to another VC to show the results
        searchController.dimsBackgroundDuringPresentation = false // dims the screen assuming hte reslts are displayed in seperate view, but we are displaying the reuslts in the same View.So setting it to false
        definesPresentationContext = true // ensures the search bar is shown only on this VC
        myTableView.tableHeaderView = searchController.searchBar //adding the searchbar to table Header
    
    }

    //MARK:- Public functions
    func numberOfSections(in tableView: UITableView) -> Int {  // version update
        if searchController.searchBar.text != "" {
            return 1
        } else {
            return phoneBook.keys.count
        }
    }

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { // version update
        if searchController.searchBar.text != "" {
            return ""
        } else {
            return String(phoneBook.keys.sorted()[section])
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // version update
        if searchController.searchBar.text != ""{
                return filteredContacts.count
            } else {
                let myKey = phoneBook.keys.sorted()[section]
            return (phoneBook[myKey] as? Array<Contacts>)?.count ?? 0
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // version update
        
        var contact: Contacts
        
        if searchController.isActive && searchController.searchBar.text != ""{
            contact = filteredContacts[indexPath.row]
        } else {
            let myKey = phoneBook.keys.sorted()[indexPath.section]
            contact = (phoneBook[myKey] as? Array<Contacts>)?[indexPath.row] ?? boon
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = contact.name
        
        return cell
        
    }
    
    //protocol method of UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        
        filteredContacts.removeAll()
        filterContent(searchText: searchController.searchBar.text!)
    }
    
    func filterContent(searchText: String){
        
        var intermediateStorage: [Contacts] = []
        
        for key in phoneBook.keys {
            print("im key  ",key)
            intermediateStorage = ((phoneBook[key] as? Array<Contacts>))?.filter{
                user in
                let contactName = user.name as String
                return contactName.lowercased().contains(searchText.lowercased())
                } ?? []
            print("filtered are : ",filteredContacts)
            filteredContacts.append(contentsOf: intermediateStorage)
        }
        myTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section, " ---- ", indexPath.row)
        
        if searchController.searchBar.text != ""{
//            print(filteredContacts[indexPath.row])
            segueName = filteredContacts[indexPath.row].name
            seguePhone = String(filteredContacts[indexPath.row].phone_no)
        } else {
             let myKey = phoneBook.keys.sorted()[indexPath.section]
//            print(phoneBook[myKey]?[indexPath.row] ?? boon)
            segueName = (phoneBook[myKey] as? Array<Contacts>)?[indexPath.row].name ?? ""
            seguePhone = String((phoneBook[myKey] as? Array<Contacts>)?[indexPath.row].phone_no ?? 0)
        }
        
        performSegue(withIdentifier: "mySegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mySegue" {
            let destinationVC = segue.destination as! SecondViewController
            destinationVC.myName = segueName
            destinationVC.myPhone = seguePhone
        }
    }
}


