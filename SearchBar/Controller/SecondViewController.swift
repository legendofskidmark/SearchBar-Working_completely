//
//  SecondViewController.swift
//  SearchBar
//
//  Created by Boon on 19/07/19.
//  Copyright © 2019 Boon. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    //MARK:- Variables
    var myName:String = ""
    var myPhone:String = ""
    
    //MARK:- IBOutlets
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var labelName: UILabel!
    
    //MARK:- View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        labelName.text = "Name: \(myName)"
        labelPhone.text = "Ph.no: \(myPhone)"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
