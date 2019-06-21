// To parse this JSON data, do
//
//     final commande = commandeFromJson(jsonString);

import 'dart:convert';

List<Commande> commandesFromJson(String str) =>
    new List<Commande>.from(json.decode(str).map((x) => Commande.fromJson(x)));

String commandesToJson(List<Commande> data) =>
    json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Commande {
  String id;
  String client;
  String dateCommande;
  String clientDate;
  String menu;
  String plat;
  String pain;
  String ingredient;
  List<String> accompagnements;
  dynamic dessert;
  dynamic complement;
  dynamic boisson;
  bool traitee;

  Commande({
    this.id,
    this.client,
    this.dateCommande,
    this.clientDate,
    this.menu,
    this.plat,
    this.pain,
    this.ingredient,
    this.accompagnements,
    this.dessert,
    this.complement,
    this.boisson,
    this.traitee,
  });

  factory Commande.fromJson(Map<String, dynamic> json) => new Commande(
        id: json["id"],
        client: json["client"],
        dateCommande: json["dateCommande"],
        clientDate: json["clientDate"],
        menu: json["menu"],
        plat: json["plat"],
        pain: json["pain"],
        ingredient: json["ingredient"],
        accompagnements: json["accompagnements"] != null
            ? new List<String>.from(json["accompagnements"].map((x) => x))
            : null,
        dessert: json["dessert"],
        complement: json["complement"],
        boisson: json["boisson"],
        traitee: json["traitee"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client": client,
        "dateCommande": dateCommande,
        "clientDate": clientDate,
        "menu": menu,
        "plat": plat,
        "pain": pain,
        "ingredient": ingredient,
        "accompagnements": accompagnements != null
            ? new List<dynamic>.from(accompagnements?.map((x) => x))
            : null,
        "dessert": dessert,
        "complement": complement,
        "boisson": boisson,
        "traitee": traitee,
      };

  @override
  String toString() {
    return 'Commande{id: $id, client: $client, dateCommande: $dateCommande, clientDate: $clientDate, menu: $menu, plat: $plat, pain: $pain, ingredient: $ingredient, accompagnements: $accompagnements, dessert: $dessert, complement: $complement, boisson: $boisson, traitee: $traitee}';
  }

  String articles() {
    return '${Commande.withThat('', this.plat)} ' +
        '${Commande.withThat('', this.pain)} ' +
        '${Commande.withThat('avec ', this.ingredient)} ' +
        '${Commande.withThat('garni de ', (this.accompagnements != null && this.accompagnements.length > 0) ? this.accompagnements.join(', ') : null)}' +
        '${Commande.withThat(', avec comme dessert ', this.dessert)}' +
        '${Commande.withThat(', comme complément ', this.complement)}' +
        '${Commande.withThat(', et comme boisson ', this.boisson)}';
    ;
  }

  static String withThat(String s1, String s2, [String s3 = '']) =>
      (s2 != null) ? s1 + s2 + s3 : '';
}
