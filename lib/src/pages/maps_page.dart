import 'package:qr_code_scanner/src/bloc/scan_bloc.dart';
import 'package:qr_code_scanner/src/models/scan_model.dart';

import 'package:qr_code_scanner/src/utils/utils.dart' as utils;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:io';

class MapsPage extends StatelessWidget {
  final scanBloc = new ScanBloc();

  @override
  Widget build(BuildContext context) {
    scanBloc.getScans();

    return StreamBuilder<List<ScanModel>>(
      stream: scanBloc.scanStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          return Platform.isAndroid
              ? Center(
                  child: CircularProgressIndicator(
                  backgroundColor: Colors.green,
                  valueColor: AlwaysStoppedAnimation(Colors.green[800]),
                ))
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
                onDismissed: (direction) =>
                    scanBloc.deleteScan(scans[index].id),
                child: ListTile(
                  leading: Icon(
                    Icons.zoom_out_map,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(scans[index].value),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  ),
                  onTap: () => utils.launchScan(context, scans[index]),
                ),
              ),
        );
      },
    );
  }
}
