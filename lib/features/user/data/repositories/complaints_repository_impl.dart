import 'package:waseet/features/user/data/datasources/complaint_data_source.dart';
import 'package:waseet/features/user/domain/entities/complaint_entity.dart';
import 'package:waseet/features/user/domain/entities/request/complaint_request.dart';
import 'package:waseet/features/user/domain/repositories/complaints_repository.dart';
import 'package:waseet/res/resource.dart';

class ComplaintRepositoryImpl extends ComplaintRepository {
  ComplaintRepositoryImpl({
    required ComplaintDataSource complaintDataSource,
  }) : _complaintDataSource = complaintDataSource;

  final ComplaintDataSource _complaintDataSource;

  @override
  Future<Resource<List<ComplaintEntity>?>> getComplaints(int userId) {
    return _complaintDataSource.getComplaints(userId);
  }

  @override
  Future<Resource<String>> createComplaint(ComplaintRequest complaintRequest) {
    return _complaintDataSource.createComplaints(complaintRequest);
  }
}
