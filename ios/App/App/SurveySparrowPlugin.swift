//
//  SurveySparrowPlugin.swift
//  App
//
//  Created by Gokulkrishna Raju on 19/10/24.
//

import SurveySparrowSdk
import Capacitor

@objc(SurveySparrowPlugin)
public class SurveySparrowPlugin: CAPPlugin {
    
    var svc: SubViewController!
    
    override init() {
        self.svc = SubViewController()
        super.init()
    }

    @objc public func loadFullScreenSurvey(_ call: CAPPluginCall) {
        DispatchQueue.global().async {
            let domain = call.getString("domain") ?? ""
            let token = call.getString("token") ?? ""
            let sparrowLang = call.getString("sparrowLang") ?? ""
            print("domainName -> \(domain) targetToken -> targetToken \(token).")
            self.svc.loadFullscreenSurvey(domain: domain, token: token, sparrowLang: sparrowLang)
            call.resolve()
        }
    }
}
