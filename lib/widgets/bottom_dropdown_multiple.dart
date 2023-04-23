import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/widgets/my_button.dart';
import 'package:yolustunde_mobile/widgets/my_list_tile.dart';
import 'package:yolustunde_mobile/widgets/my_textfield.dart';

class BottomDropdownMultiple extends StatefulWidget {
  BottomDropdownMultiple({
    Key? key,
    required this.options,
    required this.onSelected,
    required this.selecteds,
    this.showCancelButton = false,
  }) : super(key: key);

  final List options;
  final List selecteds;
  final Function(String) onSelected;
  final bool showCancelButton;

  @override
  State<BottomDropdownMultiple> createState() => _BottomDropdownMultipleState();
}

class _BottomDropdownMultipleState extends State<BottomDropdownMultiple> {
  String? searchText;

  @override
  Widget build(BuildContext context) {
    List options = this.widget.options.where((element) => element.toLowerCase().contains(searchText ?? '')).toList();
    return StatefulBuilder(builder: (context, setState) {
      return Material(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: SafeArea(
          top: false,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.all(10).add(EdgeInsets.only(top: 20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: MyTextfield.white(
                        hintText: 'Ara',
                        onChanged: (val) {
                          setState(() {
                            searchText = val.toLowerCase();
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      bool selected = this.widget.selecteds.contains(options[index]);
                      return Column(
                        children: [
                          MyListTile(
                            onTap: () {
                              widget.onSelected(options[index]);
                              if (selected) {
                                this.widget.selecteds.remove(options[index]);
                              } else {
                                this.widget.selecteds.add(options[index]);
                              }
                              setState(() {});
                            },
                            child: Expanded(
                              child: Row(
                                children: [
                                  Text(options[index]),
                                  Spacer(),
                                  Opacity(opacity: selected ? 1 : 0, child: Icon(Icons.check)),
                                ],
                              ),
                            ),
                            showTrailing: false,
                          ),
                          Divider(),
                        ],
                      );
                    },
                  ),
                ),
                if (this.widget.showCancelButton)
                  MyButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: ('Tamam'),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
