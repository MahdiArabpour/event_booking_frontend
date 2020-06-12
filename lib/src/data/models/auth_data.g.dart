// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AuthData> _$authDataSerializer = new _$AuthDataSerializer();

class _$AuthDataSerializer implements StructuredSerializer<AuthData> {
  @override
  final Iterable<Type> types = const [AuthData, _$AuthData];
  @override
  final String wireName = 'AuthData';

  @override
  Iterable<Object> serialize(Serializers serializers, AuthData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
      'token',
      serializers.serialize(object.token,
          specifiedType: const FullType(String)),
      'tokenExpiration',
      serializers.serialize(object.tokenExpiration,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  AuthData deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AuthDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'token':
          result.token = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tokenExpiration':
          result.tokenExpiration = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$AuthData extends AuthData {
  @override
  final String userId;
  @override
  final String token;
  @override
  final int tokenExpiration;

  factory _$AuthData([void Function(AuthDataBuilder) updates]) =>
      (new AuthDataBuilder()..update(updates)).build();

  _$AuthData._({this.userId, this.token, this.tokenExpiration}) : super._() {
    if (userId == null) {
      throw new BuiltValueNullFieldError('AuthData', 'userId');
    }
    if (token == null) {
      throw new BuiltValueNullFieldError('AuthData', 'token');
    }
    if (tokenExpiration == null) {
      throw new BuiltValueNullFieldError('AuthData', 'tokenExpiration');
    }
  }

  @override
  AuthData rebuild(void Function(AuthDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthDataBuilder toBuilder() => new AuthDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthData &&
        userId == other.userId &&
        token == other.token &&
        tokenExpiration == other.tokenExpiration;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, userId.hashCode), token.hashCode),
        tokenExpiration.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AuthData')
          ..add('userId', userId)
          ..add('token', token)
          ..add('tokenExpiration', tokenExpiration))
        .toString();
  }
}

class AuthDataBuilder implements Builder<AuthData, AuthDataBuilder> {
  _$AuthData _$v;

  String _userId;
  String get userId => _$this._userId;
  set userId(String userId) => _$this._userId = userId;

  String _token;
  String get token => _$this._token;
  set token(String token) => _$this._token = token;

  int _tokenExpiration;
  int get tokenExpiration => _$this._tokenExpiration;
  set tokenExpiration(int tokenExpiration) =>
      _$this._tokenExpiration = tokenExpiration;

  AuthDataBuilder();

  AuthDataBuilder get _$this {
    if (_$v != null) {
      _userId = _$v.userId;
      _token = _$v.token;
      _tokenExpiration = _$v.tokenExpiration;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthData other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AuthData;
  }

  @override
  void update(void Function(AuthDataBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AuthData build() {
    final _$result = _$v ??
        new _$AuthData._(
            userId: userId, token: token, tokenExpiration: tokenExpiration);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
