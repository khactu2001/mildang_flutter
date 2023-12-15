import 'package:flutter/material.dart';
import 'package:flutter_mildang/configs/theme.config.dart';

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

class DropdownButton extends StatefulWidget {
  const DropdownButton({
    super.key,
    required this.selectMenuItem,
    // this.currentMenuItem,
  });

  final Function(String) selectMenuItem;
  // final String? currentMenuItem;

  @override
  State<DropdownButton> createState() => DropdownButtonState();
}

class DropdownButtonState extends State<DropdownButton> {
  String? currentMenuItem = menus[0]['value'];

  @override
  Widget build(BuildContext context) {
    // return DropdownButtonHideUnderline(
    //   child: DropdownMenu(
    //     textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
    //           fontSize: 14,
    //         ),
    //     // initialSelection: currentMenuItem,
    //     inputDecorationTheme: InputDecorationTheme(
    //       enabledBorder: OutlineInputBorder(
    //         borderSide: BorderSide(
    //           color: textLabelColor,
    //         ),
    //         borderRadius: const BorderRadius.all(Radius.circular(8)),
    //       ),
    //       // contentPadding: EdgeInsets.only(top: 20),
    //       // constraints: BoxConstraints()
    //     ),
    //     // menuHeight: 100,
    //     menuStyle: MenuStyle(
    //       alignment: AlignmentDirectional(-1, 1.2),
    //       backgroundColor: MaterialStateProperty.resolveWith<Color?>(
    //         (Set<MaterialState> states) {
    //           if (states.contains(MaterialState.focused)) {
    //             return Theme.of(context).colorScheme.primary.withOpacity(0.5);
    //           }
    //           if (states.contains(MaterialState.pressed)) {
    //             return Theme.of(context).colorScheme.primary.withOpacity(0.5);
    //           }
    //           if (states.contains(MaterialState.selected)) {
    //             return Theme.of(context).colorScheme.primary.withOpacity(0.5);
    //           }
    //           return Colors.white;
    //           // return Colors.red; // Use the component's default.
    //         },
    //       ),
    //       surfaceTintColor: MaterialStateProperty.resolveWith<Color?>(
    //           (Set<MaterialState> states) {
    //         if (states.contains(MaterialState.focused)) {
    //           return Theme.of(context).colorScheme.primary.withOpacity(0.5);
    //         }
    //         if (states.contains(MaterialState.pressed)) {
    //           return Theme.of(context).colorScheme.primary.withOpacity(0.5);
    //         }
    //         if (states.contains(MaterialState.selected)) {
    //           return Theme.of(context).colorScheme.primary.withOpacity(0.5);
    //         }
    //         return Colors.white; // Use the component's default.
    //         // return null;
    //       }),
    //       padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry?>(
    //           (Set<MaterialState> padding) {
    //         return EdgeInsets.zero;
    //       }),
    //       shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
    //           (Set<MaterialState> states) {
    //         return RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(8.0),
    //           side: BorderSide(color: textHeaderColor), // Default border side
    //         );
    //       }),
    //     ),
    //     onSelected: (value) {
    //       print(value);
    //       // if (value != null) widget.selectMenuItem(value);
    //     },
    //     dropdownMenuEntries: menus.map((menu) {
    //       return DropdownMenuEntry(
    //         // style: MenuItemButton.styleFrom(
    //         //   foregroundColor: Colors.black,
    //         //   backgroundColor: Colors.pink,

    //         //   // textStyle: const TextStyle(
    //         //   //   backgroundColor: Colors.red,
    //         //   //   color: Colors.amberAccent,
    //         //   // ),
    //         // ),
    //         value: menu['value'],
    //         label: menu['label']!,
    //       );
    //       // return DropdownMenuItem(child: ,)
    //     }).toList(),
    //   ),
    // );

    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.greenAccent, //<-- SEE HERE
      ),
      child: DropdownButton(
        //   value: dropdownValue,
        //   onChanged: (String? newValue) {
        //     setState(() {
        //       dropdownValue = newValue!;
        //     });
        //   },
        //   items: <String>['Car', 'Train', 'Bus', 'Flight']
        //       .map<DropdownMenuItem<String>>((String value) {
        //     return DropdownMenuItem<String>(
        //       value: value,
        //       child: Text(
        //         value,
        //       ),
        //     );
        //   }).toList(),
        selectMenuItem: (p0) {},
      ),
    );
  }
}
