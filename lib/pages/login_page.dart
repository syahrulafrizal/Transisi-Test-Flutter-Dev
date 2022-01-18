import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transisi/api/login_api_listener.dart';
import 'package:transisi/api/login_api_services.dart';
import 'package:transisi/componets/CustomDialogInformation.dart';
import 'package:transisi/componets/CustomLoader.dart';
import 'package:transisi/helper/constants.dart';
import 'package:transisi/helper/screen.dart';
import 'package:transisi/helper/my_helper.dart';
import 'package:transisi/pages/list_employee_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginApiListener {
  late Screen size;
  late BuildContext mContext;

  TextEditingController inputEmail = TextEditingController();
  bool validateEmail = true;
  late String msgEmail;

  TextEditingController inputPassword = TextEditingController();
  bool validatePassword = true, showPassword = false;
  late String msgPassword;

  @override
  void initState() {
    super.initState();
    MyHelpers.setStatusBar();
    if (kDebugMode) {
      inputEmail.value = const TextEditingValue(text: "eve.holt@reqres.in");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void toggleShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  validationFormInput(String email, String password) {
    if (email.isEmpty) {
      validateEmail = false;
      msgEmail = "Email tidak boleh kosong";
    } else {
      if (!MyHelpers.validateEmail(email)) {
        validateEmail = false;
        msgEmail = "Email tidak valid";
      } else {
        validateEmail = true;
        msgEmail = "";
      }
    }

    if (password.isEmpty) {
      validatePassword = false;
      msgPassword = "Password tidak boleh kosong";
    } else {
      validatePassword = true;
      msgPassword = "";
    }
    setState(() {});
    if (validateEmail && validatePassword) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    return Scaffold(
      backgroundColor: Constants.BACKGROUND_COLOR,
      body: Builder(
        builder: (BuildContext buildContext) {
          mContext = buildContext;
          return Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + size.getWidthPx(24),
            ),
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                renderHeader(),
                renderInputEmail(),
                renderInputPassword(),
                renderButtonLogin(),
              ],
            ),
          );
        },
      ),
    );
  }

  renderHeader() {
    return Container(
      height: size.hp(8),
      padding: EdgeInsets.symmetric(
        horizontal: size.getWidthPx(24),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        "Login ke Akunmu",
        textAlign: TextAlign.left,
        style: TextStyle(
          color: const Color(0xFF000000),
          fontWeight: FontWeight.bold,
          fontSize: size.getWidthPx(22),
        ),
      ),
    );
  }

  renderInputEmail() {
    return Container(
      margin: EdgeInsets.only(top: size.getWidthPx(24)),
      padding: EdgeInsets.symmetric(
        horizontal: size.getWidthPx(24),
      ),
      child: TextField(
        controller: inputEmail,
        cursorColor: const Color(0xFF575757),
        style: TextStyle(
          fontSize: size.getWidthPx(14),
          color: const Color(0xFF575757),
        ),
        autofocus: false,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "Masukan email Anda",
          hintStyle: TextStyle(
            fontSize: size.getWidthPx(12),
            color: const Color(0xFFD0D0D0),
          ),
          contentPadding: const EdgeInsets.fromLTRB(
            0.0,
            0.0,
            0.0,
            0.0,
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFC4C4C4)),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFC4C4C4)),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFC4C4C4)),
          ),
          labelText: "Email",
          labelStyle: TextStyle(
            color: const Color(0xFF575757),
            fontSize: size.getWidthPx(14),
          ),
          floatingLabelStyle: TextStyle(
            color: const Color(0xFF575757),
            fontWeight: FontWeight.w800,
            fontSize: size.getWidthPx(14),
          ),
          errorText: !validateEmail ? msgEmail : null,
          errorStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
            fontStyle: FontStyle.italic,
            fontSize: size.getWidthPx(10),
          ),
        ),
      ),
    );
  }

  renderInputPassword() {
    return Container(
      margin: EdgeInsets.only(top: size.getWidthPx(24)),
      padding: EdgeInsets.symmetric(
        horizontal: size.getWidthPx(24),
      ),
      child: TextField(
        obscureText: !showPassword,
        controller: inputPassword,
        cursorColor: const Color(0xFF575757),
        style: TextStyle(
          fontSize: size.getWidthPx(14),
          color: const Color(0xFF575757),
        ),
        autofocus: false,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: "Masukan password Anda",
          hintStyle: TextStyle(
            fontSize: size.getWidthPx(12),
            color: const Color(0xFFD0D0D0),
          ),
          contentPadding: const EdgeInsets.fromLTRB(
            0.0,
            0.0,
            0.0,
            0.0,
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFC4C4C4)),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFC4C4C4)),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFC4C4C4)),
          ),
          labelText: "Password",
          labelStyle: TextStyle(
            color: const Color(0xFF575757),
            fontSize: size.getWidthPx(14),
          ),
          floatingLabelStyle: TextStyle(
            color: const Color(0xFF575757),
            fontWeight: FontWeight.w800,
            fontSize: size.getWidthPx(14),
          ),
          errorText: !validatePassword ? msgPassword : null,
          errorStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
            fontStyle: FontStyle.italic,
            fontSize: size.getWidthPx(10),
          ),
          suffixIcon: InkWell(
            onTap: () {
              toggleShowPassword();
            },
            child: Icon(
              showPassword ? Icons.visibility_off : Icons.visibility,
              color: const Color(0xFFC4C4C4),
            ),
          ),
        ),
      ),
    );
  }

  renderButtonLogin() {
    return Container(
      margin: EdgeInsets.only(
        top: size.getWidthPx(64),
        left: size.getWidthPx(24),
        right: size.getWidthPx(24),
      ),
      child: ElevatedButton(
        onPressed: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          String emailValue = inputEmail.text.toString().trim();
          String passwordValue = inputPassword.text.toString().trim();
          bool validate = await validationFormInput(emailValue, passwordValue);
          if (validate) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const CustomLoader();
              },
            );
            LoginApiServices(this).postLogin(
              emailValue,
              passwordValue,
            );
          }
        },
        child: Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: size.getWidthPx(12),
          ),
        ),
        style: ElevatedButton.styleFrom(
          fixedSize: Size(double.infinity, size.getWidthPx(40)),
          primary: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(
            vertical: size.getWidthPx(10),
            horizontal: size.getWidthPx(14),
          ),
        ),
      ),
    );
  }

  @override
  onLoginFailure(response, statusCode) async {
    Navigator.of(context, rootNavigator: true).pop(true);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CustomDialogInformation(
        title: "$statusCode",
        desc: "${response['error']}",
        color: Colors.orange,
        icon: Icons.error_outline,
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  onLoginSuccess(response, statusCode) async {
    await MyHelpers.setString(Constants.TOKEN, response['token']);
    Navigator.of(context, rootNavigator: true).pop(true);
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const ListEmployeePage(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  onNoInternetConnection() {
    Navigator.of(context, rootNavigator: true).pop(true);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CustomDialogInformation(
        title: "Failed",
        desc: Constants.NO_CONNECTION,
        color: Colors.orange,
        icon: Icons.error_outline,
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
