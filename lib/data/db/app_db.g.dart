// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// ignore_for_file: type=lint
class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('INR'),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _merchantNameMeta = const VerificationMeta(
    'merchantName',
  );
  @override
  late final GeneratedColumn<String> merchantName = GeneratedColumn<String>(
    'merchant_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _merchantVpaMeta = const VerificationMeta(
    'merchantVpa',
  );
  @override
  late final GeneratedColumn<String> merchantVpa = GeneratedColumn<String>(
    'merchant_vpa',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _merchantCodeMeta = const VerificationMeta(
    'merchantCode',
  );
  @override
  late final GeneratedColumn<String> merchantCode = GeneratedColumn<String>(
    'merchant_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _transactionReferenceMeta =
      const VerificationMeta('transactionReference');
  @override
  late final GeneratedColumn<String> transactionReference =
      GeneratedColumn<String>(
        'transaction_reference',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _transactionNoteMeta = const VerificationMeta(
    'transactionNote',
  );
  @override
  late final GeneratedColumn<String> transactionNote = GeneratedColumn<String>(
    'transaction_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _qrRawDataMeta = const VerificationMeta(
    'qrRawData',
  );
  @override
  late final GeneratedColumn<String> qrRawData = GeneratedColumn<String>(
    'qr_raw_data',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _upiAppMeta = const VerificationMeta('upiApp');
  @override
  late final GeneratedColumn<String> upiApp = GeneratedColumn<String>(
    'upi_app',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentStatusMeta = const VerificationMeta(
    'paymentStatus',
  );
  @override
  late final GeneratedColumn<String> paymentStatus = GeneratedColumn<String>(
    'payment_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('draft'),
  );
  static const VerificationMeta _paymentTimestampMeta = const VerificationMeta(
    'paymentTimestamp',
  );
  @override
  late final GeneratedColumn<DateTime> paymentTimestamp =
      GeneratedColumn<DateTime>(
        'payment_timestamp',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _timezoneMeta = const VerificationMeta(
    'timezone',
  );
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
    'timezone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationAccuracyMeta = const VerificationMeta(
    'locationAccuracy',
  );
  @override
  late final GeneratedColumn<double> locationAccuracy = GeneratedColumn<double>(
    'location_accuracy',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationLabelMeta = const VerificationMeta(
    'locationLabel',
  );
  @override
  late final GeneratedColumn<String> locationLabel = GeneratedColumn<String>(
    'location_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    amount,
    currency,
    category,
    description,
    merchantName,
    merchantVpa,
    merchantCode,
    transactionReference,
    transactionNote,
    qrRawData,
    upiApp,
    paymentStatus,
    paymentTimestamp,
    timezone,
    latitude,
    longitude,
    locationAccuracy,
    locationLabel,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Transaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('merchant_name')) {
      context.handle(
        _merchantNameMeta,
        merchantName.isAcceptableOrUnknown(
          data['merchant_name']!,
          _merchantNameMeta,
        ),
      );
    }
    if (data.containsKey('merchant_vpa')) {
      context.handle(
        _merchantVpaMeta,
        merchantVpa.isAcceptableOrUnknown(
          data['merchant_vpa']!,
          _merchantVpaMeta,
        ),
      );
    }
    if (data.containsKey('merchant_code')) {
      context.handle(
        _merchantCodeMeta,
        merchantCode.isAcceptableOrUnknown(
          data['merchant_code']!,
          _merchantCodeMeta,
        ),
      );
    }
    if (data.containsKey('transaction_reference')) {
      context.handle(
        _transactionReferenceMeta,
        transactionReference.isAcceptableOrUnknown(
          data['transaction_reference']!,
          _transactionReferenceMeta,
        ),
      );
    }
    if (data.containsKey('transaction_note')) {
      context.handle(
        _transactionNoteMeta,
        transactionNote.isAcceptableOrUnknown(
          data['transaction_note']!,
          _transactionNoteMeta,
        ),
      );
    }
    if (data.containsKey('qr_raw_data')) {
      context.handle(
        _qrRawDataMeta,
        qrRawData.isAcceptableOrUnknown(data['qr_raw_data']!, _qrRawDataMeta),
      );
    }
    if (data.containsKey('upi_app')) {
      context.handle(
        _upiAppMeta,
        upiApp.isAcceptableOrUnknown(data['upi_app']!, _upiAppMeta),
      );
    }
    if (data.containsKey('payment_status')) {
      context.handle(
        _paymentStatusMeta,
        paymentStatus.isAcceptableOrUnknown(
          data['payment_status']!,
          _paymentStatusMeta,
        ),
      );
    }
    if (data.containsKey('payment_timestamp')) {
      context.handle(
        _paymentTimestampMeta,
        paymentTimestamp.isAcceptableOrUnknown(
          data['payment_timestamp']!,
          _paymentTimestampMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentTimestampMeta);
    }
    if (data.containsKey('timezone')) {
      context.handle(
        _timezoneMeta,
        timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('location_accuracy')) {
      context.handle(
        _locationAccuracyMeta,
        locationAccuracy.isAcceptableOrUnknown(
          data['location_accuracy']!,
          _locationAccuracyMeta,
        ),
      );
    }
    if (data.containsKey('location_label')) {
      context.handle(
        _locationLabelMeta,
        locationLabel.isAcceptableOrUnknown(
          data['location_label']!,
          _locationLabelMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      merchantName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant_name'],
      )!,
      merchantVpa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant_vpa'],
      ),
      merchantCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant_code'],
      ),
      transactionReference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_reference'],
      ),
      transactionNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_note'],
      ),
      qrRawData: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}qr_raw_data'],
      ),
      upiApp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}upi_app'],
      ),
      paymentStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_status'],
      )!,
      paymentTimestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}payment_timestamp'],
      )!,
      timezone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timezone'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      locationAccuracy: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}location_accuracy'],
      ),
      locationLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_label'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final String id;
  final double amount;
  final String currency;
  final String category;
  final String? description;
  final String merchantName;
  final String? merchantVpa;
  final String? merchantCode;
  final String? transactionReference;
  final String? transactionNote;
  final String? qrRawData;
  final String? upiApp;
  final String paymentStatus;
  final DateTime paymentTimestamp;
  final String? timezone;
  final double? latitude;
  final double? longitude;
  final double? locationAccuracy;
  final String? locationLabel;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Transaction({
    required this.id,
    required this.amount,
    required this.currency,
    required this.category,
    this.description,
    required this.merchantName,
    this.merchantVpa,
    this.merchantCode,
    this.transactionReference,
    this.transactionNote,
    this.qrRawData,
    this.upiApp,
    required this.paymentStatus,
    required this.paymentTimestamp,
    this.timezone,
    this.latitude,
    this.longitude,
    this.locationAccuracy,
    this.locationLabel,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['amount'] = Variable<double>(amount);
    map['currency'] = Variable<String>(currency);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['merchant_name'] = Variable<String>(merchantName);
    if (!nullToAbsent || merchantVpa != null) {
      map['merchant_vpa'] = Variable<String>(merchantVpa);
    }
    if (!nullToAbsent || merchantCode != null) {
      map['merchant_code'] = Variable<String>(merchantCode);
    }
    if (!nullToAbsent || transactionReference != null) {
      map['transaction_reference'] = Variable<String>(transactionReference);
    }
    if (!nullToAbsent || transactionNote != null) {
      map['transaction_note'] = Variable<String>(transactionNote);
    }
    if (!nullToAbsent || qrRawData != null) {
      map['qr_raw_data'] = Variable<String>(qrRawData);
    }
    if (!nullToAbsent || upiApp != null) {
      map['upi_app'] = Variable<String>(upiApp);
    }
    map['payment_status'] = Variable<String>(paymentStatus);
    map['payment_timestamp'] = Variable<DateTime>(paymentTimestamp);
    if (!nullToAbsent || timezone != null) {
      map['timezone'] = Variable<String>(timezone);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || locationAccuracy != null) {
      map['location_accuracy'] = Variable<double>(locationAccuracy);
    }
    if (!nullToAbsent || locationLabel != null) {
      map['location_label'] = Variable<String>(locationLabel);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      amount: Value(amount),
      currency: Value(currency),
      category: Value(category),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      merchantName: Value(merchantName),
      merchantVpa: merchantVpa == null && nullToAbsent
          ? const Value.absent()
          : Value(merchantVpa),
      merchantCode: merchantCode == null && nullToAbsent
          ? const Value.absent()
          : Value(merchantCode),
      transactionReference: transactionReference == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionReference),
      transactionNote: transactionNote == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionNote),
      qrRawData: qrRawData == null && nullToAbsent
          ? const Value.absent()
          : Value(qrRawData),
      upiApp: upiApp == null && nullToAbsent
          ? const Value.absent()
          : Value(upiApp),
      paymentStatus: Value(paymentStatus),
      paymentTimestamp: Value(paymentTimestamp),
      timezone: timezone == null && nullToAbsent
          ? const Value.absent()
          : Value(timezone),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      locationAccuracy: locationAccuracy == null && nullToAbsent
          ? const Value.absent()
          : Value(locationAccuracy),
      locationLabel: locationLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(locationLabel),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Transaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<String>(json['id']),
      amount: serializer.fromJson<double>(json['amount']),
      currency: serializer.fromJson<String>(json['currency']),
      category: serializer.fromJson<String>(json['category']),
      description: serializer.fromJson<String?>(json['description']),
      merchantName: serializer.fromJson<String>(json['merchantName']),
      merchantVpa: serializer.fromJson<String?>(json['merchantVpa']),
      merchantCode: serializer.fromJson<String?>(json['merchantCode']),
      transactionReference: serializer.fromJson<String?>(
        json['transactionReference'],
      ),
      transactionNote: serializer.fromJson<String?>(json['transactionNote']),
      qrRawData: serializer.fromJson<String?>(json['qrRawData']),
      upiApp: serializer.fromJson<String?>(json['upiApp']),
      paymentStatus: serializer.fromJson<String>(json['paymentStatus']),
      paymentTimestamp: serializer.fromJson<DateTime>(json['paymentTimestamp']),
      timezone: serializer.fromJson<String?>(json['timezone']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      locationAccuracy: serializer.fromJson<double?>(json['locationAccuracy']),
      locationLabel: serializer.fromJson<String?>(json['locationLabel']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'amount': serializer.toJson<double>(amount),
      'currency': serializer.toJson<String>(currency),
      'category': serializer.toJson<String>(category),
      'description': serializer.toJson<String?>(description),
      'merchantName': serializer.toJson<String>(merchantName),
      'merchantVpa': serializer.toJson<String?>(merchantVpa),
      'merchantCode': serializer.toJson<String?>(merchantCode),
      'transactionReference': serializer.toJson<String?>(transactionReference),
      'transactionNote': serializer.toJson<String?>(transactionNote),
      'qrRawData': serializer.toJson<String?>(qrRawData),
      'upiApp': serializer.toJson<String?>(upiApp),
      'paymentStatus': serializer.toJson<String>(paymentStatus),
      'paymentTimestamp': serializer.toJson<DateTime>(paymentTimestamp),
      'timezone': serializer.toJson<String?>(timezone),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'locationAccuracy': serializer.toJson<double?>(locationAccuracy),
      'locationLabel': serializer.toJson<String?>(locationLabel),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Transaction copyWith({
    String? id,
    double? amount,
    String? currency,
    String? category,
    Value<String?> description = const Value.absent(),
    String? merchantName,
    Value<String?> merchantVpa = const Value.absent(),
    Value<String?> merchantCode = const Value.absent(),
    Value<String?> transactionReference = const Value.absent(),
    Value<String?> transactionNote = const Value.absent(),
    Value<String?> qrRawData = const Value.absent(),
    Value<String?> upiApp = const Value.absent(),
    String? paymentStatus,
    DateTime? paymentTimestamp,
    Value<String?> timezone = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<double?> locationAccuracy = const Value.absent(),
    Value<String?> locationLabel = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Transaction(
    id: id ?? this.id,
    amount: amount ?? this.amount,
    currency: currency ?? this.currency,
    category: category ?? this.category,
    description: description.present ? description.value : this.description,
    merchantName: merchantName ?? this.merchantName,
    merchantVpa: merchantVpa.present ? merchantVpa.value : this.merchantVpa,
    merchantCode: merchantCode.present ? merchantCode.value : this.merchantCode,
    transactionReference: transactionReference.present
        ? transactionReference.value
        : this.transactionReference,
    transactionNote: transactionNote.present
        ? transactionNote.value
        : this.transactionNote,
    qrRawData: qrRawData.present ? qrRawData.value : this.qrRawData,
    upiApp: upiApp.present ? upiApp.value : this.upiApp,
    paymentStatus: paymentStatus ?? this.paymentStatus,
    paymentTimestamp: paymentTimestamp ?? this.paymentTimestamp,
    timezone: timezone.present ? timezone.value : this.timezone,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    locationAccuracy: locationAccuracy.present
        ? locationAccuracy.value
        : this.locationAccuracy,
    locationLabel: locationLabel.present
        ? locationLabel.value
        : this.locationLabel,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Transaction copyWithCompanion(TransactionsCompanion data) {
    return Transaction(
      id: data.id.present ? data.id.value : this.id,
      amount: data.amount.present ? data.amount.value : this.amount,
      currency: data.currency.present ? data.currency.value : this.currency,
      category: data.category.present ? data.category.value : this.category,
      description: data.description.present
          ? data.description.value
          : this.description,
      merchantName: data.merchantName.present
          ? data.merchantName.value
          : this.merchantName,
      merchantVpa: data.merchantVpa.present
          ? data.merchantVpa.value
          : this.merchantVpa,
      merchantCode: data.merchantCode.present
          ? data.merchantCode.value
          : this.merchantCode,
      transactionReference: data.transactionReference.present
          ? data.transactionReference.value
          : this.transactionReference,
      transactionNote: data.transactionNote.present
          ? data.transactionNote.value
          : this.transactionNote,
      qrRawData: data.qrRawData.present ? data.qrRawData.value : this.qrRawData,
      upiApp: data.upiApp.present ? data.upiApp.value : this.upiApp,
      paymentStatus: data.paymentStatus.present
          ? data.paymentStatus.value
          : this.paymentStatus,
      paymentTimestamp: data.paymentTimestamp.present
          ? data.paymentTimestamp.value
          : this.paymentTimestamp,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      locationAccuracy: data.locationAccuracy.present
          ? data.locationAccuracy.value
          : this.locationAccuracy,
      locationLabel: data.locationLabel.present
          ? data.locationLabel.value
          : this.locationLabel,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('merchantName: $merchantName, ')
          ..write('merchantVpa: $merchantVpa, ')
          ..write('merchantCode: $merchantCode, ')
          ..write('transactionReference: $transactionReference, ')
          ..write('transactionNote: $transactionNote, ')
          ..write('qrRawData: $qrRawData, ')
          ..write('upiApp: $upiApp, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('paymentTimestamp: $paymentTimestamp, ')
          ..write('timezone: $timezone, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('locationAccuracy: $locationAccuracy, ')
          ..write('locationLabel: $locationLabel, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    amount,
    currency,
    category,
    description,
    merchantName,
    merchantVpa,
    merchantCode,
    transactionReference,
    transactionNote,
    qrRawData,
    upiApp,
    paymentStatus,
    paymentTimestamp,
    timezone,
    latitude,
    longitude,
    locationAccuracy,
    locationLabel,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.currency == this.currency &&
          other.category == this.category &&
          other.description == this.description &&
          other.merchantName == this.merchantName &&
          other.merchantVpa == this.merchantVpa &&
          other.merchantCode == this.merchantCode &&
          other.transactionReference == this.transactionReference &&
          other.transactionNote == this.transactionNote &&
          other.qrRawData == this.qrRawData &&
          other.upiApp == this.upiApp &&
          other.paymentStatus == this.paymentStatus &&
          other.paymentTimestamp == this.paymentTimestamp &&
          other.timezone == this.timezone &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.locationAccuracy == this.locationAccuracy &&
          other.locationLabel == this.locationLabel &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<String> id;
  final Value<double> amount;
  final Value<String> currency;
  final Value<String> category;
  final Value<String?> description;
  final Value<String> merchantName;
  final Value<String?> merchantVpa;
  final Value<String?> merchantCode;
  final Value<String?> transactionReference;
  final Value<String?> transactionNote;
  final Value<String?> qrRawData;
  final Value<String?> upiApp;
  final Value<String> paymentStatus;
  final Value<DateTime> paymentTimestamp;
  final Value<String?> timezone;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<double?> locationAccuracy;
  final Value<String?> locationLabel;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.currency = const Value.absent(),
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.merchantName = const Value.absent(),
    this.merchantVpa = const Value.absent(),
    this.merchantCode = const Value.absent(),
    this.transactionReference = const Value.absent(),
    this.transactionNote = const Value.absent(),
    this.qrRawData = const Value.absent(),
    this.upiApp = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    this.paymentTimestamp = const Value.absent(),
    this.timezone = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.locationAccuracy = const Value.absent(),
    this.locationLabel = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionsCompanion.insert({
    required String id,
    required double amount,
    this.currency = const Value.absent(),
    required String category,
    this.description = const Value.absent(),
    this.merchantName = const Value.absent(),
    this.merchantVpa = const Value.absent(),
    this.merchantCode = const Value.absent(),
    this.transactionReference = const Value.absent(),
    this.transactionNote = const Value.absent(),
    this.qrRawData = const Value.absent(),
    this.upiApp = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    required DateTime paymentTimestamp,
    this.timezone = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.locationAccuracy = const Value.absent(),
    this.locationLabel = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       amount = Value(amount),
       category = Value(category),
       paymentTimestamp = Value(paymentTimestamp);
  static Insertable<Transaction> custom({
    Expression<String>? id,
    Expression<double>? amount,
    Expression<String>? currency,
    Expression<String>? category,
    Expression<String>? description,
    Expression<String>? merchantName,
    Expression<String>? merchantVpa,
    Expression<String>? merchantCode,
    Expression<String>? transactionReference,
    Expression<String>? transactionNote,
    Expression<String>? qrRawData,
    Expression<String>? upiApp,
    Expression<String>? paymentStatus,
    Expression<DateTime>? paymentTimestamp,
    Expression<String>? timezone,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? locationAccuracy,
    Expression<String>? locationLabel,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (currency != null) 'currency': currency,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
      if (merchantName != null) 'merchant_name': merchantName,
      if (merchantVpa != null) 'merchant_vpa': merchantVpa,
      if (merchantCode != null) 'merchant_code': merchantCode,
      if (transactionReference != null)
        'transaction_reference': transactionReference,
      if (transactionNote != null) 'transaction_note': transactionNote,
      if (qrRawData != null) 'qr_raw_data': qrRawData,
      if (upiApp != null) 'upi_app': upiApp,
      if (paymentStatus != null) 'payment_status': paymentStatus,
      if (paymentTimestamp != null) 'payment_timestamp': paymentTimestamp,
      if (timezone != null) 'timezone': timezone,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (locationAccuracy != null) 'location_accuracy': locationAccuracy,
      if (locationLabel != null) 'location_label': locationLabel,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionsCompanion copyWith({
    Value<String>? id,
    Value<double>? amount,
    Value<String>? currency,
    Value<String>? category,
    Value<String?>? description,
    Value<String>? merchantName,
    Value<String?>? merchantVpa,
    Value<String?>? merchantCode,
    Value<String?>? transactionReference,
    Value<String?>? transactionNote,
    Value<String?>? qrRawData,
    Value<String?>? upiApp,
    Value<String>? paymentStatus,
    Value<DateTime>? paymentTimestamp,
    Value<String?>? timezone,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<double?>? locationAccuracy,
    Value<String?>? locationLabel,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      category: category ?? this.category,
      description: description ?? this.description,
      merchantName: merchantName ?? this.merchantName,
      merchantVpa: merchantVpa ?? this.merchantVpa,
      merchantCode: merchantCode ?? this.merchantCode,
      transactionReference: transactionReference ?? this.transactionReference,
      transactionNote: transactionNote ?? this.transactionNote,
      qrRawData: qrRawData ?? this.qrRawData,
      upiApp: upiApp ?? this.upiApp,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentTimestamp: paymentTimestamp ?? this.paymentTimestamp,
      timezone: timezone ?? this.timezone,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      locationAccuracy: locationAccuracy ?? this.locationAccuracy,
      locationLabel: locationLabel ?? this.locationLabel,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (merchantName.present) {
      map['merchant_name'] = Variable<String>(merchantName.value);
    }
    if (merchantVpa.present) {
      map['merchant_vpa'] = Variable<String>(merchantVpa.value);
    }
    if (merchantCode.present) {
      map['merchant_code'] = Variable<String>(merchantCode.value);
    }
    if (transactionReference.present) {
      map['transaction_reference'] = Variable<String>(
        transactionReference.value,
      );
    }
    if (transactionNote.present) {
      map['transaction_note'] = Variable<String>(transactionNote.value);
    }
    if (qrRawData.present) {
      map['qr_raw_data'] = Variable<String>(qrRawData.value);
    }
    if (upiApp.present) {
      map['upi_app'] = Variable<String>(upiApp.value);
    }
    if (paymentStatus.present) {
      map['payment_status'] = Variable<String>(paymentStatus.value);
    }
    if (paymentTimestamp.present) {
      map['payment_timestamp'] = Variable<DateTime>(paymentTimestamp.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (locationAccuracy.present) {
      map['location_accuracy'] = Variable<double>(locationAccuracy.value);
    }
    if (locationLabel.present) {
      map['location_label'] = Variable<String>(locationLabel.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('merchantName: $merchantName, ')
          ..write('merchantVpa: $merchantVpa, ')
          ..write('merchantCode: $merchantCode, ')
          ..write('transactionReference: $transactionReference, ')
          ..write('transactionNote: $transactionNote, ')
          ..write('qrRawData: $qrRawData, ')
          ..write('upiApp: $upiApp, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('paymentTimestamp: $paymentTimestamp, ')
          ..write('timezone: $timezone, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('locationAccuracy: $locationAccuracy, ')
          ..write('locationLabel: $locationLabel, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentAttemptsTable extends PaymentAttempts
    with TableInfo<$PaymentAttemptsTable, PaymentAttempt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentAttemptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transactionIdMeta = const VerificationMeta(
    'transactionId',
  );
  @override
  late final GeneratedColumn<String> transactionId = GeneratedColumn<String>(
    'transaction_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES transactions (id)',
    ),
  );
  static const VerificationMeta _upiAppMeta = const VerificationMeta('upiApp');
  @override
  late final GeneratedColumn<String> upiApp = GeneratedColumn<String>(
    'upi_app',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _launchedAtMeta = const VerificationMeta(
    'launchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> launchedAt = GeneratedColumn<DateTime>(
    'launched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _returnedAtMeta = const VerificationMeta(
    'returnedAt',
  );
  @override
  late final GeneratedColumn<DateTime> returnedAt = GeneratedColumn<DateTime>(
    'returned_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _callbackStatusMeta = const VerificationMeta(
    'callbackStatus',
  );
  @override
  late final GeneratedColumn<String> callbackStatus = GeneratedColumn<String>(
    'callback_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _responseCodeMeta = const VerificationMeta(
    'responseCode',
  );
  @override
  late final GeneratedColumn<String> responseCode = GeneratedColumn<String>(
    'response_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _externalTransactionIdMeta =
      const VerificationMeta('externalTransactionId');
  @override
  late final GeneratedColumn<String> externalTransactionId =
      GeneratedColumn<String>(
        'external_transaction_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _rawResponseMeta = const VerificationMeta(
    'rawResponse',
  );
  @override
  late final GeneratedColumn<String> rawResponse = GeneratedColumn<String>(
    'raw_response',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    transactionId,
    upiApp,
    launchedAt,
    returnedAt,
    callbackStatus,
    responseCode,
    externalTransactionId,
    rawResponse,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payment_attempts';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentAttempt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
        _transactionIdMeta,
        transactionId.isAcceptableOrUnknown(
          data['transaction_id']!,
          _transactionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionIdMeta);
    }
    if (data.containsKey('upi_app')) {
      context.handle(
        _upiAppMeta,
        upiApp.isAcceptableOrUnknown(data['upi_app']!, _upiAppMeta),
      );
    } else if (isInserting) {
      context.missing(_upiAppMeta);
    }
    if (data.containsKey('launched_at')) {
      context.handle(
        _launchedAtMeta,
        launchedAt.isAcceptableOrUnknown(data['launched_at']!, _launchedAtMeta),
      );
    }
    if (data.containsKey('returned_at')) {
      context.handle(
        _returnedAtMeta,
        returnedAt.isAcceptableOrUnknown(data['returned_at']!, _returnedAtMeta),
      );
    }
    if (data.containsKey('callback_status')) {
      context.handle(
        _callbackStatusMeta,
        callbackStatus.isAcceptableOrUnknown(
          data['callback_status']!,
          _callbackStatusMeta,
        ),
      );
    }
    if (data.containsKey('response_code')) {
      context.handle(
        _responseCodeMeta,
        responseCode.isAcceptableOrUnknown(
          data['response_code']!,
          _responseCodeMeta,
        ),
      );
    }
    if (data.containsKey('external_transaction_id')) {
      context.handle(
        _externalTransactionIdMeta,
        externalTransactionId.isAcceptableOrUnknown(
          data['external_transaction_id']!,
          _externalTransactionIdMeta,
        ),
      );
    }
    if (data.containsKey('raw_response')) {
      context.handle(
        _rawResponseMeta,
        rawResponse.isAcceptableOrUnknown(
          data['raw_response']!,
          _rawResponseMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentAttempt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentAttempt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      transactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_id'],
      )!,
      upiApp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}upi_app'],
      )!,
      launchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}launched_at'],
      )!,
      returnedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}returned_at'],
      ),
      callbackStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}callback_status'],
      ),
      responseCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}response_code'],
      ),
      externalTransactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}external_transaction_id'],
      ),
      rawResponse: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_response'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PaymentAttemptsTable createAlias(String alias) {
    return $PaymentAttemptsTable(attachedDatabase, alias);
  }
}

class PaymentAttempt extends DataClass implements Insertable<PaymentAttempt> {
  final String id;
  final String transactionId;
  final String upiApp;
  final DateTime launchedAt;
  final DateTime? returnedAt;
  final String? callbackStatus;
  final String? responseCode;
  final String? externalTransactionId;
  final String? rawResponse;
  final DateTime createdAt;
  const PaymentAttempt({
    required this.id,
    required this.transactionId,
    required this.upiApp,
    required this.launchedAt,
    this.returnedAt,
    this.callbackStatus,
    this.responseCode,
    this.externalTransactionId,
    this.rawResponse,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['transaction_id'] = Variable<String>(transactionId);
    map['upi_app'] = Variable<String>(upiApp);
    map['launched_at'] = Variable<DateTime>(launchedAt);
    if (!nullToAbsent || returnedAt != null) {
      map['returned_at'] = Variable<DateTime>(returnedAt);
    }
    if (!nullToAbsent || callbackStatus != null) {
      map['callback_status'] = Variable<String>(callbackStatus);
    }
    if (!nullToAbsent || responseCode != null) {
      map['response_code'] = Variable<String>(responseCode);
    }
    if (!nullToAbsent || externalTransactionId != null) {
      map['external_transaction_id'] = Variable<String>(externalTransactionId);
    }
    if (!nullToAbsent || rawResponse != null) {
      map['raw_response'] = Variable<String>(rawResponse);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PaymentAttemptsCompanion toCompanion(bool nullToAbsent) {
    return PaymentAttemptsCompanion(
      id: Value(id),
      transactionId: Value(transactionId),
      upiApp: Value(upiApp),
      launchedAt: Value(launchedAt),
      returnedAt: returnedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(returnedAt),
      callbackStatus: callbackStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(callbackStatus),
      responseCode: responseCode == null && nullToAbsent
          ? const Value.absent()
          : Value(responseCode),
      externalTransactionId: externalTransactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(externalTransactionId),
      rawResponse: rawResponse == null && nullToAbsent
          ? const Value.absent()
          : Value(rawResponse),
      createdAt: Value(createdAt),
    );
  }

  factory PaymentAttempt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentAttempt(
      id: serializer.fromJson<String>(json['id']),
      transactionId: serializer.fromJson<String>(json['transactionId']),
      upiApp: serializer.fromJson<String>(json['upiApp']),
      launchedAt: serializer.fromJson<DateTime>(json['launchedAt']),
      returnedAt: serializer.fromJson<DateTime?>(json['returnedAt']),
      callbackStatus: serializer.fromJson<String?>(json['callbackStatus']),
      responseCode: serializer.fromJson<String?>(json['responseCode']),
      externalTransactionId: serializer.fromJson<String?>(
        json['externalTransactionId'],
      ),
      rawResponse: serializer.fromJson<String?>(json['rawResponse']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'transactionId': serializer.toJson<String>(transactionId),
      'upiApp': serializer.toJson<String>(upiApp),
      'launchedAt': serializer.toJson<DateTime>(launchedAt),
      'returnedAt': serializer.toJson<DateTime?>(returnedAt),
      'callbackStatus': serializer.toJson<String?>(callbackStatus),
      'responseCode': serializer.toJson<String?>(responseCode),
      'externalTransactionId': serializer.toJson<String?>(
        externalTransactionId,
      ),
      'rawResponse': serializer.toJson<String?>(rawResponse),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PaymentAttempt copyWith({
    String? id,
    String? transactionId,
    String? upiApp,
    DateTime? launchedAt,
    Value<DateTime?> returnedAt = const Value.absent(),
    Value<String?> callbackStatus = const Value.absent(),
    Value<String?> responseCode = const Value.absent(),
    Value<String?> externalTransactionId = const Value.absent(),
    Value<String?> rawResponse = const Value.absent(),
    DateTime? createdAt,
  }) => PaymentAttempt(
    id: id ?? this.id,
    transactionId: transactionId ?? this.transactionId,
    upiApp: upiApp ?? this.upiApp,
    launchedAt: launchedAt ?? this.launchedAt,
    returnedAt: returnedAt.present ? returnedAt.value : this.returnedAt,
    callbackStatus: callbackStatus.present
        ? callbackStatus.value
        : this.callbackStatus,
    responseCode: responseCode.present ? responseCode.value : this.responseCode,
    externalTransactionId: externalTransactionId.present
        ? externalTransactionId.value
        : this.externalTransactionId,
    rawResponse: rawResponse.present ? rawResponse.value : this.rawResponse,
    createdAt: createdAt ?? this.createdAt,
  );
  PaymentAttempt copyWithCompanion(PaymentAttemptsCompanion data) {
    return PaymentAttempt(
      id: data.id.present ? data.id.value : this.id,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      upiApp: data.upiApp.present ? data.upiApp.value : this.upiApp,
      launchedAt: data.launchedAt.present
          ? data.launchedAt.value
          : this.launchedAt,
      returnedAt: data.returnedAt.present
          ? data.returnedAt.value
          : this.returnedAt,
      callbackStatus: data.callbackStatus.present
          ? data.callbackStatus.value
          : this.callbackStatus,
      responseCode: data.responseCode.present
          ? data.responseCode.value
          : this.responseCode,
      externalTransactionId: data.externalTransactionId.present
          ? data.externalTransactionId.value
          : this.externalTransactionId,
      rawResponse: data.rawResponse.present
          ? data.rawResponse.value
          : this.rawResponse,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentAttempt(')
          ..write('id: $id, ')
          ..write('transactionId: $transactionId, ')
          ..write('upiApp: $upiApp, ')
          ..write('launchedAt: $launchedAt, ')
          ..write('returnedAt: $returnedAt, ')
          ..write('callbackStatus: $callbackStatus, ')
          ..write('responseCode: $responseCode, ')
          ..write('externalTransactionId: $externalTransactionId, ')
          ..write('rawResponse: $rawResponse, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    transactionId,
    upiApp,
    launchedAt,
    returnedAt,
    callbackStatus,
    responseCode,
    externalTransactionId,
    rawResponse,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentAttempt &&
          other.id == this.id &&
          other.transactionId == this.transactionId &&
          other.upiApp == this.upiApp &&
          other.launchedAt == this.launchedAt &&
          other.returnedAt == this.returnedAt &&
          other.callbackStatus == this.callbackStatus &&
          other.responseCode == this.responseCode &&
          other.externalTransactionId == this.externalTransactionId &&
          other.rawResponse == this.rawResponse &&
          other.createdAt == this.createdAt);
}

class PaymentAttemptsCompanion extends UpdateCompanion<PaymentAttempt> {
  final Value<String> id;
  final Value<String> transactionId;
  final Value<String> upiApp;
  final Value<DateTime> launchedAt;
  final Value<DateTime?> returnedAt;
  final Value<String?> callbackStatus;
  final Value<String?> responseCode;
  final Value<String?> externalTransactionId;
  final Value<String?> rawResponse;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PaymentAttemptsCompanion({
    this.id = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.upiApp = const Value.absent(),
    this.launchedAt = const Value.absent(),
    this.returnedAt = const Value.absent(),
    this.callbackStatus = const Value.absent(),
    this.responseCode = const Value.absent(),
    this.externalTransactionId = const Value.absent(),
    this.rawResponse = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentAttemptsCompanion.insert({
    required String id,
    required String transactionId,
    required String upiApp,
    this.launchedAt = const Value.absent(),
    this.returnedAt = const Value.absent(),
    this.callbackStatus = const Value.absent(),
    this.responseCode = const Value.absent(),
    this.externalTransactionId = const Value.absent(),
    this.rawResponse = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       transactionId = Value(transactionId),
       upiApp = Value(upiApp);
  static Insertable<PaymentAttempt> custom({
    Expression<String>? id,
    Expression<String>? transactionId,
    Expression<String>? upiApp,
    Expression<DateTime>? launchedAt,
    Expression<DateTime>? returnedAt,
    Expression<String>? callbackStatus,
    Expression<String>? responseCode,
    Expression<String>? externalTransactionId,
    Expression<String>? rawResponse,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (transactionId != null) 'transaction_id': transactionId,
      if (upiApp != null) 'upi_app': upiApp,
      if (launchedAt != null) 'launched_at': launchedAt,
      if (returnedAt != null) 'returned_at': returnedAt,
      if (callbackStatus != null) 'callback_status': callbackStatus,
      if (responseCode != null) 'response_code': responseCode,
      if (externalTransactionId != null)
        'external_transaction_id': externalTransactionId,
      if (rawResponse != null) 'raw_response': rawResponse,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentAttemptsCompanion copyWith({
    Value<String>? id,
    Value<String>? transactionId,
    Value<String>? upiApp,
    Value<DateTime>? launchedAt,
    Value<DateTime?>? returnedAt,
    Value<String?>? callbackStatus,
    Value<String?>? responseCode,
    Value<String?>? externalTransactionId,
    Value<String?>? rawResponse,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PaymentAttemptsCompanion(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      upiApp: upiApp ?? this.upiApp,
      launchedAt: launchedAt ?? this.launchedAt,
      returnedAt: returnedAt ?? this.returnedAt,
      callbackStatus: callbackStatus ?? this.callbackStatus,
      responseCode: responseCode ?? this.responseCode,
      externalTransactionId:
          externalTransactionId ?? this.externalTransactionId,
      rawResponse: rawResponse ?? this.rawResponse,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<String>(transactionId.value);
    }
    if (upiApp.present) {
      map['upi_app'] = Variable<String>(upiApp.value);
    }
    if (launchedAt.present) {
      map['launched_at'] = Variable<DateTime>(launchedAt.value);
    }
    if (returnedAt.present) {
      map['returned_at'] = Variable<DateTime>(returnedAt.value);
    }
    if (callbackStatus.present) {
      map['callback_status'] = Variable<String>(callbackStatus.value);
    }
    if (responseCode.present) {
      map['response_code'] = Variable<String>(responseCode.value);
    }
    if (externalTransactionId.present) {
      map['external_transaction_id'] = Variable<String>(
        externalTransactionId.value,
      );
    }
    if (rawResponse.present) {
      map['raw_response'] = Variable<String>(rawResponse.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentAttemptsCompanion(')
          ..write('id: $id, ')
          ..write('transactionId: $transactionId, ')
          ..write('upiApp: $upiApp, ')
          ..write('launchedAt: $launchedAt, ')
          ..write('returnedAt: $returnedAt, ')
          ..write('callbackStatus: $callbackStatus, ')
          ..write('responseCode: $responseCode, ')
          ..write('externalTransactionId: $externalTransactionId, ')
          ..write('rawResponse: $rawResponse, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SavingsTable extends Savings with TableInfo<$SavingsTable, Saving> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
    'goal_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _savingDateMeta = const VerificationMeta(
    'savingDate',
  );
  @override
  late final GeneratedColumn<DateTime> savingDate = GeneratedColumn<DateTime>(
    'saving_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    amount,
    goalId,
    description,
    savingDate,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'savings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Saving> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('saving_date')) {
      context.handle(
        _savingDateMeta,
        savingDate.isAcceptableOrUnknown(data['saving_date']!, _savingDateMeta),
      );
    } else if (isInserting) {
      context.missing(_savingDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Saving map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Saving(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_id'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      savingDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}saving_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SavingsTable createAlias(String alias) {
    return $SavingsTable(attachedDatabase, alias);
  }
}

class Saving extends DataClass implements Insertable<Saving> {
  final String id;
  final double amount;
  final String? goalId;
  final String? description;
  final DateTime savingDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Saving({
    required this.id,
    required this.amount,
    this.goalId,
    this.description,
    required this.savingDate,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || goalId != null) {
      map['goal_id'] = Variable<String>(goalId);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['saving_date'] = Variable<DateTime>(savingDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SavingsCompanion toCompanion(bool nullToAbsent) {
    return SavingsCompanion(
      id: Value(id),
      amount: Value(amount),
      goalId: goalId == null && nullToAbsent
          ? const Value.absent()
          : Value(goalId),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      savingDate: Value(savingDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Saving.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Saving(
      id: serializer.fromJson<String>(json['id']),
      amount: serializer.fromJson<double>(json['amount']),
      goalId: serializer.fromJson<String?>(json['goalId']),
      description: serializer.fromJson<String?>(json['description']),
      savingDate: serializer.fromJson<DateTime>(json['savingDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'amount': serializer.toJson<double>(amount),
      'goalId': serializer.toJson<String?>(goalId),
      'description': serializer.toJson<String?>(description),
      'savingDate': serializer.toJson<DateTime>(savingDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Saving copyWith({
    String? id,
    double? amount,
    Value<String?> goalId = const Value.absent(),
    Value<String?> description = const Value.absent(),
    DateTime? savingDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Saving(
    id: id ?? this.id,
    amount: amount ?? this.amount,
    goalId: goalId.present ? goalId.value : this.goalId,
    description: description.present ? description.value : this.description,
    savingDate: savingDate ?? this.savingDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Saving copyWithCompanion(SavingsCompanion data) {
    return Saving(
      id: data.id.present ? data.id.value : this.id,
      amount: data.amount.present ? data.amount.value : this.amount,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      description: data.description.present
          ? data.description.value
          : this.description,
      savingDate: data.savingDate.present
          ? data.savingDate.value
          : this.savingDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Saving(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('goalId: $goalId, ')
          ..write('description: $description, ')
          ..write('savingDate: $savingDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    amount,
    goalId,
    description,
    savingDate,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Saving &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.goalId == this.goalId &&
          other.description == this.description &&
          other.savingDate == this.savingDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SavingsCompanion extends UpdateCompanion<Saving> {
  final Value<String> id;
  final Value<double> amount;
  final Value<String?> goalId;
  final Value<String?> description;
  final Value<DateTime> savingDate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SavingsCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.goalId = const Value.absent(),
    this.description = const Value.absent(),
    this.savingDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SavingsCompanion.insert({
    required String id,
    required double amount,
    this.goalId = const Value.absent(),
    this.description = const Value.absent(),
    required DateTime savingDate,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       amount = Value(amount),
       savingDate = Value(savingDate);
  static Insertable<Saving> custom({
    Expression<String>? id,
    Expression<double>? amount,
    Expression<String>? goalId,
    Expression<String>? description,
    Expression<DateTime>? savingDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (goalId != null) 'goal_id': goalId,
      if (description != null) 'description': description,
      if (savingDate != null) 'saving_date': savingDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SavingsCompanion copyWith({
    Value<String>? id,
    Value<double>? amount,
    Value<String?>? goalId,
    Value<String?>? description,
    Value<DateTime>? savingDate,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SavingsCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      goalId: goalId ?? this.goalId,
      description: description ?? this.description,
      savingDate: savingDate ?? this.savingDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (savingDate.present) {
      map['saving_date'] = Variable<DateTime>(savingDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavingsCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('goalId: $goalId, ')
          ..write('description: $description, ')
          ..write('savingDate: $savingDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SavingsGoalsTable extends SavingsGoals
    with TableInfo<$SavingsGoalsTable, SavingsGoal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavingsGoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetAmountMeta = const VerificationMeta(
    'targetAmount',
  );
  @override
  late final GeneratedColumn<double> targetAmount = GeneratedColumn<double>(
    'target_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentAmountMeta = const VerificationMeta(
    'currentAmount',
  );
  @override
  late final GeneratedColumn<double> currentAmount = GeneratedColumn<double>(
    'current_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _targetDateMeta = const VerificationMeta(
    'targetDate',
  );
  @override
  late final GeneratedColumn<DateTime> targetDate = GeneratedColumn<DateTime>(
    'target_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    targetAmount,
    currentAmount,
    targetDate,
    status,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'savings_goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<SavingsGoal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('target_amount')) {
      context.handle(
        _targetAmountMeta,
        targetAmount.isAcceptableOrUnknown(
          data['target_amount']!,
          _targetAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetAmountMeta);
    }
    if (data.containsKey('current_amount')) {
      context.handle(
        _currentAmountMeta,
        currentAmount.isAcceptableOrUnknown(
          data['current_amount']!,
          _currentAmountMeta,
        ),
      );
    }
    if (data.containsKey('target_date')) {
      context.handle(
        _targetDateMeta,
        targetDate.isAcceptableOrUnknown(data['target_date']!, _targetDateMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavingsGoal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavingsGoal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      targetAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_amount'],
      )!,
      currentAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_amount'],
      )!,
      targetDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}target_date'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SavingsGoalsTable createAlias(String alias) {
    return $SavingsGoalsTable(attachedDatabase, alias);
  }
}

class SavingsGoal extends DataClass implements Insertable<SavingsGoal> {
  final String id;
  final String name;
  final double targetAmount;
  final double currentAmount;
  final DateTime? targetDate;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SavingsGoal({
    required this.id,
    required this.name,
    required this.targetAmount,
    required this.currentAmount,
    this.targetDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['target_amount'] = Variable<double>(targetAmount);
    map['current_amount'] = Variable<double>(currentAmount);
    if (!nullToAbsent || targetDate != null) {
      map['target_date'] = Variable<DateTime>(targetDate);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SavingsGoalsCompanion toCompanion(bool nullToAbsent) {
    return SavingsGoalsCompanion(
      id: Value(id),
      name: Value(name),
      targetAmount: Value(targetAmount),
      currentAmount: Value(currentAmount),
      targetDate: targetDate == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDate),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SavingsGoal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavingsGoal(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      targetAmount: serializer.fromJson<double>(json['targetAmount']),
      currentAmount: serializer.fromJson<double>(json['currentAmount']),
      targetDate: serializer.fromJson<DateTime?>(json['targetDate']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'targetAmount': serializer.toJson<double>(targetAmount),
      'currentAmount': serializer.toJson<double>(currentAmount),
      'targetDate': serializer.toJson<DateTime?>(targetDate),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SavingsGoal copyWith({
    String? id,
    String? name,
    double? targetAmount,
    double? currentAmount,
    Value<DateTime?> targetDate = const Value.absent(),
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SavingsGoal(
    id: id ?? this.id,
    name: name ?? this.name,
    targetAmount: targetAmount ?? this.targetAmount,
    currentAmount: currentAmount ?? this.currentAmount,
    targetDate: targetDate.present ? targetDate.value : this.targetDate,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SavingsGoal copyWithCompanion(SavingsGoalsCompanion data) {
    return SavingsGoal(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      targetAmount: data.targetAmount.present
          ? data.targetAmount.value
          : this.targetAmount,
      currentAmount: data.currentAmount.present
          ? data.currentAmount.value
          : this.currentAmount,
      targetDate: data.targetDate.present
          ? data.targetDate.value
          : this.targetDate,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavingsGoal(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('targetAmount: $targetAmount, ')
          ..write('currentAmount: $currentAmount, ')
          ..write('targetDate: $targetDate, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    targetAmount,
    currentAmount,
    targetDate,
    status,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavingsGoal &&
          other.id == this.id &&
          other.name == this.name &&
          other.targetAmount == this.targetAmount &&
          other.currentAmount == this.currentAmount &&
          other.targetDate == this.targetDate &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SavingsGoalsCompanion extends UpdateCompanion<SavingsGoal> {
  final Value<String> id;
  final Value<String> name;
  final Value<double> targetAmount;
  final Value<double> currentAmount;
  final Value<DateTime?> targetDate;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SavingsGoalsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.targetAmount = const Value.absent(),
    this.currentAmount = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SavingsGoalsCompanion.insert({
    required String id,
    required String name,
    required double targetAmount,
    this.currentAmount = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       targetAmount = Value(targetAmount);
  static Insertable<SavingsGoal> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<double>? targetAmount,
    Expression<double>? currentAmount,
    Expression<DateTime>? targetDate,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (targetAmount != null) 'target_amount': targetAmount,
      if (currentAmount != null) 'current_amount': currentAmount,
      if (targetDate != null) 'target_date': targetDate,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SavingsGoalsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<double>? targetAmount,
    Value<double>? currentAmount,
    Value<DateTime?>? targetDate,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SavingsGoalsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      targetAmount: targetAmount ?? this.targetAmount,
      currentAmount: currentAmount ?? this.currentAmount,
      targetDate: targetDate ?? this.targetDate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (targetAmount.present) {
      map['target_amount'] = Variable<double>(targetAmount.value);
    }
    if (currentAmount.present) {
      map['current_amount'] = Variable<double>(currentAmount.value);
    }
    if (targetDate.present) {
      map['target_date'] = Variable<DateTime>(targetDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavingsGoalsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('targetAmount: $targetAmount, ')
          ..write('currentAmount: $currentAmount, ')
          ..write('targetDate: $targetDate, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MonthlyReportsTable extends MonthlyReports
    with TableInfo<$MonthlyReportsTable, MonthlyReport> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MonthlyReportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reportMonthMeta = const VerificationMeta(
    'reportMonth',
  );
  @override
  late final GeneratedColumn<int> reportMonth = GeneratedColumn<int>(
    'report_month',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reportYearMeta = const VerificationMeta(
    'reportYear',
  );
  @override
  late final GeneratedColumn<int> reportYear = GeneratedColumn<int>(
    'report_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalSpendingMeta = const VerificationMeta(
    'totalSpending',
  );
  @override
  late final GeneratedColumn<double> totalSpending = GeneratedColumn<double>(
    'total_spending',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalSavingsMeta = const VerificationMeta(
    'totalSavings',
  );
  @override
  late final GeneratedColumn<double> totalSavings = GeneratedColumn<double>(
    'total_savings',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _transactionCountMeta = const VerificationMeta(
    'transactionCount',
  );
  @override
  late final GeneratedColumn<int> transactionCount = GeneratedColumn<int>(
    'transaction_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _reportDataMeta = const VerificationMeta(
    'reportData',
  );
  @override
  late final GeneratedColumn<String> reportData = GeneratedColumn<String>(
    'report_data',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _generatedAtMeta = const VerificationMeta(
    'generatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> generatedAt = GeneratedColumn<DateTime>(
    'generated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    reportMonth,
    reportYear,
    totalSpending,
    totalSavings,
    transactionCount,
    reportData,
    generatedAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'monthly_reports';
  @override
  VerificationContext validateIntegrity(
    Insertable<MonthlyReport> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('report_month')) {
      context.handle(
        _reportMonthMeta,
        reportMonth.isAcceptableOrUnknown(
          data['report_month']!,
          _reportMonthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reportMonthMeta);
    }
    if (data.containsKey('report_year')) {
      context.handle(
        _reportYearMeta,
        reportYear.isAcceptableOrUnknown(data['report_year']!, _reportYearMeta),
      );
    } else if (isInserting) {
      context.missing(_reportYearMeta);
    }
    if (data.containsKey('total_spending')) {
      context.handle(
        _totalSpendingMeta,
        totalSpending.isAcceptableOrUnknown(
          data['total_spending']!,
          _totalSpendingMeta,
        ),
      );
    }
    if (data.containsKey('total_savings')) {
      context.handle(
        _totalSavingsMeta,
        totalSavings.isAcceptableOrUnknown(
          data['total_savings']!,
          _totalSavingsMeta,
        ),
      );
    }
    if (data.containsKey('transaction_count')) {
      context.handle(
        _transactionCountMeta,
        transactionCount.isAcceptableOrUnknown(
          data['transaction_count']!,
          _transactionCountMeta,
        ),
      );
    }
    if (data.containsKey('report_data')) {
      context.handle(
        _reportDataMeta,
        reportData.isAcceptableOrUnknown(data['report_data']!, _reportDataMeta),
      );
    }
    if (data.containsKey('generated_at')) {
      context.handle(
        _generatedAtMeta,
        generatedAt.isAcceptableOrUnknown(
          data['generated_at']!,
          _generatedAtMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MonthlyReport map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MonthlyReport(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      reportMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}report_month'],
      )!,
      reportYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}report_year'],
      )!,
      totalSpending: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_spending'],
      )!,
      totalSavings: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_savings'],
      )!,
      transactionCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}transaction_count'],
      )!,
      reportData: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}report_data'],
      )!,
      generatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}generated_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MonthlyReportsTable createAlias(String alias) {
    return $MonthlyReportsTable(attachedDatabase, alias);
  }
}

class MonthlyReport extends DataClass implements Insertable<MonthlyReport> {
  final String id;
  final int reportMonth;
  final int reportYear;
  final double totalSpending;
  final double totalSavings;
  final int transactionCount;
  final String reportData;
  final DateTime generatedAt;
  final DateTime updatedAt;
  const MonthlyReport({
    required this.id,
    required this.reportMonth,
    required this.reportYear,
    required this.totalSpending,
    required this.totalSavings,
    required this.transactionCount,
    required this.reportData,
    required this.generatedAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['report_month'] = Variable<int>(reportMonth);
    map['report_year'] = Variable<int>(reportYear);
    map['total_spending'] = Variable<double>(totalSpending);
    map['total_savings'] = Variable<double>(totalSavings);
    map['transaction_count'] = Variable<int>(transactionCount);
    map['report_data'] = Variable<String>(reportData);
    map['generated_at'] = Variable<DateTime>(generatedAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MonthlyReportsCompanion toCompanion(bool nullToAbsent) {
    return MonthlyReportsCompanion(
      id: Value(id),
      reportMonth: Value(reportMonth),
      reportYear: Value(reportYear),
      totalSpending: Value(totalSpending),
      totalSavings: Value(totalSavings),
      transactionCount: Value(transactionCount),
      reportData: Value(reportData),
      generatedAt: Value(generatedAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MonthlyReport.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MonthlyReport(
      id: serializer.fromJson<String>(json['id']),
      reportMonth: serializer.fromJson<int>(json['reportMonth']),
      reportYear: serializer.fromJson<int>(json['reportYear']),
      totalSpending: serializer.fromJson<double>(json['totalSpending']),
      totalSavings: serializer.fromJson<double>(json['totalSavings']),
      transactionCount: serializer.fromJson<int>(json['transactionCount']),
      reportData: serializer.fromJson<String>(json['reportData']),
      generatedAt: serializer.fromJson<DateTime>(json['generatedAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'reportMonth': serializer.toJson<int>(reportMonth),
      'reportYear': serializer.toJson<int>(reportYear),
      'totalSpending': serializer.toJson<double>(totalSpending),
      'totalSavings': serializer.toJson<double>(totalSavings),
      'transactionCount': serializer.toJson<int>(transactionCount),
      'reportData': serializer.toJson<String>(reportData),
      'generatedAt': serializer.toJson<DateTime>(generatedAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MonthlyReport copyWith({
    String? id,
    int? reportMonth,
    int? reportYear,
    double? totalSpending,
    double? totalSavings,
    int? transactionCount,
    String? reportData,
    DateTime? generatedAt,
    DateTime? updatedAt,
  }) => MonthlyReport(
    id: id ?? this.id,
    reportMonth: reportMonth ?? this.reportMonth,
    reportYear: reportYear ?? this.reportYear,
    totalSpending: totalSpending ?? this.totalSpending,
    totalSavings: totalSavings ?? this.totalSavings,
    transactionCount: transactionCount ?? this.transactionCount,
    reportData: reportData ?? this.reportData,
    generatedAt: generatedAt ?? this.generatedAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MonthlyReport copyWithCompanion(MonthlyReportsCompanion data) {
    return MonthlyReport(
      id: data.id.present ? data.id.value : this.id,
      reportMonth: data.reportMonth.present
          ? data.reportMonth.value
          : this.reportMonth,
      reportYear: data.reportYear.present
          ? data.reportYear.value
          : this.reportYear,
      totalSpending: data.totalSpending.present
          ? data.totalSpending.value
          : this.totalSpending,
      totalSavings: data.totalSavings.present
          ? data.totalSavings.value
          : this.totalSavings,
      transactionCount: data.transactionCount.present
          ? data.transactionCount.value
          : this.transactionCount,
      reportData: data.reportData.present
          ? data.reportData.value
          : this.reportData,
      generatedAt: data.generatedAt.present
          ? data.generatedAt.value
          : this.generatedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyReport(')
          ..write('id: $id, ')
          ..write('reportMonth: $reportMonth, ')
          ..write('reportYear: $reportYear, ')
          ..write('totalSpending: $totalSpending, ')
          ..write('totalSavings: $totalSavings, ')
          ..write('transactionCount: $transactionCount, ')
          ..write('reportData: $reportData, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    reportMonth,
    reportYear,
    totalSpending,
    totalSavings,
    transactionCount,
    reportData,
    generatedAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MonthlyReport &&
          other.id == this.id &&
          other.reportMonth == this.reportMonth &&
          other.reportYear == this.reportYear &&
          other.totalSpending == this.totalSpending &&
          other.totalSavings == this.totalSavings &&
          other.transactionCount == this.transactionCount &&
          other.reportData == this.reportData &&
          other.generatedAt == this.generatedAt &&
          other.updatedAt == this.updatedAt);
}

class MonthlyReportsCompanion extends UpdateCompanion<MonthlyReport> {
  final Value<String> id;
  final Value<int> reportMonth;
  final Value<int> reportYear;
  final Value<double> totalSpending;
  final Value<double> totalSavings;
  final Value<int> transactionCount;
  final Value<String> reportData;
  final Value<DateTime> generatedAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MonthlyReportsCompanion({
    this.id = const Value.absent(),
    this.reportMonth = const Value.absent(),
    this.reportYear = const Value.absent(),
    this.totalSpending = const Value.absent(),
    this.totalSavings = const Value.absent(),
    this.transactionCount = const Value.absent(),
    this.reportData = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MonthlyReportsCompanion.insert({
    required String id,
    required int reportMonth,
    required int reportYear,
    this.totalSpending = const Value.absent(),
    this.totalSavings = const Value.absent(),
    this.transactionCount = const Value.absent(),
    this.reportData = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       reportMonth = Value(reportMonth),
       reportYear = Value(reportYear);
  static Insertable<MonthlyReport> custom({
    Expression<String>? id,
    Expression<int>? reportMonth,
    Expression<int>? reportYear,
    Expression<double>? totalSpending,
    Expression<double>? totalSavings,
    Expression<int>? transactionCount,
    Expression<String>? reportData,
    Expression<DateTime>? generatedAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reportMonth != null) 'report_month': reportMonth,
      if (reportYear != null) 'report_year': reportYear,
      if (totalSpending != null) 'total_spending': totalSpending,
      if (totalSavings != null) 'total_savings': totalSavings,
      if (transactionCount != null) 'transaction_count': transactionCount,
      if (reportData != null) 'report_data': reportData,
      if (generatedAt != null) 'generated_at': generatedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MonthlyReportsCompanion copyWith({
    Value<String>? id,
    Value<int>? reportMonth,
    Value<int>? reportYear,
    Value<double>? totalSpending,
    Value<double>? totalSavings,
    Value<int>? transactionCount,
    Value<String>? reportData,
    Value<DateTime>? generatedAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MonthlyReportsCompanion(
      id: id ?? this.id,
      reportMonth: reportMonth ?? this.reportMonth,
      reportYear: reportYear ?? this.reportYear,
      totalSpending: totalSpending ?? this.totalSpending,
      totalSavings: totalSavings ?? this.totalSavings,
      transactionCount: transactionCount ?? this.transactionCount,
      reportData: reportData ?? this.reportData,
      generatedAt: generatedAt ?? this.generatedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (reportMonth.present) {
      map['report_month'] = Variable<int>(reportMonth.value);
    }
    if (reportYear.present) {
      map['report_year'] = Variable<int>(reportYear.value);
    }
    if (totalSpending.present) {
      map['total_spending'] = Variable<double>(totalSpending.value);
    }
    if (totalSavings.present) {
      map['total_savings'] = Variable<double>(totalSavings.value);
    }
    if (transactionCount.present) {
      map['transaction_count'] = Variable<int>(transactionCount.value);
    }
    if (reportData.present) {
      map['report_data'] = Variable<String>(reportData.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<DateTime>(generatedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyReportsCompanion(')
          ..write('id: $id, ')
          ..write('reportMonth: $reportMonth, ')
          ..write('reportYear: $reportYear, ')
          ..write('totalSpending: $totalSpending, ')
          ..write('totalSavings: $totalSavings, ')
          ..write('transactionCount: $transactionCount, ')
          ..write('reportData: $reportData, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _preferredUpiAppMeta = const VerificationMeta(
    'preferredUpiApp',
  );
  @override
  late final GeneratedColumn<String> preferredUpiApp = GeneratedColumn<String>(
    'preferred_upi_app',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _monthlySavingsTargetMeta =
      const VerificationMeta('monthlySavingsTarget');
  @override
  late final GeneratedColumn<double> monthlySavingsTarget =
      GeneratedColumn<double>(
        'monthly_savings_target',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(5000),
      );
  static const VerificationMeta _notificationsEnabledMeta =
      const VerificationMeta('notificationsEnabled');
  @override
  late final GeneratedColumn<bool> notificationsEnabled = GeneratedColumn<bool>(
    'notifications_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notifications_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _locationEnabledMeta = const VerificationMeta(
    'locationEnabled',
  );
  @override
  late final GeneratedColumn<bool> locationEnabled = GeneratedColumn<bool>(
    'location_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("location_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('INR'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    preferredUpiApp,
    monthlySavingsTarget,
    notificationsEnabled,
    locationEnabled,
    currency,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('preferred_upi_app')) {
      context.handle(
        _preferredUpiAppMeta,
        preferredUpiApp.isAcceptableOrUnknown(
          data['preferred_upi_app']!,
          _preferredUpiAppMeta,
        ),
      );
    }
    if (data.containsKey('monthly_savings_target')) {
      context.handle(
        _monthlySavingsTargetMeta,
        monthlySavingsTarget.isAcceptableOrUnknown(
          data['monthly_savings_target']!,
          _monthlySavingsTargetMeta,
        ),
      );
    }
    if (data.containsKey('notifications_enabled')) {
      context.handle(
        _notificationsEnabledMeta,
        notificationsEnabled.isAcceptableOrUnknown(
          data['notifications_enabled']!,
          _notificationsEnabledMeta,
        ),
      );
    }
    if (data.containsKey('location_enabled')) {
      context.handle(
        _locationEnabledMeta,
        locationEnabled.isAcceptableOrUnknown(
          data['location_enabled']!,
          _locationEnabledMeta,
        ),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      preferredUpiApp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preferred_upi_app'],
      ),
      monthlySavingsTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}monthly_savings_target'],
      )!,
      notificationsEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notifications_enabled'],
      )!,
      locationEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}location_enabled'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final int id;
  final String? preferredUpiApp;
  final double monthlySavingsTarget;
  final bool notificationsEnabled;
  final bool locationEnabled;
  final String currency;
  final DateTime createdAt;
  final DateTime updatedAt;
  const AppSetting({
    required this.id,
    this.preferredUpiApp,
    required this.monthlySavingsTarget,
    required this.notificationsEnabled,
    required this.locationEnabled,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || preferredUpiApp != null) {
      map['preferred_upi_app'] = Variable<String>(preferredUpiApp);
    }
    map['monthly_savings_target'] = Variable<double>(monthlySavingsTarget);
    map['notifications_enabled'] = Variable<bool>(notificationsEnabled);
    map['location_enabled'] = Variable<bool>(locationEnabled);
    map['currency'] = Variable<String>(currency);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      preferredUpiApp: preferredUpiApp == null && nullToAbsent
          ? const Value.absent()
          : Value(preferredUpiApp),
      monthlySavingsTarget: Value(monthlySavingsTarget),
      notificationsEnabled: Value(notificationsEnabled),
      locationEnabled: Value(locationEnabled),
      currency: Value(currency),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      preferredUpiApp: serializer.fromJson<String?>(json['preferredUpiApp']),
      monthlySavingsTarget: serializer.fromJson<double>(
        json['monthlySavingsTarget'],
      ),
      notificationsEnabled: serializer.fromJson<bool>(
        json['notificationsEnabled'],
      ),
      locationEnabled: serializer.fromJson<bool>(json['locationEnabled']),
      currency: serializer.fromJson<String>(json['currency']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'preferredUpiApp': serializer.toJson<String?>(preferredUpiApp),
      'monthlySavingsTarget': serializer.toJson<double>(monthlySavingsTarget),
      'notificationsEnabled': serializer.toJson<bool>(notificationsEnabled),
      'locationEnabled': serializer.toJson<bool>(locationEnabled),
      'currency': serializer.toJson<String>(currency),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppSetting copyWith({
    int? id,
    Value<String?> preferredUpiApp = const Value.absent(),
    double? monthlySavingsTarget,
    bool? notificationsEnabled,
    bool? locationEnabled,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => AppSetting(
    id: id ?? this.id,
    preferredUpiApp: preferredUpiApp.present
        ? preferredUpiApp.value
        : this.preferredUpiApp,
    monthlySavingsTarget: monthlySavingsTarget ?? this.monthlySavingsTarget,
    notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    locationEnabled: locationEnabled ?? this.locationEnabled,
    currency: currency ?? this.currency,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      preferredUpiApp: data.preferredUpiApp.present
          ? data.preferredUpiApp.value
          : this.preferredUpiApp,
      monthlySavingsTarget: data.monthlySavingsTarget.present
          ? data.monthlySavingsTarget.value
          : this.monthlySavingsTarget,
      notificationsEnabled: data.notificationsEnabled.present
          ? data.notificationsEnabled.value
          : this.notificationsEnabled,
      locationEnabled: data.locationEnabled.present
          ? data.locationEnabled.value
          : this.locationEnabled,
      currency: data.currency.present ? data.currency.value : this.currency,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('preferredUpiApp: $preferredUpiApp, ')
          ..write('monthlySavingsTarget: $monthlySavingsTarget, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('locationEnabled: $locationEnabled, ')
          ..write('currency: $currency, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    preferredUpiApp,
    monthlySavingsTarget,
    notificationsEnabled,
    locationEnabled,
    currency,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.preferredUpiApp == this.preferredUpiApp &&
          other.monthlySavingsTarget == this.monthlySavingsTarget &&
          other.notificationsEnabled == this.notificationsEnabled &&
          other.locationEnabled == this.locationEnabled &&
          other.currency == this.currency &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<String?> preferredUpiApp;
  final Value<double> monthlySavingsTarget;
  final Value<bool> notificationsEnabled;
  final Value<bool> locationEnabled;
  final Value<String> currency;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.preferredUpiApp = const Value.absent(),
    this.monthlySavingsTarget = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.locationEnabled = const Value.absent(),
    this.currency = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.preferredUpiApp = const Value.absent(),
    this.monthlySavingsTarget = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.locationEnabled = const Value.absent(),
    this.currency = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<String>? preferredUpiApp,
    Expression<double>? monthlySavingsTarget,
    Expression<bool>? notificationsEnabled,
    Expression<bool>? locationEnabled,
    Expression<String>? currency,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (preferredUpiApp != null) 'preferred_upi_app': preferredUpiApp,
      if (monthlySavingsTarget != null)
        'monthly_savings_target': monthlySavingsTarget,
      if (notificationsEnabled != null)
        'notifications_enabled': notificationsEnabled,
      if (locationEnabled != null) 'location_enabled': locationEnabled,
      if (currency != null) 'currency': currency,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<String?>? preferredUpiApp,
    Value<double>? monthlySavingsTarget,
    Value<bool>? notificationsEnabled,
    Value<bool>? locationEnabled,
    Value<String>? currency,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      preferredUpiApp: preferredUpiApp ?? this.preferredUpiApp,
      monthlySavingsTarget: monthlySavingsTarget ?? this.monthlySavingsTarget,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      locationEnabled: locationEnabled ?? this.locationEnabled,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (preferredUpiApp.present) {
      map['preferred_upi_app'] = Variable<String>(preferredUpiApp.value);
    }
    if (monthlySavingsTarget.present) {
      map['monthly_savings_target'] = Variable<double>(
        monthlySavingsTarget.value,
      );
    }
    if (notificationsEnabled.present) {
      map['notifications_enabled'] = Variable<bool>(notificationsEnabled.value);
    }
    if (locationEnabled.present) {
      map['location_enabled'] = Variable<bool>(locationEnabled.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('preferredUpiApp: $preferredUpiApp, ')
          ..write('monthlySavingsTarget: $monthlySavingsTarget, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('locationEnabled: $locationEnabled, ')
          ..write('currency: $currency, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  $AppDbManager get managers => $AppDbManager(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $PaymentAttemptsTable paymentAttempts = $PaymentAttemptsTable(
    this,
  );
  late final $SavingsTable savings = $SavingsTable(this);
  late final $SavingsGoalsTable savingsGoals = $SavingsGoalsTable(this);
  late final $MonthlyReportsTable monthlyReports = $MonthlyReportsTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    transactions,
    paymentAttempts,
    savings,
    savingsGoals,
    monthlyReports,
    appSettings,
  ];
}

typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      required String id,
      required double amount,
      Value<String> currency,
      required String category,
      Value<String?> description,
      Value<String> merchantName,
      Value<String?> merchantVpa,
      Value<String?> merchantCode,
      Value<String?> transactionReference,
      Value<String?> transactionNote,
      Value<String?> qrRawData,
      Value<String?> upiApp,
      Value<String> paymentStatus,
      required DateTime paymentTimestamp,
      Value<String?> timezone,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<double?> locationAccuracy,
      Value<String?> locationLabel,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<String> id,
      Value<double> amount,
      Value<String> currency,
      Value<String> category,
      Value<String?> description,
      Value<String> merchantName,
      Value<String?> merchantVpa,
      Value<String?> merchantCode,
      Value<String?> transactionReference,
      Value<String?> transactionNote,
      Value<String?> qrRawData,
      Value<String?> upiApp,
      Value<String> paymentStatus,
      Value<DateTime> paymentTimestamp,
      Value<String?> timezone,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<double?> locationAccuracy,
      Value<String?> locationLabel,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$TransactionsTableReferences
    extends BaseReferences<_$AppDb, $TransactionsTable, Transaction> {
  $$TransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PaymentAttemptsTable, List<PaymentAttempt>>
  _paymentAttemptsRefsTable(_$AppDb db) => MultiTypedResultKey.fromTable(
    db.paymentAttempts,
    aliasName: 'transactions__id__payment_attempts__transaction_id',
  );

  $$PaymentAttemptsTableProcessedTableManager get paymentAttemptsRefs {
    final manager = $$PaymentAttemptsTableTableManager(
      $_db,
      $_db.paymentAttempts,
    ).filter((f) => f.transactionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _paymentAttemptsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDb, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get merchantName => $composableBuilder(
    column: $table.merchantName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get merchantVpa => $composableBuilder(
    column: $table.merchantVpa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get merchantCode => $composableBuilder(
    column: $table.merchantCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transactionReference => $composableBuilder(
    column: $table.transactionReference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transactionNote => $composableBuilder(
    column: $table.transactionNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qrRawData => $composableBuilder(
    column: $table.qrRawData,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get upiApp => $composableBuilder(
    column: $table.upiApp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentStatus => $composableBuilder(
    column: $table.paymentStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get paymentTimestamp => $composableBuilder(
    column: $table.paymentTimestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get locationAccuracy => $composableBuilder(
    column: $table.locationAccuracy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationLabel => $composableBuilder(
    column: $table.locationLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> paymentAttemptsRefs(
    Expression<bool> Function($$PaymentAttemptsTableFilterComposer f) f,
  ) {
    final $$PaymentAttemptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentAttempts,
      getReferencedColumn: (t) => t.transactionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentAttemptsTableFilterComposer(
            $db: $db,
            $table: $db.paymentAttempts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDb, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get merchantName => $composableBuilder(
    column: $table.merchantName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get merchantVpa => $composableBuilder(
    column: $table.merchantVpa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get merchantCode => $composableBuilder(
    column: $table.merchantCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionReference => $composableBuilder(
    column: $table.transactionReference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionNote => $composableBuilder(
    column: $table.transactionNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qrRawData => $composableBuilder(
    column: $table.qrRawData,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get upiApp => $composableBuilder(
    column: $table.upiApp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentStatus => $composableBuilder(
    column: $table.paymentStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get paymentTimestamp => $composableBuilder(
    column: $table.paymentTimestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get locationAccuracy => $composableBuilder(
    column: $table.locationAccuracy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationLabel => $composableBuilder(
    column: $table.locationLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDb, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get merchantName => $composableBuilder(
    column: $table.merchantName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get merchantVpa => $composableBuilder(
    column: $table.merchantVpa,
    builder: (column) => column,
  );

  GeneratedColumn<String> get merchantCode => $composableBuilder(
    column: $table.merchantCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get transactionReference => $composableBuilder(
    column: $table.transactionReference,
    builder: (column) => column,
  );

  GeneratedColumn<String> get transactionNote => $composableBuilder(
    column: $table.transactionNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get qrRawData =>
      $composableBuilder(column: $table.qrRawData, builder: (column) => column);

  GeneratedColumn<String> get upiApp =>
      $composableBuilder(column: $table.upiApp, builder: (column) => column);

  GeneratedColumn<String> get paymentStatus => $composableBuilder(
    column: $table.paymentStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get paymentTimestamp => $composableBuilder(
    column: $table.paymentTimestamp,
    builder: (column) => column,
  );

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get locationAccuracy => $composableBuilder(
    column: $table.locationAccuracy,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationLabel => $composableBuilder(
    column: $table.locationLabel,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> paymentAttemptsRefs<T extends Object>(
    Expression<T> Function($$PaymentAttemptsTableAnnotationComposer a) f,
  ) {
    final $$PaymentAttemptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentAttempts,
      getReferencedColumn: (t) => t.transactionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentAttemptsTableAnnotationComposer(
            $db: $db,
            $table: $db.paymentAttempts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $TransactionsTable,
          Transaction,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (Transaction, $$TransactionsTableReferences),
          Transaction,
          PrefetchHooks Function({bool paymentAttemptsRefs})
        > {
  $$TransactionsTableTableManager(_$AppDb db, $TransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> merchantName = const Value.absent(),
                Value<String?> merchantVpa = const Value.absent(),
                Value<String?> merchantCode = const Value.absent(),
                Value<String?> transactionReference = const Value.absent(),
                Value<String?> transactionNote = const Value.absent(),
                Value<String?> qrRawData = const Value.absent(),
                Value<String?> upiApp = const Value.absent(),
                Value<String> paymentStatus = const Value.absent(),
                Value<DateTime> paymentTimestamp = const Value.absent(),
                Value<String?> timezone = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<double?> locationAccuracy = const Value.absent(),
                Value<String?> locationLabel = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                amount: amount,
                currency: currency,
                category: category,
                description: description,
                merchantName: merchantName,
                merchantVpa: merchantVpa,
                merchantCode: merchantCode,
                transactionReference: transactionReference,
                transactionNote: transactionNote,
                qrRawData: qrRawData,
                upiApp: upiApp,
                paymentStatus: paymentStatus,
                paymentTimestamp: paymentTimestamp,
                timezone: timezone,
                latitude: latitude,
                longitude: longitude,
                locationAccuracy: locationAccuracy,
                locationLabel: locationLabel,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required double amount,
                Value<String> currency = const Value.absent(),
                required String category,
                Value<String?> description = const Value.absent(),
                Value<String> merchantName = const Value.absent(),
                Value<String?> merchantVpa = const Value.absent(),
                Value<String?> merchantCode = const Value.absent(),
                Value<String?> transactionReference = const Value.absent(),
                Value<String?> transactionNote = const Value.absent(),
                Value<String?> qrRawData = const Value.absent(),
                Value<String?> upiApp = const Value.absent(),
                Value<String> paymentStatus = const Value.absent(),
                required DateTime paymentTimestamp,
                Value<String?> timezone = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<double?> locationAccuracy = const Value.absent(),
                Value<String?> locationLabel = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion.insert(
                id: id,
                amount: amount,
                currency: currency,
                category: category,
                description: description,
                merchantName: merchantName,
                merchantVpa: merchantVpa,
                merchantCode: merchantCode,
                transactionReference: transactionReference,
                transactionNote: transactionNote,
                qrRawData: qrRawData,
                upiApp: upiApp,
                paymentStatus: paymentStatus,
                paymentTimestamp: paymentTimestamp,
                timezone: timezone,
                latitude: latitude,
                longitude: longitude,
                locationAccuracy: locationAccuracy,
                locationLabel: locationLabel,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TransactionsTable, Transaction>(table),
                  $$TransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({paymentAttemptsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (paymentAttemptsRefs) db.paymentAttempts,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (paymentAttemptsRefs)
                    await $_getPrefetchedData<
                      Transaction,
                      $TransactionsTable,
                      PaymentAttempt
                    >(
                      currentTable: table,
                      referencedTable: $$TransactionsTableReferences
                          ._paymentAttemptsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TransactionsTableReferences(
                            db,
                            table,
                            p0,
                          ).paymentAttemptsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.transactionId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $TransactionsTable,
      Transaction,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (Transaction, $$TransactionsTableReferences),
      Transaction,
      PrefetchHooks Function({bool paymentAttemptsRefs})
    >;
typedef $$PaymentAttemptsTableCreateCompanionBuilder =
    PaymentAttemptsCompanion Function({
      required String id,
      required String transactionId,
      required String upiApp,
      Value<DateTime> launchedAt,
      Value<DateTime?> returnedAt,
      Value<String?> callbackStatus,
      Value<String?> responseCode,
      Value<String?> externalTransactionId,
      Value<String?> rawResponse,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$PaymentAttemptsTableUpdateCompanionBuilder =
    PaymentAttemptsCompanion Function({
      Value<String> id,
      Value<String> transactionId,
      Value<String> upiApp,
      Value<DateTime> launchedAt,
      Value<DateTime?> returnedAt,
      Value<String?> callbackStatus,
      Value<String?> responseCode,
      Value<String?> externalTransactionId,
      Value<String?> rawResponse,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$PaymentAttemptsTableReferences
    extends BaseReferences<_$AppDb, $PaymentAttemptsTable, PaymentAttempt> {
  $$PaymentAttemptsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TransactionsTable _transactionIdTable(_$AppDb db) => db.transactions
      .createAlias('payment_attempts__transaction_id__transactions__id');

  $$TransactionsTableProcessedTableManager get transactionId {
    final $_column = $_itemColumn<String>('transaction_id')!;

    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_transactionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PaymentAttemptsTableFilterComposer
    extends Composer<_$AppDb, $PaymentAttemptsTable> {
  $$PaymentAttemptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get upiApp => $composableBuilder(
    column: $table.upiApp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get launchedAt => $composableBuilder(
    column: $table.launchedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get returnedAt => $composableBuilder(
    column: $table.returnedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get callbackStatus => $composableBuilder(
    column: $table.callbackStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get responseCode => $composableBuilder(
    column: $table.responseCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get externalTransactionId => $composableBuilder(
    column: $table.externalTransactionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawResponse => $composableBuilder(
    column: $table.rawResponse,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TransactionsTableFilterComposer get transactionId {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionId,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentAttemptsTableOrderingComposer
    extends Composer<_$AppDb, $PaymentAttemptsTable> {
  $$PaymentAttemptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get upiApp => $composableBuilder(
    column: $table.upiApp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get launchedAt => $composableBuilder(
    column: $table.launchedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get returnedAt => $composableBuilder(
    column: $table.returnedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get callbackStatus => $composableBuilder(
    column: $table.callbackStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get responseCode => $composableBuilder(
    column: $table.responseCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get externalTransactionId => $composableBuilder(
    column: $table.externalTransactionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawResponse => $composableBuilder(
    column: $table.rawResponse,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TransactionsTableOrderingComposer get transactionId {
    final $$TransactionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionId,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableOrderingComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentAttemptsTableAnnotationComposer
    extends Composer<_$AppDb, $PaymentAttemptsTable> {
  $$PaymentAttemptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get upiApp =>
      $composableBuilder(column: $table.upiApp, builder: (column) => column);

  GeneratedColumn<DateTime> get launchedAt => $composableBuilder(
    column: $table.launchedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get returnedAt => $composableBuilder(
    column: $table.returnedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get callbackStatus => $composableBuilder(
    column: $table.callbackStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get responseCode => $composableBuilder(
    column: $table.responseCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get externalTransactionId => $composableBuilder(
    column: $table.externalTransactionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rawResponse => $composableBuilder(
    column: $table.rawResponse,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$TransactionsTableAnnotationComposer get transactionId {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionId,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentAttemptsTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $PaymentAttemptsTable,
          PaymentAttempt,
          $$PaymentAttemptsTableFilterComposer,
          $$PaymentAttemptsTableOrderingComposer,
          $$PaymentAttemptsTableAnnotationComposer,
          $$PaymentAttemptsTableCreateCompanionBuilder,
          $$PaymentAttemptsTableUpdateCompanionBuilder,
          (PaymentAttempt, $$PaymentAttemptsTableReferences),
          PaymentAttempt,
          PrefetchHooks Function({bool transactionId})
        > {
  $$PaymentAttemptsTableTableManager(_$AppDb db, $PaymentAttemptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentAttemptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentAttemptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentAttemptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> transactionId = const Value.absent(),
                Value<String> upiApp = const Value.absent(),
                Value<DateTime> launchedAt = const Value.absent(),
                Value<DateTime?> returnedAt = const Value.absent(),
                Value<String?> callbackStatus = const Value.absent(),
                Value<String?> responseCode = const Value.absent(),
                Value<String?> externalTransactionId = const Value.absent(),
                Value<String?> rawResponse = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentAttemptsCompanion(
                id: id,
                transactionId: transactionId,
                upiApp: upiApp,
                launchedAt: launchedAt,
                returnedAt: returnedAt,
                callbackStatus: callbackStatus,
                responseCode: responseCode,
                externalTransactionId: externalTransactionId,
                rawResponse: rawResponse,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String transactionId,
                required String upiApp,
                Value<DateTime> launchedAt = const Value.absent(),
                Value<DateTime?> returnedAt = const Value.absent(),
                Value<String?> callbackStatus = const Value.absent(),
                Value<String?> responseCode = const Value.absent(),
                Value<String?> externalTransactionId = const Value.absent(),
                Value<String?> rawResponse = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentAttemptsCompanion.insert(
                id: id,
                transactionId: transactionId,
                upiApp: upiApp,
                launchedAt: launchedAt,
                returnedAt: returnedAt,
                callbackStatus: callbackStatus,
                responseCode: responseCode,
                externalTransactionId: externalTransactionId,
                rawResponse: rawResponse,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PaymentAttemptsTable, PaymentAttempt>(table),
                  $$PaymentAttemptsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({transactionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (transactionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.transactionId,
                        referencedTable: $$PaymentAttemptsTableReferences
                            ._transactionIdTable(db),
                        referencedColumn: $$PaymentAttemptsTableReferences
                            ._transactionIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PaymentAttemptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $PaymentAttemptsTable,
      PaymentAttempt,
      $$PaymentAttemptsTableFilterComposer,
      $$PaymentAttemptsTableOrderingComposer,
      $$PaymentAttemptsTableAnnotationComposer,
      $$PaymentAttemptsTableCreateCompanionBuilder,
      $$PaymentAttemptsTableUpdateCompanionBuilder,
      (PaymentAttempt, $$PaymentAttemptsTableReferences),
      PaymentAttempt,
      PrefetchHooks Function({bool transactionId})
    >;
typedef $$SavingsTableCreateCompanionBuilder = SavingsCompanion Function({
  required String id,
  required double amount,
  Value<String?> goalId,
  Value<String?> description,
  required DateTime savingDate,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$SavingsTableUpdateCompanionBuilder = SavingsCompanion Function({
  Value<String> id,
  Value<double> amount,
  Value<String?> goalId,
  Value<String?> description,
  Value<DateTime> savingDate,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$SavingsTableFilterComposer extends Composer<_$AppDb, $SavingsTable> {
  $$SavingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goalId => $composableBuilder(
    column: $table.goalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get savingDate => $composableBuilder(
    column: $table.savingDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SavingsTableOrderingComposer extends Composer<_$AppDb, $SavingsTable> {
  $$SavingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goalId => $composableBuilder(
    column: $table.goalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get savingDate => $composableBuilder(
    column: $table.savingDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SavingsTableAnnotationComposer
    extends Composer<_$AppDb, $SavingsTable> {
  $$SavingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get goalId =>
      $composableBuilder(column: $table.goalId, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get savingDate => $composableBuilder(
    column: $table.savingDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SavingsTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $SavingsTable,
          Saving,
          $$SavingsTableFilterComposer,
          $$SavingsTableOrderingComposer,
          $$SavingsTableAnnotationComposer,
          $$SavingsTableCreateCompanionBuilder,
          $$SavingsTableUpdateCompanionBuilder,
          (Saving, BaseReferences<_$AppDb, $SavingsTable, Saving>),
          Saving,
          PrefetchHooks Function()
        > {
  $$SavingsTableTableManager(_$AppDb db, $SavingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String?> goalId = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> savingDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SavingsCompanion(
                id: id,
                amount: amount,
                goalId: goalId,
                description: description,
                savingDate: savingDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required double amount,
                Value<String?> goalId = const Value.absent(),
                Value<String?> description = const Value.absent(),
                required DateTime savingDate,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SavingsCompanion.insert(
                id: id,
                amount: amount,
                goalId: goalId,
                description: description,
                savingDate: savingDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SavingsTable, Saving>(table),
                  BaseReferences<_$AppDb, $SavingsTable, Saving>(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SavingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $SavingsTable,
      Saving,
      $$SavingsTableFilterComposer,
      $$SavingsTableOrderingComposer,
      $$SavingsTableAnnotationComposer,
      $$SavingsTableCreateCompanionBuilder,
      $$SavingsTableUpdateCompanionBuilder,
      (Saving, BaseReferences<_$AppDb, $SavingsTable, Saving>),
      Saving,
      PrefetchHooks Function()
    >;
typedef $$SavingsGoalsTableCreateCompanionBuilder =
    SavingsGoalsCompanion Function({
      required String id,
      required String name,
      required double targetAmount,
      Value<double> currentAmount,
      Value<DateTime?> targetDate,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$SavingsGoalsTableUpdateCompanionBuilder =
    SavingsGoalsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<double> targetAmount,
      Value<double> currentAmount,
      Value<DateTime?> targetDate,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$SavingsGoalsTableFilterComposer
    extends Composer<_$AppDb, $SavingsGoalsTable> {
  $$SavingsGoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetAmount => $composableBuilder(
    column: $table.targetAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentAmount => $composableBuilder(
    column: $table.currentAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SavingsGoalsTableOrderingComposer
    extends Composer<_$AppDb, $SavingsGoalsTable> {
  $$SavingsGoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetAmount => $composableBuilder(
    column: $table.targetAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentAmount => $composableBuilder(
    column: $table.currentAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SavingsGoalsTableAnnotationComposer
    extends Composer<_$AppDb, $SavingsGoalsTable> {
  $$SavingsGoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get targetAmount => $composableBuilder(
    column: $table.targetAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get currentAmount => $composableBuilder(
    column: $table.currentAmount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SavingsGoalsTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $SavingsGoalsTable,
          SavingsGoal,
          $$SavingsGoalsTableFilterComposer,
          $$SavingsGoalsTableOrderingComposer,
          $$SavingsGoalsTableAnnotationComposer,
          $$SavingsGoalsTableCreateCompanionBuilder,
          $$SavingsGoalsTableUpdateCompanionBuilder,
          (
            SavingsGoal,
            BaseReferences<_$AppDb, $SavingsGoalsTable, SavingsGoal>,
          ),
          SavingsGoal,
          PrefetchHooks Function()
        > {
  $$SavingsGoalsTableTableManager(_$AppDb db, $SavingsGoalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavingsGoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavingsGoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavingsGoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> targetAmount = const Value.absent(),
                Value<double> currentAmount = const Value.absent(),
                Value<DateTime?> targetDate = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SavingsGoalsCompanion(
                id: id,
                name: name,
                targetAmount: targetAmount,
                currentAmount: currentAmount,
                targetDate: targetDate,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required double targetAmount,
                Value<double> currentAmount = const Value.absent(),
                Value<DateTime?> targetDate = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SavingsGoalsCompanion.insert(
                id: id,
                name: name,
                targetAmount: targetAmount,
                currentAmount: currentAmount,
                targetDate: targetDate,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SavingsGoalsTable, SavingsGoal>(table),
                  BaseReferences<_$AppDb, $SavingsGoalsTable, SavingsGoal>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SavingsGoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $SavingsGoalsTable,
      SavingsGoal,
      $$SavingsGoalsTableFilterComposer,
      $$SavingsGoalsTableOrderingComposer,
      $$SavingsGoalsTableAnnotationComposer,
      $$SavingsGoalsTableCreateCompanionBuilder,
      $$SavingsGoalsTableUpdateCompanionBuilder,
      (SavingsGoal, BaseReferences<_$AppDb, $SavingsGoalsTable, SavingsGoal>),
      SavingsGoal,
      PrefetchHooks Function()
    >;
typedef $$MonthlyReportsTableCreateCompanionBuilder =
    MonthlyReportsCompanion Function({
      required String id,
      required int reportMonth,
      required int reportYear,
      Value<double> totalSpending,
      Value<double> totalSavings,
      Value<int> transactionCount,
      Value<String> reportData,
      Value<DateTime> generatedAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$MonthlyReportsTableUpdateCompanionBuilder =
    MonthlyReportsCompanion Function({
      Value<String> id,
      Value<int> reportMonth,
      Value<int> reportYear,
      Value<double> totalSpending,
      Value<double> totalSavings,
      Value<int> transactionCount,
      Value<String> reportData,
      Value<DateTime> generatedAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$MonthlyReportsTableFilterComposer
    extends Composer<_$AppDb, $MonthlyReportsTable> {
  $$MonthlyReportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reportMonth => $composableBuilder(
    column: $table.reportMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reportYear => $composableBuilder(
    column: $table.reportYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalSpending => $composableBuilder(
    column: $table.totalSpending,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalSavings => $composableBuilder(
    column: $table.totalSavings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get transactionCount => $composableBuilder(
    column: $table.transactionCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reportData => $composableBuilder(
    column: $table.reportData,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MonthlyReportsTableOrderingComposer
    extends Composer<_$AppDb, $MonthlyReportsTable> {
  $$MonthlyReportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reportMonth => $composableBuilder(
    column: $table.reportMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reportYear => $composableBuilder(
    column: $table.reportYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalSpending => $composableBuilder(
    column: $table.totalSpending,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalSavings => $composableBuilder(
    column: $table.totalSavings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get transactionCount => $composableBuilder(
    column: $table.transactionCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reportData => $composableBuilder(
    column: $table.reportData,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MonthlyReportsTableAnnotationComposer
    extends Composer<_$AppDb, $MonthlyReportsTable> {
  $$MonthlyReportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get reportMonth => $composableBuilder(
    column: $table.reportMonth,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reportYear => $composableBuilder(
    column: $table.reportYear,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalSpending => $composableBuilder(
    column: $table.totalSpending,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalSavings => $composableBuilder(
    column: $table.totalSavings,
    builder: (column) => column,
  );

  GeneratedColumn<int> get transactionCount => $composableBuilder(
    column: $table.transactionCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reportData => $composableBuilder(
    column: $table.reportData,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MonthlyReportsTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $MonthlyReportsTable,
          MonthlyReport,
          $$MonthlyReportsTableFilterComposer,
          $$MonthlyReportsTableOrderingComposer,
          $$MonthlyReportsTableAnnotationComposer,
          $$MonthlyReportsTableCreateCompanionBuilder,
          $$MonthlyReportsTableUpdateCompanionBuilder,
          (
            MonthlyReport,
            BaseReferences<_$AppDb, $MonthlyReportsTable, MonthlyReport>,
          ),
          MonthlyReport,
          PrefetchHooks Function()
        > {
  $$MonthlyReportsTableTableManager(_$AppDb db, $MonthlyReportsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MonthlyReportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MonthlyReportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MonthlyReportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> reportMonth = const Value.absent(),
                Value<int> reportYear = const Value.absent(),
                Value<double> totalSpending = const Value.absent(),
                Value<double> totalSavings = const Value.absent(),
                Value<int> transactionCount = const Value.absent(),
                Value<String> reportData = const Value.absent(),
                Value<DateTime> generatedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MonthlyReportsCompanion(
                id: id,
                reportMonth: reportMonth,
                reportYear: reportYear,
                totalSpending: totalSpending,
                totalSavings: totalSavings,
                transactionCount: transactionCount,
                reportData: reportData,
                generatedAt: generatedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int reportMonth,
                required int reportYear,
                Value<double> totalSpending = const Value.absent(),
                Value<double> totalSavings = const Value.absent(),
                Value<int> transactionCount = const Value.absent(),
                Value<String> reportData = const Value.absent(),
                Value<DateTime> generatedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MonthlyReportsCompanion.insert(
                id: id,
                reportMonth: reportMonth,
                reportYear: reportYear,
                totalSpending: totalSpending,
                totalSavings: totalSavings,
                transactionCount: transactionCount,
                reportData: reportData,
                generatedAt: generatedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MonthlyReportsTable, MonthlyReport>(table),
                  BaseReferences<_$AppDb, $MonthlyReportsTable, MonthlyReport>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MonthlyReportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $MonthlyReportsTable,
      MonthlyReport,
      $$MonthlyReportsTableFilterComposer,
      $$MonthlyReportsTableOrderingComposer,
      $$MonthlyReportsTableAnnotationComposer,
      $$MonthlyReportsTableCreateCompanionBuilder,
      $$MonthlyReportsTableUpdateCompanionBuilder,
      (
        MonthlyReport,
        BaseReferences<_$AppDb, $MonthlyReportsTable, MonthlyReport>,
      ),
      MonthlyReport,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<String?> preferredUpiApp,
      Value<double> monthlySavingsTarget,
      Value<bool> notificationsEnabled,
      Value<bool> locationEnabled,
      Value<String> currency,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<String?> preferredUpiApp,
      Value<double> monthlySavingsTarget,
      Value<bool> notificationsEnabled,
      Value<bool> locationEnabled,
      Value<String> currency,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDb, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preferredUpiApp => $composableBuilder(
    column: $table.preferredUpiApp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get monthlySavingsTarget => $composableBuilder(
    column: $table.monthlySavingsTarget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get locationEnabled => $composableBuilder(
    column: $table.locationEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDb, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferredUpiApp => $composableBuilder(
    column: $table.preferredUpiApp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get monthlySavingsTarget => $composableBuilder(
    column: $table.monthlySavingsTarget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get locationEnabled => $composableBuilder(
    column: $table.locationEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDb, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get preferredUpiApp => $composableBuilder(
    column: $table.preferredUpiApp,
    builder: (column) => column,
  );

  GeneratedColumn<double> get monthlySavingsTarget => $composableBuilder(
    column: $table.monthlySavingsTarget,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get locationEnabled => $composableBuilder(
    column: $table.locationEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (AppSetting, BaseReferences<_$AppDb, $AppSettingsTable, AppSetting>),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDb db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> preferredUpiApp = const Value.absent(),
                Value<double> monthlySavingsTarget = const Value.absent(),
                Value<bool> notificationsEnabled = const Value.absent(),
                Value<bool> locationEnabled = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                preferredUpiApp: preferredUpiApp,
                monthlySavingsTarget: monthlySavingsTarget,
                notificationsEnabled: notificationsEnabled,
                locationEnabled: locationEnabled,
                currency: currency,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> preferredUpiApp = const Value.absent(),
                Value<double> monthlySavingsTarget = const Value.absent(),
                Value<bool> notificationsEnabled = const Value.absent(),
                Value<bool> locationEnabled = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                preferredUpiApp: preferredUpiApp,
                monthlySavingsTarget: monthlySavingsTarget,
                notificationsEnabled: notificationsEnabled,
                locationEnabled: locationEnabled,
                currency: currency,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppSettingsTable, AppSetting>(table),
                  BaseReferences<_$AppDb, $AppSettingsTable, AppSetting>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (AppSetting, BaseReferences<_$AppDb, $AppSettingsTable, AppSetting>),
      AppSetting,
      PrefetchHooks Function()
    >;

class $AppDbManager {
  final _$AppDb _db;
  $AppDbManager(this._db);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$PaymentAttemptsTableTableManager get paymentAttempts =>
      $$PaymentAttemptsTableTableManager(_db, _db.paymentAttempts);
  $$SavingsTableTableManager get savings =>
      $$SavingsTableTableManager(_db, _db.savings);
  $$SavingsGoalsTableTableManager get savingsGoals =>
      $$SavingsGoalsTableTableManager(_db, _db.savingsGoals);
  $$MonthlyReportsTableTableManager get monthlyReports =>
      $$MonthlyReportsTableTableManager(_db, _db.monthlyReports);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
