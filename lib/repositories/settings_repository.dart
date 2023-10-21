import 'package:calcularimcompersistenciadedados/classes/settings.dart';
import 'package:calcularimcompersistenciadedados/constants.dart';
import 'package:hive/hive.dart';

class SettingsRepository {
  static late Box _box;

  SettingsRepository.create();

  static Future<SettingsRepository> loadData() async {
    if (Hive.isBoxOpen(boxHistorico)) {
      _box = Hive.box(boxHistorico);
    } else {
      _box = await Hive.openBox(boxHistorico);
    }

    return SettingsRepository.create();
  }

  void save(Settings config) {
    _box.put(boxHistorico, {'nome': config.nome, 'altura': config.altura});
  }

  Settings getData() {
    var boxSettings = _box.get(boxHistorico) ?? Settings.empty();

    if (boxSettings == null) {
      return Settings.empty();
    }

    return Settings(
        boxSettings['nome']!, double.parse(boxSettings['altura'].toString()));
  }
}
