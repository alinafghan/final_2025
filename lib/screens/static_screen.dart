import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_2025/blocs/data_cubit/data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StaticScreen extends StatefulWidget {
  const StaticScreen({super.key});

  @override
  State<StaticScreen> createState() => _StaticScreenState();
}

class _StaticScreenState extends State<StaticScreen> {
  List<String> list = [
    'https://picsum.photos/350/200',
    'https://picsum.photos/350/200',
    'https://picsum.photos/350/200'
  ];

  List<String> tileTitle = ['Netflix', 'Spotify', 'Netflix'];
  List<String> tileDate = ['15 Dec 2024', '14 Dec 2024', '12 Dec 2024'];
  List<String> tilePrice = ['\$15,48', '\$19,90', '\$15,48'];
  @override
  void initState() {
    context.read<DataCubit>().getAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.pink.shade100,
              const Color.fromARGB(255, 218, 196, 203),
              Colors.white,
            ],
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://fastly.picsum.photos/id/1026/200/200.jpg?hmac=CWxlEHUZLgcfP2qGDrSBD-5MXHOjsY-ic-LwDigTunc'),
              ),
            ),
            title: Text('Chards'),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _circularIcon(Icons.abc),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          body: SafeArea(
              child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          CarouselSlider(
                            items: list.map((item) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: NetworkImage(item))),
                                  );
                                },
                              );
                            }).toList(),
                            options: CarouselOptions(
                              height: 200,
                              enlargeCenterPage: true,
                              aspectRatio: 16 / 7,
                              viewportFraction: 0.85,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Last Activities',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                Text('Open All'),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 500,
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: tileDate.length,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      tileColor: Colors.white,
                                      leading: _circularIcon(Icons.star),
                                      title: Text(tileTitle[i]),
                                      subtitle: Text(tileDate[i]),
                                      trailing: Text(
                                        tilePrice[i],
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  );
                                }),
                          )
                        ],
                      )))),
          bottomNavigationBar: NavigationBar(
            backgroundColor: Colors.white,
            indicatorColor: Colors.white,
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                  icon: Icon(Icons.category_outlined), label: 'Cards'),
              NavigationDestination(
                  icon: Icon(Icons.account_circle), label: 'Pix'),
              NavigationDestination(
                  icon: Icon(Icons.account_circle), label: 'Notes'),
              NavigationDestination(
                  icon: Icon(Icons.account_circle), label: 'Extracts'),
            ],
          ),
        ));
  }

  Widget _circularIcon(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.pink.shade200, width: 2),
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: () {},
      ),
    );
  }
}
