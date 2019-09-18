package com.example.perfdiagnosisdemo;

import android.content.Intent;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.view.FlutterMain;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.StringCodec;
import io.flutter.plugins.GeneratedPluginRegistrant;

import io.flutter.view.FlutterMain;
import java.util.*;

public class MainActivity extends FlutterActivity {
  private BasicMessageChannel<String> channel;

  // TODO(jacobr): expose this method publicly in Flutter Engine to avoid
  // duplicated code. This method from from FlutterActivityDelegate.java
  // needs to be copied so that the correct value for --start-paused
  // is passed in when debugging the dart app.
  public String[] getArgsFromIntent(Intent intent) {
    // Before adding more entries to this list, consider that arbitrary
    // Android applications can generate intents with extra data and that
    // there are many security-sensitive args in the binary.
    ArrayList<String> args = new ArrayList<>();
    if (intent.getBooleanExtra("trace-startup", false)) {
        args.add("--trace-startup");
    }
    if (intent.getBooleanExtra("start-paused", false)) {
        args.add("--start-paused");
    }
    if (intent.getBooleanExtra("enable-dart-profiling", false)) {
        args.add("--enable-dart-profiling");
    }

    if (!args.isEmpty()) {
        String[] argsArray = new String[args.size()];
        return args.toArray(argsArray);
    }
    return new String[0];
  }

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    ArrayList<String> args = new ArrayList(Arrays.asList(getArgsFromIntent(getIntent())));

    args.add("--dart-flags=--profile_period=344");

    FlutterMain.ensureInitializationComplete(getApplicationContext(), args.toArray(new String[0]));

    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    channel = new BasicMessageChannel<String>(getFlutterView(), "shuttle", StringCodec.INSTANCE);
    channel.setMessageHandler((message, reply) -> {
      try {
        reply.reply("Done!");
        Thread.sleep(2000);
        channel.send("Response from Java");
      } catch(Exception e) {}
    });
  }
}
