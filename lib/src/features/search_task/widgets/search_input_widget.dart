import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nova_design_system/nova_design_system.dart';
import 'package:taski/src/core/constants/app_images.dart';
import 'package:taski/src/core/constants/app_strings.dart';

class SearchInputWidget extends StatefulWidget {
  const SearchInputWidget({
    required this.controller,
    required this.onChanged,
    required this.onClear,
    super.key,
  });
  final TextEditingController controller;
  final Function(String) onChanged;
  final Function() onClear;

  @override
  State<SearchInputWidget> createState() => _SearchInputWidgetState();
}

class _SearchInputWidgetState extends State<SearchInputWidget> {
  late Timer _debounce;

  void _onSearchChanged(String value) {
    _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      widget.onChanged(value);
    });
  }

  @override
  void dispose() {
    _debounce.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _debounce = Timer(const Duration(milliseconds: 500), () {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: UIAppColors.paleWhite,
          prefixIcon: SvgPicture.asset(
            AppImages.searchImage,
            fit: BoxFit.scaleDown,
          ),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.cancel_rounded,
              color: UIAppColors.mutedAzure,
            ),
            onPressed: () async {
              widget.onClear();
            },
          ),
          hintText: AppStrings.searchTask,
          hintStyle: context.textTheme.titleSmall?.copyWith(
            color: UIAppColors.mutedAzure,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: UIAppColors.mutedAzure),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: UIAppColors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
        ),
        onChanged: _onSearchChanged,
      ),
    );
  }
}
