import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:transisi/api/create_employee_api_listener.dart';
import 'package:transisi/api/create_employee_api_services.dart';
import 'package:transisi/componets/custom_dialog_information.dart';
import 'package:transisi/componets/custom_dialog_question.dart';
import 'package:transisi/componets/custom_loader.dart';
import 'package:transisi/helper/constants.dart';
import 'package:transisi/helper/my_helper.dart';
import 'package:transisi/helper/screen.dart';

class CreateEmployeePage extends StatefulWidget {
  const CreateEmployeePage({Key? key}) : super(key: key);

  @override
  _CreateEmployeePageState createState() => _CreateEmployeePageState();
}

class _CreateEmployeePageState extends State<CreateEmployeePage>
    implements CreateEmployeeApiListener {
  late Screen size;
  File? imageFile;

  TextEditingController inputName = TextEditingController();
  bool validateName = true;
  late String msgName;

  TextEditingController inputJob = TextEditingController();
  bool validateJob = true;
  late String msgJob;

  TextEditingController inputPhonenumber = TextEditingController();
  bool validatePhonenumber = true;
  late String msgPhonenumber;

  TextEditingController inputEmail = TextEditingController();
  bool validateEmail = true;
  late String msgEmail;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  selectImageFrom(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(
                MdiIcons.camera,
                color: Colors.grey[700],
                size: size.getWidthPx(25),
              ),
              title: Text(
                'Kamera',
                style: TextStyle(
                  fontSize: size.getWidthPx(12),
                ),
              ),
              onTap: () async {
                Navigator.pop(context);
                getFromCamera();
              },
            ),
            ListTile(
              leading: Icon(
                MdiIcons.fileImage,
                color: Colors.grey[700],
                size: size.getWidthPx(25),
              ),
              title: Text(
                'Gallery',
                style: TextStyle(
                  fontSize: size.getWidthPx(12),
                ),
              ),
              onTap: () async {
                Navigator.pop(context);
                getFromGallery();
              },
            ),
          ],
        );
      },
    );
  }

  getFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 720,
      maxHeight: 720,
      imageQuality: 50,
    );
    cropImage(pickedFile!.path);
  }

  getFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 720,
      maxHeight: 720,
      imageQuality: 50,
    );
    cropImage(pickedFile!.path);
  }

  cropImage(filePath) async {
    File? croppedImage = await ImageCropper.cropImage(
      sourcePath: filePath,
      maxWidth: size.wp(100).toInt(),
      maxHeight: size.wp(100).toInt(),
      compressQuality: 50,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    imageFile = croppedImage;
    setState(() {});
  }

  validationFormInput(
    String name,
    String job,
    String phonenumber,
    String email,
  ) {
    if (name.isEmpty) {
      validateName = false;
      msgName = "Nama lengkap tidak boleh kosong";
    } else {
      validateName = true;
      msgName = "";
    }

    if (job.isEmpty) {
      validateJob = false;
      msgJob = "Jabatan tidak boleh kosong";
    } else {
      validateJob = true;
      msgJob = "";
    }

    if (phonenumber.isEmpty) {
      validatePhonenumber = false;
      msgPhonenumber = "Nomor handphone tidak boleh kosong";
    } else {
      validatePhonenumber = true;
      msgPhonenumber = "";
    }

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

    setState(() {});
    if (validateName && validateJob && validatePhonenumber && validateEmail) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D47A1),
        title: const Text("Tambah Karyawan"),
      ),
      body: Container(
        color: Constants.BACKGROUND_COLOR,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            renderInputAvatar(),
            renderInputName(),
            renderInputJob(),
            renderInputPhonenumber(),
            renderInputEmail(),
            renderButtonSave(),
          ],
        ),
      ),
    );
  }

  renderInputAvatar() {
    return InkWell(
      onTap: () {
        selectImageFrom(context);
      },
      child: Container(
        margin: EdgeInsets.only(top: size.getWidthPx(24)),
        alignment: Alignment.center,
        width: size.getWidthPx(110),
        height: size.getWidthPx(110),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF0D47A1),
        ),
        child: ClipOval(
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (imageFile != null)
                Image.file(
                  imageFile!,
                  fit: BoxFit.cover,
                ),
              Container(
                width: size.getWidthPx(110),
                height: size.getWidthPx(110),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(0.5),
                ),
                child: Icon(
                  Icons.camera_alt_rounded,
                  size: size.getWidthPx(24),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  renderInputName() {
    return Container(
      margin: EdgeInsets.only(top: size.getWidthPx(24)),
      padding: EdgeInsets.symmetric(
        horizontal: size.getWidthPx(24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: size.getWidthPx(10)),
            child: Icon(
              Icons.account_circle,
              color: const Color(0xFF0D47A1),
              size: size.getWidthPx(24),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Flexible(
            child: SizedBox(
              width: double.infinity,
              child: TextField(
                controller: inputName,
                cursorColor: const Color(0xFF0D47A1),
                style: TextStyle(
                  fontSize: size.getWidthPx(15),
                  color: const Color(0xFF0D47A1),
                ),
                autofocus: false,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(
                    0.0,
                    0.0,
                    10.0,
                    0.0,
                  ),
                  errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF0D47A1)),
                  ),
                  labelText: "Nama Lengkap",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: size.getWidthPx(14),
                  ),
                  floatingLabelStyle: TextStyle(
                    color: const Color(0xFF0D47A1),
                    fontWeight: FontWeight.bold,
                    fontSize: size.getWidthPx(14),
                  ),
                  errorText: !validateName ? msgName : null,
                  errorStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontStyle: FontStyle.italic,
                    fontSize: size.getWidthPx(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  renderInputJob() {
    return Container(
      margin: EdgeInsets.only(top: size.getWidthPx(24)),
      padding: EdgeInsets.symmetric(
        horizontal: size.getWidthPx(24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: size.getWidthPx(10)),
            child: Icon(
              Icons.work_rounded,
              color: const Color(0xFF0D47A1),
              size: size.getWidthPx(24),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Flexible(
            child: SizedBox(
              width: double.infinity,
              child: TextField(
                controller: inputJob,
                cursorColor: const Color(0xFF0D47A1),
                style: TextStyle(
                  fontSize: size.getWidthPx(15),
                  color: const Color(0xFF0D47A1),
                ),
                autofocus: false,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(
                    0.0,
                    0.0,
                    10.0,
                    0.0,
                  ),
                  errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF0D47A1)),
                  ),
                  labelText: "Jabatan",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: size.getWidthPx(14),
                  ),
                  floatingLabelStyle: TextStyle(
                    color: const Color(0xFF0D47A1),
                    fontWeight: FontWeight.bold,
                    fontSize: size.getWidthPx(14),
                  ),
                  errorText: !validateJob ? msgJob : null,
                  errorStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontStyle: FontStyle.italic,
                    fontSize: size.getWidthPx(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  renderInputPhonenumber() {
    return Container(
      margin: EdgeInsets.only(top: size.getWidthPx(24)),
      padding: EdgeInsets.symmetric(
        horizontal: size.getWidthPx(24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: size.getWidthPx(10)),
            child: Icon(
              Icons.phone_android_rounded,
              color: const Color(0xFF0D47A1),
              size: size.getWidthPx(24),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Flexible(
            child: SizedBox(
              width: double.infinity,
              child: TextField(
                controller: inputPhonenumber,
                cursorColor: const Color(0xFF0D47A1),
                style: TextStyle(
                  fontSize: size.getWidthPx(15),
                  color: const Color(0xFF0D47A1),
                ),
                autofocus: false,
                keyboardType: TextInputType.phone,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(
                    0.0,
                    0.0,
                    10.0,
                    0.0,
                  ),
                  errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF0D47A1)),
                  ),
                  labelText: "Nomor Handphone",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: size.getWidthPx(14),
                  ),
                  floatingLabelStyle: TextStyle(
                    color: const Color(0xFF0D47A1),
                    fontWeight: FontWeight.bold,
                    fontSize: size.getWidthPx(14),
                  ),
                  errorText: !validatePhonenumber ? msgPhonenumber : null,
                  errorStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontStyle: FontStyle.italic,
                    fontSize: size.getWidthPx(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  renderInputEmail() {
    return Container(
      margin: EdgeInsets.only(top: size.getWidthPx(24)),
      padding: EdgeInsets.symmetric(
        horizontal: size.getWidthPx(24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: size.getWidthPx(10)),
            child: Icon(
              Icons.email,
              color: const Color(0xFF0D47A1),
              size: size.getWidthPx(24),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Flexible(
            child: SizedBox(
              width: double.infinity,
              child: TextField(
                controller: inputEmail,
                cursorColor: const Color(0xFF0D47A1),
                style: TextStyle(
                  fontSize: size.getWidthPx(15),
                  color: const Color(0xFF0D47A1),
                ),
                autofocus: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(
                    0.0,
                    0.0,
                    10.0,
                    0.0,
                  ),
                  errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF0D47A1)),
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: size.getWidthPx(14),
                  ),
                  floatingLabelStyle: TextStyle(
                    color: const Color(0xFF0D47A1),
                    fontWeight: FontWeight.bold,
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
            ),
          ),
        ],
      ),
    );
  }

  renderButtonSave() {
    return Container(
      margin: EdgeInsets.only(
        top: size.getWidthPx(32),
        bottom: size.getWidthPx(32),
        left: size.getWidthPx(24),
        right: size.getWidthPx(24),
      ),
      child: ElevatedButton(
        onPressed: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          String name = inputName.text.toString().trim();
          String job = inputJob.text.toString().trim();
          String phonenumber = inputPhonenumber.text.toString().trim();
          String email = inputEmail.text.toString().trim();
          bool validate = await validationFormInput(
            name,
            job,
            phonenumber,
            email,
          );
          if (validate) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return CustomDialogQuestion(
                  title: "",
                  onTapOke: () async {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const CustomLoader();
                      },
                    );
                    CreateEmployeeApiServices(this).postCreateEmployee(
                      imageFile!.path,
                      name,
                      job,
                      phonenumber,
                      email,
                    );
                  },
                  desc: "Apakahan Anda yakin ingin menambah data karyawan ?",
                );
              },
            );
          }
        },
        child: Text(
          "Simpan",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: size.getWidthPx(14),
          ),
        ),
        style: ElevatedButton.styleFrom(
          fixedSize: Size(double.infinity, size.getWidthPx(40)),
          primary: Colors.blue[900],
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
  onCreateEmployeeFailure(response, statusCode) async {
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
  onCreateEmployeeSuccess(response, statusCode) async {
    Navigator.of(context, rootNavigator: true).pop(true);
    inputName.clear();
    inputEmail.clear();
    inputJob.clear();
    inputPhonenumber.clear();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CustomDialogInformation(
        title: "$statusCode",
        desc: "Tambah data karyawan berhasil!",
        color: Colors.green,
        icon: Icons.check_circle_outline,
        onTap: () {
          Navigator.pop(context);
        },
      ),
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
