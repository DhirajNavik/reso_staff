class RefundApproval {
  final bool? status;
  final List<RefundApprovalDatum>? data;
  final String? message;

  RefundApproval({
    this.status,
    this.data,
    this.message,
  });

  factory RefundApproval.fromJson(Map<String, dynamic> json) => RefundApproval(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<RefundApprovalDatum>.from(
                json["data"]!.map((x) => RefundApprovalDatum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class RefundApprovalDatum {
  final String? formRequestId;
  final dynamic formGroupId;
  final String? userId;
  final String? formType;
  final RefundApprovalData? data;
  final dynamic fromdate;
  final dynamic todate;
  final dynamic indata;
  final dynamic gatepassid;
  final String? createdTimestamp;
  final dynamic updatedTimestamp;
  final String? status;
  final dynamic batchid;
  final String? datumCreatedBy;
  final dynamic datumUpdatedBy;
  final String? name;
  final String? applicationnumber;
  final String? createdBy;
  final dynamic updatedBy;

  RefundApprovalDatum({
    this.formRequestId,
    this.formGroupId,
    this.userId,
    this.formType,
    this.data,
    this.fromdate,
    this.todate,
    this.indata,
    this.gatepassid,
    this.createdTimestamp,
    this.updatedTimestamp,
    this.status,
    this.batchid,
    this.datumCreatedBy,
    this.datumUpdatedBy,
    this.name,
    this.applicationnumber,
    this.createdBy,
    this.updatedBy,
  });

  factory RefundApprovalDatum.fromJson(Map<String, dynamic> json) =>
      RefundApprovalDatum(
        formRequestId: json["form_request_id"],
        formGroupId: json["form_group_id"],
        userId: json["user_id"],
        formType: json["form_type"],
        data: json["data"] == null
            ? null
            : RefundApprovalData.fromJson(json["data"]),
        fromdate: json["fromdate"],
        todate: json["todate"],
        indata: json["indata"],
        gatepassid: json["gatepassid"],
        createdTimestamp: json["created_timestamp"],
        updatedTimestamp: json["updated_timestamp"],
        status: json["status"],
        batchid: json["batchid"],
        datumCreatedBy: json["created_by"],
        datumUpdatedBy: json["updated_by"],
        name: json["name"],
        applicationnumber: json["applicationnumber"],
        createdBy: json["CreatedBy"],
        updatedBy: json["UpdatedBy"],
      );

  Map<String, dynamic> toJson() => {
        "form_request_id": formRequestId,
        "form_group_id": formGroupId,
        "user_id": userId,
        "form_type": formType,
        "data": data?.toJson(),
        "fromdate": fromdate,
        "todate": todate,
        "indata": indata,
        "gatepassid": gatepassid,
        "created_timestamp": createdTimestamp,
        "updated_timestamp": updatedTimestamp,
        "status": status,
        "batchid": batchid,
        "created_by": datumCreatedBy,
        "updated_by": datumUpdatedBy,
        "name": name,
        "applicationnumber": applicationnumber,
        "CreatedBy": createdBy,
        "UpdatedBy": updatedBy,
      };
}

class RefundApprovalData {
  final String? ifsc;
  final String? acNo;
  final String? branch;
  final String? bankName;
  final String? daysInHostel;
  final int? refundAmount;
  final String? refundReason;
  final String? booksReceived;
  final String? materialReceived;

  RefundApprovalData({
    this.ifsc,
    this.acNo,
    this.branch,
    this.bankName,
    this.daysInHostel,
    this.refundAmount,
    this.refundReason,
    this.booksReceived,
    this.materialReceived,
  });

  factory RefundApprovalData.fromJson(Map<String, dynamic> json) =>
      RefundApprovalData(
        ifsc: json["IFSC"],
        acNo: json["Ac/No"],
        branch: json["Branch"],
        bankName: json["BankName"],
        daysInHostel: json["DaysInHostel"],
        refundAmount: json["RefundAmount"],
        refundReason: json["RefundReason"],
        booksReceived: json["BooksReceived"],
        materialReceived: json["MaterialReceived"],
      );

  Map<String, dynamic> toJson() => {
        "IFSC": ifsc,
        "Ac/No": acNo,
        "Branch": branch,
        "BankName": bankName,
        "DaysInHostel": daysInHostel,
        "RefundAmount": refundAmount,
        "RefundReason": refundReason,
        "BooksReceived": booksReceived,
        "MaterialReceived": materialReceived,
      };
}
