import '../../data/models/api_group.dart';
import '../entities/group.dart';

abstract interface class IGroupRepository {
  Future<void> createGroup(Group group);
}
