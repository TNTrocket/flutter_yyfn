import 'package:flutter/material.dart';
import '../components/dropItem.dart';
import '../components/filterButtonModel.dart';
import '../components/listItem.dart';

class Course extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DropDownStateWidget(),
      ),
      body: Column(
        children: <Widget>[CourseFilter()],
      ),
    );
  }
}

class CourseFilter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CourseFilterState();
}

class CourseFilterState extends State<CourseFilter> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListItem(),
        DropDownFilter(
          buttons: [
            FilterButtonModel(
              title: '排序',
              type: 'Column',
              contents: ['默认排序', '首付最低', '月供最低', '车价最低', '车价最高'],
            ),
            FilterButtonModel(
              title: '排序',
              type: 'Column',
              contents: ['默认排序1111', '首付最低', '月供最低', '车价最低', '车价最高'],
            ),
            FilterButtonModel(
                title: '排序',
                type: 'Column',
                contents: ['默认排序1111', '首付最低', '月供最低', '车价最低', '车价最高']),
          ],
        ),
      ],
    );
  }
}

class DropDownStateWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DropDownState();
}

class DropDownState extends State<DropDownStateWidget> {
  //下拉菜单item点击之后获取到的值
  var selectItemValue;
  /*DropDownState(){
    selectItemValue=getDropdownMenuItem()[0].value;
  }*/
  List<DropdownMenuItem> generateItemList() {
    List<DropdownMenuItem> items = new List();
    DropdownMenuItem item1 =
        new DropdownMenuItem(value: '张三', child: new Text('张三'));
    DropdownMenuItem item2 =
        new DropdownMenuItem(value: '李四', child: new Text('李四'));
    DropdownMenuItem item3 =
        new DropdownMenuItem(value: '王二', child: new Text('王二'));
    DropdownMenuItem item4 =
        new DropdownMenuItem(value: '麻子', child: new Text('麻子'));
    selectItemValue = item1.value;
    items.add(item1);
    items.add(item2);
    items.add(item3);
    items.add(item4);
    return items;
  }

  @override
  Widget build(BuildContext context) {
    //DropdownButtonHideUnderline：下拉菜单展示的内容处没有下划线
    return new DropdownButtonHideUnderline(
      child: new DropdownButton(
        hint: new Text('选择'),
        //设置这个value之后,选中对应位置的item，
        //再次呼出下拉菜单，会自动定位item位置在当前按钮显示的位置处
        value: selectItemValue,
        items: generateItemList(),
        onChanged: (T) {
          setState(() {
            selectItemValue = T;
          });
        },
      ),
    );
  }
}
