import 'package:flutter/material.dart';
import 'package:flutter_bloc1/constants/strings.dart';
import 'package:flutter_bloc1/data/model/character.dart';
import 'package:flutter_bloc1/constants/colors.dart';

class CharacterItem extends StatelessWidget {
  final Results characteritem;

  const CharacterItem({super.key, required this.characteritem});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      //to navigate from characterscreen to details screen.
      onTap: () => Navigator.pushNamed(context, character_details,
          arguments: characteritem),
      child: Hero(
        //*to make animation
        tag: characteritem.id!,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
          padding: const EdgeInsetsDirectional.all(4),
          decoration: BoxDecoration(
              color: colors.white, borderRadius: BorderRadius.circular(8)),
          child: GridTile(
            child: Container(
                color: colors.Grey,
                child: characteritem.image!.isNotEmpty //if the image exist
                    ? FadeInImage.assetNetwork(
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: 'assets/images/Loading.gif',
                        image: characteritem.image!)
                    : Image.asset("assets/images/download.jpg")),
            footer: Container(
              //container of the name
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                '${characteritem.name}',
                style: TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: colors.white,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
