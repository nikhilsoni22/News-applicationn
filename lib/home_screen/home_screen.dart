import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:practice/api_integrate/new_view_model.dart';
import 'package:practice/backup/img_back.dart';
import 'package:practice/backup/spinkit_up.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:practice/home_screen/category_screen.dart';
import 'package:practice/home_screen/news_detail_screen.dart';
import 'package:practice/model/catergory_model.dart';

class homeScreen extends StatefulWidget {
  homeState createState() => homeState();
}

enum FilterList {
  bbcNews,
  aryNews,
  independent,
  reuters,
  cnn,
  alJazeera,
  googleNews
}

class homeState extends State<homeScreen> {

  String name = 'bbc-news';


  newsViewModel NewsViewModel = newsViewModel();

  FilterList? selectedMenu;


  final format = DateFormat('MMM dd, yyyy');


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .sizeOf(context)
        .height * 1;
    final width = MediaQuery
        .sizeOf(context)
        .width * 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            DotsImg,
            height: 30,
            width: 30,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => categoryScreen(),));
          },
        ),
        title: Center(
            child: Text(
              'News',
              style: GoogleFonts.acme(),
            )),
        actions: [
          PopupMenuButton<FilterList>(
            icon: Icon(Icons.more_vert, color: Colors.black,),
            onSelected: (FilterList item) {
              if (FilterList.bbcNews.name == item.name) {
                name = 'bbc-news';
              }
              if (FilterList.aryNews.name == item.name) {
                name = 'ary-news';
              }
              if (FilterList.alJazeera.name == item.name) {
                name = 'al-jazeera-english';
              }
              if (FilterList.independent.name == item.name) {
                name = 'independent';
              }
              if (FilterList.cnn.name == item.name) {
                name = 'cnn';
              }
              if (FilterList.googleNews.name == item.name) {
                name = 'google-news-in';
              }
              setState(() {
                selectedMenu = item;
              });
            },
            initialValue: selectedMenu,
            itemBuilder: (context) =>
            <PopupMenuEntry<FilterList>>[
              PopupMenuItem<FilterList>(
                  value: FilterList.bbcNews, child: Text('BBC News')),

              PopupMenuItem<FilterList>(
                  value: FilterList.aryNews, child: Text('ary News')),

              PopupMenuItem<FilterList>(
                  value: FilterList.independent, child: Text('Independent')),

              PopupMenuItem<FilterList>(
                  value: FilterList.reuters, child: Text('Reuters')),

              PopupMenuItem<FilterList>(
                  value: FilterList.alJazeera, child: Text('Al Janzeera')),

              PopupMenuItem<FilterList>(
                  value: FilterList.cnn, child: Text('Cnn')),

              PopupMenuItem<FilterList>(
                  value: FilterList.googleNews,
                  child: Text('Google-News India')),
            ],
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder(
              future: NewsViewModel.headlines(name),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: circleSpin,
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(snapshot
                          .data!.articles![index].publishedAt
                          .toString());

                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => NewsDetailScreen(
                                newImage: snapshot
                                    .data!.articles![index].urlToImage
                                    .toString(),
                                newsTitle: snapshot
                                    .data!.articles![index].title
                                    .toString(),
                                newsDate:snapshot
                                    .data!.articles![index].publishedAt
                                    .toString(),
                                author: snapshot
                                    .data!.articles![index].author
                                    .toString(),
                                description: snapshot
                                    .data!.articles![index].description
                                    .toString(),
                                content: snapshot
                                    .data!.articles![index].content
                                    .toString(),
                                source: snapshot
                                    .data!.articles![index].source!.name
                                    .toString()),));
                        },
                        child: SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: height * 0.6,
                                width: width * 0.9,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: height * 0.02),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context,
                                          url) => fadingCircle,
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                            Icons.error_outline,
                                            color: Colors.red,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                child: Card(
                                  elevation: 5,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    height: height * 0.22,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Container(
                                          width: width * 0.7,
                                          child: Text(
                                            snapshot.data!.articles![index]
                                                .title
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.05,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              snapshot.data!.articles![index]
                                                  .source!.name
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              width: width * 0.1,
                                            ),
                                            Text(
                                              format.format(dateTime),
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700),
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding:  EdgeInsets.all(20),
            child: FutureBuilder<categoryModel>(
              future: NewsViewModel.category('general'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: fadingCircle,
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,

                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, index) {
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return Padding(
                          padding:  EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot
                                      .data!.articles![index].urlToImage
                                      .toString(),
                                  fit: BoxFit.cover,
                                  height: height * .18,
                                  width: width * .3,
                                  placeholder: (context, url) =>
                                      Container(
                                        child: circleSpin,
                                      ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error_outline),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                    height: height * .18,
                                    padding: EdgeInsets.only(left: 15),
                                    child: Column(
                                      children: [
                                        Text(
                                          snapshot.data!.articles![index].title
                                              .toString(),
                                          maxLines: 2,
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Spacer(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text(
                                              snapshot
                                                  .data!.articles![index]
                                                  .source!.name
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              format.format(dateTime),
                                              style: GoogleFonts.poppins(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
