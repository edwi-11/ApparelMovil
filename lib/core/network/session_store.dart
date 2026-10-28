class SessionStore {
  String? token;

  void guardar(String nuevoToken) => token = nuevoToken;
  void limpiar() => token = null;
}