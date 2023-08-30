import 'package:flutter/material.dart';
import 'package:flutter_bloc1/constants/colors.dart';

import 'package:flutter_bloc1/data/model/character.dart';

class Character_details extends StatelessWidget {
  final Results result;
  const Character_details({
    Key? key,
    required this.result,
  }) : super(key: key);
  Widget BuildSliverAppBar() {
    return SliverAppBar(
      //App Bar when stretch the container to top
      //control the image
      expandedHeight: 550,
      pinned: true,
      stretch: true,
      backgroundColor: colors.orange,
      flexibleSpace: FlexibleSpaceBar(
        //what written in app bar
        title: Text(
          result.name!,
          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        background: Hero(
            //back ground is image
            tag: result.id!,
            child: Image.network(
              result.image!,
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Widget characterinfo(String title, String value) {
    return RichText(
      //to more control over the text
      text: TextSpan(children: [
        TextSpan(
            text: title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colors.white)),
        TextSpan(
            text: value, style: TextStyle(fontSize: 16, color: colors.white))
      ]),
      maxLines: 1,
      overflow: TextOverflow.ellipsis, //!
    );
  }

  Widget BuildDivider(double endIndent) {
    //to make line
    return Divider(
      color: colors.orange,
      height: 30,
      endIndent: endIndent, //the length of the line
      thickness: 4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.Grey,
      body: CustomScrollView(
        slivers: [
          BuildSliverAppBar(),
          SliverList(
            //container of info about character
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start, //!
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterinfo('species: ', result.species!),
                    BuildDivider(250),
                    characterinfo('status: ', result.status!),
                    BuildDivider(265),
                    characterinfo('gender: ', result.gender!),
                    BuildDivider(260),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              SizedBox(
                //to make more space from bottom
                height: 500,
              )
            ]),
          )
        ],
      ),
    );
  }
}
