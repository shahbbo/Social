import 'package:flutter/material.dart';

Widget defaultButton(
    {
       double width = double.infinity ,
       Color background = Colors.deepOrange,
      bool isUpperCase = true ,
      double radius = 10.0 ,
      required  function ,
      required String text,
    }
    ) =>  Container(
  width: width ,
  child: MaterialButton (
      onPressed: function ,
      child:  Text(
        isUpperCase ? text.toUpperCase() : text,
        style: TextStyle
          (
          color: Colors.white,
        ),
      )
  ),
  decoration:BoxDecoration(borderRadius: BorderRadius.circular(radius,),
    color: background  ,
  ) ,
);
Widget defalutTextButton({required  function, required String text}) =>
    TextButton(
        onPressed: function,
        child: Text(text.toUpperCase(),
        )
    );

Widget defaultFormField(
{
  required TextEditingController controller,
  required TextInputType type,
  onSubmit ,
  onChange,
  onTap,
  suffixPressed,
  required validate ,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool isPassword = false ,
  bool isClick = true ,
}
) => TextFormField (
        controller:  controller,
        keyboardType: type,
        obscureText: isPassword,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        onTap:onTap,
        enabled: isClick,
        validator: validate,
        decoration:  InputDecoration(
        labelText: label,
        prefixIcon: Icon(
        prefix,
        ),

          suffixIcon: suffix != null ? IconButton(
            onPressed: suffixPressed,
            icon: Icon(
              suffix,
            ),
          ) : null ,
        border: OutlineInputBorder(),
        ),
);

void navigateTo(context , widget) =>  Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context)  => widget,
  ),
);

void navigatefisnh(context , widget) =>  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context) => widget,
    ),
        (route) => false
);