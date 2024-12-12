import { Component } from '@angular/core';
import { Platform } from '@ionic/angular';
import SurveySparrowPlugin from '../SurveySparrowPlugin/SurveySparrow';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})

export class HomePage {

  constructor(private platform: Platform) { 
    this.platform.ready().then(() => {});
  }

  loadSurvey() {
    let domain = "<account-domain>";
    let token = "<sdk-token>";
    
    SurveySparrowPlugin.loadFullScreenSurvey({
      domain,
      token
    }).then(() => {
      console.log('Survey loaded successfully');
    }).catch((error) => {
      console.error('Error loading survey:', error);
    });
  }

  loadSurveyWithValidation() {
    let domain = "<account-domain>";
    let token = "<sdk-token>";

    SurveySparrowPlugin.loadFullScreenSurveyWithValidation({
      domain,
      token
    }).then(() => {
      console.log('Survey loaded successfully');
    }).catch((error) => {
      console.error('Error loading survey:', error);
    });
  }
}
