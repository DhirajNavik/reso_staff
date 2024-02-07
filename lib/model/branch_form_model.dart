class BranchTransfer {
  final bool? status;
  final List<BranchTransferDatum>? data;
  final String? message;

  BranchTransfer({
    this.status,
    this.data,
    this.message,
  });

  factory BranchTransfer.fromJson(Map<String, dynamic> json) => BranchTransfer(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<BranchTransferDatum>.from(
                json["data"]!.map((x) => BranchTransferDatum.fromJson(x))),
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

class BranchTransferDatum {
  final String? formRequestId;
  final dynamic formGroupId;
  final String? userId;
  final String? formType;
  final BranchTransferData? data;
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

  BranchTransferDatum({
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

  factory BranchTransferDatum.fromJson(Map<String, dynamic> json) =>
      BranchTransferDatum(
        formRequestId: json["form_request_id"],
        formGroupId: json["form_group_id"],
        userId: json["user_id"],
        formType: json["form_type"],
        data: json["data"] == null
            ? null
            : BranchTransferData.fromJson(json["data"]),
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

class BranchTransferData {
  final String? fee;
  final String? branchid;
  final String? inventory;
  final DateTime? transferDate;
  final String? admissionType;
  final DateTime? reportingDate;
  final String? transferReason;
  final String? daysStayedInHostel;

  BranchTransferData({
    this.fee,
    this.branchid,
    this.inventory,
    this.transferDate,
    this.admissionType,
    this.reportingDate,
    this.transferReason,
    this.daysStayedInHostel,
  });

  factory BranchTransferData.fromJson(Map<String, dynamic> json) =>
      BranchTransferData(
        fee: json["fee"],
        branchid: json["Branchid"],
        inventory: json["Inventory"],
        transferDate: json["TransferDate"] == null
            ? null
            : DateTime.parse(json["TransferDate"]),
        admissionType: json["AdmissionType"],
        reportingDate: json["ReportingDate"] == null
            ? null
            : DateTime.parse(json["ReportingDate"]),
        transferReason: json["TransferReason"],
        daysStayedInHostel: json["DaysStayedInHostel"],
      );

  Map<String, dynamic> toJson() => {
        "fee": fee,
        "Branchid": branchid,
        "Inventory": inventory,
        "TransferDate":
            "${transferDate!.year.toString().padLeft(4, '0')}-${transferDate!.month.toString().padLeft(2, '0')}-${transferDate!.day.toString().padLeft(2, '0')}",
        "AdmissionType": admissionType,
        "ReportingDate":
            "${reportingDate!.year.toString().padLeft(4, '0')}-${reportingDate!.month.toString().padLeft(2, '0')}-${reportingDate!.day.toString().padLeft(2, '0')}",
        "TransferReason": transferReason,
        "DaysStayedInHostel": daysStayedInHostel,
      };
}
