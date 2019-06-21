import 'package:sandwicheria/core/models/commande.dart';

String getImageName(Commande commande) {
  if (commande.menu == 'sandwich') {
    return 'graphics/sandwich.png';
  } else if (commande.plat.contains('sandwich')) {
    return 'graphics/menu_sandwich.png';
  } else if (commande.plat.contains("salade")) {
    return 'graphics/salade.png';
  } else {
    return 'graphics/plat.png';
  }
}