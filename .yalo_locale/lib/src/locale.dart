import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/src/widgets/localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

      abstract class _Home {
      late String title;
      late String children;
      }
      class _RuHome extends _Home {
      /// Description: ""
    /// Example: "Главная"
    @override
    final String title = Intl.message('Главная', name: 'title', desc: '');
      /// Description: ""
    /// Example: "Детей:"
    @override
    final String children = Intl.message('Детей:', name: 'children', desc: '');
      }
      abstract class _AddParent {
      late String title;
      late String about;
      }
      class _RuAddParent extends _AddParent {
      /// Description: ""
    /// Example: "Добавить родителя"
    @override
    final String title = Intl.message('Добавить родителя', name: 'title', desc: '');
      /// Description: ""
    /// Example: "Сведения о родителе:"
    @override
    final String about = Intl.message('Сведения о родителе:', name: 'about', desc: '');
      }
      abstract class _AddChild {
      late String title;
      late String about;
      }
      class _RuAddChild extends _AddChild {
      /// Description: ""
    /// Example: "Добавить ребенка"
    @override
    final String title = Intl.message('Добавить ребенка', name: 'title', desc: '');
      /// Description: ""
    /// Example: "Сведения о ребенке:"
    @override
    final String about = Intl.message('Сведения о ребенке:', name: 'about', desc: '');
      }
      abstract class _AddAdd {
      late String parent;
      late String child;
      }
      class _RuAddAdd extends _AddAdd {
      /// Description: ""
    /// Example: "Добавить родителя"
    @override
    final String parent = Intl.message('Добавить родителя', name: 'parent', desc: '');
      /// Description: ""
    /// Example: "Добавить ребенка"
    @override
    final String child = Intl.message('Добавить ребенка', name: 'child', desc: '');
      }
      abstract class _Add {
      late _AddParent parent;
      late _AddChild child;
      late String surname;
      late String name;
      late String patronymic;
      late String dob;
      late String position;
      late _AddAdd add;
      }
      class _RuAdd extends _Add {
      @override
    final _AddParent parent = _RuAddParent();
      @override
    final _AddChild child = _RuAddChild();
      /// Description: ""
    /// Example: "Фамилия"
    @override
    final String surname = Intl.message('Фамилия', name: 'surname', desc: '');
      /// Description: ""
    /// Example: "Имя"
    @override
    final String name = Intl.message('Имя', name: 'name', desc: '');
      /// Description: ""
    /// Example: "Отчество"
    @override
    final String patronymic = Intl.message('Отчество', name: 'patronymic', desc: '');
      /// Description: ""
    /// Example: "Дата рождения"
    @override
    final String dob = Intl.message('Дата рождения', name: 'dob', desc: '');
      /// Description: ""
    /// Example: "Должность"
    @override
    final String position = Intl.message('Должность', name: 'position', desc: '');
      @override
    final _AddAdd add = _RuAddAdd();
      }
      abstract class LocalizationMessages {
      late _Home home;
      late _Add add;
      }
      class _Ru extends LocalizationMessages {
      @override
    final _Home home = _RuHome();
      @override
    final _Add add = _RuAdd();
      }
    class LocalizationDelegate extends LocalizationsDelegate<LocalizationMessages> {
    @override
    bool isSupported(Locale locale) => _languageMap.keys.contains(locale.languageCode);
  
    @override
    Future<LocalizationMessages> load(Locale locale) async {
      Intl.defaultLocale = locale.countryCode == null ? locale.languageCode : locale.toString();
      return _languageMap[locale.languageCode]!;
    }
    
    @override
    bool shouldReload(LocalizationsDelegate<LocalizationMessages> old) => false;

    final Map<String, LocalizationMessages> _languageMap = {
      'ru': _Ru(),
      };

    }

    class Messages {
    static LocalizationMessages of(BuildContext context) => Localizations.of(context, LocalizationMessages);

    static LocalizationMessages get ru => LocalizationDelegate()._languageMap['ru']!;
    
  }
  
  final List<LocalizationsDelegate> localizationsDelegates = [LocalizationDelegate(), ...GlobalMaterialLocalizations.delegates];

  const List<Locale> supportedLocales = [
const Locale('ru'),
    ];