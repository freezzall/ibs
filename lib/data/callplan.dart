class Callplan {
  String? szDocId;
  String? dtmDoc;
  String? szEmployeeId;
  Employee? employee;
  String? szVehicleNo;
  String? dtmStart;
  String? dtmFinished;
  bool? bStarted;
  bool? bFinished;
  String? szNote;
  List<Items>? items;
  TodayPerformance? todayPerformance;
  MonthlyPerformance? monthlyPerformance;
  List<Reasons>? reasons;
  List<DailyNews>? dailyNews;

  Callplan({
    this.szDocId,
    this.dtmDoc,
    this.szEmployeeId,
    this.employee,
    this.szVehicleNo,
    this.dtmStart,
    this.dtmFinished,
    this.bStarted,
    this.bFinished,
    this.szNote,
    this.items,
    this.todayPerformance,
    this.monthlyPerformance,
    this.reasons,
    this.dailyNews,
  });

  Callplan.fromJson(Map<String, dynamic> json) {
    szDocId = json['szDocId'] as String?;
    dtmDoc = json['dtmDoc'] as String?;
    szEmployeeId = json['szEmployeeId'] as String?;
    employee = (json['employee'] as Map<String,dynamic>?) != null ? Employee.fromJson(json['employee'] as Map<String,dynamic>) : null;
    szVehicleNo = json['szVehicleNo'] as String?;
    dtmStart = json['dtmStart'] as String?;
    dtmFinished = json['dtmFinished'] as String?;
    bStarted = json['bStarted'] as bool?;
    bFinished = json['bFinished'] as bool?;
    szNote = json['szNote'];
    items = (json['items'] as List?)?.map((dynamic e) => Items.fromJson(e as Map<String,dynamic>)).toList();
    todayPerformance = (json['TodayPerformance'] as Map<String,dynamic>?) != null ? TodayPerformance.fromJson(json['TodayPerformance'] as Map<String,dynamic>) : null;
    monthlyPerformance = (json['MonthlyPerformance'] as Map<String,dynamic>?) != null ? MonthlyPerformance.fromJson(json['MonthlyPerformance'] as Map<String,dynamic>) : null;
    reasons = (json['reasons'] as List?)?.map((dynamic e) => Reasons.fromJson(e as Map<String,dynamic>)).toList();
    dailyNews = (json['dailyNews'] as List?)?.map((dynamic e) => DailyNews.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['szDocId'] = szDocId;
    json['dtmDoc'] = dtmDoc;
    json['szEmployeeId'] = szEmployeeId;
    json['employee'] = employee?.toJson();
    json['szVehicleNo'] = szVehicleNo;
    json['dtmStart'] = dtmStart;
    json['dtmFinished'] = dtmFinished;
    json['bStarted'] = bStarted;
    json['bFinished'] = bFinished;
    json['szNote'] = szNote;
    json['items'] = items?.map((e) => e.toJson()).toList();
    json['TodayPerformance'] = todayPerformance?.toJson();
    json['MonthlyPerformance'] = monthlyPerformance?.toJson();
    json['reasons'] = reasons?.map((e) => e.toJson()).toList();
    json['dailyNews'] = dailyNews?.map((e) => e.toJson()).toList();
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
  String? szCustomerId;
  String? dtmStart;
  String? dtmFinish;
  String? szStatus;
  String? szReasonId;
  String? szNote;
  bool? bRescheduled;
  String? dtmReschedule;
  dynamic szImageId;
  dynamic szImageBase64;
  dynamic btImag;
  Customer? customer;
  bool? bVisited;
  bool? bFinished;
  String? szLongitude;
  String? szLatitude;
  List<Images>? images;

  Items({
    this.szDocId,
    this.szCustomerId,
    this.dtmStart,
    this.dtmFinish,
    this.szStatus,
    this.szReasonId,
    this.szNote,
    this.bRescheduled,
    this.dtmReschedule,
    this.szImageId,
    this.szImageBase64,
    this.btImag,
    this.customer,
    this.bVisited,
    this.bFinished,
    this.szLongitude,
    this.szLatitude,
    this.images,
  });

  Items.fromJson(Map<String, dynamic> json) {
    szDocId = json['szDocId'] as String?;
    szCustomerId = json['szCustomerId'] as String?;
    dtmStart = json['dtmStart'] as String?;
    dtmFinish = json['dtmFinish'] as String?;
    szStatus = json['szStatus'] as String?;
    szReasonId = json['szReasonId'] as String?;
    szNote = json['szNote'] as String?;
    bRescheduled = json['bRescheduled'] as bool?;
    dtmReschedule = json['dtmReschedule'] as String?;
    szImageId = json['szImageId'];
    szImageBase64 = json['szImageBase64'];
    btImag = json['btImag'];
    customer = (json['customer'] as Map<String,dynamic>?) != null ? Customer.fromJson(json['customer'] as Map<String,dynamic>) : null;
    bVisited = json['bVisited'] as bool?;
    bFinished = json['bFinished'] as bool?;
    szLongitude = json['szLongitude'] as String?;
    szLatitude = json['szLatitude'] as String?;
    images = (json['images'] as List?)?.map((dynamic e) => Images.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['szDocId'] = szDocId;
    json['szCustomerId'] = szCustomerId;
    json['dtmStart'] = dtmStart;
    json['dtmFinish'] = dtmFinish;
    json['szStatus'] = szStatus;
    json['szReasonId'] = szReasonId;
    json['szNote'] = szNote;
    json['bRescheduled'] = bRescheduled;
    json['dtmReschedule'] = dtmReschedule;
    json['szImageId'] = szImageId;
    json['szImageBase64'] = szImageBase64;
    json['btImag'] = btImag;
    json['customer'] = customer?.toJson();
    json['bVisited'] = bVisited;
    json['bFinished'] = bFinished;
    json['szLongitude'] = szLongitude;
    json['szLatitude'] = szLatitude;
    json['images'] = images?.map((e) => e.toJson()).toList();
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
  List<OperArList>? operArList;
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

class Images {
  String? szDocId;
  String? szImageId;
  dynamic szImageBase64;
  dynamic szCustomerId;

  Images({
    this.szDocId,
    this.szImageId,
    this.szImageBase64,
    this.szCustomerId,
  });

  Images.fromJson(Map<String, dynamic> json) {
    szDocId = json['szDocId'] as String?;
    szImageId = json['szImageId'] as String?;
    szImageBase64 = json['szImageBase64'];
    szCustomerId = json['szCustomerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['szDocId'] = szDocId;
    json['szImageId'] = szImageId;
    json['szImageBase64'] = szImageBase64;
    json['szCustomerId'] = szCustomerId;
    return json;
  }
}

class TodayPerformance {
  int? target;
  int? sukses;
  int? gagal;
  int? belum;
  int? extraCall;

  TodayPerformance({
    this.target,
    this.sukses,
    this.gagal,
    this.belum,
    this.extraCall,
  });

  TodayPerformance.fromJson(Map<String, dynamic> json) {
    target = json['Target'] as int?;
    sukses = json['Sukses'] as int?;
    gagal = json['Gagal'] as int?;
    belum = json['Belum'] as int?;
    extraCall = json['ExtraCall'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['Target'] = target;
    json['Sukses'] = sukses;
    json['Gagal'] = gagal;
    json['Belum'] = belum;
    json['ExtraCall'] = extraCall;
    return json;
  }
}

class MonthlyPerformance {
  int? target;
  int? sukses;
  int? gagal;
  int? tidakDiKunjungi;
  String? effective;

  MonthlyPerformance({
    this.target,
    this.sukses,
    this.gagal,
    this.tidakDiKunjungi,
    this.effective,
  });

  MonthlyPerformance.fromJson(Map<String, dynamic> json) {
    target = json['Target'] as int?;
    sukses = json['Sukses'] as int?;
    gagal = json['Gagal'] as int?;
    tidakDiKunjungi = json['TidakDiKunjungi'] as int?;
    effective = json['Effective'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['Target'] = target;
    json['Sukses'] = sukses;
    json['Gagal'] = gagal;
    json['TidakDiKunjungi'] = tidakDiKunjungi;
    json['Effective'] = effective;
    return json;
  }
}

class Reasons {
  String? szId;
  String? szName;
  String? szReasonType;

  Reasons({
    this.szId,
    this.szName,
    this.szReasonType,
  });

  Reasons.fromJson(Map<String, dynamic> json) {
    szId = json['szId'] as String?;
    szName = json['szName'] as String?;
    szReasonType = json['szReasonType'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['szId'] = szId;
    json['szName'] = szName;
    json['szReasonType'] = szReasonType;
    return json;
  }
}

class DailyNews {
  String? szId;
  String? szEmployeeId;
  String? szMessage;
  bool? bRead;
  String? dtmRead;
  String? szAttachmentFileName;
  String? szAttachmentUrl;
  String? dtmFrom;
  String? dtmTo;

  DailyNews({
    this.szId,
    this.szEmployeeId,
    this.szMessage,
    this.bRead,
    this.dtmRead,
    this.szAttachmentFileName,
    this.szAttachmentUrl,
    this.dtmFrom,
    this.dtmTo,
  });

  DailyNews.fromJson(Map<String, dynamic> json) {
    szId = json['szId'] as String?;
    szEmployeeId = json['szEmployeeId'] as String?;
    szMessage = json['szMessage'] as String?;
    bRead = json['bRead'] as bool?;
    dtmRead = json['dtmRead'] as String?;
    szAttachmentFileName = json['szAttachmentFileName'] as String?;
    szAttachmentUrl = json['szAttachmentUrl'] as String?;
    dtmFrom = json['dtmFrom'] as String?;
    dtmTo = json['dtmTo'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['szId'] = szId;
    json['szEmployeeId'] = szEmployeeId;
    json['szMessage'] = szMessage;
    json['bRead'] = bRead;
    json['dtmRead'] = dtmRead;
    json['szAttachmentFileName'] = szAttachmentFileName;
    json['szAttachmentUrl'] = szAttachmentUrl;
    json['dtmFrom'] = dtmFrom;
    json['dtmTo'] = dtmTo;
    return json;
  }
}