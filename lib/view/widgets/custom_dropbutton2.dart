import 'package:attendance/constant/strings.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

customDropButton2({
  required BuildContext context,
  required dynamic controller,
  required List<DropdownMenuItem<String>>? items,
  required String? value,
  required void Function(String?)? onChanged,
  required TextEditingController? textcontroller,
}) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
        border: Border.all(color: Strings.primaryColor, width: 2),
        borderRadius: BorderRadius.circular(3)),
    child: DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        iconStyleData: IconStyleData(
          iconSize: 30,
          icon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.people,
              color: Strings.primaryColor,
            ),
          ),
        ),
        hint: Text(
          'Select',
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).hintColor,
          ),
        ),
        items: items,
        value: value,
        onChanged: onChanged,
        buttonStyleData: ButtonStyleData(height: 40),
        menuItemStyleData: MenuItemStyleData(height: 40),
        dropdownStyleData:
            DropdownStyleData(maxHeight: MediaQuery.of(context).size.width),
        dropdownSearchData: DropdownSearchData(
          searchController: textcontroller,
          searchInnerWidgetHeight: 40,
          searchInnerWidget: Padding(
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              // textCapitalization:
              //     TextCapitalization.characters,
              controller: textcontroller,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: 'Search ',
                hintStyle: const TextStyle(fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            final lowerCaseApplicationNumber =
                item.value.toString().toLowerCase();
            return lowerCaseApplicationNumber
                .contains(searchValue.toLowerCase());
          },
        ),
        // onMenuStateChange: (isOpen) {
        //   if (!isOpen) {
        //     textcontroller.clear();
        //   }
        // },
      ),
    ),
  );
}
