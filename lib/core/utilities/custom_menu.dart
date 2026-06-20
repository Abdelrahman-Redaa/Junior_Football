import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';

class CustomMenu<T> extends StatelessWidget {
  const CustomMenu({
    super.key,
    required this.hintText,
    this.onChange,
    required this.items,
    this.itemBuilder,
  });

  final String hintText;
  final void Function(T?)? onChange;
  final List<T> items;

  final String Function(T value)? itemBuilder;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return DropdownButtonFormField<T>(
      borderRadius: BorderRadius.circular(10.r),

      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: theme.medium14.copyWith(
          color: theme.neutral,
        ),
      ),

      items: items.map(
            (item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(
              itemBuilder?.call(item) ??
                  item.toString(),
            ),
          );
        },
      ).toList(),

      onChanged: onChange,
    );
  }
}