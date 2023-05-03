class Customers {
  String? szStatus;
  String? szMessage;
  List<OResult>? oResult;

  Customers({
    this.szStatus,
    this.szMessage,
    this.oResult,
  });

  Customers.fromJson(Map<String, dynamic> json) {
    szStatus = json['szStatus'] as String?;
    szMessage = json['szMessage'] as String?;
    oResult = (json['oResult'] as List?)?.map((dynamic e) => OResult.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['szStatus'] = szStatus;
    json['szMessage'] = szMessage;
    json['oResult'] = oResult?.map((e) => e.toJson()).toList();
    return json;
  }
}

class OResult {
  String? szId;
  String? szName;
  String? szAddress;
  String? szPhone1;
  String? szPhone2;
  String? szLongitude;
  String? szLatitude;
  List<OperArList>? operArList;
  double? decTotalOpenAr;

  OResult({
    this.szId,
    this.szName,
    this.szAddress,
    this.szPhone1,
    this.szPhone2,
    this.szLongitude,
    this.szLatitude,
    this.operArList,
    this.decTotalOpenAr,
  });

  OResult.fromJson(Map<String, dynamic> json) {
    szId = json['szId'] as String?;
    szName = json['szName'] as String?;
    szAddress = json['szAddress'] as String?;
    szPhone1 = json['szPhone1'] as String?;
    szPhone2 = json['szPhone2'] as String?;
    szLongitude = json['szLongitude'] as String?;
    szLatitude = json['szLatitude'] as String?;
    operArList = (json['operArList'] as List?)?.map((dynamic e) => OperArList.fromJson(e as Map<String,dynamic>)).toList();
    decTotalOpenAr = json['decTotalOpenAr'] as double?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['szId'] = szId;
    json['szName'] = szName;
    json['szAddress'] = szAddress;
    json['szPhone1'] = szPhone1;
    json['szPhone2'] = szPhone2;
    json['szLongitude'] = szLongitude;
    json['szLatitude'] = szLatitude;
    json['operArList'] = operArList?.map((e) => e.toJson()).toList();
    json['decTotalOpenAr'] = decTotalOpenAr;
    return json;
  }
}

class OperArList {
  String? szDocInvoiceId;
  String? szDocPolisId;
  String? szCurrencyId;
  int? intInstallmentNumber;
  String? dtmInstallment;
  double? decRemain;

  OperArList({
    this.szDocInvoiceId,
    this.szDocPolisId,
    this.szCurrencyId,
    this.intInstallmentNumber,
    this.dtmInstallment,
    this.decRemain,
  });

  OperArList.fromJson(Map<String, dynamic> json) {
    szDocInvoiceId = json['szDocInvoiceId'] as String?;
    szDocPolisId = json['szDocPolisId'] as String?;
    szCurrencyId = json['szCurrencyId'] as String?;
    intInstallmentNumber = json['intInstallmentNumber'] as int?;
    dtmInstallment = json['dtmInstallment'] as String?;
    decRemain = json['decRemain'] as double?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['szDocInvoiceId'] = szDocInvoiceId;
    json['szDocPolisId'] = szDocPolisId;
    json['szCurrencyId'] = szCurrencyId;
    json['intInstallmentNumber'] = intInstallmentNumber;
    json['dtmInstallment'] = dtmInstallment;
    json['decRemain'] = decRemain;
    return json;
  }
}