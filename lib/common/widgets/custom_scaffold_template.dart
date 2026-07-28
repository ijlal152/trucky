part of 'widget_imports.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final Gradient? gradiantBackground;
  final bool extendBodyBehindAppBar;
  final bool? resizeToAvoidBottomInset;
  const CustomScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.backgroundColor = Colors.transparent,
    this.extendBodyBehindAppBar = false,
    this.resizeToAvoidBottomInset,
    this.gradiantBackground = const LinearGradient(
      begin: Alignment(0.00, -1.00),
      end: Alignment(0, 1),
      colors: [Color(0xFFE8EBF5), Color(0xFFFBFCFF)],
    ),
  });

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      gradient: gradiantBackground,
      child: GestureDetector(
        onTap: () {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          appBar: appBar,
          backgroundColor:
              backgroundColor, // Make Scaffold background transparent to show the gradient
          body: body,
          floatingActionButton: floatingActionButton,
          bottomNavigationBar: bottomNavigationBar,
        ),
      ),
    );
  }
}
