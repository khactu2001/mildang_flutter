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
  {'value': 'DESC', 'label': 'DESC'},
  {'value': 'ASC', 'label': 'ASC'},
  {'value': 'createdAt', 'label': 'Created At'},
];

// class CustomDropdown extends DropdownMenuEntry {
//   CustomDropdown({
//     Key? key,
//     String? value,
//     required String label,
//     MenuStyle? menuStyle,
//   }) : super(value: value, label: '');
// }

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
    return DropdownMenu(
      width: 100,
      initialSelection: currentMenuItem,
      textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 14,
          ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: textLabelColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        constraints: const BoxConstraints(
          maxHeight: 44,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      ),
      menuStyle: MenuStyle(
        alignment: const AlignmentDirectional(-1, 1.2),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            return null;
          },
        ),
        // maximumSize: MaterialStateProperty.resolveWith<Size?>(
        //   (Set<MaterialState> states) {
        //     return Size(164, 44);
        //   },
        // ),
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

        if (value != null) widget.selectMenuItem(value);
      },
      dropdownMenuEntries: menus.map((menu) {
        return DropdownMenuEntry(
          style: MenuItemButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.amber,
            // padding: EdgeInsets.zero,
            // maximumSize: Size(50, 50),
          ),
          value: menu['value'],
          label: menu['label']!,
        );
      }).toList(),
    );
  }
}
