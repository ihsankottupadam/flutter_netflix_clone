import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/screens/search_screen.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({Key? key, this.scrollOffset = 0.0, required this.showMenu})
      : super(key: key);
  final double scrollOffset;
  final bool showMenu;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      color:
          Colors.black.withOpacity((scrollOffset / 350).clamp(0, 1).toDouble()),
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Column(
            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: AnimatedOpacity(
                  opacity: showMenu ? 1 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: AnimatedSlide(
                    offset: showMenu ? Offset.zero : const Offset(0, -2),
                    duration: const Duration(milliseconds: 300),
                    child: Column(
                      children: [
                        SizedBox(
                          height: showMenu ? 50 : 0,
                          child: Row(
                            children: [
                              const SizedBox(width: 24),
                              Image.asset(
                                'assets/images/netflix_logo_small.png',
                                height: 50,
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SearchScreen(),
                                      ));
                                },
                                icon: const Icon(CupertinoIcons.search),
                                tooltip: 'Search',
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 221, 204, 51),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _AppbarButton(label: 'TV Shows', onTap: () {}),
                    _AppbarButton(label: 'Movies', onTap: () {}),
                    _AppbarButton(label: 'Categories', onTap: () {})
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _AppbarButton extends StatelessWidget {
  const _AppbarButton({Key? key, required this.label, required this.onTap})
      : super(key: key);
  final String label;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Text(
        label,
        style: const TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }
}
