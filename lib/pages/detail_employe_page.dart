import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:transisi/helper/constants.dart';
import 'package:transisi/helper/screen.dart';

class DetailEmployePage extends StatefulWidget {
  final dynamic employeeData;
  const DetailEmployePage({Key? key, required this.employeeData})
      : super(key: key);

  @override
  DetailEmployePageState createState() => DetailEmployePageState();
}

class DetailEmployePageState extends State<DetailEmployePage> {
  late Screen size;
  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    return Scaffold(
      body: Container(
        color: Constants.BACKGROUND_COLOR,
        child: Column(
          children: [
            Container(
              color: Colors.blue[900],
              width: size.wp(100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: size.getWidthPx(24),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: size.getWidthPx(100),
                    height: size.getWidthPx(100),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        imageUrl: widget.employeeData['avatar'],
                        filterQuality: FilterQuality.low,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: size.getWidthPx(10),
                                width: size.getWidthPx(10),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Color(0xFF0D47A1),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        errorWidget: (context, url, error) => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.red,
                            ),
                            Text(
                              "Gagal memuat gambar",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: size.getWidthPx(8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: size.getWidthPx(24),
                      bottom: size.getWidthPx(24),
                    ),
                    child: Text(
                      "${widget.employeeData['first_name']} ${widget.employeeData['last_name']}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: size.getWidthPx(18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              margin: EdgeInsets.only(
                top: size.getWidthPx(16),
                left: size.getWidthPx(8),
                right: size.getWidthPx(8),
              ),
              child: SizedBox(
                width: size.wp(100),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(size.getWidthPx(24)),
                      child: Icon(
                        MdiIcons.phone,
                        size: size.getWidthPx(24),
                        color: Colors.blue[900],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "+62 9302 8849 989",
                            style: TextStyle(
                              fontSize: size.getWidthPx(16),
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Telefone",
                            style: TextStyle(
                              fontSize: size.getWidthPx(12),
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(size.getWidthPx(24)),
                      child: Icon(
                        MdiIcons.messageText,
                        size: size.getWidthPx(24),
                        color: Colors.blue[900],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              margin: EdgeInsets.only(
                top: size.getWidthPx(16),
                left: size.getWidthPx(8),
                right: size.getWidthPx(8),
              ),
              child: SizedBox(
                width: size.wp(100),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(size.getWidthPx(24)),
                      child: Icon(
                        MdiIcons.email,
                        size: size.getWidthPx(24),
                        color: Colors.blue[900],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.employeeData['email'],
                            style: TextStyle(
                              fontSize: size.getWidthPx(16),
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "E-mail",
                            style: TextStyle(
                              fontSize: size.getWidthPx(12),
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              margin: EdgeInsets.only(
                top: size.getWidthPx(16),
                left: size.getWidthPx(8),
                right: size.getWidthPx(8),
              ),
              child: SizedBox(
                width: size.wp(100),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(size.getWidthPx(24)),
                      child: Icon(
                        MdiIcons.shareVariant,
                        size: size.getWidthPx(24),
                        color: Colors.blue[900],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Enviar Contato",
                            style: TextStyle(
                              fontSize: size.getWidthPx(16),
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Compartilhar",
                            style: TextStyle(
                              fontSize: size.getWidthPx(12),
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
