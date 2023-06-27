import 'package:dio/dio.dart';
import 'package:prev_ler/src/shared/cache/domain/cache_model.dart';
import 'package:prev_ler/src/shared/cache/domain/cache_service.dart';
import 'package:prev_ler/src/shared/services/check_internet.dart';
import 'package:prev_ler/src/shared/utils/debug_print_http.dart';

class CacheInterceptor extends InterceptorsWrapper {
  static const _durationCacheInMinutes = 5;
  final ICacheAdapter _cacheAdapter;
  final CheckInternet _checkInternet;

  CacheInterceptor({cacheAdapter, checkInternet})
      : _cacheAdapter = cacheAdapter,
        _checkInternet = checkInternet;

  _getCacheId(RequestOptions options) {
    return '${options.method}${options.path}';
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    debugPrintHttpRequestOptions(options);

    final online = await _checkInternet();
    final bool getCache = (options.extra['cached'] ?? false) || !online;
    if (!getCache) {
      return handler.next(options);
    }

    final cacheId = _getCacheId(options);
    var dataCached = await _cacheAdapter.get(cacheId);
    if (dataCached == null) {
      return handler.next(options);
    }

    final now = DateTime.now();
    final cacheDataDurationDiff = now.difference(dataCached.date).inMinutes;
    if (online || cacheDataDurationDiff > _durationCacheInMinutes) {
      return handler.next(options);
    }

    return handler.resolve(
      Response(
        data: dataCached.data,
        extra: options.extra,
        statusCode: 200,
        requestOptions: options,
      ),
      true,
    );
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    debugPrintHttpResponse(response);

    final options = response.requestOptions;
    if (options.method != 'GET') {
      return handler.next(response);
    }

    final id = _getCacheId(options);
    var dataCached = await _cacheAdapter.get(id);
    final now = DateTime.now();
    final cacheDataDurationDiff = now.difference(
      dataCached?.date ?? now.subtract(const Duration(minutes: 5)),
    );

    final online = await _checkInternet();

    if (online && cacheDataDurationDiff.inMinutes >= _durationCacheInMinutes) {
      final data = CacheModel(
        data: response.data,
        date: DateTime.now(),
        id: id,
      );
      _cacheAdapter.put(data);
    }

    return handler.next(response);
  }
}
