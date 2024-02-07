class DiscountApproval {
  final bool? status;
  final List<DiscountApprovalDatum>? data;
  final String? message;

  DiscountApproval({
    this.status,
    this.data,
    this.message,
  });

  factory DiscountApproval.fromJson(Map<String, dynamic> json) =>
      DiscountApproval(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<DiscountApprovalDatum>.from(
                json["data"]!.map((x) => DiscountApprovalDatum.fromJson(x))),
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

class DiscountApprovalDatum {
  final String? formRequestId;
  final dynamic formGroupId;
  final String? userId;
  final String? formType;
  final DiscountApprovalData? data;
  final dynamic fromdate;
  final dynamic todate;
  final dynamic indata;
  final dynamic gatepassid;
  final String? createdTimestamp;
  final dynamic updatedTimestamp;
  final String? status;
  final String? batchid;
  final String? datumCreatedBy;
  final dynamic datumUpdatedBy;
  final String? name;
  final String? applicationnumber;
  final String? createdBy;
  final dynamic updatedBy;
  final dynamic discountid;

  DiscountApprovalDatum({
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
    this.discountid,
  });

  factory DiscountApprovalDatum.fromJson(Map<String, dynamic> json) =>
      DiscountApprovalDatum(
        formRequestId: json["form_request_id"],
        formGroupId: json["form_group_id"],
        userId: json["user_id"],
        formType: json["form_type"],
        data: json["data"] == null
            ? null
            : DiscountApprovalData.fromJson(json["data"]),
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
        discountid: json["discount_id"],
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
        "discountid": discountid,
      };
}

class DiscountApprovalData {
  final String? amount;
  final String? invoiceId;
  final String? discountid;
  final String? additionaldetails;

  DiscountApprovalData({
    this.amount,
    this.invoiceId,
    this.discountid,
    this.additionaldetails,
  });

  factory DiscountApprovalData.fromJson(Map<String, dynamic> json) =>
      DiscountApprovalData(
        amount: json["Amount"],
        invoiceId: json["InvoiceId"],
        discountid: json["discountid"],
        additionaldetails: json["additionaldetails"],
      );

  Map<String, dynamic> toJson() => {
        "Amount": amount,
        "InvoiceId": invoiceId,
        "discountid": discountid,
        "additionaldetails": additionaldetails,
      };
}
