import 'package:cached_network_image/cached_network_image.dart';
import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/feature/feature_drawers/domain/entity/painter_entity.dart';
import 'package:flutter/material.dart';

class DrawerCard extends StatelessWidget {
  const DrawerCard({super.key, this.onTap, this.painterEntity});
  final void Function()? onTap;
  final PainterEntity? painterEntity;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstant.borderRadius),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: CachedNetworkImage(
            imageUrl: painterEntity?.imageUrl ?? '',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
