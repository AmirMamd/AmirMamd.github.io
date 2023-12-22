class AddRouteService {
  static bool areFieldsEmpty(
      String name,
      String imageUrl,
      String price,
      ) {
    return name.isEmpty || imageUrl.isEmpty || price.isEmpty;
  }

  static bool doesRouteExist(
      List<Map<String, dynamic>> routes,
      String enteredName,
      ) {
    return routes.any(
          (doc) => doc['name'].toString().toLowerCase() == enteredName.toLowerCase(),
    );
  }
}