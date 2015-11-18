//
//  ResultTableViewController.swift
//  VoteVoteVote
//
//  Created by FOWAFOLO on 15/11/16.
//  Copyright © 2015年 Fowafolo. All rights reserved.
//

import UIKit

class ResultTableViewController: UITableViewController {
    @IBOutlet weak var firstIdeaLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var secondIdeaLabel: UILabel!
    @IBOutlet weak var secondNameLabel: UILabel!
    @IBOutlet weak var thirdIdeaLabel: UILabel!
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
            firstIdeaLabel.text = itemList[0].idea
            if count > 1 {
                secondNameLabel.text = itemList[1].name
                secondIdeaLabel.text = itemList[1].idea
                if count > 2 {
                    thirdNameLabel.text = itemList[2].name
                    thirdIdeaLabel.text = itemList[2].idea
                }else {
                    thirdNameLabel.text = ""
                    thirdIdeaLabel.text = ""
                    thirdLabel.hidden = true
                }
            }else {
                secondIdeaLabel.text = ""
                secondNameLabel.text = ""
                thirdIdeaLabel.text = ""
                thirdNameLabel.text = ""
                secondLabel.hidden = true
                thirdLabel.hidden = true
            }
        }
        
    }
    
    func sortDataListDes(dataList: [NSData])->[ItemModel] {
        var itemList: [ItemModel] = []
        print(dataList.count)
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
        if let _ = NSUserDefaults.standardUserDefaults().objectForKey("items"){
            return 3
        }
        return 0
    }

}
