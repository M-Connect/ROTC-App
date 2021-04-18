import 'dart:io' show Platform;

/*
Author: Christine Thomas
This class defines and handles the client Ids as defined by the GoogleCalendarAPI
 */
class GCClientCodes {
  static const ANDROID_CLIENT_ID = "99105941087-baorre9r41fkudgglgbtaj42vrbpgsii.apps.googleusercontent.com";
  static const IOS_CLIENT_ID = "99105941087-0in9bebpe9fsp77i0ckimsho1aq8umh8.apps.googleusercontent.com";
  static const WEB_APPLICATION_CLIENT_ID  = "99105941087-v6clikibmpoogm7huaeteqp5v8l1ostl.apps.googleusercontent.com";
  static String getCodes() => Platform.isAndroid ? GCClientCodes.ANDROID_CLIENT_ID : GCClientCodes.IOS_CLIENT_ID;
}