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

Widget signUp(BuildContext context, Size size, PageController _pageController) {
  return BaseWidget<SignInSignUpViewModel>(
    model: SignInSignUpViewModel(repo: Provider.of(context)),
    builder: (context, model, child) => SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          shadowColor: Colors.transparent,
          title: Text(LabelSignup,
              style: boldHeading1.copyWith(color: onPrimaryColor)),
          centerTitle: true,
        ),
        body: Form(
          child: SingleChildScrollView(
              child: SizedBox(
            height: size.height - 120,
            width: double.infinity,
            child: Padding(
              padding: UIHelper.pagePaddingSmall.copyWith(bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Text(LabelName, style: boldHeading3),
                  UIHelper.verticalSpaceSmall,
                  CustomTextField(
                    controller: model.nameController,
                    keyboardType: TextInputType.name,
                  ),
                  if (model.nameState == false)
                    Text(
                      LabelName,
                      style: TextStyle(color: errorMessage),
                    ),
                  UIHelper.verticalSpaceMedium,
                  const Text(LabelEmail, style: boldHeading3),
                  UIHelper.verticalSpaceSmall,
                  CustomTextField(
                    controller: model.emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  if (model.duplicateEmail)
                    const Text(
                      LabelEmailAlreadyExist,
                      style: TextStyle(color: errorMessage),
                    )
                  else if (model.emailState == false)
                    Text(
                      labelEmailError,
                      style: const TextStyle(color: errorMessage),
                    ),
                  UIHelper.verticalSpaceMedium,
                  const Text(LabelMobile, style: boldHeading3),
                  UIHelper.verticalSpaceSmall,
                  CustomTextField(
                    controller: model.numberController,
                    keyboardType: TextInputType.number,
                  ),
                  if (model.duplicatePhone)
                    const Text(LabelPhoneAlreadyExist,
                        style: TextStyle(color: errorMessage))
                  else if (model.phoneState == false)
                    Text(
                      labelPhoneNoError,
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
                      labelPasswordError,
                      style: const TextStyle(color: errorMessage),
                    ),
                  UIHelper.verticalSpaceMedium,
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: model.busy
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : PrimaryButton(
                            text: const Text(
                              LabelSignup,
                              style: buttonTextStyle,
                            ),
                            ontap: () async {
                              model.btnSignupClick(context);
                            },
                          ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(LabelAlreadyHaveAccount,
                          style: heading3.copyWith(color: onPrimaryColor2)),
                      InkWell(
                        onTap: () =>
                            model.btnAlreadyHaveAnAccountClick(_pageController),
                        child: Text(
                          labelSignIn,
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
    ),
  );
}
