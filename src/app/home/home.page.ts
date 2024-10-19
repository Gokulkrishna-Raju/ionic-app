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
    SurveySparrowPlugin.loadFullScreenSurvey({
      domain: "gokulkrishnaraju1183.surveysparrow.com",
      token: "tt-DKLvmYD7iby"
    }).then(() => {
      console.log('Survey loaded successfully');
    }).catch((error) => {
      console.error('Error loading survey:', error);
    });
  }

  loadSurveyWithValidation() {
    SurveySparrowPlugin.loadFullScreenSurveyWithValidation({
      domain: "gokulkrishnaraju1183.surveysparrow.com",
      token: "tt-DKLvmYD7iby"
    }).then(() => {
      console.log('Survey loaded successfully');
    }).catch((error) => {
      console.error('Error loading survey:', error);
    });
  }
}
