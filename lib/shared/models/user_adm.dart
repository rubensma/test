import 'package:academia/shared/models/user_abstract.dart';
import 'package:academia/shared/models/user_trainer.dart';

class UserAdm extends AbstractUser {
  late List<int> listTrainerIds;
  late List<UserTrainer> listUserTrainers;
}
