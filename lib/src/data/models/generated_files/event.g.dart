part of '../event.dart';

Serializer<Event> _$eventSerializer = new _$EventSerializer();

class _$EventSerializer implements StructuredSerializer<Event> {
  @override
  final Iterable<Type> types = const [Event, _$Event];
  @override
  final String wireName = 'Event';

  @override
  Iterable<Object> serialize(Serializers serializers, Event object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'price',
      serializers.serialize(object.price,
          specifiedType: const FullType(double)),
      'date',
      serializers.serialize(object.date,
          specifiedType: const FullType(DateTime)),
      'creator',
      serializers.serialize(object.creator,
          specifiedType: const FullType(User)),
    ];

    return result;
  }

  @override
  Event deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EventBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'creator':
          result.creator.replace(serializers.deserialize(value,
              specifiedType: const FullType(User)) as User);
          break;
      }
    }

    return result.build();
  }
}

class _$Event extends Event {
  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final double price;
  @override
  final DateTime date;
  @override
  final User creator;

  factory _$Event([void Function(EventBuilder) updates]) =>
      (new EventBuilder()..update(updates)).build();

  _$Event._(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.date,
      this.creator})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Event', 'id');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('Event', 'title');
    }
    if (description == null) {
      throw new BuiltValueNullFieldError('Event', 'description');
    }
    if (price == null) {
      throw new BuiltValueNullFieldError('Event', 'price');
    }
    if (date == null) {
      throw new BuiltValueNullFieldError('Event', 'date');
    }
    if (creator == null) {
      throw new BuiltValueNullFieldError('Event', 'creator');
    }
  }

  @override
  Event rebuild(void Function(EventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EventBuilder toBuilder() => new EventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Event &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        price == other.price &&
        date == other.date &&
        creator == other.creator;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, id.hashCode), title.hashCode),
                    description.hashCode),
                price.hashCode),
            date.hashCode),
        creator.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Event')
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('price', price)
          ..add('date', date)
          ..add('creator', creator))
        .toString();
  }
}

class EventBuilder implements Builder<Event, EventBuilder> {
  _$Event _$v;

  String _id;

  String get id => _$this._id;

  set id(String id) => _$this._id = id;

  String _title;

  String get title => _$this._title;

  set title(String title) => _$this._title = title;

  String _description;

  String get description => _$this._description;

  set description(String description) => _$this._description = description;

  double _price;

  double get price => _$this._price;

  set price(double price) => _$this._price = price;

  DateTime _date;

  DateTime get date => _$this._date;

  set date(DateTime date) => _$this._date = date;

  UserBuilder _creator;

  UserBuilder get creator => _$this._creator ??= new UserBuilder();

  set creator(UserBuilder creator) => _$this._creator = creator;

  EventBuilder();

  EventBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _title = _$v.title;
      _description = _$v.description;
      _price = _$v.price;
      _date = _$v.date;
      _creator = _$v.creator?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Event other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Event;
  }

  @override
  void update(void Function(EventBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Event build() {
    _$Event _$result;
    try {
      _$result = _$v ??
          new _$Event._(
              id: id,
              title: title,
              description: description,
              price: price,
              date: date,
              creator: creator.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'creator';
        creator.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Event', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
