part of "widget_imports.dart";

Divider dividerWidget() {
  return Divider(color: Colors.black.withValues(alpha: 0.1));
}

class DividerWidget extends StatelessWidget {
  final double height;
  final double width;
  final double paddingV;
  final double padddingH;
  final double radius;
  final Color color;
  const DividerWidget({
    super.key,
    this.width = 48,
    this.paddingV = 0,
    this.padddingH = 0,
    this.height = 4,
    this.radius = 2,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      padding: EdgeInsets.symmetric(vertical: paddingV, horizontal: padddingH),
    );
  }
}
