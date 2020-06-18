import 'package:basketball/fixtures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'add_fixture_dialog.dart';
import 'fixtures_database_util.dart';

class FixtureDashboard extends StatefulWidget {

  FixtureDashboard({Key key,this.fixture})
      : super(key: key);


  final FirebaseUser fixture;


  @override
  _FixtureDashboardState createState() => new _FixtureDashboardState();
}

class _FixtureDashboardState extends State<FixtureDashboard> implements AddFixtureCallback {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  bool _anchorToBottom = false;
  FirebaseDatabaseUtil databaseUtil;

  @override
  void initState() {
    super.initState();
    databaseUtil = new FirebaseDatabaseUtil();
    databaseUtil.initState();
  }

  @override
  void dispose() {
    super.dispose();
    databaseUtil.dispose();
  }








  @override
  Widget build(BuildContext context) {

    Widget _buildTitle(BuildContext context) {
      return new InkWell(
        child: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                'Live Matches',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );

    }

//    List<Widget> _buildActions() {
//      return <Widget>[
//        new IconButton(
//          icon: const Icon(
//            Icons.group_add,
//            color: Colors.white,
//          ),
//          onPressed: () {},
//        ),
//      ];
//    }

    return Container(
      child: new Scaffold(
        key: _scaffoldKey,


        appBar: AppBar(
          title: Text(
            "Scores",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.grey,
        ),

        body: new FirebaseAnimatedList(

          key: new ValueKey<bool>(_anchorToBottom),
          query: databaseUtil.getFixture(),



          reverse: _anchorToBottom,
          sort: _anchorToBottom
              ? (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key)
              : null,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            return new SizeTransition(
              sizeFactor: animation,
              child: showFixture(snapshot),


            );


          },



        ),


        backgroundColor: Colors.white,
      ),
    );

  }


  @override
  void addFixture(Fixture fixture) {
    setState(() {
      databaseUtil.addFixture(fixture);
    });
  }

  @override
  void update(Fixture fixture) {
    setState(() {
      databaseUtil.updateFixture(fixture);
    });
  }


  Widget showFixture(DataSnapshot res) {
    Fixture fixture = Fixture.fromSnapshot(res);

    var item = new Card(
elevation: 40,
      child: new Container(width: 500,
          child: new Center(
            child: new Row(
              children: <Widget>[

                new Expanded(
                  child: new Padding(
                    padding: EdgeInsets.all(10.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        new Text(
                          fixture.match,
                          // set some style to text
                          style: new TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 20.0, color: Colors.brown),
                        ),
                        SizedBox(height: 30,),
                        new Text(
                         " Current Scores",
                          // set some style to text
                          style: new TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 20.0, color: Colors.black),
                        ),
                        SizedBox(height: 10,),

                        SingleChildScrollView(
                          child: Row(
                            children: <Widget>[
                              new Text(
                                fixture.hometeam,
                                // set some style to text
                                style: new TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 15.0, color: Colors.black),
                              ),
                              SizedBox(width: 20,),
                              new Text(
                               " VS",
                                // set some style to text
                                style: new TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 30.0, color: Colors.black),
                              ),

                              SizedBox(width: 20,),
                              new Text(
                                fixture.awayteam,
                                // set some style to text
                                style: new TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 15.0, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        new Text("Quater :" +  " "   +
                          fixture.quater,
                          // set some style to text
                          style: new TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 20.0, color: Colors.black),
                        ),
                        SizedBox(height: 30,),
                        new Text(
                          fixture.start_stop,
                          // set some style to text
                          style: new TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 20.0, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0)),
      color: Colors.grey,
    );

    return item;
  }

  String getShortName(Fixture fixture) {
    String shortName = "";
    if (!fixture.match.isEmpty) {
      shortName = fixture.match.substring(0, 1);
    }
    return shortName;
  }

  showEditWidget(Fixture fixture, bool isEdit) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          new AddFixtureDialog().buildAboutDialog(context, this, isEdit, fixture),
    );
  }

  deleteFixture(Fixture fixture) {
    setState(() {
      databaseUtil.deleteFixture(fixture);
    });

  }






}


