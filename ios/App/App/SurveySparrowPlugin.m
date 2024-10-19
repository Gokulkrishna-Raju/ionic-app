//
//  SurveySparrowPlugin.m
//  App
//
//  Created by Gokulkrishna Raju on 19/10/24.
//

#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

CAP_PLUGIN(SurveySparrowPlugin, "SurveySparrowPlugin",
    CAP_PLUGIN_METHOD(loadEmbeddedSurvey, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(loadFullScreenSurvey, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(loadFullScreenSurveyWithValidation, CAPPluginReturnPromise);
);
