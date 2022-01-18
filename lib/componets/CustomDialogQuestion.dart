import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:transisi/helper/screen.dart';

class CustomDialogQuestion extends StatefulWidget {
  final dynamic title, onTapOke, desc;
  const CustomDialogQuestion({
    Key? key,
    @required this.title,
    @required this.onTapOke,
    @required this.desc,
  }) : super(key: key);

  @override
  _CustomDialogQuestionState createState() => _CustomDialogQuestionState();
}

class _CustomDialogQuestionState extends State<CustomDialogQuestion> {
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
                      MdiIcons.helpCircleOutline,
                      color: Colors.orange,
                      size: size.getWidthPx(50),
                    ),
                    SizedBox(
                      height: size.getWidthPx(16),
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
            const SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: SizedBox(
                      width: double.infinity,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: size.getWidthPx(18),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Batal",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: size.getWidthPx(13),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      width: double.infinity,
                      child: InkWell(
                        onTap: widget.onTapOke,
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
                                fontSize: size.getWidthPx(13),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
