import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/feature/main/view_model/vm/main_vm.dart';

final mainVM = ChangeNotifierProvider((ref) {
  return MainVm();
});
