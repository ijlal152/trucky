part of 'widget_imports.dart';

class NavigatableRowWithImage extends StatelessWidget {
  final String img;
  final String title;
  final String trailingIcon;
  final double imgHeight;
  final double imgWidth;

  const NavigatableRowWithImage({
    super.key,
    this.img = "",
    this.title = "",
    this.imgHeight = 40,
    this.imgWidth = 40,
    this.trailingIcon = "assets/images/arrow_right.png",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(img, height: imgHeight.h, width: imgWidth.h),
            10.horizontalSpace,
            LabelWidget(
              text: title,
              textSize: 17.sp,
              fontWeight: FontWeight.w600,
              textColor: Colors.black,
            ),
          ],
        ),
        Image.asset(trailingIcon, height: 12.h),
      ],
    );
  }
}
