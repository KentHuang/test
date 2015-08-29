//
//  ViewController.swift
//  test
//
//  Created by Kent Huang on 8/28/15.
//  Copyright (c) 2015 Kent Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var imageView: UIImageView? {
        didSet {
            let recognizer = UITapGestureRecognizer(target: self, action: "toggleButtons")
            imageView!.addGestureRecognizer(recognizer)
            imageView?.userInteractionEnabled = true
        }
    }
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.configureTextFields(topTextField)
        self.configureTextFields(bottomTextField)
        
        backButton.hidden = true
        addImageButton.hidden = true
        cameraButton.hidden = true
        saveButton.hidden = true
        shareButton.hidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "keyboardWillShow:", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "keyboardWillHide:", object: nil)
    }
    
    // MARK: Keyboard
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(keyboardAnimationDuration(notification))
            UIView.setAnimationCurve(keyboardAnimationCurve(notification))
            self.view.frame.origin.y -= keyboardHeight(notification)
            UIView.commitAnimations()
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(keyboardAnimationDuration(notification))
            UIView.setAnimationCurve(keyboardAnimationCurve(notification))
            self.view.frame.origin.y += keyboardHeight(notification)
            UIView.commitAnimations()
        }
    }
    
    func keyboardHeight(notification: NSNotification) -> CGFloat {
        let keyboardInfo = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardInfo.CGRectValue().height
    }
    
    func keyboardAnimationDuration(notification: NSNotification) -> NSTimeInterval {
        let keyboardDuration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        return keyboardDuration
    }
    
    func keyboardAnimationCurve(notification: NSNotification) -> UIViewAnimationCurve {
        let keyboardCurve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
        return UIViewAnimationCurve(rawValue: keyboardCurve.integerValue)!
    }
    
    // MARK: TextFields
    
    func configureTextFields(textField: UITextField) {
        textField.defaultTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -2.0
        ]
        textField.delegate = self
        textField.borderStyle = UITextBorderStyle.None
        textField.placeholder = "Type Here"
        textField.textAlignment = NSTextAlignment.Center
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        configureTextFields(textField)
        textField.placeholder = ""
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.text == "" {
            textField.placeholder = "Type Here"
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    // Buttons
    
    func toggleButtons() {
        self.fadeButtons([backButton, addImageButton, cameraButton, saveButton, shareButton])
    }
    
    func fadeButtons(buttons: [UIButton]) {
        for button in buttons {
            UIView.transitionWithView(button, duration: 0.3, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { (button.hidden = !button.hidden) }, completion: nil)
        }
    }
    
    @IBAction func tapBackButton(sender: UIButton) {
        println("back")
    }
    
    @IBAction func tapAddImageButton(sender: AnyObject) {
        println("add")
    }

    @IBAction func tapCameraButton(sender: AnyObject) {
        println("camera")
    }
    
    @IBAction func tapSaveButton(sender: AnyObject) {
        println("save")
    }
    
    @IBAction func tapShareButton(sender: AnyObject) {
        println("share")
    }
    
}

