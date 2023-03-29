import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ropstam_poc/ui/shared/ui_helpers.dart';
import 'package:ropstam_poc/ui/views/base_widget.dart';
import 'package:ropstam_poc/viewmodels/views/splash_view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SplashViewModel>(
      model: SplashViewModel(repository: Provider.of(context)),
      onModelReady: (model) {
        model.checkAlreadyLogin(context);
      },
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Car Mangement"),
              UIHelper.verticalSpaceLarge,
              CircleAvatar(
                radius: 39,
                backgroundColor: Colors.blue,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
