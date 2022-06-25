import 'package:cached_network_image/cached_network_image.dart';
import 'package:tutorials/component/cache/user_caches.dart';
import 'package:tutorials/component/dialog/dialogs.dart';
import 'package:tutorials/component/log/Logs.dart';
import 'package:tutorials/constant/route_constant.dart';
import 'package:tutorials/locale/Translations.dart';
import 'package:tutorials/request/model/user.dart';
import 'package:tutorials/utils/app_utils.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({
    Key? key,
  }) : super(key: key);

  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    User user = UserCaches.getUser();
    Logs.info("user:  ${user.toString()}");
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 68,bottom: 36),
              child: GestureDetector(
                onTap: () {
                  AppUtils.toPage(
                      context, RouteNameConstant.route_name_profile);
                },
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 36),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: user.iconUrl ?? '',
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Image(
                              image: AssetImage("assets/images/user_null.png")),
                          height: 86,
                          width: 86,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                            user.userName ??
                                Translations.textOf(context, "all.app.name"),
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(left: 24),
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: Text(
                        Translations.textOf(context, "home.drawer.settings")),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RouteNameConstant.route_name_settings);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title:
                        Text(Translations.textOf(context, "home.drawer.about")),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RouteNameConstant.route_name_about);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title:
                        Text(Translations.textOf(context, "home.drawer.exit")),
                    onTap: () {
                      // 确认框
                      checkExitApp();
                    },
                  ),
//                  ListTile(
//                    leading: const Icon(Icons.person),
//                    title: Text(Translations.textOf(context, "home.drawer.profile")),
//                    onTap: () {
//                      Navigator.of(context)
//                          .pushNamed(RouteNameConstant.route_name_profile);
//                    },
//                  ),
//                  ListTile(
//                    leading: const Icon(Icons.logout),
//                    title: const Text('Logout'),
//                    onTap: () {
//
//                    },
//                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkExitApp() async {
    String? showConfirmDialog = await Dialogs.showConfirmDialog(
        _context, Translations.textOf(_context, "home.back.confirm"), null);
    Logs.info('checkExitApp showConfirmDialog = $showConfirmDialog');
    if ("true" == showConfirmDialog) {
      AppUtils.exitApp();
    }
  }
}