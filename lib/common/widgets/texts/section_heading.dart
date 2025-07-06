import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class TSectionHeading extends StatelessWidget {
  const TSectionHeading({
    super.key,
    required this.title,
    this.showActionButton = false,
    this.buttonTitle = 'Voir plus',
    this.onPressed,
    this.padding,
  });

  final String title;
  final bool showActionButton;
  final String buttonTitle;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      child: SizedBox(
        width: double.infinity, // Contrainte de largeur
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              // Remplace Expanded par Flexible
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (showActionButton)
              Flexible(
                // Ajoute Flexible pour le bouton
                child: TextButton(
                  onPressed: onPressed,
                  child: Text(buttonTitle),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
