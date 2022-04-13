
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:social/shared/constatnt/colors.dart';
import 'package:social/shared/styles/icon_broken.dart';

//navigate with remove
void navigateAndRemove({context, widget}) => {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false)
};
//to navigate
void navigateTo({required context, required widget}) =>
    {Navigator.push(context, MaterialPageRoute(builder: (context) => widget))};
//navigate to back
void backTo({required context, required widget}) =>
    {Navigator.pop(context, MaterialPageRoute(builder: (context) => widget))};

//defaultTextButton
Widget textButton({required String text, required VoidCallback? fun}) =>
    TextButton(onPressed: fun, child: Text(text.toUpperCase()));
//defaultButton
Widget defaultButton({
  double radius = 0,
  double width = double.infinity,
  Color color = Colors.amber,
  bool isUpper = true,
  required String text,
  required VoidCallback fun,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        child: Text(
          " ${isUpper ? text.toUpperCase() : text} ",
          style: const TextStyle(color: Colors.white, fontSize: 25),
        ),
        onPressed: fun,
      ),
    );
//defaultFormField
Widget defaultFormField({
  String? initialValue,
  TextEditingController? controller,
  required TextInputType textKeyboard,
  IconData? suffix,
  String? helper = '',
  GestureTapCallback? onTaped,
  bool isPassword = false,
  required IconData prefix,
  ValueChanged<String>? onchange,
  ValueChanged<String>? onFieldSubmitted,
  required FormFieldValidator<String> validate,
  required String textLabel,
  VoidCallback? suffixPressed,
  FormFieldSetter<String>? onSaved,
}) =>
    TextFormField(
      onSaved: onSaved,
      initialValue: initialValue,
      validator: validate,
      controller: controller,
      keyboardType: textKeyboard,
      obscureText: isPassword,
      decoration: InputDecoration(
        helperText: '$helper',
        labelText: textLabel,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
          icon: Icon(suffix),
          onPressed: suffixPressed,
        )
            : null,
        border: const OutlineInputBorder(),
      ),
      onChanged: onchange,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTaped,
    );
//Toat
void toast({required String text, required ToastState state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { warning, error, success }

Color? color;

Color chooseToastColor(ToastState state) {
  switch (state) {
    case (ToastState.success):
      color = Colors.green;
      break;

    case (ToastState.error):
      color = Colors.red;
      break;
    case (ToastState.warning):
      color = Colors.amber;
      break;
  }
  return color!;
}

//full TXT
void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

//appBar
PreferredSizeWidget? defaultAppBar({
  List<Widget>? actions,
  String? title,
  required BuildContext context,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(IconBroken.Arrow___Left_2),
      ),
      titleSpacing: 5.0,

      title: Text('$title'),
      actions: actions,
    );
//phone valid
bool isPhoneNoValid(value) {
  if (value == null) return false;
  final regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  return regExp.hasMatch(value);
}
