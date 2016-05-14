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
            button.addTarget(self, action: #selector(VoteTableViewController.addFunction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            // Configure the cell...
        }
        
        if let userDefault = NSUserDefaults.standardUserDefaults().objectForKey("items") {
            let dataList = userDefault as? [NSData]
            let currentName = ItemModel.NSDataToModel(dataList![indexPath.row]).name
            (cell.viewWithTag(101) as! UILabel).text = currentName
        }
        return cell
    }
    
    func addFunction(sender:UIButton) {
//        print(sender.tag)
        let userDefault = NSUserDefaults.standardUserDefaults().objectForKey("items")
        var dataList = userDefault as? [NSData]
        let itemToChange = ItemModel.NSDataToModel(dataList![sender.tag])
        itemToChange.voteCount = itemToChange.voteCount! + 1
        dataList![sender.tag] = itemToChange.modelToNSData()!
        NSUserDefaults.standardUserDefaults().setObject(dataList, forKey: "items")
        
        UIView.animateWithDuration(0.2, animations: {
                sender.transform = CGAffineTransformMakeScale(1.05, 1.05)
            }, completion: {(true) in
                sender.transform = CGAffineTransformMakeScale(1, 1)
                
                let alertView = UIAlertController(title: "Great", message: "成功投了一票", preferredStyle: .Alert)
                alertView.addAction(UIAlertAction(title: "下一票", style: .Default, handler: nil))
                self.presentViewController(alertView, animated: true, completion: nil)
        })
        
    }
}
