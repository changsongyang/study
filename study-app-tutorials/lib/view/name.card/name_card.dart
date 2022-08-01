import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tutorials/component/image.crop/image_cropper.dart';
import 'package:tutorials/component/log/logs.dart';
import 'package:tutorials/component/picker/image_picker.dart';
import 'package:tutorials/locale/translations.dart';
import 'package:tutorials/request/file_upload_request.dart';
import 'package:tutorials/request/model/upload/file_upload_param.dart';
import 'package:tutorials/view/name.card/name_card_basic.dart';
import 'package:tutorials/view/name.card/name_card_school.dart';
import 'package:tutorials/widgets/profile_icon_basic.dart';

class NameCard extends StatefulWidget {
  const NameCard({Key? key}) : super(key: key);

  @override
  _NameCardState createState() => _NameCardState();
}

class _NameCardState extends State<NameCard> {
  List<String> images = [];

  String url = "assets/images/user_null.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.textOf(context, "name.card.title")),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: NameCardBasic(
                title: '基本信息',
                subTitle: '陆瑞华',
                desc: '1993年，出生于广西上思，21世纪新一代杰出青年！',
                url: 'https://avatars.githubusercontent.com/u/18094768?v=4',
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: NameCardBasic(
                title: '学校信息',
                subTitle: '河海大学',
                desc: '2013年-2017年 计算机科学与技术专业！',
                url: 'https://avatars.githubusercontent.com/u/18094768?v=4',
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: NameCardBasic(
                title: '公司信息',
                subTitle: '携程旅行',
                desc: '2019年4月-至今',
                url: 'https://avatars.githubusercontent.com/u/18094768?v=4',
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: NameCardBasic(
                title: '公司信息',
                subTitle: '携程旅行',
                desc: '2019年4月-至今',
                url: 'https://avatars.githubusercontent.com/u/18094768?v=4',
              ),
            ),

          ],
        ),
      ),
    );
  }

  pickBack(String? value) async {
    Logs.info('image picked:  $value');
    if (value != null) {
      String valueCrop = await _cropImage(value);
      setState(() {
        url = valueCrop;
      });

      FileUploadParam param = FileUploadParam();
      param.files = [MultipartFile.fromFileSync(url)];
      FileUploadRequests.upload(param, (count, total) {}).then((value) => {});
    } else {
      setState(() {
        url = url == "assets/images/logo128.png"
            ? "assets/images/user_null.png"
            : "assets/images/logo128.png";
      });
    }
  }

  Future<String> _cropImage(String valueCrop) async {
    return await ImageCropper.cropImage(context, valueCrop);
  }
}
