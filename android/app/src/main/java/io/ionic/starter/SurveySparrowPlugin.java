package io.ionic.starter;

import android.util.Log;

import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;
import com.surveysparrow.ss_android_sdk.OnSsResponseEventListener;
import com.surveysparrow.ss_android_sdk.OnSsValidateSurveyEventListener;
import com.surveysparrow.ss_android_sdk.SsSurvey;
import com.surveysparrow.ss_android_sdk.SsSurvey.CustomParam;
import com.surveysparrow.ss_android_sdk.SsSurveyFragment;
import com.surveysparrow.ss_android_sdk.SurveySparrow;
import org.json.JSONObject;
import java.util.HashMap;

@CapacitorPlugin(name = "SurveySparrowPlugin")
public class SurveySparrowPlugin extends Plugin implements OnSsValidateSurveyEventListener, OnSsResponseEventListener {

  public static final int SURVEY_REQUEST_CODE = 1;
  public static final int SURVEY_SCHEDULE_REQUEST_CODE = 2;

  private final String ssDomain = "gokulkrishnaraju1183.surveysparrow.com";
  private final String ssToken = "ntt-eqqU2xscRgWm6AaLULwzNX";
  private final String ssLangCode = "PREFERRED_LANG_CODE";
  private final CustomParam[] params = {
    new CustomParam("emailaddress", "email@surveysparrow.com"),
    new CustomParam("email", "email@surveysparrow.com"),
    new CustomParam("url", "a"),
  };
  private final Boolean closeButtonEnabled = true;
  private SurveySparrow surveySparrow;

  // Method to initialize the survey
  private void initializeSurvey() {
    HashMap properties = new HashMap<String, String>();
    properties.put("langCode", ssLangCode);
    properties.put("isCloseButtonEnabled", closeButtonEnabled);

    SsSurvey survey = new SsSurvey(ssDomain, ssToken, params, properties);
    surveySparrow = new SurveySparrow(this.getActivity(), survey)
      .enableBackButton(true)
      .setWaitTime(2000);
  }


  @PluginMethod
  public void loadEmbeddedSurvey(PluginCall call) {
    // Extract optional parameters from the plugin call if provided
    String domain = call.getString("domain", ssDomain);
    String token = call.getString("token", ssToken);
    String langCode = call.getString("langCode", ssLangCode);

    HashMap<String, String> properties = new HashMap<>();
    properties.put("langCode", langCode);
    properties.put("isCloseButtonEnabled", String.valueOf(closeButtonEnabled));

    // Create a SsSurvey object with domain, token, and custom parameters
    SsSurvey survey = null;
    if (domain != null && token != null) {
        survey = new SsSurvey(domain, token, params, properties);
    }

    // Initialize the SsSurveyFragment
    SsSurveyFragment surveyFragment = new SsSurveyFragment();
    surveyFragment.setValidateSurveyListener(this);
    surveyFragment.setSurvey(survey);

    // Get the FragmentManager to handle the fragment transaction
    FragmentManager fragmentManager = getActivity().getSupportFragmentManager();
    FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();

    // Replace the current fragment in the surveyContainer with the SsSurveyFragment
    fragmentTransaction.replace(R.id.surveyContainer, surveyFragment);
    fragmentTransaction.commit();

    // Resolve the plugin call
    call.resolve();
  }

  // Method to load the survey (fullscreen)
  @PluginMethod
  public void loadFullScreenSurvey(PluginCall call) {
    if (surveySparrow == null) {
      initializeSurvey();
    }

    surveySparrow.startSurveyForResult(SURVEY_REQUEST_CODE);
    call.resolve();
  }

  // Method to load the survey with validation
  @PluginMethod
  public void loadFullScreenSurveyWithValidation(PluginCall call) {
    if (surveySparrow == null) {
      initializeSurvey();
    }

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
