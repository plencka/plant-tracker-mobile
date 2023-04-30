import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:plant_tracker/providers/auth.dart';

class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _auth = ref.watch(authenticationProvider);
    final isLoading = ref.watch(loginLoadingProvider);

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(
              image: AssetImage('assets/icons/logo.png'),
              width: 150,
            ),
            Text(
              AppLocalizations.of(context)!.signIn,
            ),
            const SizedBox(height: 10),
            isLoading
                ? CircularProgressIndicator()
                : SocialLoginButton(
                    buttonType: SocialLoginButtonType.google,
                    text:
                        AppLocalizations.of(context)!.signInProvider("Google"),
                    onPressed: () async {
                      ref.read(loginLoadingProvider.state).state = true;
                      await _auth.signInWithGoogle();
                      ref.read(loginLoadingProvider.state).state = false;
                    },
                  ),
          ],
        ),
      ),
    ));
  }
}

final loginLoadingProvider = StateProvider<bool>((ref) => false);