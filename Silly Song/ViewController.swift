//
//  ViewController.swift
//  Silly Song
//
//  Created by Mark Yang on 5/8/16.
//  Copyright © 2016 Myang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameField.delegate = self
        nameField.returnKeyType = UIReturnKeyType.Done
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(sender: AnyObject) {
        nameField.text = ""
        lyricsView.text = ""
    }

    @IBAction func displayLyrics(sender: AnyObject) {
        if nameField.hasText() {
            lyricsView.text = lyricsForName(bananaFanaTemplate.joinWithSeparator("\n"), fullName: nameField.text!)
            lyricsView.textAlignment = .Center
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"
]

func shortNameFromName(name: String) -> String {
    let lowercaseName = name.lowercaseString
    let vowelSet = NSCharacterSet(charactersInString:"aeiou")
    
    if let firstVowelIndex = lowercaseName.rangeOfCharacterFromSet(vowelSet)?.startIndex {
        return String(lowercaseName.substringFromIndex(firstVowelIndex))
    }
    return lowercaseName
}

func lyricsForName(lyricsTemplate: String, fullName: String) -> String{
    return lyricsTemplate.stringByReplacingOccurrencesOfString("<FULL_NAME>", withString: fullName.capitalizedString).stringByReplacingOccurrencesOfString("<SHORT_NAME>", withString: shortNameFromName(fullName))
}