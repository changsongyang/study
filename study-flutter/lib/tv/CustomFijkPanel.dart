import 'dart:math';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';

class CustomFijkPanel extends StatefulWidget {
  final FijkPlayer player;
  final BuildContext buildContext;
  final Size viewSize;
  final Rect texturePos;

  const CustomFijkPanel({
    @required this.player,
    this.buildContext,
    this.viewSize,
    this.texturePos,
  });

  @override
  _CustomFijkPanel createState() => _CustomFijkPanel();
}

class _CustomFijkPanel extends State<CustomFijkPanel> {
  FijkPlayer get player => widget.player;

  /// 播放状态
  bool _playing = false;
  bool _full_screen = true;

  /// 是否显示状态栏+菜单栏
  bool isPlayShowCont = true;

  @override
  void initState() {
    /// 提前加载
    /// 进行监听
    widget.player.addListener(_playerValueChanged);

    /// 初始化
    super.initState();
  }

  /// 监听器
  void _playerValueChanged() {
    FijkValue value = player.value;

    /// 播放状态
    bool playing = (value.state == FijkState.started);
    if (playing != _playing) setState(() => _playing = playing);

    // 全屏
    setState(() => _full_screen = value.fullScreen);
  }

  @override
  Widget build(BuildContext context) {
    Rect rect = Rect.fromLTRB(
      max(0.0, widget.texturePos.left),
      max(0.0, widget.texturePos.top),
      min(widget.viewSize.width, widget.texturePos.right),
      min(widget.viewSize.height, widget.texturePos.bottom),
    );

    return Positioned.fromRect(
      rect: rect,
      child: GestureDetector(
        onTap: () {
          setState(() {
            /// 显示 、隐藏  进度条+标题栏
            isPlayShowCont = !isPlayShowCont;
          });
        },
        child: Container(
            color: Color.fromRGBO(0, 0, 0, 0.0),
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                /// 标题栏
                !isPlayShowCont
                    ? SizedBox()
                    : Container(
                        color: Color.fromRGBO(0, 0, 0, 0.65),
                        height: 35,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.chevron_left,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ],
                        ),
                      ),

                /// 控制条
                !isPlayShowCont
                    ? SizedBox()
                    : Container(
                        color: Color.fromRGBO(0, 0, 0, 0.65),
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                _playing ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                              ),
                              onPressed: () => _playing
                                  ? widget.player.pause()
                                  : widget.player.start(),
                            ),
                            IconButton(
                              alignment: Alignment.bottomRight,
                              icon: Icon(widget.player.value.fullScreen
                                  ? Icons.fullscreen_exit
                                  : Icons.fullscreen,
                                color: Colors.white,
                              ),
                              onPressed: () => widget.player.value.fullScreen
                                  ? widget.player.exitFullScreen()
                                  : widget.player.enterFullScreen(),
                            )
                          ],
                        ),
                      )
              ],
            )),
      ),
    );
  }

  @override
  void dispose() {
    /// 关闭监听
    player.removeListener(_playerValueChanged);

    /// 关闭流回调
    super.dispose();
  }
}
