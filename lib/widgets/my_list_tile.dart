import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:yolustunde_mobile/theme/colors.dart';

class MyListTile extends StatelessWidget {
  const MyListTile({
    super.key,
    this.title,
    this.leading,
    this.child,
    this.trailing,
    this.onTap,
    this.showTrailing = true,
    this.borderColor = MyColors.greyLight2,
    this.slidableActions,
  });

  final String? title;
  final Widget? leading;
  final Widget? child;
  final Widget? trailing;
  final void Function()? onTap;
  final bool showTrailing;
  final Color borderColor;
  final List<SlidableAction>? slidableActions;

  @override
  Widget build(BuildContext context) {
    if (slidableActions == null || slidableActions!.isEmpty) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              if (leading != null)
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: leading!,
                ),
              if (title != null)
                Text(
                  title!,
                  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                )
              else if (child != null)
                child!,
              if (trailing != null)
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: trailing!,
                  ),
                )
              else if (showTrailing)
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_outlined, size: 16),
                    ],
                  ),
                )
            ],
          ),
        ),
      );
    }
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: slidableActions!,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              if (leading != null)
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: leading!,
                ),
              if (title != null)
                Text(
                  title!,
                  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                )
              else if (child != null)
                child!,
              if (showTrailing)
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_outlined, size: 16),
                    ],
                  ),
                )
              else if (trailing != null)
                trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
