import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netflix/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double scrollOffset = 0;
  ScrollController scrollController = ScrollController();
  bool showTopMenu = true;
  @override
  void initState() {
    initScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(size.width, 80),
        child: HomeAppbar(
          scrollOffset: scrollOffset,
          showMenu: showTopMenu,
        ),
      ),
      body: CustomScrollView(
        controller: scrollController,
        slivers: const [
          SliverToBoxAdapter(
            child: HeaderView(),
          ),
          SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: ContentList(title: 'Trending Now'))),
          SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: NumberdList(
                    title: 'Top 10 Movies in India Today',
                  ))),
          SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: ContentList(title: 'Top Rated Movies'))),
          SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: ContentList(title: 'Upcoming Movies'))),
          SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: NumberdList(
                    title: 'Top 10 TV Shows',
                  ))),
        ],
      ),
    );
  }

  void initScrollController() {
    scrollController.addListener(() {
      setState(() {
        scrollOffset = scrollController.offset;
      });
      if (scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          showTopMenu) {
        setState(() {
          showTopMenu = false;
        });
      } else if (scrollController.position.userScrollDirection ==
              ScrollDirection.forward &&
          !showTopMenu) {
        setState(() {
          showTopMenu = true;
        });
      }
    });
  }
}
