//
//  EmbedSurveyController.swift
//  App
//
//  Created by Gokulkrishna Raju on 19/10/24.
//

import UIKit
import SurveySparrowSdk

class EmbedSurveyController: UIViewController {
    @IBOutlet weak var ssSurveyView: SsSurveyView!
    
    var domain: String?
    var token: String?
    var sparrowLang: String?
    var params: [String:String]?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let domain = domain, let token = token {
            ssSurveyView.loadEmbedSurvey(
                domain: domain,
                token: token,
                params: params ?? ["emailaddress": "email@email.com"],
                sparrowLang: sparrowLang ?? "en"
            )
        }
    }
}

