//
//  FieldViewController.swift
//  Furry1
//
//  Created by Joseph Anderson on 2/9/15.
//  Copyright (c) 2015 Realm. All rights reserved.
//

import UIKit

class FieldViewController: UIViewController, UIActionSheetDelegate, UIScrollViewDelegate {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var bunnySpeechLabel: UILabel!
    @IBOutlet weak var bunnyRabbit: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var fieldImageView: UIImageView!
    
    var scale: CGFloat! = 1.0
    var rotate: CGFloat! = 0
    
    @IBOutlet weak var speakTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.delegate = self
        scrollView.contentSize = fieldImageView.frame.size
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressUpButton(sender: AnyObject) {
        var originalBunnyCenterY = bunnyRabbit.center.y
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.bunnyRabbit.center.y = originalBunnyCenterY - 40
        })
    }

    @IBAction func didPressDownButton(sender: AnyObject) {
        bunnyRabbit.center.y = bunnyRabbit.center.y + 40
    }

    @IBAction func didPressRightButton(sender: AnyObject) {
        bunnyRabbit.center.x = bunnyRabbit.center.x + 40
    }

    @IBAction func didPressLeftButton(sender: AnyObject) {
        bunnyRabbit.center.x = bunnyRabbit.center.x - 40
    }

    @IBAction func didPressTearButton(sender: AnyObject) {
        scale = scale - 0.1
        rotateAndScale()
    }
    
    @IBAction func didPressGrowButton(sender: AnyObject) {
        scale = scale + 0.1
        rotateAndScale()
    }
    
    @IBAction func didPressRotateLeft(sender: AnyObject) {
        rotate = rotate - 5.0
        rotateAndScale()
    }
    
    @IBAction func didPressRotateRight(sender: AnyObject) {
        rotate = rotate + 5.0
        rotateAndScale()
    }
    
    func rotateAndScale(){
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            var scaleTransform = CGAffineTransformMakeScale(self.scale, self.scale)
            var rotateTransform = CGAffineTransformMakeDegreeRotation(self.rotate)
            var combinedTransform = CGAffineTransformConcat(scaleTransform, rotateTransform)
            self.bunnyRabbit.transform = combinedTransform
        })
    }
    
    @IBAction func didPressShowButton(sender: AnyObject) {
        bunnyRabbit.hidden = false
    }
    
    @IBAction func didPressHideButton(sender: AnyObject) {
        bunnyRabbit.hidden = true
    }
    
    @IBAction func didPressSendButton(sender: AnyObject) {
        bunnySpeechLabel.text = ""
        activityIndicator.startAnimating()
        delay(0.5, { () -> () in
            self.checkTextInput()
        })
    }
    
    func checkTextInput(){
        if (self.speakTextField.text == "Hey"){
            self.bunnySpeechLabel.text = "Hello"
        } else if (self.speakTextField.text == "What's your name?"){
            self.bunnySpeechLabel.text = "Roger"
        }
        else {
            self.bunnySpeechLabel.text = "I don't understand"
        }
        self.activityIndicator.stopAnimating()
    }
    
    @IBAction func didPressLogoutButton(sender: AnyObject) {
        var actionSheet = UIActionSheet(title: "Are you sure?", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: "Logout")
        actionSheet.showInView(view)
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if (buttonIndex == 0){
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        fieldImageView.frame.origin.y = -scrollView.contentOffset.y/10
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
