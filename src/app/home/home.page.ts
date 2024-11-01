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

  embedSurvey() {
    SurveySparrowPlugin.loadEmbeddedSurvey({
      domain: "DOMAIN",
      token: "TOKEN"
    }).then(() => {
      console.log('Survey loaded successfully');
    }).catch((error) => {
      console.error('Error loading survey:', error);
    });
  }

  loadSurvey() {
    SurveySparrowPlugin.loadFullScreenSurvey({
      domain: "DOMAIN",
      token: "TOKEN"
    }).then(() => {
      console.log('Survey loaded successfully');
    }).catch((error) => {
      console.error('Error loading survey:', error);
    });
  }

  loadSurveyWithValidation() {
    SurveySparrowPlugin.loadFullScreenSurveyWithValidation({
      domain: "DOMAIN",
      token: "TOKEN"
    }).then(() => {
      console.log('Survey loaded successfully');
    }).catch((error) => {
      console.error('Error loading survey:', error);
    });
  }
}
