import 'package:flutter/material.dart';
import 'package:rooforall/ui/resources/utils/utils.dart';

class HousingItem extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String adress;
  final int surface;
  final int price;
  final int numberPieces;

  const HousingItem({Key key,
    this.imageUrl,
    this.description,
    this.adress,
    this.surface,
    this.price,
    this.numberPieces})
      : super(key: key);

  TextStyle getStyle(Color color, FontWeight fontWeight) {
    return TextStyle(
      fontFamily: Utils.customFont,
      color: color, 
      fontWeight: fontWeight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: InkWell(onTap: () {}, child: Image.network(imageUrl)),
        footer: GridTileBar(
          trailing: Text(
            '$surface m2',
            style: getStyle(Utils.customPurpleColor, FontWeight.bold),
          ),
          backgroundColor: Colors.black54,
          leading: Text(
            '$price €',
            style: getStyle(Colors.amber, FontWeight.bold),
          ),
          title: Text(
            adress,
            style: getStyle(Colors.white, FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
