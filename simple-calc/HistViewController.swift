//
//  HistViewController.swift
//  simple-calc
//
//  Created by studentuser on 4/25/17.
//  Copyright © 2017 KitoPham. All rights reserved.
//

import UIKit

class HistViewController: UIViewController {

    @IBOutlet weak var ScrollView: UIScrollView!
    var history : [String] = [""]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for index in 0...history.count - 1 {
            let label = UILabel(frame: CGRect(x: 0, y: index * 45, width: 300, height: 40))
            label.text = history[index]
            ScrollView.addSubview(label)

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let calcView = segue.destination as! ViewController
        calcView.history = self.history
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
