  import 'package:flutter/services.dart';
  enum Asset {
      _stub,
    intl,

}

final Map<Asset, String> _assetEnumMap = {
Asset.intl: 'assets/localizations/ru/intl.yaml',

};

class Assets {
String get intl => intlS;
static const String intlS = 'assets/localizations/ru/intl.yaml';
    final Map<Asset, String> _preloadedAssets = Map();
    bool isPreloaded = false;
    Future<bool> preloadAssets() async {
      final List<Future> loaders = [];
      loadAsset(Asset asset) async {        
        final String assetContent = await rootBundle.loadString(_assetEnumMap[asset]!, cache: false);
        _preloadedAssets[asset] = assetContent;
      }
      for (Asset assetEnumField in Asset.values) {
        loaders.add(loadAsset(assetEnumField));
      }
      await Future.wait<void>(loaders);
      isPreloaded = true;
      return isPreloaded;
    }
    String getAssetData(Asset assetEnum) {
      if (!isPreloaded) {
        throw Exception('You should run method "preloadAssets" before accessing data with "getAssetData" method');
      }
      return _preloadedAssets[assetEnum]!;
    }
}