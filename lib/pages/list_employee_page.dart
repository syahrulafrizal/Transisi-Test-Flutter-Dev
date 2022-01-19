import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transisi/api/detail_employee_api_listener.dart';
import 'package:transisi/api/detail_employee_api_services.dart';
import 'package:transisi/api/list_employee_api_listener.dart';
import 'package:transisi/api/list_employee_api_services.dart';
import 'package:transisi/componets/custom_dialog_information.dart';
import 'package:transisi/componets/custom_dialog_question.dart';
import 'package:transisi/componets/custom_loader.dart';
import 'package:transisi/helper/constants.dart';
import 'package:transisi/helper/my_helper.dart';
import 'package:transisi/helper/screen.dart';
import 'package:transisi/pages/create_employee_page.dart';
import 'package:transisi/pages/detail_employe_page.dart';

import 'login_page.dart';

class ListEmployeePage extends StatefulWidget {
  const ListEmployeePage({
    Key? key,
  }) : super(key: key);
  @override
  _ListEmployeePageState createState() => _ListEmployeePageState();
}

class _ListEmployeePageState extends State<ListEmployeePage>
    implements ListEmployeeApiListener, DetailEmployeeApiListener {
  late Screen size;
  bool isLoading = true;
  bool isError = false;

  String errorMsg = Constants.ERROR_SERVER;
  String errorType = Constants.ERROR_SERVER_API;
  List responseList = [];
  int page = 1, totalPage = 1;

  @override
  void initState() {
    super.initState();
    MyHelpers.setStatusBar();
    ListEmployeeApiServices(this).getListEmployee(page);
  }

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
  }

  onRefresh() {
    isLoading = true;
    responseList.clear();
    page = 1;
    isError = false;
    ListEmployeeApiServices(this).getListEmployee(page);
    setState(() {});
  }

  onLoadingMore() {
    ListEmployeeApiServices(this).getListEmployee(page);
    setState(() {});
  }

  RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  final GlobalKey key = GlobalKey();
  late Timer timer;
  int start = 2;
  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 1)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Tekan tombol kembali lagi untuk keluar");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D47A1),
        title: const Text("Karyawan"),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return CustomDialogQuestion(
                    title: "",
                    onTapOke: () async {
                      Navigator.pop(context);
                      await MyHelpers.clearAllData();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                    desc: "Apakahan Anda yakin ingin keluar dari aplikasi ?",
                  );
                },
              );
            },
            padding: const EdgeInsets.only(right: 8),
          ),
        ],
      ),
      body: WillPopScope(
        child: Container(
          color: Constants.BACKGROUND_COLOR,
          child: SmartRefresher(
            controller: refreshController,
            onRefresh: onRefresh,
            onLoading: onLoadingMore,
            enablePullDown: !isLoading,
            enablePullUp: (page == totalPage &&
                    isError == false &&
                    isLoading == false &&
                    responseList.isNotEmpty)
                ? true
                : false,
            child: (isLoading)
                ? contentLoading()
                : (isError)
                    ? contentError()
                    : contentSuccess(),
          ),
        ),
        onWillPop: onWillPop,
      ),
      floatingActionButton: renderFAB(),
    );
  }

  contentLoading() {
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      // shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: size.getWidthPx(16),
                  bottom: size.getWidthPx(16),
                  left: size.getWidthPx(16),
                  right: size.getWidthPx(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: size.getWidthPx(45),
                      height: size.getWidthPx(45),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(100.0),
                        ),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: size.getWidthPx(14),
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: size.getWidthPx(10),
                            width: size.wp(70),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: size.getWidthPx(10),
                            width: size.wp(50),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          baseColor: Colors.grey.shade400,
          highlightColor: Colors.grey.shade200,
        );
      },
      itemCount: 10,
      separatorBuilder: (BuildContext context, int index) {
        return MyHelpers.renderDivider();
      },
    );
  }

  contentError() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          (errorType == Constants.ERROR_SERVER_API)
              ? 'assets/respons-error.png'
              : 'assets/no-connection.png',
          width: size.getWidthPx(150),
          height: size.getWidthPx(150),
          fit: BoxFit.fill,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Center(
            child: Text(
              errorMsg,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: size.getWidthPx(14),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            onRefresh();
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue[900],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(100.0),
            ),
            margin: EdgeInsets.symmetric(horizontal: size.getWidthPx(64)),
            padding: EdgeInsets.symmetric(
              vertical: size.getWidthPx(12),
              horizontal: size.getWidthPx(14),
            ),
            child: Text(
              "Coba Lagi",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: size.getWidthPx(14),
              ),
            ),
          ),
        ),
      ],
    );
  }

  contentSuccess() {
    if (responseList.isNotEmpty) {
      return listData();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/data-not-found.png",
            width: size.getWidthPx(150),
            height: size.getWidthPx(150),
            fit: BoxFit.fill,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Center(
              child: Text(
                "Tidak ada data",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: size.getWidthPx(14),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  listData() {
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      // shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        dynamic item = responseList[index];
        return itemData(item, index);
      },
      itemCount: responseList.length,
      separatorBuilder: (BuildContext context, int index) {
        return MyHelpers.renderDivider();
      },
    );
  }

  itemData(item, index) {
    return InkWell(
      onTap: () async {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const CustomLoader();
          },
        );
        DetailEmployeeApiServices(this).getDetailEmployee(item['id']);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: size.getWidthPx(16),
              bottom: size.getWidthPx(16),
              left: size.getWidthPx(16),
              right: size.getWidthPx(16),
            ),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: size.getWidthPx(45),
                  height: size.getWidthPx(45),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      imageUrl: item['avatar'],
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
                                  strokeWidth: 2,
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
                SizedBox(
                  width: size.getWidthPx(14),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item['first_name']} ${item['last_name']}",
                        style: TextStyle(
                          fontSize: size.getWidthPx(16),
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "${item['email']}",
                        style: TextStyle(
                          fontSize: size.getWidthPx(12),
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  renderFAB() {
    return Visibility(
      visible: !isLoading,
      child: FloatingActionButton(
        backgroundColor: const Color(0xFF0D47A1),
        onPressed: () {
          Navigator.of(context).push(
            MyHelpers.createRouting(
              const CreateEmployeePage(),
            ),
          );
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  onListEmployeeFailure(response, statusCode) async {
    refreshController.refreshCompleted();
    refreshController.loadComplete();
    isLoading = false;
  }

  @override
  onListEmployeeSuccess(response, statusCode) async {
    List tempList = [];
    for (var item in response['data']) {
      tempList.add(item);
    }
    responseList.addAll(tempList);
    page = page + 1;
    totalPage = response['total_pages'];
    isError = false;
    refreshController.refreshCompleted();
    refreshController.loadComplete();
    isLoading = false;
    setState(() {});
  }

  @override
  onNoInternetConnection() {
    if (isLoading) {
      refreshController.refreshCompleted();
      isLoading = false;
      isError = true;
      responseList.clear();
      errorMsg = Constants.NO_CONNECTION;
      errorType = Constants.ERROR_CONNECTION;
    } else {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CustomDialogInformation(
        onTap: () {
          Navigator.pop(context);
        },
        title: "Failed",
        desc: Constants.NO_CONNECTION,
        color: Colors.orange,
        icon: Icons.error_outline,
      ),
    );
    setState(() {});
  }

  @override
  onDetailEmployeeFailure(response, statusCode) async {
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
  onDetailEmployeeSuccess(response, statusCode) async {
    Navigator.of(context, rootNavigator: true).pop(true);
    Navigator.of(context).push(
      MyHelpers.createRouting(
        DetailEmployePage(employeeData: response['data']),
      ),
    );
  }
}
