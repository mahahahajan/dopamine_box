import 'package:dopamine_box/components/task_list_holder.dart';
import 'package:dopamine_box/constants.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

class DopamineBoxHomeScreen extends StatefulWidget {
  const DopamineBoxHomeScreen({Key? key}) : super(key: key);

  @override
  State<DopamineBoxHomeScreen> createState() => _DopamineBoxHomeScreenState();
}

class _DopamineBoxHomeScreenState extends State<DopamineBoxHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    var fullHeight = deviceData.size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                // padding: const EdgeInsets.fromLTRB(10, 5, 1, 5),
                color: darkThemeBackgroundColor,
                height: fullHeight,
                child: const TaskListHolder(),
              ),
            ),
          ],
        ),
        // bottomNavigationBar: bottomBarWidget(),
      ),
    );
  }
}

class BottomBarWidvet extends StatelessWidget {
  const BottomBarWidvet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DotNavigationBar(
      currentIndex: 0,
      onTap: (index) {},
      // margin: const EdgeInsets.fromLTRB(1, 0, 1, 0),
      // dotIndicatorColor: Colors.black,
      marginR: const EdgeInsets.fromLTRB(2, 5, 2, 5),
      paddingR: const EdgeInsets.fromLTRB(1, 15, 1, 15),
      dotIndicatorColor: Colors.transparent,
      boxShadow: const [
        BoxShadow(
            color: Colors.transparent,
            spreadRadius: 10,
            blurRadius: 0,
            offset: Offset(0, 0))
      ],
      items: [
        /// Home
        DotNavigationBarItem(
          icon: const Icon(Icons.home),
          // selectedColor: Colors.purple,
        ),

        /// Likes
        DotNavigationBarItem(
          icon: const Icon(Icons.favorite_border),
          // selectedColor: Colors.pink,
        ),

        /// Search
        DotNavigationBarItem(
          icon: const Icon(Icons.search),
          // selectedColor: Colors.orange,
        ),
      ],
    );
  }
}
