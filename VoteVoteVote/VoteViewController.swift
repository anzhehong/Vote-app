//
//  VoteViewController.swift
//  VoteVoteVote
//
//  Created by FOWAFOLO on 15/11/17.
//  Copyright © 2015年 Fowafolo. All rights reserved.
//

import UIKit

class VoteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showResult(sender: UIButton) {
        var userDefault = NSUserDefaults.standardUserDefaults()
        if let object = userDefault.objectForKey("items"){
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("result")
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            UIAlertView(title: "艾玛", message: "还没添加信息呢！", delegate: nil, cancelButtonTitle: "噢我错了，现在就加").show()
        }
    }

}
