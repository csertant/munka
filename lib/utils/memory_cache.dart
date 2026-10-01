import 'types.dart';

class CacheItem {
  CacheItem(this.value, this.lastModifiedAt);
  final CacheValue value;
  final DateTime lastModifiedAt;
}

class MemoryCache {
  final Map<CacheKey, CacheItem> _cache = {};

  CacheValue? getItem(CacheKey key) {
    final item = _cache[key];
    if (item == null) {
      return null;
    }
    return item.value;
  }

  void setItem(CacheKey key, CacheValue value) {
    _cache[key] = CacheItem(value, DateTime.now());
  }

  DateTime? getLastModifiedAt(CacheKey key) {
    final item = _cache[key];
    if (item == null) {
      return null;
    }
    return item.lastModifiedAt;
  }
}
