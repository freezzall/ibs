class Attendance {
  String? szDocId;
  String? dtmDoc;
  String? szEmployeeId;
  String? dtmAttedancePagi;
  bool? bAttedancePagi;
  String? szLongitudePagi;
  String? szLatitudePagi;
  String? dtmAttedanceSore;
  bool? bAttedanceSore;
  String? szLongitudeSore;
  String? szLatitudeSore;

  Attendance({
    this.szDocId,
    this.dtmDoc,
    this.szEmployeeId,
    this.dtmAttedancePagi,
    this.bAttedancePagi,
    this.szLongitudePagi,
    this.szLatitudePagi,
    this.dtmAttedanceSore,
    this.bAttedanceSore,
    this.szLongitudeSore,
    this.szLatitudeSore,
  });

  Attendance.fromJson(Map<String, dynamic> json) {
    szDocId = json['szDocId'] as String?;
    dtmDoc = json['dtmDoc'] as String?;
    szEmployeeId = json['szEmployeeId'] as String?;
    dtmAttedancePagi = json['dtmAttedance_Pagi'] as String?;
    bAttedancePagi = json['bAttedance_Pagi'] as bool?;
    szLongitudePagi = json['szLongitude_Pagi'] as String?;
    szLatitudePagi = json['szLatitude_Pagi'] as String?;
    dtmAttedanceSore = json['dtmAttedance_Sore'] as String?;
    bAttedanceSore = json['bAttedance_Sore'] as bool?;
    szLongitudeSore = json['szLongitude_Sore'] as String?;
    szLatitudeSore = json['szLatitude_Sore'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['szDocId'] = szDocId;
    json['dtmDoc'] = dtmDoc;
    json['szEmployeeId'] = szEmployeeId;
    json['dtmAttedance_Pagi'] = dtmAttedancePagi;
    json['bAttedance_Pagi'] = bAttedancePagi;
    json['szLongitude_Pagi'] = szLongitudePagi;
    json['szLatitude_Pagi'] = szLatitudePagi;
    json['dtmAttedance_Sore'] = dtmAttedanceSore;
    json['bAttedance_Sore'] = bAttedanceSore;
    json['szLongitude_Sore'] = szLongitudeSore;
    json['szLatitude_Sore'] = szLatitudeSore;
    return json;
  }
}