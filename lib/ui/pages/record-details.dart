import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:rooforall/data/provider/user_provider.dart';
import 'package:rooforall/ui/resources/utils/theme_notif.dart';
import 'package:rooforall/ui/resources/utils/utils.dart';
import 'package:rooforall/ui/resources/widgets/housing-item.dart';

class RecordDetails extends StatefulWidget {
  final int id;

  static const routeName = "/record-details";

  const RecordDetails({Key key, this.id}) : super(key: key);

  @override
  _RecordDetailsState createState() => _RecordDetailsState();
}

class _RecordDetailsState extends State<RecordDetails> {
  TextStyle getStyle() {
    return TextStyle(
      fontFamily: Utils.customFont,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    var _darkTheme = true;
    final themeNotifier = Provider.of<ThemeNotif>(context);
    _darkTheme = (themeNotifier.getTheme() == Utils.darktheme);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: !_darkTheme ? Utils.customPurpleColor : Colors.black,
        title: Text(
          'Details du dossier',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: Utils.customFont),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: userProvider.getRecordById(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("SNAPSHOT ${snapshot.data}");
            return GridView.builder(
              itemCount: snapshot.data['houseList'].length ?? 0,
              itemBuilder: (ctx, index) {
                return HousingItem(
                  surface: snapshot.data['houseList'][index]['surface'],
                  description: snapshot.data['houseList'][index]['description'],
                  adress: snapshot.data['houseList'][index]['address'],
                  price: snapshot.data['houseList'][index]['price'],
                  numberPieces: snapshot.data['houseList'][index]['rooms'],
                  imageUrl: snapshot.data['houseList'][index]['mainImage'] ?? '',
                );
              },
              padding: const EdgeInsets.all(25),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 80,
                  mainAxisSpacing: 10),
            );

//                Container(
//                  color: Utils.customGreenColor,
//                  margin: EdgeInsets.only(top: 20),
//                  height: MediaQuery.of(context).size.height / 4,
//                  width: MediaQuery.of(context).size.width / 1.2,
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Text(
//                        snapshot.data["habitatType"] ?? '',
//                        style: getStyle(),
//                      ),
//                      Text('${snapshot.data["budgetMin"]}' ?? '',
//                          style: getStyle()),
//                      Text(
//                        '${snapshot.data["budgetMax"]}',
//                        style: getStyle(),
//                      ),
//                      Text(
//                        '${snapshot.data["habitationSurface"]}' ?? '',
//                        style: getStyle(),
//                      ),
//                      Text(
//                        snapshot.data["town"] ?? '',
//                        style: getStyle(),
//                      ),
//                    ],
//                  ),
//                ),
//                    ListView.builder(
//                      itemBuilder: (ctx, index) {
//                        return Container(
//                          child: Text(
//                              snapshot.data['address']),
//                        );
//                      },
//                      itemCount: snapshot.data['houseList'].length ?? 0,
//                    ),
//                    snapshot.data['houseList'].length != 0
//                        ? Container()
//                        : Container(
//                            child: Text('Aucun logement trouve pour le moment'),
//                          )
//                  ],

          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
