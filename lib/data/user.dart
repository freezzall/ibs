import 'package:flutter/cupertino.dart';

class user{
  String? szId;
  String? szName;
  String? szPassword;
  String? szBranchId;
  String? szBranchNm;
  String? szCompanyId;
  String? szCompanyNm;
  String? szVersion;
  String? szAPKUrl;

  user({
    this.szId,
    this.szName,
    this.szPassword,
    this.szBranchId,
    this.szBranchNm,
    this.szCompanyId,
    this.szCompanyNm,
    this.szVersion,
    this.szAPKUrl
  });

  user.fromJson(Map<String, dynamic> json) {
    szId = json['szId'];
    szName = json['szName'];
    szPassword = json['szPassword'];
    szBranchId = json['szBranchId'];
    szBranchNm = json['szBranchNm'];
    szCompanyId = json['szCompanyId'];
    szCompanyNm = json['szCompanyNm'];
    szVersion = json['szVersion'];
    szAPKUrl = json['szAPKUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['szId'] = this.szId;
    data['szName'] = this.szName;
    data['szPassword'] = this.szPassword;
    data['szBranchId'] = this.szBranchId;
    data['szBranchNm'] = this.szBranchNm;
    data['szCompanyId'] = this.szCompanyId;
    data['szCompanyNm'] = this.szCompanyNm;
    data['szVersion'] = this.szVersion;
    data['szAPKUrl'] = this.szAPKUrl;
    return data;
  }
}
