import 'package:blood_donation/constant/colors.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends ConsumerStatefulWidget {
  final String? label;
  final String? hint;
  final Function(dynamic)? onChanged;
  final Future<List<dynamic>> Function(String)? asyncItems;
  final String? selectedItem;
  final double? widthSize;
  final bool Function(dynamic, String)? filterfn;

  const CustomDropDown(
      {super.key,
      this.filterfn,
      required this.label,
      required this.hint,
      this.onChanged,
      this.asyncItems,
      this.selectedItem,
      this.widthSize});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends ConsumerState<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: DropdownSearch(
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
              label: Text(widget.label!),
              hintText: widget.hint!,
              hintStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: txtBorderColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: txtBorderColor)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: txtBorderColor))),
        ),
        dropdownButtonProps: const DropdownButtonProps(
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey,
            size: 18,
          ),
        ),
        asyncItems: widget.asyncItems,
        onChanged: widget.onChanged,
        filterFn: widget.filterfn,
        popupProps: const PopupProps.menu(
          menuProps: MenuProps(elevation: 16, backgroundColor: Colors.white),
          showSearchBox: true,
        ),
        selectedItem: widget.selectedItem,
      ),
    );
  }
}
