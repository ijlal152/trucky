part of 'widget_imports.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;
  const GradientBackground({super.key, required this.child, this.gradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: gradient),
      child: child,
    );
  }
}

class SetBackgroundImage extends StatelessWidget {
  final String bgImage;
  final Widget child;
  const SetBackgroundImage({
    super.key,
    required this.bgImage,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(bgImage), fit: BoxFit.cover),
      ),
      child: child,
    );
  }
}
