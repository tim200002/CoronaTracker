import 'package:corona/blocs/blocCompareScreen.dart';
import 'package:corona/blocs/blocDetailScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'CompareScreen.dart';
import 'DetailScreen.dart';
import 'StatScreen.dart';

class PageViewer extends StatefulWidget {
  @override
  _PageViewerState createState() => _PageViewerState();
}

class _PageViewerState extends State<PageViewer> {
  PageController _controller = PageController(initialPage: 1);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: <Widget>[
        StatScreen(),
        //Bloc Provider for the Detail Screen
        BlocProvider(
          create: (BuildContext context) => BlocDetailScreen(),
          child: DetailScreen(),
        ),
        BlocProvider(
          create: (BuildContext context) => BlocCompareScreen(),
          child: CompareScreen(),
        ),
      ],
    );
  }
   
}
