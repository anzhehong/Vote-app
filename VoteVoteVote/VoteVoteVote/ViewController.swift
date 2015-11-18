//
//  ViewController.swift
//  VoteVoteVote
//
//  Created by FOWAFOLO on 15/11/16.
//  Copyright © 2015年 Fowafolo. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var ideaTextField: UITextField!

    @IBOutlet weak var addIdeaButton: UIButton!
    
    @IBOutlet weak var startVotingButton: UIButton!
    
    var itemModel: ItemModel?
    var presentItemCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        ideaTextField.delegate = self
        updateUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func setTextFieldStyle(textField: UITextField) {
        textField.borderStyle = UITextBorderStyle.None
        textField.layer.borderColor = UIColor.whiteColor().CGColor
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 25.0
        let paddingView = UIView(frame: CGRectMake(0, 0, 25, 25))
        textField.leftView = paddingView
        textField.leftViewMode = UITextFieldViewMode.Always
    }
    
    private func setButtonStyle(button: UIButton){
        button.layer.cornerRadius = 25.0
    }
    
    private func updateUI(){
        setTextFieldStyle(nameTextField)
        setTextFieldStyle(ideaTextField)
        setButtonStyle(addIdeaButton)
        setButtonStyle(startVotingButton)
    }
    
    
    @IBAction func addAnItem(sender: UIButton) {
        //TODO:add an item func
        let currentDefault = NSUserDefaults.standardUserDefaults()
        
        let currentItem = ItemModel()
        currentItem.name = nameTextField.text
        currentItem.idea = ideaTextField.text
        if currentItem.name == "" || currentItem.idea == "" {
            UIAlertView(title: "增加项目", message: "请输入有效内容！", delegate: nil, cancelButtonTitle: "ok").show()
        } else {
            currentItem.voteCount = 0
            if let _ = currentDefault.objectForKey("items") {
                //MARK: - 已经存在此userdefault
                addThisItemToUserDefault(currentItem)
            }else {
                //MARK: - 需要新建此userdefault
                currentDefault.setObject([NSData](), forKey: "items")
                addThisItemToUserDefault(currentItem)
            }
        }
    }
    
    func addThisItemToUserDefault(thisItem:ItemModel){
        var list = NSUserDefaults.standardUserDefaults().objectForKey("items") as? [NSData]
        list?.append(thisItem.modelToNSData()!)
        NSUserDefaults.standardUserDefaults().setObject(list, forKey: "items")
        presentItemCount++
        UIAlertView(title: "增加项目", message: "您已成功添加项目！", delegate: nil, cancelButtonTitle: "ok").show()
    }
    
    //MARK: - keyboard
    //MARK: - UITextFildDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        ideaTextField.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //        changedValueTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        ideaTextField.resignFirstResponder()
    }


}

