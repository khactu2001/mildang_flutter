import 'package:flutter/material.dart';
import 'package:flutter_mildang/utils/utilities.dart';

class CustomCheckboxRow extends StatelessWidget {
  const CustomCheckboxRow({
    super.key,
    required this.isChecked,
    required this.onChanged,
    this.seeMore,
  });

  final bool isChecked;
  final void Function(bool?) onChanged;
  final void Function()? seeMore;

  @override
  Widget build(BuildContext context) {
    final double ratioDesignWidthActual =
        392 / MediaQuery.of(context).size.width;
    // final double iconSize = 28 / ratioDesignWidthActual;
    return Container(
      width: double.infinity,
      // decoration: const BoxDecoration(color: Colors.amber),
      child: Row(
        // mainAxisAlignment: ,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            constraints: BoxConstraints.tight(
              Size(28 / ratioDesignWidthActual, 28 / ratioDesignWidthActual),
            ),
            // child: Transform.scale(
            //   scale: 1.5,
            //   child: Checkbox(
            //     value: isChecked,
            //     onChanged: onChanged,
            //     side: BorderSide(
            //       color: isChecked ? Colors.black : HexColor('#C4C6CD'),
            //     ),
            //     activeColor: Colors.black,
            //   ),
            // ),
            child: Checkbox(
              value: isChecked,
              onChanged: onChanged,
              side: BorderSide(
                color: isChecked ? Colors.black : HexColor('#C4C6CD'),
              ),
              activeColor: Colors.black,
            ),
          ),
          const Expanded(
            child: Text(
              '모두 동의하기',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints.tight(
              Size(28 / ratioDesignWidthActual, 28 / ratioDesignWidthActual),
            ),
            // child: Transform.scale(
            //   scale: 1.5,
            //   child: Checkbox(
            //     value: isChecked,
            //     onChanged: onChanged,
            //     side: BorderSide(
            //       color: isChecked ? Colors.black : HexColor('#C4C6CD'),
            //     ),
            //     activeColor: Colors.black,
            //   ),
            // ),
            child: IconButton(
              padding: EdgeInsets.zero,
              // style: ElevatedButton.styleFrom(
              //   padding: EdgeInsets.all(0),
              // ),
              // alignment: Alignment.centerRight,
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
              ),
              onPressed: seeMore,
            ),
          ),
        ],
      ),
    );
    // return ListTile(
    //   // onTap: () {
    //   //   onChanged(!isChecked);
    //   // },
    //   leading: Container(
    //     constraints: BoxConstraints.tight(
    //       Size(28 / ratioDesignWidthActual, 28 / ratioDesignWidthActual),
    //     ),
    //     child: Transform.scale(
    //       scale: 1.5,
    //       child: Checkbox(
    //         value: isChecked,
    //         onChanged: onChanged,
    //         side: BorderSide(
    //           color: isChecked ? Colors.black : HexColor('#C4C6CD'),
    //         ),
    //         activeColor: Colors.black,
    //       ),
    //     ),
    //   ),
    //   title: const Text(
    //     '모두 동의하기',
    //     style: TextStyle(
    //       fontSize: 24,
    //       color: Colors.black,
    //       fontWeight: FontWeight.w700,
    //     ),
    //   ),
    //   // trailing: IconButton(
    //   //   icon: const Icon(
    //   //     Icons.arrow_forward_ios_rounded,
    //   //     color: Colors.black,
    //   //   ),
    //   //   onPressed: seeMore,
    //   // ),
    //   trailing: Container(
    //     // Wrap the trailing widget with a Container
    //     padding: EdgeInsets.zero, // Adjust padding within the trailing widget
    //     child: IconButton(
    //       icon: const Icon(
    //         Icons.arrow_forward_ios_rounded,
    //         color: Colors.black,
    //         // size: iconSize,
    //       ),
    //       onPressed: seeMore,
    //     ), // Replace YourTrailingWidget with your desired widget
    //   ),
    //   contentPadding: const EdgeInsets.all(0),
    //   tileColor: Colors.amber,
    //   // style: ListTileStyle.drawer,
    //   // leadingAndTrailingTextStyle: TextStyle()
    // );
  }
}
