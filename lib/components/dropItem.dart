import 'package:flutter/material.dart';
import './filterButtonModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDownFilter extends StatefulWidget {
  DropDownFilter({Key key, this.otherWidget, this.buttons});
  final Widget otherWidget; //页面除了筛选按钮部分Widget 新车页：列表
  final List<FilterButtonModel> buttons; //按钮数组 数据类型FilterButtonModel

  @override
  _DropDownFilterState createState() => _DropDownFilterState();
}

class _DropDownFilterState extends State<DropDownFilter>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  double innerHeight = 150.0;
  bool isMask = false; //下拉蒙层是否显示
  FilterButtonModel curButton;
  int curFilterIndex;

  initState() {
    // TODO: implement initState
    super.initState();
    //初始化下拉列表
    curButton = widget.buttons[0];

    controller = new AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);

    animation = new Tween(begin: 0.0, end: innerHeight).animate(controller)
      ..addListener(() {
        //这行如果不写，没有动画效果
        setState(() {});
      });
  }

  void ontap() {
    controller.reverse();
    triggerIcon(widget.buttons[curFilterIndex]);
    triggerMask();
  }

  void triggerMask() {
    setState(() {
      isMask = !isMask;
    });
  }

  void triggerIcon(btn) {
    if (btn.direction == 'up') {
      btn.direction = 'down';
    } else {
      btn.direction = 'up';
    }
  }

  void initButtonStatus() {
    widget.buttons.forEach((i) {
      setState(() {
        i.direction = 'down';
      });
    });
  }

  //更新数据
  void updateData(i) {
    setState(() {
      curButton = widget.buttons[i];
      curFilterIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height:  ScreenUtil().setHeight(1020),
        child: Stack(
          //stack设置为overflow：visible之后，内部的元素中超出的部分就不能触发点击事件；所以尽量避免这种布局
          // overflow: Overflow.visible,
          children: <Widget>[
            Row(
              children: <Widget>[
                _button(),
                // widget.otherWidget
              ],
            ),
            _contentList(curButton)
          ],
        ));
  }

  //筛选按钮
  Widget _button() {
    return Row(
      children: List.generate(widget.buttons.length, (i) {
        final thisButton = widget.buttons[i];
        return SizedBox(
          height: ScreenUtil().setHeight(100),
          width: ScreenUtil().setWidth(250),
          child: FlatButton(
            padding: EdgeInsets.only(top: 0, left: 10),
            child: Row(
              children: <Widget>[
                Text(
                  thisButton.title,
                ),
                _rotateIcon(thisButton.direction)
              ],
            ),
            onPressed: () {
              //处理 下拉列表打开时，点击别的按钮
              if (isMask && i != curFilterIndex) {
                initButtonStatus();
                triggerIcon(widget.buttons[i]);
                updateData(i);
                return;
              }

              updateData(i);

              if (curButton.callback == null) {
                if (animation.status == AnimationStatus.completed) {
                  controller.reverse();
                } else {
                  controller.forward();
                }
                triggerMask();
              } else {
                curButton.callback();
              }

              triggerIcon(widget.buttons[i]);
            },
          ),
        );
      }),
    );
  }

  //筛选弹出的下拉列表
  Widget _contentList(FilterButtonModel lists) {
    // debugPrint('data: ${lists.contents}');
    if (lists.contents != null && lists.contents.length > 0 && isMask) {
      return Positioned(
          width: ScreenUtil().setWidth(750),
          top: 50,
          // bottom: 0,
          left: 0,
          child: Column(
            children: <Widget>[
              Container(
                  width: ScreenUtil().setWidth(750),
                  color: Colors.red,
                  height: ScreenUtil().setHeight(300),
                  child: _innerConList(lists)),
              _mask()
            ],
          ));
    } else {
      return Container(
        height: 0,
      );
    }
  }

  Widget _innerConList(FilterButtonModel lists) {
    print('type: ${lists.type}');
    setState(() {
      innerHeight = 50.0 * lists.contents.length;
    });
    return ListView(
      children: List.generate(lists.contents.length, (i) {
        return GestureDetector(
            onTap: ontap,
            child: Container(
              height: 300,
              padding: EdgeInsets.only(top: 15, left: 15, bottom: 15),
              child: Text(
                lists.contents[i],
                style: TextStyle(),
              ),
            ));
      }),
    );
    // }
  }

  //筛选的黑色蒙层
  Widget _mask() {
    var height = ScreenUtil().setHeight(1334);
    print('height, $height');
    if (isMask) {
      return Container(
        width: ScreenUtil().setWidth(750),
        height: ScreenUtil().setHeight(1334),
        color: Color.fromRGBO(0, 0, 0, 0.5),
      );
      // return Opacity(
      //   opacity: 0.3,
      //   child: ModalBarrier(dismissible: false, color: Colors.grey),
      // );
    } else {
      return Container(
        height: 0,
      );
    }
  }

  //右侧旋转箭头组建
  Widget _rotateIcon(direction) {
    if (direction == 'up') {
      return Icon(Icons.keyboard_arrow_up, color: Colors.orange);
    } else {
      return Icon(
        Icons.keyboard_arrow_down,
        color: Colors.orange,
      );
    }
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
