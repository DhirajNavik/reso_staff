import 'package:attendance/constant/strings.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDownWithSearch extends StatefulWidget {
  final BuildContext context;
  final TextEditingController searchController;
  final Function(String?)? onChanged;
  final String hint;
  final dynamic list;

  const DropDownWithSearch(
      {super.key,
      required this.context,
      required this.searchController,
      required this.onChanged,
      required this.hint,
      this.list});

  @override
  State<DropDownWithSearch> createState() => _DropDownWithSearchState();
}

class _DropDownWithSearchState extends State<DropDownWithSearch> {
  // final List<String> _list = [
  //   "Follow",
  //   "lakshydeep-14",
  //   "on",
  //   "Github",
  //   "Medium",
  //   "LinkedIn"
  // ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 400,
      decoration: BoxDecoration(
          border: Border.all(color: Strings.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Expanded(
              child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
                hint: Text(
                  widget.hint,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                onChanged: widget.onChanged,
                items: [
                  ...widget.list.map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                ],
                dropdownSearchData: DropdownSearchData(
                  searchController: widget.searchController,
                  searchInnerWidgetHeight: 40,
                  searchInnerWidget: Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      controller: widget.searchController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'Search for item',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                )),
          ))
        ],
      ),
    );
  }
}
