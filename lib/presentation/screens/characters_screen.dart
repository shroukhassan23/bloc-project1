import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc1/business_logic/cubit/cubit_cubit.dart';
import 'package:flutter_bloc1/data/model/character.dart';
import 'package:flutter_bloc1/constants/colors.dart';
import 'package:flutter_bloc1/data/web_services/characters_web_services.dart';
import 'package:flutter_bloc1/presentation/Widgets/characterItem.dart';
import 'package:flutter_offline/flutter_offline.dart';

class characters_screen extends StatefulWidget {
  const characters_screen({Key? key}) : super(key: key);
  @override
  State<characters_screen> createState() => _characters_screenState();
}

class _characters_screenState extends State<characters_screen> {
  late List<Results>? allcharacters;
  late List<Results>? searchedforresults;
  bool issearching = false;
  final searchtextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CubitCubit>(context).getAllcharacters();
    //*call the cubit to take the data from it.
  }

  /* Future<void> loadAllCharacters() async {
    final loadcharacters =
        await BlocProvider.of<CubitCubit>(context).getAllcharacters();
    setState(() {
      allcharacters = loadcharacters;
    });
  }*/
  //!
  /* Future<dynamic> characterwebservice() {
    final webservice = characterswebServices().getAllcharacters();
    return webservice;
  }*/
  Widget BuildsearchField() {
    return TextField(
      controller: searchtextController,
      cursorColor: colors.Grey,
      decoration: InputDecoration(
        hintText: 'Find a character...',
        hintStyle: TextStyle(color: colors.Grey, fontSize: 18),
      ),
      style: const TextStyle(color: Color.fromARGB(255, 7, 8, 8), fontSize: 18),
      onChanged: (searchedcharacetr) {
        addsearcheditemsonlytolist(searchedcharacetr);
      },
    );
  }

  void addsearcheditemsonlytolist(String searchedcharacetr) {
    searchedforresults = allcharacters!
        .where((character) =>
            character.name!.toLowerCase().startsWith(searchedcharacetr))
        .toList(); //*to filter rhe list of characters
    setState(() {});
  }

  List<Widget> _buildAppbaritem() {
    if (issearching) {
      return [
        IconButton(
          icon: const Icon(
            Icons.clear,
            color: colors.Grey,
          ),
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startsearch,
          icon: const Icon(Icons.search),
          color: colors.Grey,
        )
      ];
    }
  }

  void _startsearch() {
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(
        onRemove:
            _stopsearching)); //*if is exist any word in search fild route to another appbar &when remove clear the search fild and pur the state issearching=false.
    setState(() {
      issearching = true;
    });
  }

  void _stopsearching() {
    //*when remove the word clear the search fild and put the state issearching=false.
    _clearSearch();
    setState(() {
      issearching = false;
    });
  }

  void _clearSearch() {
    //*clear search field
    searchtextController.clear();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CubitCubit, CubitState>(
      builder: (context, state) {
        if (state is charactersloaded) {
          allcharacters = (state)
              .characterss; //*all characters take the value of list in characetrs loaded
          return buildLoadedListWidget();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }
  /* Widget buildBlocWidget() {
    return FutureBuilder<List<Results>?>(
      future: BlocProvider.of<CubitCubit>(context).getAllcharacters(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return showLoadingIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          allcharacters = snapshot.data!;
          return buildLoadedListWidget();
        } else {
          return Text('No data available');
        }
      },
    );
  }*/

  buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: colors.Grey, //background comntainer
        child: Column(
          children: [buildCharactersList()],
        ),
      ),
    );
  }

  Widget showLoadingIndicator() {
    //*loading mark
    return Center(
      child: CircularProgressIndicator(
        color: colors.Yellow,
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: searchtextController.text
              .isEmpty //*Creates a scrollable, 2D array of widgets that are created on demand.
          ? allcharacters!.length
          : searchedforresults!.length,
      itemBuilder: (cotext, index) {
        //ToDo:not done
        if (allcharacters != null) {
          return CharacterItem(
            characteritem: searchtextController.text
                    .isEmpty //*if the search field empty return the complete list -->else return filtered list.
                ? allcharacters![index]
                : searchedforresults![index],
          );
        } else {
          print("all characters is null");
        }
      },
    );
  }

  Widget BuildAppBartitle() {
    return Text(
      "Characters",
      style: TextStyle(color: Colors.black, fontSize: 20),
    );
  }

  Widget BuildnoInterntWidget() {
    return Container(
      child: Center(
          child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Text(
            "No Internet Connection.",
            style: TextStyle(
                color: const Color.fromARGB(255, 248, 51, 36),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Image.asset("assets/images/nosignal.png")
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.orange,
        // leading: ,
        title: issearching
            ? BuildsearchField()
            : BuildAppBartitle(), //if issearching return the search field else return the title
        actions: _buildAppbaritem(), //*the conditions of is searching or not.
      ),
      body: OfflineBuilder(
        connectivityBuilder: ((BuildContext context,
            ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return buildBlocWidget();
          } else {
            return BuildnoInterntWidget();
          }
        }),
        child: Container(),
      ),
    );
  }
}
