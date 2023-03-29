import 'package:flutter/material.dart';
import 'package:ropstam_poc/constants/strings.dart';
import 'package:ropstam_poc/ui/shared/ui_helpers.dart';
import 'package:ropstam_poc/ui/views/base_widget.dart';
import 'package:ropstam_poc/viewmodels/views/home_viewmodel.dart';

import '../../shared/app_colors.dart';
import '../../shared/text_styles.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';

class AddEditCar extends StatelessWidget {
  int? selectedIndex;
  final HomeViewModel homeViewModelmodel;
  AddEditCar({Key? key, required this.homeViewModelmodel, this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
      model: homeViewModelmodel,
      onModelReady: (p0) {
        if (selectedIndex != null) {
          p0.getSelectedItemInfo(selectedIndex!);
        }
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: model.selectedIndexForUpdate == null
                ? Text(labelAddCar)
                : Text(labelUpdateCar),
          ),
          body: Form(
            child: SingleChildScrollView(
                child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Padding(
                padding: UIHelper.pagePaddingSmall.copyWith(bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UIHelper.verticalSpaceSmall,
                    DropdownButtonFormField<String>(
                      value: model.selectedCategory,
                      onChanged: (newValue) {
                        model.selectedCategory = newValue!;
                        model.setBusy(false);
                      },
                      items: model.categories
                          .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              ))
                          .toList(),
                      decoration: InputDecoration(
                        labelText: labelCatagory,
                      ),
                    ),
                    UIHelper.verticalSpaceMedium,
                    const Text(labelTitle, style: boldHeading3),
                    UIHelper.verticalSpaceSmall,
                    CustomTextField(
                      controller: model.titleController,
                    ),
                    if (model.titleState)
                      Text(
                        labelTitleError,
                        style: TextStyle(color: errorMessage),
                      ),
                    UIHelper.verticalSpaceMedium,
                    const Text(labelModel, style: boldHeading3),
                    UIHelper.verticalSpaceSmall,
                    CustomTextField(
                      controller: model.modelController,
                    ),
                    if (model.modelState)
                      Text(
                        labelModelError,
                        style: TextStyle(color: errorMessage),
                      ),
                    UIHelper.verticalSpaceMedium,
                    const Text(labelRegNo, style: boldHeading3),
                    UIHelper.verticalSpaceSmall,
                    CustomTextField(
                      readOnly:
                          model.selectedIndexForUpdate != null ? true : false,
                      controller: model.registrationNoController,
                    ),
                    if (model.regState)
                      Text(
                        labelRegNoError,
                        style: TextStyle(color: errorMessage),
                      ),
                    UIHelper.verticalSpaceMedium,
                    const Text(labelColor, style: boldHeading3),
                    UIHelper.verticalSpaceSmall,
                    CustomTextField(
                      controller: model.colorController,
                    ),
                    if (model.colorState)
                      Text(
                        labelColorError,
                        style: TextStyle(color: errorMessage),
                      ),
                    UIHelper.verticalSpaceLarge,
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: model.busy
                          ? const Center(child: CircularProgressIndicator())
                          : PrimaryButton(
                              text: Text(
                                model.selectedIndexForUpdate == null
                                    ? labelAddCar
                                    : labelUpdateCar,
                                style: buttonTextStyle,
                              ),
                              ontap: () {
                                model.selectedIndexForUpdate == null
                                    ? model.addCar(context)
                                    : model.updateCar(context);
                              },
                            ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              ),
            )),
          ),
        );
      },
    );
  }
}
