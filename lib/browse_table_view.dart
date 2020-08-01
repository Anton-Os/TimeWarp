import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timewarpsoc/helper/db_logic.dart';

import 'package:timewarpsoc/timeline_screen.dart';
import 'package:timewarpsoc/create_screen.dart';

class BrowseTableView extends StatefulWidget { //
  const BrowseTableView({Key key, this.MQ}) : super(key: key);

  final MediaQueryData MQ;
  static SearchRecords_FirebaseDB remoteDB = new SearchRecords_FirebaseDB();
  static SavedPrefsData savedPrefsData = new SavedPrefsData();
  static Iterable<MapEntry<String, dynamic>> searchRecords;

  static const Color bkColor = Color(0xFF193947);
  static const Color createBtnColor = Color(0xFF14ff9c);
  static const Color showBtnColor = Color(0xFF14cc9c);
  static const Color timelineBtnColor = Color(0xFF4368a3);
  static const Color createdBtnColor = Color(0xFF9963e0);
  static const TextStyle timelineBtnScriptL = TextStyle( fontSize: 9, color: Color(0xFFb2c8eb), decoration: TextDecoration.none, fontFamily: 'Amita');
  static const TextStyle timelineBtnScriptS = TextStyle( fontSize: 5.5, color: Color(0xFFb2c8eb), decoration: TextDecoration.none, fontFamily: 'Amita');
  static const TextStyle lowBtnScript = TextStyle( fontSize: 9, color: Color(0xFF193947), decoration: TextDecoration.none, fontFamily: 'EBGaramond');

  @override
  _BrowseTableView createState() => _BrowseTableView();
}

class _BrowseTableView extends State<BrowseTableView> {

  @override
  Widget build(BuildContext context) {
    Widget listDataDisplay =
    FutureBuilder(
        future: Future.wait([BrowseTableView.savedPrefsData.init(), BrowseTableView.remoteDB.init()]),
        builder: (context, snapshot){

          BrowseTableView.searchRecords = BrowseTableView.remoteDB.getRecords(
              BrowseTableView.savedPrefsData.exclusionIndices,
              BrowseTableView.savedPrefsData.creationIndices
          );

          return
            ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: (snapshot.hasData) ? BrowseTableView.searchRecords.length : 0, // SNAPSHOT GOD!
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                      height: 20,
                      child: Row( // TODO: Load elements from another view class!
                          children: <Widget>[
                            Expanded(
                              flex: 12,
                              child:
                              SizedBox.expand(
                                  child:
                                  FlatButton(
                                      color: (index > BrowseTableView.savedPrefsData.creationIndices.length - 1)? BrowseTableView.timelineBtnColor : BrowseTableView.createdBtnColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(3.0),
                                              bottomLeft: Radius.circular(3.0))
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context, MaterialPageRoute(builder: (context) =>
                                            TimelineScreen(
                                                MQ: widget.MQ,
                                                documentId: BrowseTableView.searchRecords.elementAt(index).key.toString(),
                                                documentName: BrowseTableView.searchRecords.elementAt(index).value.toString(),
                                            ))
                                        );
                                      },
                                      child: Text(BrowseTableView.searchRecords.elementAt(index).value.toString(),
                                          style: (BrowseTableView.searchRecords.elementAt(index).value.toString().length < 28)
                                              ? BrowseTableView.timelineBtnScriptL : BrowseTableView.timelineBtnScriptS
                                      )
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child:
                              SizedBox.expand(
                                  child:
                                  RaisedButton(
                                      color: BrowseTableView.timelineBtnColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(3.0),
                                              bottomRight: Radius.circular(3.0))
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          BrowseTableView.savedPrefsData.addExclusionIndex(index);
                                        });
                                      },
                                      child: Text("X", textAlign: TextAlign.right,
                                          style: BrowseTableView.timelineBtnScriptL
                                      )
                                  )
                              ),
                            )
                          ]
                      )
                  );
                });
        });

    Widget gridDataDisplay =
    FutureBuilder(
        future: BrowseTableView.remoteDB.init(),
        builder: (context, snapshot){
          return
            GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: BrowseTableView.remoteDB.searchRecMap.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 8.0),
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                      // color: BrowseTableView.timelineBtnColor,
                      height: 20,
                      child: Row( // TODO: Load elements from another view class!
                          children: <Widget>[
                            Expanded(
                              flex: 12,
                              child:
                              SizedBox.expand(
                                  child:
                                  FlatButton(
                                      color: BrowseTableView.timelineBtnColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(3.0),
                                              bottomLeft: Radius.circular(3.0))
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context, MaterialPageRoute(builder: (
                                            context) => TimelineScreen()));
                                      },
                                      child: Text(BrowseTableView.remoteDB.searchRecMap.elementAt(index).value.toString(),
                                          style: BrowseTableView.timelineBtnScriptL
                                      )
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child:
                              SizedBox.expand(
                                  child:
                                  RaisedButton(
                                      color: BrowseTableView.timelineBtnColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(3.0),
                                              bottomRight: Radius.circular(3.0))
                                      ),
                                      onPressed: () {
                                        // Make sure it gets starred
                                      },
                                      child: Text("X", textAlign: TextAlign.right,
                                          style: BrowseTableView.timelineBtnScriptL
                                      )
                                  )
                              ),
                            )
                          ]
                      )
                  );
                });
        });

    // This is the entire browse table view!!!
    return Column(
        children: <Widget>[
          Container(
              color: BrowseTableView.bkColor,
              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
              height: (widget.MQ.orientation == Orientation.portrait) ? 305.0 : 160.0,
              child: (widget.MQ.orientation == Orientation.portrait)
                  ? listDataDisplay
                  : gridDataDisplay
          ),
          Padding(padding: EdgeInsets.only(top: 3)),
          Container(
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
            height: 20,
            child:
            Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child:
                    SizedBox.expand(
                        child:
                        FlatButton(
                          color: BrowseTableView.createBtnColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(3.0))
                          ),
                          onPressed: () {
                            BrowseTableView.savedPrefsData.addCreationIndex(BrowseTableView.remoteDB.searchRecMap.length);

                            // TODO: Interact with flutter to generate new documents and entries

                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    CreateScreen(
                                      MQ: widget.MQ,
                                      docStr: 'E7GSISGNZkqJrgO93Djr',
                                      docName: 'Creation!',
                                    )));
                          },
                          child: Text("New Timeline",
                              style: BrowseTableView.lowBtnScript),
                        )
                    ),
                  ),
                ]),
          )
        ]
    );
  }
}