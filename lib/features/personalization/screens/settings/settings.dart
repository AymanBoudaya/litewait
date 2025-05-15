import 'package:caferesto/common/widgets/appbar/appbar.dart';
import 'package:caferesto/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:caferesto/common/widgets/texts/section_heading.dart';
import 'package:caferesto/features/personalization/screens/profile/profile.dart';
import 'package:caferesto/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../utils/constants/sizes.dart';
import '../address/address.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          /// Header
          TPrimaryHeaderContainer(
            child: Column(
              children: [
                TAppBar(
                    title: Text('Compte',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .apply(color: TColors.white))),

                /// Profile Picture card
                TUserProfileTile(
                    onPressed: () => Get.to(() => const ProfileScreen())),
                const SizedBox(height: TSizes.spaceBtwSections),
              ],
            ),
          ),

          /// Body
          ///
          Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(children: [
                /// Account Settings
                TSectionHeading(
                  title: "Réglages du compte",
                  showActionButton: false,
                ),
                SizedBox(height: TSizes.spaceBtwItems),

                TSettingsMenuTile(
                    title: "Mes Adresses",
                    subTitle: "Mes adresses de livraison",
                    icon: Iconsax.safe_home,
                    onTap: () => Get.to(() => const UserAddressScreen())),
                TSettingsMenuTile(
                    title: "Mon Panier",
                    subTitle: "Ajouter, modifier ou supprimer des articles",
                    icon: Iconsax.shopping_cart,
                    onTap: () {}),
                TSettingsMenuTile(
                    title: "Mes Commandes",
                    subTitle: "Commandes passées et en cours",
                    icon: Iconsax.bag_tick,
                    onTap: () {}),
                TSettingsMenuTile(
                    title: "Compte Bancaire",
                    subTitle: "Mes informations bancaires",
                    icon: Iconsax.bank,
                    onTap: () {}),
                TSettingsMenuTile(
                    title: "Mes Vouchers",
                    subTitle: "Mes bons de réduction",
                    icon: Iconsax.discount_shape,
                    onTap: () {}),
                TSettingsMenuTile(
                    title: "Notifications",
                    subTitle: "Notifications de l'application",
                    icon: Iconsax.notification,
                    onTap: () {}),
                TSettingsMenuTile(
                    title: "Sécurité du Compte",
                    subTitle: "Sécuriser mon compte",
                    icon: Iconsax.security_card,
                    onTap: () {}),

                /// App Settings
                SizedBox(height: TSizes.spaceBtwSections),
                TSectionHeading(
                    title: "Paramètres de l'application",
                    showActionButton: false),
                SizedBox(height: TSizes.spaceBtwItems),
                TSettingsMenuTile(
                    icon: Iconsax.location,
                    title: "Géolocalisation",
                    subTitle:
                        "Définir une recommandation à partir de ma position",
                    trailing: Switch(value: true, onChanged: (value) {})),
                TSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: "Géolocalisation",
                    subTitle:
                        "Résultats de recherche sans danger pour tous les âges",
                    trailing: Switch(value: false, onChanged: (value) {})),
                TSettingsMenuTile(
                    icon: Iconsax.image,
                    title: "Qualité image HD",
                    subTitle: "Définir la qualité d'image haute définition",
                    trailing: Switch(value: false, onChanged: (value) {})),
              ]))
        ],
      )),
    );
  }
}
