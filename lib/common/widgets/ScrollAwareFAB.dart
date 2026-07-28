part of 'widget_imports.dart';

class ScrollAwareFAB extends StatelessWidget {
  final VoidCallback onTap;
  final String? imgPath;
  final IconData icon;
  final Animation<double> scale;

  const ScrollAwareFAB({
    super.key,
    required this.onTap,
    required this.scale,
    this.imgPath,
    this.icon = Icons.add,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: CustomFloatingBtn(imgPath: imgPath, icon: icon, onTap: onTap),
    );
  }
}
