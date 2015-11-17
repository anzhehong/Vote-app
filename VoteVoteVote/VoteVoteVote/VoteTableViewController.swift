//
//  VoteTableViewController.swift
//  VoteVoteVote
//
//  Created by FOWAFOLO on 15/11/16.
//  Copyright © 2015年 Fowafolo. All rights reserved.
//

import UIKit

class VoteTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let userDefault = NSUserDefaults.standardUserDefaults().objectForKey("items"){
            return userDefault.count
        }
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        if let button = cell.viewWithTag(103) as? UIButton {
            button.tag = indexPath.row
            //        test(button)
            button.addTarget(self, action: "addFunction:", forControlEvents: UIControlEvents.TouchUpInside)
            // Configure the cell...
        }
//        var button = cell.viewWithTag(103) as! UIButton
        
        if let userDefault = NSUserDefaults.standardUserDefaults().objectForKey("items"){
            let dataList = userDefault as? [NSData]
            let currentName = ItemModel.NSDataToModel(dataList![indexPath.row]).name
            let currentIdea = ItemModel.NSDataToModel(dataList![indexPath.row]).idea
            (cell.viewWithTag(101) as! UILabel).text = currentName
            (cell.viewWithTag(102) as! UILabel).text = currentIdea
        }
        return cell
    }
    func addFunction(sender:UIButton) {
//        print(sender.tag)
        let userDefault = NSUserDefaults.standardUserDefaults().objectForKey("items")
        var dataList = userDefault as? [NSData]
        var itemToChange = ItemModel.NSDataToModel(dataList![sender.tag])
        itemToChange.voteCount = itemToChange.voteCount! + 1
        dataList![sender.tag] = itemToChange.modelToNSData()!
        NSUserDefaults.standardUserDefaults().setObject(dataList, forKey: "items")
        UIAlertView(title: "great", message: "成功投了一票", delegate: self, cancelButtonTitle: "下一票").show()
    }
}
