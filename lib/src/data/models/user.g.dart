// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<User> _$userSerializer = new _$UserSerializer();

class _$UserSerializer implements StructuredSerializer<User> {
  @override
  final Iterable<Type> types = const [User, _$User];
  @override
  final String wireName = 'User';

  @override
  Iterable<Object> serialize(Serializers serializers, User object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      '_id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
    ];
    if (object.password != null) {
      result
        ..add('password')
        ..add(serializers.serialize(object.password,
            specifiedType: const FullType(String)));
    }
    if (object.createdEvents != null) {
      result
        ..add('createdEvents')
        ..add(serializers.serialize(object.createdEvents,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Event)])));
    }
    return result;
  }

  @override
  User deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case '_id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'createdEvents':
          result.createdEvents.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Event)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$User extends User {
  @override
  final String id;
  @override
  final String email;
  @override
  final String password;
  @override
  final BuiltList<Event> createdEvents;

  factory _$User([void Function(UserBuilder) updates]) =>
      (new UserBuilder()..update(updates)).build();

  _$User._({this.id, this.email, this.password, this.createdEvents})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('User', 'id');
    }
    if (email == null) {
      throw new BuiltValueNullFieldError('User', 'email');
    }
  }

  @override
  User rebuild(void Function(UserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => new UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        id == other.id &&
        email == other.email &&
        password == other.password &&
        createdEvents == other.createdEvents;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, id.hashCode), email.hashCode), password.hashCode),
        createdEvents.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('User')
          ..add('id', id)
          ..add('email', email)
          ..add('password', password)
          ..add('createdEvents', createdEvents))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _password;
  String get password => _$this._password;
  set password(String password) => _$this._password = password;

  ListBuilder<Event> _createdEvents;
  ListBuilder<Event> get createdEvents =>
      _$this._createdEvents ??= new ListBuilder<Event>();
  set createdEvents(ListBuilder<Event> createdEvents) =>
      _$this._createdEvents = createdEvents;

  UserBuilder();

  UserBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _email = _$v.email;
      _password = _$v.password;
      _createdEvents = _$v.createdEvents?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$User;
  }

  @override
  void update(void Function(UserBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$User build() {
    _$User _$result;
    try {
      _$result = _$v ??
          new _$User._(
              id: id,
              email: email,
              password: password,
              createdEvents: _createdEvents?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'createdEvents';
        _createdEvents?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'User', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
