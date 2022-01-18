import 'package:flutter/material.dart';
import 'package:transisi/helper/screen.dart';

class CustomDialogInformation extends StatefulWidget {
  final dynamic title, desc, color, icon, onTap;
  const CustomDialogInformation({
    Key? key,
    @required this.title,
    @required this.desc,
    @required this.color,
    @required this.icon,
    @required this.onTap,
  }) : super(key: key);

  @override
  _CustomDialogInformationState createState() =>
      _CustomDialogInformationState();
}

class _CustomDialogInformationState extends State<CustomDialogInformation> {
  late Dialog fancyDialog;
  late Screen size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    fancyDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        width: size.wp(80),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: size.getWidthPx(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      widget.icon,
                      color: widget.color,
                      size: size.getWidthPx(60),
                    ),
                    SizedBox(
                      height: size.getWidthPx(8),
                    ),
                    Text(
                      "${widget.desc}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                        fontSize: size.getWidthPx(13),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.getWidthPx(6),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: widget.onTap,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: size.getWidthPx(18),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Oke",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: size.getWidthPx(14),
                      ),
                    ),
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
      child: fancyDialog,
    );
  }
}
