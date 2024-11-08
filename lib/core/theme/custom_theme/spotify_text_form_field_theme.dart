import 'package:flutter/material.dart';

abstract class SpotifyTextFormFieldTheme
{
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    contentPadding: const EdgeInsets.only(left: 27,top: 29,bottom: 29),
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle:  const TextStyle().copyWith(fontSize: 16,color: Colors.black),
    hintStyle:   const TextStyle().copyWith(fontSize: 16,color: const Color(0xff383838).withOpacity(0.6)),
    errorStyle:  const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(color: Colors.black.withOpacity(0.8)),
    border:  const OutlineInputBorder().copyWith(
      borderRadius:  BorderRadius.circular(30),
      borderSide:  BorderSide(width: 1,color: const Color(0xff000000).withOpacity(0.2)),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius:  BorderRadius.circular(30),
      borderSide:  BorderSide(width: 1,color: const Color(0xff000000).withOpacity(0.2)),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius:  BorderRadius.circular(30),
      borderSide: const BorderSide(width: 1,color: Colors.black12),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius:  BorderRadius.circular(30),
      borderSide: const BorderSide(width: 1,color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius:  BorderRadius.circular(30),
      borderSide: const BorderSide(width: 1,color: Colors.orange),
    )
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
      errorMaxLines: 3,
      contentPadding: const EdgeInsets.only(left: 27,top: 29,bottom: 29),
      prefixIconColor: Colors.grey,
      suffixIconColor: Colors.grey,
      labelStyle:  const TextStyle().copyWith(fontSize: 16,color: Colors.white),
      hintStyle:   const TextStyle().copyWith(fontSize: 16,color: const Color(0xffA7A7A7).withOpacity(0.6)),
      errorStyle:  const TextStyle().copyWith(fontStyle: FontStyle.normal),
      floatingLabelStyle: const TextStyle().copyWith(color: Colors.black.withOpacity(0.8)),
      border:  const OutlineInputBorder().copyWith(
        borderRadius:  BorderRadius.circular(30),
        borderSide:  BorderSide(width: 1,color: const Color(0xffFFFFFF).withOpacity(0.14)),
      ),
      enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius:  BorderRadius.circular(30),
        borderSide:  BorderSide(width: 1,color: const Color(0xffFFFFFF).withOpacity(0.14)),
      ),
      focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius:  BorderRadius.circular(30),
        borderSide: const BorderSide(width: 1,color: Colors.white),
      ),
      errorBorder: const OutlineInputBorder().copyWith(
        borderRadius:  BorderRadius.circular(30),
        borderSide: const BorderSide(width: 1,color: Colors.red),
      ),
      focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius:  BorderRadius.circular(30),
        borderSide: const BorderSide(width: 1,color: Colors.orange),
      )
  );
}