import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /*ScrollController scrollController = ScrollController();
  int max = 15;
  List test = [];

  @override
  void initState() {
    test = List.generate(max, ((index) => "num ${index + 1}"));
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        number();
      }
    });
  }

  number() {
    for (var i = max; i < max + 20; i++) {
      test.add("num ${i + 1}");
    }
    max += 20;
    setState(() {});
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 140,
          child: Image.asset('images/logo.png'),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              size: 30,
            ),
          ),
        ],
      ),
      body: /*ListView.builder(
        controller: scrollController,
        itemCount: test.length + 1,
        itemExtent: 80,
        itemBuilder: (context, index) {
          if (index == test.length) {
            return CircularProgressIndicator();
          }
          return Text(
            test[index].toString(),
            style: TextStyle(fontSize: 50),
          );
        },
      ),*/
          Container(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 12,
            //mainAxisSpacing: 12,
          ),
          itemCount: 8,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(top: 12),
              child: Stack(children: [
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://i.pinimg.com/originals/70/f8/9b/70f89be880db03d112133a6b37bd80aa.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Center(
                      child: const Text(
                        'Neon Genesis Evangelion',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ]),
            );
          },
        ),
      ),
    );
  }
}
