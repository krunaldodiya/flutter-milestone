import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milestone/src/blocs/category/bloc.dart';
import 'package:milestone/src/blocs/category/state.dart';
import 'package:milestone/src/blocs/user/bloc.dart';
import 'package:milestone/src/blocs/user/state.dart';
import 'package:milestone/src/helpers/vars.dart';
import 'package:milestone/src/models/category.dart';
import 'package:milestone/src/screens/drawer.dart';
import 'package:milestone/src/screens/topics.dart';
import 'package:milestone/src/screens/users/view_profile.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPage createState() => _CategoryPage();
}

class _CategoryPage extends State<CategoryPage>
    with SingleTickerProviderStateMixin {
  CategoryBloc categoryBloc;
  UserBloc userBloc;

  @override
  void initState() {
    super.initState();

    setState(() {
      categoryBloc = BlocProvider.of<CategoryBloc>(context);
      userBloc = BlocProvider.of<UserBloc>(context);
    });

    categoryBloc.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        textTheme: TextTheme(
          title: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20.0,
            fontFamily: 'TitilliumWeb-Regular',
          ),
        ),
        title: Text(
          appName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20.0,
            fontFamily: 'TitilliumWeb-Regular',
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ViewProfilePage(),
                ),
              );
            },
            child: Hero(
              tag: "profile-image",
              child: BlocBuilder(
                bloc: userBloc,
                builder: (context, UserState state) {
                  return Container(
                    padding: EdgeInsets.all(10.0),
                    child: ClipOval(
                      child: Image.network(
                        "$baseUrl/users/${state.user.avatar}",
                        width: 36.0,
                        height: 36.0,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.0),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: BlocBuilder(
            bloc: categoryBloc,
            builder: (context, CategoryState state) {
              if (state.loaded == false) {
                return Center(child: CircularProgressIndicator());
              }

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: state.categories.length,
                itemBuilder: (context, int index) {
                  final Category category = state.categories[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return TopicsPage(category: category);
                          },
                        ),
                      );
                    },
                    child: Hero(
                      tag: category.id,
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.25),
                                BlendMode.dstATop,
                              ),
                              image: NetworkImage(
                                "$baseUrl/storage/${category.image}",
                              ),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  category.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                    fontFamily: "TitilliumWeb-SemiBold",
                                  ),
                                ),
                              ),
                              Container(margin: EdgeInsets.only(top: 10.0)),
                              Container(
                                child: Text(
                                  "${category.topics.length} Topics"
                                      .toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 14.0,
                                    fontFamily: "TitilliumWeb-SemiBold",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
      drawer: BlocBuilder(
        bloc: userBloc,
        builder: (context, UserState state) {
          return Drawer(
            child: DrawerPage(
              user: state.user,
            ),
          );
        },
      ),
    );
  }
}
