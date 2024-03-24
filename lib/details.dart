// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Elaborate extends StatefulWidget {
  Map data;
  String did;
  Elaborate(this.data, this.did);
  @override
  State<Elaborate> createState() => _ElaborateState();
}

class _ElaborateState extends State<Elaborate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.data["name"],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "OpenSans",
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10, left: 8, right: 8, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(20),
                height: 150,
                width: double.infinity,
                child: Hero(
                  tag: widget.data,
                  child: Image.asset(
                    widget.data["url"],
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        widget.data["description"],
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: "Times",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: DataTable(
                  columns: const [
                    DataColumn(
                      label: Text(
                        '',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                        label: Text(
                      '',
                    )),
                  ],
                  rows: [
                    DataRow(cells: [
                      const DataCell(Text('Quantity Available')),
                      DataCell(
                        Text(
                          widget.data["stock"],
                          maxLines: 50,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Price')),
                      DataCell(Text(widget.data["price"])),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
