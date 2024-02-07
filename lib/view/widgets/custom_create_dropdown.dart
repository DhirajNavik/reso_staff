import 'package:attendance/constant/strings.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

customSearchDropDown(
    {required String title,
    required BuildContext context,
    required List<String> items,
    required TextEditingController textEditingController,
    required String? selectedValue,
    bool? prefix,
    bool? isDistrict,
    String? errorText,
    required void Function(String?)? onChanged}) {
  return SizedBox(
    child: DropdownButtonHideUnderline(
      child: DropdownButtonFormField2<String>(
        isDense: true,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Strings.primaryColor, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Strings.primaryColor, width: 2),
            )),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return errorText;
          }
          return null;
        },
        alignment: prefix != true
            ? Alignment(-0.71, 0)
            : AlignmentDirectional.centerStart,
        isExpanded: true,
        hint: Row(
          children: [
            Text(
              title,
            ),
          ],
        ),
        items: items
            .toSet()
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: onChanged,
        buttonStyleData: ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: 200,
            height: 45),
        dropdownStyleData: const DropdownStyleData(maxHeight: 200),
        menuItemStyleData: const MenuItemStyleData(height: 40),
        dropdownSearchData: DropdownSearchData(
          searchController: textEditingController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 50,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              expands: true,
              maxLines: null,
              controller: textEditingController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: 'Search',
                hintStyle: const TextStyle(fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            final searchLower = searchValue.toLowerCase();
            final itemlLower = item.value.toString().toLowerCase();
            return itemlLower.contains(searchLower);
          },
        ),
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            textEditingController.clear();
          }
        },
      ),
    ),
  );
}
