package io.ionic.starter;

import android.os.Bundle;

import com.getcapacitor.BridgeActivity;


public class MainActivity extends BridgeActivity {

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    registerPlugin(SurveySparrowPlugin.class);
    super.onCreate(savedInstanceState);
  }
}
