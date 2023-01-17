import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) searchOnTap;
  final String? hint;
  const SearchBarWidget({
    Key? key,
    this.hint,
    required this.searchOnTap,
  }) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
      child: Column(
        children: [
          TextField(
            autofocus: false,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Color(0xFF000000), width: 3.0)),
                hintText: widget.hint,
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
                prefixIcon: Container(
                  padding: const EdgeInsets.all(15),
                  width: 18,
                  child: const Icon(Icons.search),
                )),
            onChanged: widget.searchOnTap,
          ),
        ],
      ),
    );
  }
}
