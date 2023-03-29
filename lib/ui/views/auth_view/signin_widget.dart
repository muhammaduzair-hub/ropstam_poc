import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/strings.dart';
import '../../../viewmodels/views/signin_signup_view_model.dart';
import '../../shared/app_colors.dart';
import '../../shared/text_styles.dart';
import '../../shared/ui_helpers.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';
import '../base_widget.dart';

class SignIn extends StatelessWidget {
  BuildContext context;
  Size size;
  PageController _pageController;
  SignIn(this.context, this.size, this._pageController, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SignInSignUpViewModel>(
      model: SignInSignUpViewModel(repo: Provider.of(context)),
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            shadowColor: Colors.transparent,
            title: Text(labelSignIn,
                style: boldHeading1.copyWith(color: onPrimaryColor)),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
              child: SizedBox(
            height: size.height - 120,
            width: double.infinity,
            child: Padding(
              padding: UIHelper.pagePaddingSmall.copyWith(bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  const Text(LabelEmail, style: boldHeading3),
                  UIHelper.verticalSpaceSmall,
                  CustomTextField(
                    controller: model.emailController,
                  ),
                  if (model.emailState == false)
                    Text(
                      labelEmailError,
                      style: const TextStyle(color: errorMessage),
                    ),
                  UIHelper.verticalSpaceMedium,
                  const Text(LabelPassword, style: boldHeading3),
                  UIHelper.verticalSpaceSmall,
                  CustomTextField(
                    controller: model.passwordController,
                    showPassword: true,
                    inputAction: TextInputAction.done,
                  ),
                  if (model.passState == false)
                    Text(
                      labelPasswordE,
                      style: TextStyle(color: errorMessage),
                    ),
                  UIHelper.verticalSpaceLarge,
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: model.busy
                        ? const Center(child: CircularProgressIndicator())
                        : PrimaryButton(
                            text: const Text(
                              labelSignIn,
                              style: buttonTextStyle,
                            ),
                            ontap: () {
                              model.btnSigninClick(context);
                            },
                          ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(LabelDontHaveAccount,
                          style: heading2.copyWith(color: onPrimaryColor2)),
                      InkWell(
                        onTap: () =>
                            model.btnCreateNewAccountClick(_pageController),
                        child: Text(
                          LabelSignup,
                          style: heading2.copyWith(color: secondaryColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
