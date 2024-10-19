//
//  SurveySparrowPlugin.swift
//  App
//
//  Created by Gokulkrishna Raju on 19/10/24.
//

import UIKit
import Capacitor
import SurveySparrowSdk

@objc(SurveySparrowPlugin)
public class SurveySparrowPlugin: CAPPlugin {
    
    var ssSurveyView: SsSurveyView?
    
    var domain: String = "<account-domain>"
    var token: String = "<sdk-token>"
    var sparrowLang: String = "<your-preferred-language-code>"
    var params: [String:String] = ["emailaddress": "email@email.com", "email": "email@email.com"]
    
    override init() {
        super.init()
        self.initializeSurveyView()
    }
    
    private func initializeSurveyView() {
        DispatchQueue.main.async {
            if self.ssSurveyView == nil {
                self.ssSurveyView = SsSurveyView()
                print("ssSurveyView initialized")
            }
        }
    }
    
    @objc public func loadEmbeddedSurvey(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            if let surveyVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmbedSurveyController") as? EmbedSurveyController {
                
                surveyVC.domain = call.getString("domain")
                surveyVC.token = call.getString("token")
                surveyVC.sparrowLang = call.getString("sparrowLang")
                surveyVC.modalPresentationStyle = .overFullScreen
                self.bridge?.viewController?.present(surveyVC, animated: false, completion: nil)
                
                call.resolve()
            } else {
                call.reject("Unable to load SurveyViewController")
            }
        }
    }
    
    @objc public func loadFullScreenSurvey(_ call: CAPPluginCall) {
        let domain = call.getString("domain") ?? self.domain
        let token = call.getString("token") ?? self.token
        let sparrowLang = call.getString("sparrowLang") ?? self.sparrowLang
        let params = call.getObject("params") as? [String: String] ?? self.params

        self.domain = domain
        self.token = token
        self.sparrowLang = sparrowLang
        self.params = params
        
        DispatchQueue.main.async {
            let ssSurveyViewController = SsSurveyViewController()
            ssSurveyViewController.domain = domain
            ssSurveyViewController.token = token
            ssSurveyViewController.sparrowLang = sparrowLang
            ssSurveyViewController.modalPresentationStyle = .fullScreen
            ssSurveyViewController.params = params
            ssSurveyViewController.getSurveyLoadedResponse = true
            ssSurveyViewController.surveyDelegate = SsDelegate()
            if let rootViewController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController {
                rootViewController.present(ssSurveyViewController, animated: true, completion: nil)
            }
        }
    }
    
    @objc public func loadFullScreenSurveyWithValidation(_ call: CAPPluginCall) {
        let domain = call.getString("domain") ?? self.domain
        let token = call.getString("token") ?? self.token
        let sparrowLang = call.getString("sparrowLang") ?? self.sparrowLang
        let params = call.getObject("params") as? [String: String] ?? self.params

        self.domain = domain
        self.token = token
        self.sparrowLang = sparrowLang
        self.params = params
        
        DispatchQueue.main.async {
            if let ssSurveyView = self.ssSurveyView {
                if let rootViewController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController {
                    ssSurveyView.loadFullscreenSurvey(
                        parent: rootViewController,
                        delegate: SsDelegate(),
                        domain: domain,
                        token: token,
                        params: params,
                        sparrowLang: sparrowLang
                    )
                    call.resolve()
                } else {
                    print("Error: Unable to find rootViewController")
                    call.reject("Unable to find rootViewController")
                }
            } else {
                print("Error: ssSurveyView is not initialized")
                call.reject("ssSurveyView is not initialized")
            }
        }
    }
}

class SsDelegate: SsSurveyDelegate {
    public func handleSurveyResponse(response: [String: AnyObject]) {
        print(response)
    }
    
    public func handleSurveyLoaded(response: [String: AnyObject]) {
        print(response)
    }
    
    public func handleSurveyValidation(response: [String: AnyObject]) {
        print(response)
    }
    
    public func handleCloseButtonTap() {
        print("CloseButtonTapped")
    }
}
