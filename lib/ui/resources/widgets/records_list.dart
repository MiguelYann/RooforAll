import 'package:flutter/material.dart';
import 'package:rooforall/ui/resources/utils/utils.dart';

class RecordList extends StatelessWidget {
  final List<dynamic> datas;

  const RecordList({this.datas});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (ctx, index) => SizedBox(
        height: 60,
        child: Divider(
          color: Utils.customPurpleColor,
        ),
      ),
      padding: EdgeInsets.all(30),
      itemBuilder: (ctx, index) => SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.height/5,
          decoration: BoxDecoration(
              color: Utils.customGreenColor,
              borderRadius: BorderRadius.circular(40)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    "${index + 1}",
                    style: TextStyle(
                      color: Utils.customPurpleColor,
                      fontFamily: Utils.customFont,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  border: Border.all(style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(40),
                ),
                height: 20,
                width: 20,
              ),
              Center(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.location_city,
                      size: 40,
                      color: Colors.amber,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${datas[index]["habitatType"].toUpperCase()}",
                      style: TextStyle(
                        color: Utils.customPurpleColor,
                        fontFamily: Utils.customFont,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 80, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.edit_location,
                      color: Colors.amber,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      datas[index]["town"],
                      style: TextStyle(
                          color: Utils.customPurpleColor,
                          fontFamily: Utils.customFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      itemCount: datas.length,
    );
  }
}