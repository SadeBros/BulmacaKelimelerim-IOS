//
//  ViewController.swift
//  BulmacaKelimelerim
//
//  Created by Şafak AKINCI on 29.12.2018.
//  Copyright © 2018 Şafak AKINCI. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    
    @IBOutlet var viewMain: UIView!
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var labelAnswer: UILabel!
    
    
    let RANDOM_WORD_URL = "http://178.62.45.220:3000/api/random"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRandomWord(url: RANDOM_WORD_URL)
        let gestureSwift2AndHigher = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        self.viewMain.addGestureRecognizer(gestureSwift2AndHigher)
    }
    
    func getRandomWord(url: String){
        Alamofire.request(url, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                
                let wordJSON : JSON = JSON(response.result.value!)
                self.updateLabels(json: wordJSON)
                
            }else{
                self.labelQuestion.text = "Connection issues"
            }
        }
    }
    
    func updateLabels(json : JSON){
        for (answer, question) in json{
            labelQuestion.text = question.string
            labelAnswer.text = answer
            print(question, answer)
        }
    }
    
    @objc func someAction(_ sender:UITapGestureRecognizer){
        getRandomWord(url: RANDOM_WORD_URL)
    }
}

