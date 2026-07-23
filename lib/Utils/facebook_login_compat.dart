import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

/// Compatibility wrapper preserving the old flutter_facebook_login API surface.
class FacebookLogin {
  Future<FacebookLoginResult> logInWithReadPermissions(List<String> permissions) =>
      logIn(permissions);

  Future<FacebookLoginResult> logIn(List<String> permissions) async {
    final result = await FacebookAuth.instance.login(
      permissions: permissions,
    );
    switch (result.status) {
      case LoginStatus.success:
        return FacebookLoginResult(
          FacebookLoginStatus.loggedIn,
          accessToken: FacebookAccessToken(result.accessToken?.tokenString),
        );
      case LoginStatus.cancelled:
        return FacebookLoginResult(FacebookLoginStatus.cancelledByUser);
      case LoginStatus.failed:
      case LoginStatus.operationInProgress:
        return FacebookLoginResult(FacebookLoginStatus.error);
    }
  }
}

enum FacebookLoginStatus { error, cancelledByUser, loggedIn }

class FacebookAccessToken {
  final String? token;
  FacebookAccessToken(this.token);
}

class FacebookLoginResult {
  final FacebookLoginStatus status;
  final FacebookAccessToken? accessToken;
  final String? errorMessage;

  FacebookLoginResult(this.status, {this.accessToken, this.errorMessage});
}
