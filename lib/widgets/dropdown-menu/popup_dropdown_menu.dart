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

class PopupDropdownMenu extends StatefulWidget {
  const PopupDropdownMenu({
    super.key,
    required this.selectMenuItem,
    // this.currentMenuItem,
  });

  final Function(String) selectMenuItem;
  // final String? currentMenuItem;

  @override
  State<PopupDropdownMenu> createState() => PopupDropdownMenuState();
}

class PopupDropdownMenuState extends State<PopupDropdownMenu> {
  // String? currentMenuItem = menus[0]['value'];
  String? currentMenuItem = 'Option 2';
  bool menuOpened = false;

  @override
  Widget build(BuildContext context) {
    // return DropdownMenu(
    //   textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
    //         fontSize: 14,
    //       ),
    //   // initialSelection: currentMenuItem,
    //   inputDecorationTheme: InputDecorationTheme(
    //     enabledBorder: OutlineInputBorder(
    //       borderSide: BorderSide(
    //         color: textLabelColor,
    //       ),
    //       borderRadius: const BorderRadius.all(Radius.circular(8)),
    //     ),
    //   ),
    //   menuStyle: MenuStyle(
    //     backgroundColor: MaterialStateProperty.resolveWith<Color?>(
    //       (Set<MaterialState> states) {
    //         // if (states.contains(MaterialState.focused)) {
    //         //   return Theme.of(context).colorScheme.primary.withOpacity(0.5);
    //         // }
    //         // if (states.contains(MaterialState.pressed)) {
    //         //   return Theme.of(context).colorScheme.primary.withOpacity(0.5);
    //         // }
    //         // if (states.contains(MaterialState.selected)) {
    //         //   return Theme.of(context).colorScheme.primary.withOpacity(0.5);
    //         // }
    //         return null;
    //         // return Colors.red; // Use the component's default.
    //       },
    //     ),
    //     surfaceTintColor: MaterialStateProperty.resolveWith<Color?>(
    //         (Set<MaterialState> states) {
    //       // if (states.contains(MaterialState.focused)) {
    //       //   return Theme.of(context).colorScheme.primary.withOpacity(0.5);
    //       // }
    //       // if (states.contains(MaterialState.pressed)) {
    //       //   return Theme.of(context).colorScheme.primary.withOpacity(0.5);
    //       // }
    //       // if (states.contains(MaterialState.selected)) {
    //       //   return Theme.of(context).colorScheme.primary.withOpacity(0.5);
    //       // }
    //       return Colors.blue; // Use the component's default.
    //     }),
    //     padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry?>(
    //         (Set<MaterialState> padding) {
    //       return EdgeInsets.zero;
    //     }),
    //     shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
    //         (Set<MaterialState> states) {
    //       return RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(8.0),
    //         side: BorderSide(color: textHeaderColor), // Default border side
    //       );
    //     }),
    //     // alignment: Alignment.bottomLeft,
    //   ),
    //   onSelected: (value) {
    //     print(value);
    //     // if (value != null) widget.selectMenuItem(value);
    //   },
    //   dropdownMenuEntries: menus.map((menu) {
    //     return DropdownMenuEntry(
    //       style: MenuItemButton.styleFrom(
    //         foregroundColor: Colors.black,
    //         backgroundColor: Colors.white,
    //       ),
    //       value: menu['value'],
    //       label: menu['label']!,
    //     );
    //   }).toList(),
    // );
    return PopupMenuButton<String>(
      initialValue: currentMenuItem,
      onOpened: () {
        setState(() {
          menuOpened = true;
        });
      },
      onCanceled: () {
        setState(() {
          menuOpened = false;
        });
      },
      // position: PopupMenuPosition.under,
      offset: const Offset(0, 10),
      itemBuilder: (BuildContext context) {
        // showMenu(context: context, position: position, items: items)
        return <PopupMenuEntry<String>>[
          // PopupMenuItem<String>(
          //   height: 20, // Add space above the first menu item
          //   child: Container(), // Empty container to create the space
          // ),
          PopupMenuItem<String>(
            value: 'Option 1',
            // padding: EdgeInsets.zero,
            child: Container(
                decoration: BoxDecoration(color: Colors.yellow),
                child: Text('Option 1')),
          ),
          const PopupMenuDivider(),
          PopupMenuItem<String>(
            value: 'Option 2',
            child: Text('Option 2'),
          ),
          PopupMenuItem<String>(
            value: 'Option 3',
            child: Text('Option 3'),
          ),
        ];
      },
      onSelected: (String value) {
        // Handle selection
        setState(() {
          currentMenuItem = value;
          menuOpened = false;
        });
      },
      // constraints: BoxConstraints.loose(Size.fromWidth(150)),
      child: UnconstrainedBox(
        child: Container(
          // width: 150,
          // height: 60,
          padding:
              const EdgeInsets.all(8.0), // Optional: Add padding to the button
          decoration: BoxDecoration(
            border:
                Border.all(color: textLabelColor, width: 1.0), // Button border
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Text(
                currentMenuItem ?? 'Select an option',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Icon(menuOpened ? Icons.arrow_drop_up : Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}
