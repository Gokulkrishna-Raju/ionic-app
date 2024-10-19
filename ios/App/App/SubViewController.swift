//
//  SubViewController.swift
//  App
//
//  Created by Gokulkrishna Raju on 19/10/24.
//

import UIKit
import Capacitor
import SurveySparrowSdk


class SubViewController: CAPBridgeViewController {
    
    var ssSurveyView: SsSurveyView?
    var domain: String = "<account-domain>"
    var token: String = "<sdk-token>"
    var sparrowLang: String = "<your-preferred-language-code>"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize the required components
        self.initializeSurveyView { isInitialized in
            if isInitialized {
                print("ssSurveyView initialized")
            }
        }
    }

    // Function to initialize the SurveySparrow view
    func initializeSurveyView(completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            if self.ssSurveyView == nil {
                self.ssSurveyView = SsSurveyView()
            }
            completion(self.ssSurveyView != nil)
        }
    }

    // Function to load the Fullscreen Survey
    func loadFullscreenSurvey(domain: String, token: String, sparrowLang: String) {
        self.domain = domain
        self.token = token
        self.sparrowLang = sparrowLang
        
        // Ensure the survey view is initialized before loading the survey
        self.initializeSurveyView { isInitialized in
            if isInitialized {
                self.presentSurvey(domain: domain, token: token, sparrowLang: sparrowLang)
            } else {
                print("Error: ssSurveyView failed to initialize")
            }
        }
    }

    // Helper function to present the survey after initialization
    private func presentSurvey(domain: String, token: String, sparrowLang: String) {
        DispatchQueue.main.async {
            if let ssSurveyView = self.ssSurveyView {
                if let rootViewController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController {
                    ssSurveyView.loadFullscreenSurvey(
                        parent: rootViewController,  // Present from rootViewController
                        delegate: SsDelegate(),
                        domain: domain,
                        token: token,
                        params: ["emailaddress": "email@email.com", "email": "email@email.com"],
                        sparrowLang: sparrowLang
                    )
                    print("Survey loading initiated")
                } else {
                    print("Error: Unable to find rootViewController")
                }
            } else {
                print("Error: ssSurveyView is not initialized")
            }
        }
    }
}


class SsDelegate: SsSurveyDelegate {
    public func handleSurveyResponse(response: [String : AnyObject]) {
        print(response)
    }
    
    public func handleSurveyLoaded(response: [String : AnyObject]){
        print(response)
    }
    
    public func handleSurveyValidation(response: [String : AnyObject]) {
        print(response)
    }
    
    public func handleCloseButtonTap() {
        print("CloseButtonTapped")
    }
}
