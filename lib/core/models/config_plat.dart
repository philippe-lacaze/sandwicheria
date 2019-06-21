class ConfigPlat {
  String nom;
  List<String> pain;
  List<String> ingredient;
  List<String> accompagnements;
  List<String> dessert;
  List<String> complement;
  List<String> boisson;

  getOptions(String name) {
    switch (name) {
      case "pain":
        return pain;
      case "ingredient":
        return ingredient;
      case "accompagnements":
        return accompagnements;
      case "dessert":
        return dessert;
      case "complement":
        return complement;
      case "boisson":
        return boisson;
      default:
        throw "$name inconnu";
    }
  }
}
