class Student {
  // Ab hier: Datendefinitionen
  String nachname;
  String vorname;
  String _emailAdresse;
  List<String> _registrierteEmailAdressen;
  int _anzahlVersendeterRegistrierungsEmails;
  bool _emailAdresseIstVerifiziert;

  // Konstruktor
  Student({
    String this.nachname,
    String this.vorname,
    String emailAdresse,
    List<String> registrierteEmailadressen,
    int anzahlVersendeterRegistrierungsEmails,
    bool emailAdresseIstVerzifiziert,
  })  : _emailAdresse = emailAdresse,
        _registrierteEmailAdressen = registrierteEmailadressen ?? [],
        _anzahlVersendeterRegistrierungsEmails = anzahlVersendeterRegistrierungsEmails ?? 0,
        _emailAdresseIstVerifiziert = emailAdresseIstVerzifiziert ?? false;

  // Getter und Setter
  String get emailAdresse => _emailAdresse;

  void set emailAdresse(String neueAdresse) {
    if (_istEmailAdresseValide(neueAdresse)) {
      String alteAdresse = _emailAdresse;
      if (_emailAdresseIstVerifiziert) {
        _registrierteEmailAdressen.add(alteAdresse);
      }
      _emailAdresse = neueAdresse;
      sendeVerifizierungsEmail();
    }
  }

  bool get emailAdresseIstVerifiziert => _emailAdresseIstVerifiziert;

  int anzahlVersendeterRegistrierungsEmails() => _anzahlVersendeterRegistrierungsEmails;

  bool _istEmailAdresseValide(String email) {
    // Prüflogik
    if (email.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  void sendeVerifizierungsEmail() {
    // Logik, mit der die Email versendet wird
    _anzahlVersendeterRegistrierungsEmails++;
  }
}
