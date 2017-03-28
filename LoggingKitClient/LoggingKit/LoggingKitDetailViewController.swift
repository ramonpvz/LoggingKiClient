//
//  LoggingKitDetailViewController.swift
//  LoggingKitClient
//
//  Created by ramon.pineda on 2/16/17.
//  Copyright © 2017 Home. All rights reserved.
//

import UIKit
import LoggingKit

class LoggingKitDetailViewController: UIViewController, UITableViewDataSource, LoggingKitOptionsDelegate, UISearchResultsUpdating
{

    @IBOutlet weak var detailTable: UITableView!
    @IBOutlet weak var searchPicker: UIPickerView!
    var results = NSMutableArray()
    var resultsDynamic = NSMutableArray()
    var optionsView:LoggingKitOptionsView?
    var searchController = UISearchController()
    var currentSearch = "ALL"

    override func viewDidLoad() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closewindow))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search , target: self, action: #selector(addTapped))
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.autocapitalizationType = UITextAutocapitalizationType.none
        definesPresentationContext = true
        self.detailTable.tableHeaderView = searchController.searchBar
        self.detailTable.register(UINib(nibName: "LoggingKitDetailCell", bundle: nil), forCellReuseIdentifier: "cellDetail")
    }
    
    func updateSearchResultsForSearchController(for searchController: UISearchController) {
        filterContentForSearch(search: searchController.searchBar.text!)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearch(search: searchController.searchBar.text!)
    }

    func filterContentForSearch(search: String, scope: String = "ALL")
    {
        self.resultsDynamic = NSMutableArray(array: self.results)
        if (search != "") {
            let pattern = "message LIKE %@ OR headerString LIKE %@ OR requestBodyString LIKE %@ OR responseBodyString LIKE %@ OR serviceURL LIKE %@ or loggingLevelString LIKE %@"
            let predicate = NSPredicate(format: pattern, "*\(search)*", "*\(search)*", "*\(search)*", "*\(search)*", "*\(search)*", "*\(search)*")
            self.resultsDynamic.filter(using: predicate)
        }
        else
        {
            if self.currentSearch == "ALL" {
                self.results = NSMutableArray(array: RequestMO().fetchAll())
                self.resultsDynamic = NSMutableArray(array: self.results)
            }
            else if self.currentSearch == "AAM" {
                self.results = NSMutableArray(array: RequestMO().fetchAllAfterMidnight())
                self.resultsDynamic = NSMutableArray(array: self.results)
            }
            else {
                self.results = NSMutableArray(array: RequestMO().fetchAllBeforeMidnight())
                self.resultsDynamic = NSMutableArray(array: self.results)
            }
        }
        self.detailTable.reloadData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:LoggingKitDetailCell = tableView.dequeueReusableCell(withIdentifier: "cellDetail") as! LoggingKitDetailCell
        let requestMO = self.resultsDynamic[indexPath.row] as! RequestMO
        cell.service_lab.text = requestMO.serviceURL
        let format = DateFormatter();
        format.dateFormat = "dd/MM/yyyy hh:mm:ss aa"
        cell.timestamp_lab.text = format.string(from: requestMO.timestamp as! Date)
        cell.level_img.image = self.getIconByLevel(level: requestMO.loggingLevel!)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsDynamic.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath: IndexPath)
    {
        let reqMO = self.resultsDynamic[didSelectRowAtIndexPath.row] as! RequestMO
        let infoVC = LoggingKitInfoViewController(request: reqMO)
        self.navigationController?.pushViewController(infoVC, animated: true)
    }

    @objc(tableView:heightForRowAtIndexPath:)
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 63.5;
    }

    func getIconByLevel(level: LoggingLevel) -> UIImage
    {
        switch level {
        case LoggingLevel.DEBUG:
            return UIImage(named: "LEVEL_DEBUG")!
        case LoggingLevel.ERROR:
            return UIImage(named: "LEVEL_ERROR")!
        case LoggingLevel.FATAL:
            return UIImage(named: "LEVEL_FATAL")!
        case LoggingLevel.INFO:
            return UIImage(named: "LEVEL_INFO")!
        default:
            return UIImage(named: "LEVEL_WARNING")!
        }
    }
    
    func closewindow()
    {
        self.dismiss(animated: true, completion: nil)
    }

    func addTapped()
    {
        if self.optionsView == nil {
            self.optionsView = LoggingKitOptionsView(frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        }
        self.optionsView?.delegate = self
        if self.optionsView!.isDescendant(of: self.view)
        {
            self.optionsView!.removeFromSuperview()
        }
        else
        {
            self.view.addSubview(self.optionsView!)
        }
    }

    func all(view: UIView)
    {
        self.currentSearch = "ALL"
        self.results = NSMutableArray(array: RequestMO().fetchAll())
        self.resultsDynamic = NSMutableArray(array: self.results)
        self.detailTable.reloadData()
        view.removeFromSuperview()
    }

    func allAfterMid (view: UIView)
    {
        self.currentSearch = "AAM"
        self.results = NSMutableArray(array: RequestMO().fetchAllAfterMidnight())
        self.resultsDynamic = NSMutableArray(array: self.results)
        self.detailTable.reloadData()
        view.removeFromSuperview()
    }
    
    func allBeforerMid (view: UIView)
    {
        self.currentSearch = "ABM"
        self.results = NSMutableArray(array: RequestMO().fetchAllBeforeMidnight())
        self.resultsDynamic = NSMutableArray(array: self.results)
        self.detailTable.reloadData()
        view.removeFromSuperview()
    }
    
    func custom (view: UIView)
    {
        self.results = NSMutableArray(array: RequestMO().fetchAllBetweenDates(date1: Date(), date2: Date()))
        self.resultsDynamic = NSMutableArray(array: self.results)
        self.detailTable.reloadData()
        view.removeFromSuperview()
    }

}
