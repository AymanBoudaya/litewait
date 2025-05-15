import 'package:caferesto/common/widgets/images/circular_image.dart';
import 'package:caferesto/common/widgets/texts/section_heading.dart';
import 'package:caferesto/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import 'widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TAppBar(
          showBackArrow: true,
          title: Text('Mon Profil'),
        ),

        /// Body
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    /// Profile Picture
                    SizedBox(
                      width: double.infinity,
                      child: Column(children: [
                        const CircularImage(
                          image: TImages.user,
                          width: 80,
                          height: 80,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Modifier la photo de profil',
                            ))
                      ]),
                    ),

                    /// Détails
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const TSectionHeading(
                        title: 'Informations du profil',
                        showActionButton: false),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    TProfileMenu(
                        title: "Nom", value: "Ali Karray", onPressed: () {}),
                    TProfileMenu(
                        title: "Nom d'utilisateur",
                        value: "Ali Karray",
                        onPressed: () {}),

                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// Heading Personal Info
                    const TSectionHeading(
                        title: 'Informations personnelles',
                        showActionButton: false),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    TProfileMenu(
                        title: "ID utilisateur",
                        value: "16564",
                        icon : Iconsax.copy,
                        onPressed: () {}),
                    TProfileMenu(
                        title: "E-mail",
                        value: "ali.karray@gmail.com",
                        onPressed: () {}),
                    TProfileMenu(
                        title: "Téléphone",
                        value: "+216 55 555 555",
                        onPressed: () {}),
                    TProfileMenu(
                        title: "Sexe", value: "Male", onPressed: () {}),
                    TProfileMenu(
                        title: "Date de naissance",
                        value: "10 Oct 1988",
                        onPressed: () {}),
                        const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    Center(
                        child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Fermer le compte',
                              style: TextStyle(
                                  color: Colors.red,
                                  ),
                            )),
                    )
                  ],
                ))));
  }
}
