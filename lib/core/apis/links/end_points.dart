class EndPoints {
  static const String _baseUrl = "https://dummyjson.com";
  static String get baseUrl => _baseUrl;
  //* post
  static const login = "$_baseUrl/auth/login";
  static const loginUser = "$_baseUrl/user/login";
  //* post
  static const addUser = "$_baseUrl/users/add";
  //* get current user
  static const getToken = "$_baseUrl/user/me";
  
  //* delete
  static String deleteUser(id) {
    return "$_baseUrl/users/add/$id";
  }

  //* get products (using dio)
  static const product = "$_baseUrl/products";

  //* get products (using http)
  static String products({limit, skip}) {
    return "$_baseUrl/products?limit=$limit&skip=$skip";
  }

  static String updateProduct({required int id}) {
    return "$_baseUrl/products/$id";
  }

  static String deleteProduct({required int id}) {
    return "$_baseUrl/products/$id";
  }

  //* add product
  static const addProduct = "$_baseUrl/products/add";
}
