// import 'dart:developer';
// import 'package:attendance/constant/strings.dart';
// import 'package:attendance/utils/get_user_id.dart';
// import 'package:attendance/view/widgets/custom_appbar.dart';
// import 'package:attendance/view/widgets/custom_drawer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// class ViewApplication extends StatefulWidget {
//   const ViewApplication({super.key});

//   @override
//   State<ViewApplication> createState() => _ViewApplicationState();
// }

// // https://maidendropgroup.com/public/home/check_application_login_mobile?userid=47
// class _ViewApplicationState extends State<ViewApplication> {
//   double _progress = 0;
//   late InAppWebViewController webviewcontroller;
//   GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//   dynamic uid;
//   @override
//   void initState() {
//     uid = GetUserData().getUserId();
//     log('userid for webview ----> $uid');
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Strings.bgColor,
//         key: scaffoldKey,
//         drawer: CustomDrawer(),
//         body: Stack(children: [
//           Column(
//             children: [
//               CustomAppBar("View Applications"),
//               Expanded(
//                 child: SizedBox(
//                   height: MediaQuery.of(context).size.height / 1.168,
//                   child: InAppWebView(
//                     initialUrlRequest: URLRequest(
//                         url: Uri.parse(
//                             "https://maidendropgroup.com/public/home/check_application_login_mobile?userid=$uid&page=view")),
//                     onWebViewCreated: (InAppWebViewController controller) {
//                       webviewcontroller = controller;
//                     },
//                     onProgressChanged:
//                         (InAppWebViewController controller, int progress) {
//                       setState(() {
//                         _progress = progress / 100;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           _progress < 1
//               ? SizedBox(
//                   height: 3,
//                   child: LinearProgressIndicator(
//                     value: _progress,
//                     // backgroundColor:
//                     //     Theme.of(context).appBarTheme.backgroundColor,
//                   ),
//                 )
//               : SizedBox(),
//         ]),
//       ),
//     );
//   }
// }
