package io.ionic.starter;

import android.util.Log;

import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;
import com.surveysparrow.ss_android_sdk.OnSsResponseEventListener;
import com.surveysparrow.ss_android_sdk.OnSsValidateSurveyEventListener;
import com.surveysparrow.ss_android_sdk.SsSurvey;
import com.surveysparrow.ss_android_sdk.SsSurvey.CustomParam;
import com.surveysparrow.ss_android_sdk.SurveySparrow;
import org.json.JSONObject;
import java.util.HashMap;

@CapacitorPlugin(name = "SurveySparrowPlugin")
public class SurveySparrowPlugin extends Plugin implements OnSsValidateSurveyEventListener, OnSsResponseEventListener {

  public static final int SURVEY_REQUEST_CODE = 1;
  public static final int SURVEY_SCHEDULE_REQUEST_CODE = 2;

  private String ssDomain = "<account-domain>";
  private String ssToken = "<sdk-token>";
  private String ssLangCode = "<your-preferred-language-code>";
  private CustomParam[] params = {
    new CustomParam("emailaddress", "email@surveysparrow.com"),
    new CustomParam("email", "email@surveysparrow.com"),
  };
  private Boolean closeButtonEnabled = true;
  private SurveySparrow surveySparrow;

  // Method to initialize the survey
  private void initializeSurvey() {}

  // Method to load the survey (fullscreen)
  @PluginMethod
  public void loadFullScreenSurvey(PluginCall call) {
    if (surveySparrow == null) {
      initializeSurvey();
    }

    this.ssDomain = call.getString("domain");
    this.ssToken = call.getString("token");

    HashMap properties = new HashMap<String, String>();
    properties.put("langCode", ssLangCode);
    properties.put("isCloseButtonEnabled", closeButtonEnabled);

    SsSurvey survey = new SsSurvey(ssDomain, ssToken, params, properties);
    surveySparrow = new SurveySparrow(this.getActivity(), survey)
      .enableBackButton(true)
      .setWaitTime(2000);

    surveySparrow.startSurveyForResult(SURVEY_REQUEST_CODE);
    call.resolve();
  }

  // Method to load the survey with validation
  @PluginMethod
  public void loadFullScreenSurveyWithValidation(PluginCall call) {
    if (surveySparrow == null) {
      initializeSurvey();
    }

    this.ssDomain = call.getString("domain");
    this.ssToken = call.getString("token");

    HashMap properties = new HashMap<String, String>();
    properties.put("langCode", ssLangCode);
    properties.put("isCloseButtonEnabled", closeButtonEnabled);

    SsSurvey survey = new SsSurvey(ssDomain, ssToken, params, properties);
    surveySparrow = new SurveySparrow(this.getActivity(), survey)
      .enableBackButton(true)
      .setWaitTime(2000);

    surveySparrow.scheduleSurvey(SURVEY_SCHEDULE_REQUEST_CODE);
    surveySparrow.setValidateSurveyListener(this);
    surveySparrow.startSurvey(SURVEY_REQUEST_CODE);
    call.resolve();
  }

  @Override
  public void onSsValidateSurvey(JSONObject jsonObject) {
    Log.v("SurveySparrow", "Survey validation error json: " + jsonObject.toString());
  }

  @Override
  public void onSsResponseEvent(JSONObject jsonObject) {
    Log.v("SurveySparrow", "Survey response received: " + jsonObject.toString());
  }
}
