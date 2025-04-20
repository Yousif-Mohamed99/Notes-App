import 'package:flutter/material.dart';

class ColorItem extends StatelessWidget {
  const ColorItem({super.key, required this.isActive, required this.color});

  final bool isActive;
  final Color color;

  @override
  Widget build(BuildContext context) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;
    // Calculate dynamic padding based on screen width
    double horizontalPadding =
        screenWidth < 400 ? 4 : 8; // 4 for small screens, 6 for larger

    return isActive
        ? Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: CircleAvatar(radius: 30, backgroundColor: color),
          ),
        )
        : Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding + 2),
          child: CircleAvatar(radius: 30, backgroundColor: color),
        );
  }
}

class ColorsListView extends StatefulWidget {
  const ColorsListView({super.key, required this.onColorSelected});
  final ValueChanged<Color> onColorSelected;

  @override
  State<ColorsListView> createState() => _ColorsListViewState();
}

class _ColorsListViewState extends State<ColorsListView> {
  int currentIndex = 0;

  List<Color> colors = [
    Color(0xffbcb6ff),
    Color(0xff92afd7),
    Color(0xff91c7b1),
    Color(0xffb33951),
    Color(0xffe3d081),
  ];

  @override
  void initState() {
    super.initState();
    // Notify parent of initial color selection
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onColorSelected(colors[currentIndex]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30 * 2,
      child: ListView.builder(
        itemCount: colors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                currentIndex = index;
              });
              widget.onColorSelected(colors[index]);
            },
            child: ColorItem(
              isActive: currentIndex == index,
              color: colors[index],
            ),
          );
        },
      ),
    );
  }
}
