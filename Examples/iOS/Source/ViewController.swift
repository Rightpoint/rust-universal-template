//
//  ViewController.swift
//  ExampleApp
//
//  Created by Chris Ballinger on 5/8/18.
//  Copyright © 2018 Raizlabs. All rights reserved.
//

import UIKit
import ExampleSwift
import ExampleObjC

class ViewController: UIViewController {

    private let message = Message(text: "Hello from Rust (Swift)!")
    private let messageObjC = RSTMessage(text: "Hello from Rust (ObjC)!")
    @IBOutlet weak var messageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        messageLabel.text = (message.name ?? "") + "\n\n" + (messageObjC.name ?? "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

