import 'package:flutter/material.dart';
import 'package:transisi/helper/screen.dart';

class CustomLoader extends StatefulWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  _CustomLoaderState createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader> {
  late Dialog loadingDialog;
  late Screen size;
  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    loadingDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        width: size.wp(80),
        padding: EdgeInsets.symmetric(
          vertical: size.getWidthPx(24),
          horizontal: size.getWidthPx(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: size.getWidthPx(35),
              width: size.getWidthPx(35),
              child: const CircularProgressIndicator(
                color: Color(0xFF0D47A1),
              ),
            ),
            SizedBox(
              width: size.getWidthPx(8),
            ),
            Flexible(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: size.getWidthPx(8),
                  vertical: size.getWidthPx(8),
                ),
                child: Text(
                  "Silahkan Tunggu...",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                    fontSize: size.getWidthPx(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return WillPopScope(
      onWillPop: () async => false,
      child: loadingDialog,
    );
  }
}
