import 'package:flutter/material.dart';

class AppStyles {
  TextStyle kTextStyle10(Color? color) {
    return TextStyle(fontSize: 10, color: color);
  }

  TextStyle kTextStyle10B(Color? color) {
    return TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold);
  }

  TextStyle kTextStyle12(Color? color) {
    return TextStyle(fontSize: 12, color: color);
  }

  TextStyle kTextStyle12B(Color? color) {
    return TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.bold);
  }

  TextStyle kTextStyle12B6(Color? color) {
    return TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600);
  }

  TextStyle kTextStyle12B5(Color? color) {
    return TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w500);
  }

  TextStyle kTextStyle12B4(Color? color) {
    return TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w400);
  }

  TextStyle kTextStyle12LT(Color? color) {
    return TextStyle(
        fontSize: 12,
        color: color,
        // fontWeight: FontWeight.bold,
        decoration: TextDecoration.lineThrough);
  }

  TextStyle kTextStyle13B4(Color? color) {
    return TextStyle(fontSize: 13, color: color, fontWeight: FontWeight.w400);
  }

  TextStyle kTextStyle13B5(Color? color) {
    return TextStyle(fontSize: 13, color: color, fontWeight: FontWeight.w500);
  }

  TextStyle kTextStyle13B6(Color? color) {
    return TextStyle(fontSize: 13, color: color, fontWeight: FontWeight.w600);
  }

  TextStyle kTextStyle14(Color? color) {
    return TextStyle(fontSize: 14, color: color);
  }

  TextStyle kTextStyle14B(Color? color) {
    return TextStyle(
        fontSize: 14,
        color: color,
        fontWeight: FontWeight.bold,
        letterSpacing: 1);
  }

  TextStyle kTextStyle14B5(Color? color) {
    return TextStyle(fontSize: 14, color: color, fontWeight: FontWeight.w500);
  }

  TextStyle kTextStyle14B6(Color? color) {
    return TextStyle(fontSize: 14, color: color, fontWeight: FontWeight.w600);
  }

  TextStyle kTextStyle14B4(Color? color) {
    return TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.w400);
  }

  TextStyle kTextStyle16(Color? color) {
    return TextStyle(fontSize: 16, color: color);
  }

  TextStyle kTextStyle16B(Color? color) {
    return TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.bold);
  }

  TextStyle kTextStyle16B4(Color? color) {
    return TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.w400);
  }

  TextStyle kTextStyle16B5(Color? color) {
    return TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.w500);
  }

  TextStyle kTextStyle15B6(Color? color) {
    return TextStyle(fontSize: 15, color: color, fontWeight: FontWeight.w600);
  }

  TextStyle kTextStyle16U(Color? color) {
    return TextStyle(
      fontSize: 16,
      color: color,
      decoration: TextDecoration.underline,
      decorationColor: color,
    );
  }

  TextStyle kTextStyle18(Color? color) {
    return TextStyle(
      fontSize: 18,
      color: color,
    );
  }

  TextStyle kTextStyle18B6(Color? color) {
    return TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.w600);
  }

  TextStyle kTextStyle18B5(Color? color) {
    return TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.w500);
  }

  TextStyle kTextStyle18UB(Color? color) {
    return TextStyle(
      fontSize: 18,
      color: color,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
      decorationColor: color,
    );
  }

  TextStyle kTextStyle20(Color? color) {
    return TextStyle(fontSize: 20, color: color);
  }

  TextStyle kTextStyle20B(Color? color) {
    return TextStyle(
      fontSize: 20,
      color: color,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle kTextStyle22B(Color? color) {
    return TextStyle(fontSize: 22, color: color, fontWeight: FontWeight.w500);
  }

  TextStyle kTextStyle24B6(Color? color) {
    return TextStyle(fontSize: 24, color: color, fontWeight: FontWeight.w600);
  }

  TextStyle kTextStyle26B6(Color? color) {
    return TextStyle(fontSize: 26, color: color, fontWeight: FontWeight.w600);
  }

  TextStyle kTextStyle26BI(Color? color) {
    return TextStyle(
      fontSize: 26,
      color: color,
      fontWeight: FontWeight.bold,
      fontFamily: 'Lato',
    );
  }

  BoxDecoration kBoxDecorationR5(Color? color) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(5),
    );
  }

  BoxDecoration kBoxDecorationR3(Color? color) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(3),
    );
  }

  BoxDecoration kBoxDecorationR0(Color? color) {
    return BoxDecoration(
      color: color,
    );
  }

  BoxDecoration kBoxBorderDecoration({double? radius }) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(radius ??11),
        border: Border.all(color: Colors.black, width: 1));
  }

  BoxDecoration kBoxBorderDecorationR3(BuildContext context) {
    return BoxDecoration(
      color: Theme
          .of(context)
          .colorScheme
          .onPrimaryFixedVariant,
        borderRadius: BorderRadius.circular(5), border: Border.all(
        color: Theme.of(context)
            .colorScheme.tertiary,width: 0.5));
  }  BoxDecoration kBoxBorderDecorationR3B(BuildContext context) {
    return BoxDecoration(

        borderRadius: BorderRadius.circular(5), border: Border.all(
        color: Theme.of(context).colorScheme.onPrimaryFixedVariant,width: 1));
  }

  BoxDecoration kBoxBorderDecorationR4() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(4), border: Border.all(width: 1));
  }

  BoxDecoration kBoxBorderDecorationR4G() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(4), border: Border.all(width: 0.5));
  }

  BoxDecoration kBoxBorderDecorationR4GB(Color? color) {
    return BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(width: 0.5));
  }

  BoxDecoration kBoxLandRBorderDecoration(Color? color) {
    return BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        border: Border.all(color: Colors.white, width: 0));
  }
}
