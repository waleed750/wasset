import 'package:waseet/features/user/domain/entities/complaint_entity.dart';
import 'package:waseet/features/user/domain/entities/request/complaint_request.dart';
import 'package:waseet/res/resource.dart';

abstract class ComplaintRepository {
  Future<Resource<List<ComplaintEntity>?>> getComplaints(int userId);
  Future<Resource<String>> createComplaint(ComplaintRequest complaintRequest);
  // Future<Resource<String>> updateComplaint({
  //   required ComplaintRequest complaintRequest,
  //   required int id,
  // });
  // Future<Resource<String>> removeComplaint(int id);
}
