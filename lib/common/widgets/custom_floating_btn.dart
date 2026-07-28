part of 'widget_imports.dart';

class CustomFloatingBtn extends StatelessWidget {
  final String? imgPath;
  final IconData icon;
  final VoidCallback onTap;

  const CustomFloatingBtn({
    super.key,
    this.imgPath,
    required this.onTap,
    this.icon = Icons.add,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 56.h,
      width: 56.h,
      child: FloatingActionButton(
        onPressed: onTap,
        heroTag: null,
        backgroundColor: colorScheme.primary,
        child: imgPath != null
            ? SvgPicture.asset(imgPath!)
            : Icon(icon, size: 22.h, color: colorScheme.onPrimary),
      ),
    );
  }
}
