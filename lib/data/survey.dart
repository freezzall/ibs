class survey {
  String? szStatus;
  String? szMessage;
  List<OResult>? oResult;

  survey({
    this.szStatus,
    this.szMessage,
    this.oResult,
  });

  survey.fromJson(Map<String, dynamic> json) {
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
  String? szDocId;
  String? dtmDoc;
  String? szEmployeeId;
  String? szCustomerId;
  String? szSurveyId;
  String? szSurveyNm;
  Customer? customer;
  Employee? employee;
  List<Items>? items;

  OResult({
    this.szDocId,
    this.dtmDoc,
    this.szEmployeeId,
    this.szCustomerId,
    this.szSurveyId,
    this.szSurveyNm,
    this.customer,
    this.employee,
    this.items,
  });

  OResult.fromJson(Map<String, dynamic> json) {
    szDocId = json['szDocId'] as String?;
    dtmDoc = json['dtmDoc'] as String?;
    szEmployeeId = json['szEmployeeId'] as String?;
    szCustomerId = json['szCustomerId'] as String?;
    szSurveyId = json['szSurveyId'] as String?;
    szSurveyNm = json['szSurveyNm'] as String?;
    customer = (json['customer'] as Map<String,dynamic>?) != null ? Customer.fromJson(json['customer'] as Map<String,dynamic>) : null;
    employee = (json['employee'] as Map<String,dynamic>?) != null ? Employee.fromJson(json['employee'] as Map<String,dynamic>) : null;
    items = (json['items'] as List?)?.map((dynamic e) => Items.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['szDocId'] = szDocId;
    json['dtmDoc'] = dtmDoc;
    json['szEmployeeId'] = szEmployeeId;
    json['szCustomerId'] = szCustomerId;
    json['szSurveyId'] = szSurveyId;
    json['szSurveyNm'] = szSurveyNm;
    json['customer'] = customer?.toJson();
    json['employee'] = employee?.toJson();
    json['items'] = items?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Customer {
  String? szId;
  String? szName;
  String? szAddress;
  String? szPhone1;
  String? szPhone2;
  String? szLongitude;
  String? szLatitude;
  List<dynamic>? operArList;
  double? decTotalOpenAr;

  Customer({
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

  Customer.fromJson(Map<String, dynamic> json) {
    szId = json['szId'] as String?;
    szName = json['szName'] as String?;
    szAddress = json['szAddress'] as String?;
    szPhone1 = json['szPhone1'] as String?;
    szPhone2 = json['szPhone2'] as String?;
    szLongitude = json['szLongitude'] as String?;
    szLatitude = json['szLatitude'] as String?;
    operArList = json['operArList'] as List?;
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
    json['operArList'] = operArList;
    json['decTotalOpenAr'] = decTotalOpenAr;
    return json;
  }
}

class Employee {
  String? szId;
  String? szName;
  String? szBranchId;
  String? szBranchNm;
  String? szCompanyId;
  String? szCompanyNm;

  Employee({
    this.szId,
    this.szName,
    this.szBranchId,
    this.szBranchNm,
    this.szCompanyId,
    this.szCompanyNm,
  });

  Employee.fromJson(Map<String, dynamic> json) {
    szId = json['szId'] as String?;
    szName = json['szName'] as String?;
    szBranchId = json['szBranchId'] as String?;
    szBranchNm = json['szBranchNm'] as String?;
    szCompanyId = json['szCompanyId'] as String?;
    szCompanyNm = json['szCompanyNm'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['szId'] = szId;
    json['szName'] = szName;
    json['szBranchId'] = szBranchId;
    json['szBranchNm'] = szBranchNm;
    json['szCompanyId'] = szCompanyId;
    json['szCompanyNm'] = szCompanyNm;
    return json;
  }
}

class Items {
  String? szDocId;
  int? intItemNumber;
  String? szQuestionId;
  String? szQuestionNm;
  int? intPage;
  int? intSequence;
  String? szAnswerType;
  bool? bMandatory;
  List<Details>? details;

  Items({
    this.szDocId,
    this.intItemNumber,
    this.szQuestionId,
    this.szQuestionNm,
    this.intPage,
    this.intSequence,
    this.szAnswerType,
    this.bMandatory,
    this.details,
  });

  Items.fromJson(Map<String, dynamic> json) {
    szDocId = json['szDocId'] as String?;
    intItemNumber = json['intItemNumber'] as int?;
    szQuestionId = json['szQuestionId'] as String?;
    szQuestionNm = json['szQuestionNm'] as String?;
    intPage = json['intPage'] as int?;
    intSequence = json['intSequence'] as int?;
    szAnswerType = json['szAnswerType'] as String?;
    bMandatory = json['bMandatory'] as bool?;
    details = (json['details'] as List?)?.map((dynamic e) => Details.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['szDocId'] = szDocId;
    json['intItemNumber'] = intItemNumber;
    json['szQuestionId'] = szQuestionId;
    json['szQuestionNm'] = szQuestionNm;
    json['intPage'] = intPage;
    json['intSequence'] = intSequence;
    json['szAnswerType'] = szAnswerType;
    json['bMandatory'] = bMandatory;
    json['details'] = details?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Details {
  String? szDocId;
  int? intItemNumber;
  int? intItemNumberDetail;
  String? szAnswerText;
  dynamic szAnswerValue;

  Details({
    this.szDocId,
    this.intItemNumber,
    this.intItemNumberDetail,
    this.szAnswerText,
    this.szAnswerValue,
  });

  Details.fromJson(Map<String, dynamic> json) {
    szDocId = json['szDocId'] as String?;
    intItemNumber = json['intItemNumber'] as int?;
    intItemNumberDetail = json['intItemNumberDetail'] as int?;
    szAnswerText = json['szAnswerText'] as String?;
    szAnswerValue = json['szAnswerValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['szDocId'] = szDocId;
    json['intItemNumber'] = intItemNumber;
    json['intItemNumberDetail'] = intItemNumberDetail;
    json['szAnswerText'] = szAnswerText;
    json['szAnswerValue'] = szAnswerValue;
    return json;
  }
}