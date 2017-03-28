//
//  LoggingKitInfoViewController.swift
//  LoggingKitClient
//
//  Created by ramon.pineda on 3/14/17.
//  Copyright © 2017 Home. All rights reserved.
//

import Foundation
import LoggingKit
import UIKit

class LoggingKitInfoViewController: UIViewController, UITableViewDataSource
{

    let options = ["Header string", "Request body string", "Response body string", "Message"]
    @IBOutlet weak var tableView: UITableView!
    var reqmo : RequestMO?
    @IBOutlet weak var detailView: UIScrollView!

    convenience init(request: RequestMO) {
        self.init()
        self.reqmo = request
        let titleView:UIView = UIView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 20))
        let label:UILabel = UILabel(frame: CGRect.init(x: titleView.bounds.size.width / 2, y: titleView.bounds.size.height / 2, width: 100, height: 20))
        label.text = request.loggingLevel?.description()
        label.textColor = UIColor.orange
        label.textAlignment = .center
        label.center = CGPoint(x: titleView.bounds.size.width / 2 , y: titleView.bounds.size.height / 2)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        titleView.addSubview(label)
        self.navigationItem.titleView = titleView
    }

    override func viewDidLoad() {
        self.tableView.register(UINib(nibName: "LoggingKitInfoCell", bundle: nil), forCellReuseIdentifier: "infoCell");
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:LoggingKitInfoCell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as! LoggingKitInfoCell
        cell.lb_title.text = options[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x:0, y:0, width: self.tableView.frame.size.width, height: 80.0))
        let label:UILabel = UILabel(frame: CGRect.init(x: 3, y: 4, width: self.tableView.frame.size.width, height: 20))
        label.text = self.reqmo?.deviceID
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.sizeToFit()
        view.addSubview(label)
        view.backgroundColor = UIColor.lightGray
        return view
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "test title 1"
    }

    @objc(tableView:heightForRowAtIndexPath:)
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 63.5;
    }

    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath: IndexPath)
    {
        let textView = UITextView()
        textView.frame = CGRect.init(x: 0 , y: 0, width: self.detailView.bounds.width, height: self.detailView.bounds.height)
        switch didSelectRowAtIndexPath.row {
            case 0:
                textView.text = reqmo?.headerString
                break
            case 1:
                textView.text = reqmo?.requestBodyString
                break
            case 2:
                textView.text = reqmo?.responseBodyString
                break
            case 3:
                textView.text = reqmo?.message
            default:
                break
        }
        textView.isEditable = false
        self.detailView.addSubview(textView)
    }

}
