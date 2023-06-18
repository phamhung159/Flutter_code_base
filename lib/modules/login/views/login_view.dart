import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ionmobile/constants/theme_provider.dart';
import 'package:ionmobile/modules/widgets/ion_button.dart';
import 'package:ionmobile/modules/widgets/ion_text_field.dart';
import 'package:ionmobile/modules/widgets/utils.dart';

import '../../../constants/R.dart';
import '../../widgets/ion_phone_field.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: ThemeProvider.bgScreen,
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _buildContent(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() => IonButton(
                        onPressed: () {
                          controller.login();
                        },
                        title: 'login'.tr,
                        styleButton: IonButtonStyle.fill,
                        isDisable:
                            controller.isDisableButton.value ? true : false,
                      )),
                  SizedBox(height: 16),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              R.ionLogoMobile,
              width: 180,
            )).paddingOnly(top: 68),
        SizedBox(
          height: 40,
        ),
        Obx(() => controller.isLoginByPhone.value
            ? _buildPhoneTextField()
            : _buildEmailTextField()),
        SizedBox(height: 12),
        _buildTextSwitch(),
      ],
    );
  }

  Widget _buildPhoneTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'mobile_number'.tr,
          style: TextStyle(
              fontFamily: ThemeProvider.fontRegular,
              fontSize: ThemeProvider.fontSize16),
        ),
        SizedBox(height: 8),
        Container(
            child: Obx(
          () => IonPhoneField(
            focusNode: controller.focusNodeTextField,
            textEditingController: controller.textcontroller,
            isValidate: controller.isValidate.value,
            onChanged: (value) {
              controller.isValidate.value = true;
              controller.isDisableButton.value =
                  controller.textcontroller.text.isEmpty;
            },
          ),
        ))
      ],
    );
  }

  Widget _buildEmailTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'email'.tr,
          style: TextStyle(
              fontFamily: ThemeProvider.fontRegular,
              fontSize: ThemeProvider.fontSize16),
        ),
        SizedBox(height: 8),
        Container(
          child: Obx(
            () => IonTextField(
              focusNode: controller.focusNodeTextField,
              textEditingController: controller.textcontroller,
              inputDecoration: inputDecorationTextField(
                  hintText: 'example@gmail.com',
                  contentPadding: EdgeInsets.only(left: 16),
                  isValidate: controller.isValidate.value,
                  focusNode: controller.focusNodeTextField,
                  textEditingController: controller.textcontroller),
              onChanged: (value) {
                controller.isValidate.value = true;
                controller.isDisableButton.value =
                    controller.textcontroller.text.isEmpty;
              },
              keyboardType: TextInputType.emailAddress,
            ),
          ),
        ),
      ],
    );
  }

  Align _buildTextSwitch() {
    return Align(
      alignment: Alignment.topRight,
      child: Obx(() => controller.isLoginByPhone.value
          ? RichText(
              text: TextSpan(
                  text: 'switch_to'.tr + ' ',
                  style: TextStyle(
                      fontFamily: ThemeProvider.fontRegular,
                      fontSize: ThemeProvider.fontSize16),
                  children: [
                    TextSpan(
                      text: 'mobile?'.tr,
                      style: TextStyle(
                          fontFamily: ThemeProvider.fontBold,
                          fontSize: ThemeProvider.fontSize16),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          controller.changeTypeLogin();
                        },
                    )
                  ]),
            )
          : RichText(
              text: TextSpan(
                  text: 'switch_to'.tr + ' ',
                  style: TextStyle(
                      fontFamily: ThemeProvider.fontRegular,
                      fontSize: ThemeProvider.fontSize16),
                  children: [
                    TextSpan(
                      text: 'email?'.tr,
                      style: TextStyle(
                          fontFamily: ThemeProvider.fontBold,
                          fontSize: ThemeProvider.fontSize16),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          controller.changeTypeLogin();
                        },
                    )
                  ]),
            )),
    );
  }
}
