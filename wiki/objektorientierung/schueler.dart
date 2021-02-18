class Student {
  // Ab hier: Datendefinitionen
  String? nachname;
  String? vorname;
  String? _emailAdresse;
  List<String> _registrierteEmailAdressen;
  int _anzahlVersendeterRegistrierungsEmails;
  bool _emailAdresseIstVerifiziert;

  // Konstruktor
  Student({
    this.nachname,
    this.vorname,
    String? emailAdresse,
    List<String>? registrierteEmailadressen,
    int? anzahlVersendeterRegistrierungsEmails,
    bool? emailAdresseIstVerzifiziert,
  })  : _emailAdresse = emailAdresse,
        _registrierteEmailAdressen = registrierteEmailadressen ?? [],
        _anzahlVersendeterRegistrierungsEmails = anzahlVersendeterRegistrierungsEmails ?? 0,
        _emailAdresseIstVerifiziert = emailAdresseIstVerzifiziert ?? false;

  // Getter und Setter
  String? get emailAdresse => _emailAdresse;

  void set emailAdresse(String? neueAdresse) {
    if (_istEmailAdresseValide(neueAdresse)) {
      if (_emailAdresse != null) {
        if (_emailAdresseIstVerifiziert) {
          if (!_registrierteEmailAdressen.contains(_emailAdresse)) {
            _registrierteEmailAdressen.add(_emailAdresse!);
          }
        }
      }
      _emailAdresse = neueAdresse;
      sendeVerifizierungsEmail();
    }
  }

  bool get emailAdresseIstVerifiziert => _emailAdresseIstVerifiziert;

  int anzahlVersendeterRegistrierungsEmails() => _anzahlVersendeterRegistrierungsEmails;

  bool _istEmailAdresseValide(String? email) {
    // Prüflogik
    if (email != null) {
      if (email.length > 0) {
        return true;
      }
    }
    return false;
  }

  void sendeVerifizierungsEmail() {
    // Logik, mit der die Email versendet wird
    _anzahlVersendeterRegistrierungsEmails++;
  }
}
