/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class MasterViewController: UITableViewController {
  
    //@IBOutlet weak var searchbar1: UISearchBar!
  // MARK: - Properties
  var detailViewController: DetailViewController? = nil
  var filteredCandies = [CityData]()
  var filteredCandies2 = [CityData]()
  let searchController = UISearchController(searchResultsController: nil)
  
  // MARK: - View Setup
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup the Search Controller
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    definesPresentationContext = true
    searchController.dimsBackgroundDuringPresentation = false
    searchController.searchBar.searchBarStyle = UISearchBarStyle(rawValue: 1)!
    
    // Setup the Scope Bar
    searchController.searchBar.scopeButtonTitles = ["도", "시/군/구", "동/읍/면"]
    tableView.tableHeaderView = searchController.searchBar
    //tableView.tableFooterView = searchController.searchBar
    //tableView.tableFooterView = searchController.searchBar
    //searchbar1 = searchController.searchBar
    
    
    if let splitViewController = splitViewController {
      let controllers = splitViewController.viewControllers
      detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    //clearsSelectionOnViewWillAppear = splitViewController!.collapsed
    
    super.viewWillAppear(animated)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Table View
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchController.active && searchController.searchBar.text != "" {
      return filteredCandies.count
    }
    else if filteredCandies2.count != 0
    {
        return filteredCandies2.count
    }
    return CityDatas.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CityCell
    let city: CityData
    if searchController.active && searchController.searchBar.text != "" {
      city = filteredCandies[indexPath.row]
    }
        else if filteredCandies2.count != 0
    {
        city = filteredCandies2[indexPath.row]
    }
    else {
      city = CityDatas[indexPath.row]
    }
    cell.detailCity = city
    
    return cell
  }
  
  func filterContentForSearchText(searchText: String, scope: String = "All") {
    filteredCandies = CityDatas.filter({( city : CityData) -> Bool in
    
    if scope == "도"
    {
      //categoryMatch = (scope == "All") || (city.Do == scope)
       // stand = city.Do
        return city.Do.lowercaseString.containsString(searchText.lowercaseString)
    }
    else if scope == "시/군/구"
    {
       //categoryMatch = (scope == "All") || (city.Si == scope)
        return city.Si.lowercaseString.containsString(searchText.lowercaseString)
    }
    else if scope == "동/읍/면"
    {
        //categoryMatch = (scope == "All") || (city.Dong == scope)
        // stand = city.Si
        return city.Dong.lowercaseString.containsString(searchText.lowercaseString)
    }
        
    return false
      
    })
    tableView.reloadData()
  }
  
  // MARK: - Segues
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
   // print("master")
   // print(segue.identifier)
    
    //if segue.identifier == "showDetail" {
      if let indexPath = tableView.indexPathForSelectedRow {
        let city: CityData
        
        if searchController.active && searchController.searchBar.text != "" {
          city = filteredCandies[indexPath.row]
        }
        else if filteredCandies2.count != 0{
            
          city = filteredCandies2[indexPath.row]
        }
        else {
          city = CityDatas[indexPath.row]
        }
        
        let controller = segue.destinationViewController as! ForecastController
        controller.city = city
        CurrCityData = city
       // controller.city = city
      }
    }
  //}
  
}

extension MasterViewController: UISearchBarDelegate {
  // MARK: - UISearchBar Delegate
    
  func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    
    filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
  }
}

extension MasterViewController: UISearchResultsUpdating {
  // MARK: - UISearchResultsUpdating Delegate
  func updateSearchResultsForSearchController(searchController: UISearchController) {
    
    let searchBar = searchController.searchBar
    
    let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
    filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    
    if(filteredCandies.count != 0)
    {
        filteredCandies2 = filteredCandies
    }
  }
}