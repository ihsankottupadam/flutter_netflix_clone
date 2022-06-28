import 'package:flutter/material.dart';
import 'package:netflix/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double scrollOffset = 0;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(() {
      setState(() {
        scrollOffset = scrollController.offset;
      });
    });
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
        preferredSize: Size(size.width, 50),
        child: HomeAppbar(scrollOffset: scrollOffset),
      ),
      body: CustomScrollView(
        controller: scrollController,
        slivers: const [
          SliverToBoxAdapter(
            child: _HeaderView(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 1000,
            ),
          )
        ],
      ),
    );
  }
}

class _HeaderView extends StatelessWidget {
  const _HeaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 500,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/banner_dr_strange.webp'),
                  fit: BoxFit.cover)),
        ),
        Container(
          height: 500,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0, 0.2])),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                VerticalIconButton(
                  icon: Icons.add,
                  label: 'My List',
                  onTap: () {},
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Play',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                  ),
                ),
                VerticalIconButton(
                  icon: Icons.info_outline,
                  label: 'info',
                  onTap: () {},
                )
              ],
            ))
      ],
    );
  }
}
