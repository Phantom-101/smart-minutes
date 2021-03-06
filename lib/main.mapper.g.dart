// This file has been generated by the dart_json_mapper package.
// https://github.com/k-paxian/dart-json-mapper
// @dart = 2.12
import 'package:dart_json_mapper/dart_json_mapper.dart' show JsonMapper, JsonMapperAdapter, typeOf;
// This file has been generated by the reflectable package.
// https://github.com/dart-lang/reflectable.


import 'dart:core';
import 'package:dart_json_mapper/src/model/annotations.dart' as prefix0;

// ignore_for_file: prefer_adjacent_string_concatenation
// ignore_for_file: prefer_collection_literals
// ignore_for_file: unnecessary_const
// ignore_for_file: implementation_imports

// ignore:unused_import
import 'package:reflectable/mirrors.dart' as m;
// ignore:unused_import
import 'package:reflectable/src/reflectable_builder_based.dart' as r;
// ignore:unused_import
import 'package:reflectable/reflectable.dart' as r show Reflectable;

final _data = <r.Reflectable, r.ReflectorData>{const prefix0.JsonSerializable(): r.ReflectorData(<m.TypeMirror>[], <m.DeclarationMirror>[], <m.ParameterMirror>[], <Type>[], 0, {}, {}, null, [])};


final _memberSymbolMap = null;

void _initializeReflectable(JsonMapperAdapter adapter) {
  if (!adapter.isGenerated) {
    return;
  }
  r.data = adapter.reflectableData!;
  r.memberSymbolMap = adapter.memberSymbolMap;
}

final mainGeneratedAdapter = JsonMapperAdapter(
  title: 'Main Generated Adapter',
  url: 'package:meeting_minutes/main.dart',
  reflectableData: _data,
  memberSymbolMap: _memberSymbolMap,
  valueDecorators: {

},
  enumValues: {

});

Future<JsonMapper> initializeJsonMapperAsync({Iterable<JsonMapperAdapter> adapters = const []}) => Future(() => initializeJsonMapper(adapters: adapters));

JsonMapper initializeJsonMapper({Iterable<JsonMapperAdapter> adapters = const []}) {
  JsonMapper.enumerateAdapters([...adapters, mainGeneratedAdapter], (JsonMapperAdapter adapter) {
    _initializeReflectable(adapter);
    JsonMapper().useAdapter(adapter);
  });
  return JsonMapper();
}