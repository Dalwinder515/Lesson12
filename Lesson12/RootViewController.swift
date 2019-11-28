//
//  ViewController.swift
//  Lesson12
//
//  Created by Student on 2019-11-27.
//  Copyright © 2019 CentennialCollege. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {

    private var familyNames:[String]!
    private var cellPointSize:CGFloat! //defined by library, for standard
    private var favouritesList: FavouritesList!
    private static let familyCell="FamilyName"
    private static let favouritesCell="Favourites"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        familyNames = (UIFont.familyNames as [String]).sorted()
        let preferredTableViewFont=UIFont.preferredFont(forTextStyle: .headline)
        cellPointSize=preferredTableViewFont.pointSize
        favouritesList=FavouritesList.getInstance()
        tableView.estimatedRowHeight=cellPointSize
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func fontForDisplay(atIndexPath indexPath: IndexPath)->UIFont?
    {
        if(indexPath.section == 0)
        {
            let familyName = familyNames[indexPath.row]
            let fontName = UIFont.fontNames(forFamilyName: familyName).first
            return fontName != nil ?
                UIFont(name: fontName!, size: cellPointSize) : nil
        }
        else
        {
            return nil
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return favouritesList.favourites.isEmpty ? 1 : 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? familyNames.count : 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "All Font Families" : "My Favourite Fonts"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: RootViewController.familyCell, for:indexPath)
            cell.textLabel?.font=fontForDisplay(atIndexPath: indexPath)
            cell.textLabel?.text=familyNames[indexPath.row]
            cell.detailTextLabel?.text=familyNames[indexPath.row]
            return cell
        }
        else{
            return tableView.dequeueReusableCell(withIdentifier: RootViewController.favouritesCell, for:indexPath)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPath(for:sender as! UITableViewCell)!
        let listViewController = segue.destination as! FontListTableTableViewController
        
        if(indexPath.section == 0)
        {
            let familyName = familyNames[indexPath.row]
            listViewController.fontNames = (UIFont.fontNames(forFamilyName: familyName) as [String]).sorted()
            listViewController.navigationItem.title = familyName
            listViewController.showsFavourites = false
        }
        else{
            listViewController.fontNames = favouritesList.favourites
            listViewController.navigationItem.title = "Favourites"
            listViewController.showsFavourites = true
        }
        
    }

}

