//
//  ViewController.swift
//  KeyboardHelperDemo
//
//  Created by Marius Constantinescu on 26/02/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import UIKit
import KeyboardHelper

class ViewController: UIViewController, KeyboardNotificationDelegate {
    
    private var tapGesture: UITapGestureRecognizer!
    private var keyboardHelper : KeyboardHelper?
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tapGesture = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tapGesture)
        self.tapGesture.enabled = false
        
        self.keyboardHelper = KeyboardHelper(delegate: self)
    }

    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func keyboardWillAppear(info: KeyboardAppearanceInfo) {
        UIView.animateWithDuration(NSTimeInterval(info.animationDuration),
            delay: 0,
            options: animationOptionsWithCurve(info.animationCurve),
            animations: {
                let insets = UIEdgeInsetsMake(0, 0, info.endFrame.size.height, 0)
                self.scrollView.contentInset = insets
                self.scrollView.scrollIndicatorInsets = insets
            },
            completion:nil)
    }
    
    func keyboardWillDisappear(info: KeyboardAppearanceInfo) {
        UIView.animateWithDuration(NSTimeInterval(info.animationDuration),
            delay: 0,
            options: animationOptionsWithCurve(info.animationCurve),
            animations: {
                let insets = UIEdgeInsetsZero
                self.scrollView.contentInset = insets
                self.scrollView.scrollIndicatorInsets = insets
            },
            completion:nil)
    }
    
    func animationOptionsWithCurve(curve: UIViewAnimationCurve) -> UIViewAnimationOptions {
        switch curve {
        case .EaseIn:
            return UIViewAnimationOptions.CurveEaseIn
        case .EaseOut:
            return UIViewAnimationOptions.CurveEaseOut
        case .EaseInOut:
            return UIViewAnimationOptions.CurveEaseInOut
        case .Linear:
            return UIViewAnimationOptions.CurveLinear
        }
    }


}

