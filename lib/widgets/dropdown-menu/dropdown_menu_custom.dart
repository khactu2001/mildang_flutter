import 'package:flutter/material.dart';
import 'package:flutter_mildang/configs/theme.config.dart';
// import 'package:flutter_mildang/utils/utilities.dart';

// final menus = <DropdownMenuEntry<Object>>[
//   const DropdownMenuEntry(value: '1', label: 'Text 1'),
//   const DropdownMenuEntry(value: '2', label: 'Text 2'),
//   const DropdownMenuEntry(value: '3', label: 'Text 3'),
//   const DropdownMenuEntry(value: '4', label: 'Text 4'),
// ];

List<Map<String, String>> menus = [
  {'value': '1', 'label': 'Text 1'},
  {'value': '2', 'label': 'Text 2'},
  {'value': '3', 'label': 'Text 3'},
];

class DropdownCustom extends StatefulWidget {
  const DropdownCustom({
    super.key,
    required this.selectMenuItem,
    // this.currentMenuItem,
  });

  final Function(String) selectMenuItem;
  // final String? currentMenuItem;

  @override
  State<DropdownCustom> createState() => DropdownCustomState();
}

class DropdownCustomState extends State<DropdownCustom> {
  String? currentMenuItem = menus[0]['value'];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownMenu(
        textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 14,
            ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: textLabelColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
        ),
        menuStyle: MenuStyle(
          alignment: const AlignmentDirectional(-1, 1.2),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              return Colors.black;
              // return itemSelectedColor;
              // return HexColor('#F0F7F9');
              // return const Color(0xFFF0F7F9);
              // return Colors.black;
            },
          ),
          padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry?>(
              (Set<MaterialState> padding) {
            return EdgeInsets.zero;
          }),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
              (Set<MaterialState> states) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: textHeaderColor), // Default border side
            );
          }),
        ),
        onSelected: (value) {
          print(value);
          // if (value != null) widget.selectMenuItem(value);
        },
        dropdownMenuEntries: menus.map((menu) {
          return DropdownMenuEntry(
            // labelWidget: Text('haha'),
            style: MenuItemButton.styleFrom(
              // foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              // surfaceTintColor: Colors.amber,
              // backgroundColor: Colors.amberAccent,
              // textStyle: TextStyle(color: Colors.yellow),
            ),
            value: menu['value'],
            label: menu['label']!,
          );
        }).toList(),
      ),
    );
  }
}
