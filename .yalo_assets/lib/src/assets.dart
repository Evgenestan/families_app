  import 'package:flutter/services.dart';
  enum Asset {
      _stub,
    
}

final Map<Asset, String> _assetEnumMap = {

};

class Assets {
String get addIcon => addIconS;
static const String addIconS = 'assets/icons/add_icon.png';
String get addChildIcon => addChildIconS;
static const String addChildIconS = 'assets/icons/add_child_icon.png';
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