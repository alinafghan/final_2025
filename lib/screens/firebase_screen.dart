import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_2025/blocs/data_cubit/data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirebaseScreen extends StatefulWidget {
  const FirebaseScreen({super.key});

  @override
  State<FirebaseScreen> createState() => _FirebaseScreenState();
}

class _FirebaseScreenState extends State<FirebaseScreen> {
  List<IconData> iconsList = [
    Icons.airplane_ticket,
    Icons.abc,
    Icons.abc,
    Icons.abc_outlined,
    Icons.more
  ];
  List<String> iconTitle = [
    'Earn 100%',
    'Tax Note',
    'Primum',
    'Challenge',
    'More'
  ];

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
            Colors.white,
            Colors.white,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://fastly.picsum.photos/id/1026/200/200.jpg?hmac=CWxlEHUZLgcfP2qGDrSBD-5MXHOjsY-ic-LwDigTunc'),
                    ),
                    title: Text('Wilson Junior'),
                    subtitle: Text('Premium'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _circularIcon(Icons.present_to_all),
                        SizedBox(width: 10),
                        _circularIcon(Icons.notifications),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              hintText: 'Search',
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.grey),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        _circularIcon(Icons.share),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: iconsList.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              _circularIcon(iconsList[i]),
                              SizedBox(height: 5),
                              Text(iconTitle[i],
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<DataCubit, DataState>(
                    builder: (context, state) {
                      if (state is GetAllDataLoaded && state.list.isNotEmpty) {
                        return CarouselSlider(
                          items: state.list.map((item) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 200,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    'assets/carousel_bg.jpg'),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(height: 4),
                                                      Text.rich(
                                                        TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  'Shop with ',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black87,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: '100%',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    Colors.pink,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: ' cashback',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black87,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 3),
                                                      Text(
                                                        'On Shopee',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[800]),
                                                      ),
                                                      SizedBox(height: 8),
                                                      Row(
                                                        children: [
                                                          ElevatedButton.icon(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Colors.pink,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                              ),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          16,
                                                                      vertical:
                                                                          8),
                                                            ),
                                                            onPressed: () {},
                                                            icon: Icon(
                                                                Icons
                                                                    .arrow_forward,
                                                                color: Colors
                                                                    .white),
                                                            label: Text(
                                                              'I want!',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            'Best offer!',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black87),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: -20,
                                            right: 30,
                                            child: Image.network(
                                              item.imageUrl,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          // Text(
                                          //   item.name,
                                          //   style: TextStyle(
                                          //     fontSize: 18,
                                          //     fontWeight: FontWeight.bold,
                                          //     color: Colors.black87,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }).toList(),
                          options: CarouselOptions(
                            height: 200,
                            enlargeCenterPage: true,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.85,
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Most Popular Offer',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        Text('See All'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: BlocBuilder<DataCubit, DataState>(
                      builder: (context, state) {
                        if (state is GetAllDataLoaded) {
                          return ListView.builder(
                              itemCount: state.list.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Card(
                                          child: Center(
                                            child: Stack(children: [
                                              Positioned(
                                                  top: 5,
                                                  right: 5,
                                                  child: Icon(Icons.favorite)),
                                              Image.network(
                                                state.list[i].imageUrl,
                                                height: 180,
                                                width: 180,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                            ]),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            state.list[i].name,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: 10),
                                          Icon(
                                            Icons.money,
                                            color: Colors.black,
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Text(state.list[i].description,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ))
                                    ],
                                  ),
                                );
                              });
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
      ),
    );
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
