import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/src/providers/db_provider.dart';

class MapsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ScanModel>>(
      future: DBProvider.db.getAllScans(),
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          return Platform.isAndroid
              ? Center(child: CircularProgressIndicator())
              : Center(child: CupertinoActivityIndicator());
        }

        final scans = snapshot.data;

        if (scans.length == 0) {
          return Center(child: Text('There\'s no data'));
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, index) => Dismissible(
                key: UniqueKey(),
                background: Container(
                  child: Icon(Icons.delete, color: Colors.white),
                  color: Colors.red,
                ),
                onDismissed: (direction) {
                  DBProvider.db.deleteScan(scans[index].id);
                },
                child: ListTile(
                  leading: Icon(
                    Icons.cloud,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(scans[index].value),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  ),
                ),
              ),
        );
      },
    );
  }
}
