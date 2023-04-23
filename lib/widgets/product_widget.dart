import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/models/product_model.dart';
import 'package:yolustunde_mobile/theme/colors.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.productModel,
    this.onTap,
    this.selected = false,
  });

  final ProductModel productModel;
  final void Function()? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: selected ? MyColors.yellow : MyColors.greyLight2),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productModel.title,
                        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 4),
                      Text(
                        productModel.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: MyColors.greyLight.withOpacity(0.8), fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '₺' + productModel.price.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
