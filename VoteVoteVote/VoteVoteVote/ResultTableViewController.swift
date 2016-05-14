//
//  ResultTableViewController.swift
//  VoteVoteVote
//
//  Created by FOWAFOLO on 15/11/16.
//  Copyright © 2015年 Fowafolo. All rights reserved.
//

import UIKit

class ResultTableViewController: UITableViewController {

    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var secondNameLabel: UILabel!
    @IBOutlet weak var thirdNameLabel: UILabel!
    
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!

    let userDefault = NSUserDefaults.standardUserDefaults().objectForKey("items")!
    var dataList = [NSData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstLabel.layer.cornerRadius = 25
        secondLabel.layer.cornerRadius = 25
        thirdLabel.layer.cornerRadius = 25
        
        dataList = (userDefault as! [NSData])
        let itemList = sortDataListDes(dataList)
        let count = itemList.count
        if count > 0{
            firstNameLabel.text = itemList[0].name
            if count > 1 {
                secondNameLabel.text = itemList[1].name
                if count > 2 {
                    thirdNameLabel.text = itemList[2].name
                }else {
                    thirdNameLabel.text = ""
                    thirdLabel.hidden = true
                }
            }else {
                secondNameLabel.text = ""
                thirdNameLabel.text = ""
                secondLabel.hidden = true
                thirdLabel.hidden = true
            }
        }
        
//        judge if there are two men whose vote number is equal and record the two men
        var equal = false
        var position = [Int]()
        
        if itemList.count >= 3 {
            for i in 0...1 {
                if itemList[i].voteCount == itemList[i + 1].voteCount {
                    position.append(i + 1)
                    equal = true
                }
            }
        } else if itemList.count == 2 {
            if itemList[0].voteCount == itemList[1].voteCount {
                position.append(0)
                equal = true
            }
        }
        
        if equal {
            self.showAlert(&position)
            
        }
        
    }
    
    private func showAlert(inout position: [Int]) {
        let alertView = UIAlertController(title: "提示", message: "第\(position[0])名与第\(position[0] + 1)名得票相等", preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) in
            position.removeAtIndex(0)
            if !position.isEmpty {
                self.showAlert(&position)
            }
        }))
        self.presentViewController(alertView, animated: true, completion: nil)
    }
    
    func sortDataListDes(dataList: [NSData])->[ItemModel] {
        var itemList: [ItemModel] = []
//        print(dataList.count)
        for i in 0...dataList.count-1 {
            itemList.append(ItemModel.NSDataToModel(dataList[i]))
        }
        //use closure to make sort function claner
        itemList = itemList.sort({$0.voteCount > $1.voteCount})
        return itemList
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = NSUserDefaults.standardUserDefaults().objectForKey("items") {
            return 3
        }
        return 0
    }

}
