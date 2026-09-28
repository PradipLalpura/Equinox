import 'package:flutter/material.dart';

// Domain enums. Exactly five categories in MVP (§17). No extras.
enum Category { food, petrol, personal, college, home }

extension CategoryX on Category {
  String get label => switch (this) {
    Category.food => 'Food',
    Category.petrol => 'Petrol',
    Category.personal => 'Personal',
    Category.college => 'College',
    Category.home => 'Home',
  };
  IconData get icon => switch (this) {
    Category.food => Icons.restaurant_outlined,
    Category.petrol => Icons.local_gas_station_outlined,
    Category.personal => Icons.person_outline,
    Category.college => Icons.school_outlined,
    Category.home => Icons.home_outlined,
  };
  static Category fromName(String n) => Category.values.firstWhere(
    (c) => c.name == n,
    orElse: () => Category.personal,
  );
}

// Payment lifecycle (§23). Never auto-success: only explicit reconcile moves
// INITIATED/PENDING/UNKNOWN → SUCCESSFUL/CANCELLED/FAILED.
enum PayStatus {
  draft,
  initiated,
  pending,
  successful,
  failed,
  cancelled,
  unknown,
}

extension PayStatusX on PayStatus {
  String get label => name.toUpperCase();
  static PayStatus fromName(String n) => PayStatus.values.firstWhere(
    (s) => s.name == n,
    orElse: () => PayStatus.unknown,
  );
  bool get isConfirmed => this == PayStatus.successful;
}

/// Minimal in-memory transaction used by Phase 1–2 UI + seed (§58).
/// Drift rows mirror these fields; DAOs map row→this in Phase 3.
class Tx {
  final String id;
  final double amount;
  final Category category;
  final String merchant;
  final String? description;
  final PayStatus status;
  final DateTime time;
  final String? upiId;
  final String? upiApp;
  final String? locationLabel;
  final String? reference;
  const Tx({
    required this.id,
    required this.amount,
    required this.category,
    required this.merchant,
    this.description,
    required this.status,
    required this.time,
    this.upiId,
    this.upiApp,
    this.locationLabel,
    this.reference,
  });
}

class SavingEntry {
  final String id;
  final double amount;
  final String? goalId;
  final String? description;
  final DateTime date;
  const SavingEntry({
    required this.id,
    required this.amount,
    this.goalId,
    this.description,
    required this.date,
  });
}

enum GoalStatus { active, paused, completed }

extension GoalStatusX on GoalStatus {
  static GoalStatus fromName(String n) => GoalStatus.values.firstWhere(
    (s) => s.name == n,
    orElse: () => GoalStatus.active,
  );
}

/// Optional savings target (§11). current grows ONLY via explicit
/// contributions — never inferred (§10).
class SavingGoal {
  final String id;
  final String name;
  final double target;
  final double current;
  final DateTime? targetDate;
  final GoalStatus status;
  const SavingGoal({
    required this.id,
    required this.name,
    required this.target,
    this.current = 0,
    this.targetDate,
    this.status = GoalStatus.active,
  });

  double get progress => target <= 0 ? 0 : (current / target).clamp(0.0, 1.0);
  double get remaining => (target - current).clamp(0, double.infinity);
}

// Seed calibrated to §58: total ₹24,860 · Sept ₹8,420 (Food 3,240 / Petrol
// 2,000 / Personal 1,280 / College 940 / Home 960) · week Sep 21–27 ₹2,150.
// Non-confirmed rows (pending/failed/cancelled) never count toward totals.
final seedTx = <Tx>[
  // September, in-week (Mon Sep 21 – Sun Sep 27): sums to ₹2,150.
  Tx(
    id: 't01',
    amount: 450,
    category: Category.food,
    merchant: 'Shree Krishna Cafe',
    description: 'Dinner',
    status: PayStatus.successful,
    time: DateTime(2026, 9, 27, 20, 42),
    upiId: 'shreekrishna@upi',
    upiApp: 'Google Pay',
    locationLabel: 'New Ranip, Ahmedabad',
    reference: 'UPI-20260927-01',
  ),
  Tx(
    id: 't02',
    amount: 320,
    category: Category.food,
    merchant: 'Shree Krishna Cafe',
    description: 'Lunch',
    status: PayStatus.successful,
    time: DateTime(2026, 9, 26, 13, 12),
    upiId: 'shreekrishna@upi',
    upiApp: 'PhonePe',
    locationLabel: 'New Ranip, Ahmedabad',
  ),
  Tx(
    id: 't03',
    amount: 350,
    category: Category.food,
    merchant: 'Shree Krishna Cafe',
    status: PayStatus.pending,
    time: DateTime(2026, 9, 27, 19, 2),
    upiId: 'shreekrishna@upi',
    upiApp: 'Google Pay',
  ),
  Tx(
    id: 't04',
    amount: 1200,
    category: Category.petrol,
    merchant: 'Shell Ranip',
    status: PayStatus.cancelled,
    time: DateTime(2026, 9, 26, 9, 15),
  ),
  Tx(
    id: 't05',
    amount: 680,
    category: Category.food,
    merchant: 'Balaji Sandwich',
    description: 'Evening snacks',
    status: PayStatus.successful,
    time: DateTime(2026, 9, 23, 18, 5),
    upiId: 'balaji@upi',
    upiApp: 'Paytm',
  ),
  Tx(
    id: 't06',
    amount: 700,
    category: Category.food,
    merchant: 'College Canteen',
    description: 'Lunch',
    status: PayStatus.successful,
    time: DateTime(2026, 9, 22, 13, 0),
    upiId: 'canteen@upi',
    upiApp: 'super.money',
  ),
  // September, outside week.
  Tx(
    id: 't07',
    amount: 500,
    category: Category.personal,
    merchant: 'Jio Recharge',
    status: PayStatus.failed,
    time: DateTime(2026, 9, 25, 10, 20),
  ),
  Tx(
    id: 't08',
    amount: 1090,
    category: Category.food,
    merchant: 'Honest Restaurant',
    description: 'Family dinner',
    status: PayStatus.successful,
    time: DateTime(2026, 9, 12, 20, 30),
    upiId: 'honest@upi',
    upiApp: 'PhonePe',
    locationLabel: 'CG Road, Ahmedabad',
  ),
  Tx(
    id: 't09',
    amount: 2000,
    category: Category.petrol,
    merchant: 'Shell Ranip',
    description: 'Petrol for bike',
    status: PayStatus.successful,
    time: DateTime(2026, 9, 18, 18, 40),
    upiId: 'shell.ranip@upi',
    upiApp: 'Google Pay',
  ),
  Tx(
    id: 't10',
    amount: 1280,
    category: Category.personal,
    merchant: 'Gift Corner',
    description: 'Gift',
    status: PayStatus.successful,
    time: DateTime(2026, 9, 10, 17, 22),
    upiId: 'giftcorner@upi',
    upiApp: 'POP UPI',
  ),
  Tx(
    id: 't11',
    amount: 940,
    category: Category.college,
    merchant: 'College Bookstore',
    description: 'Notebook',
    status: PayStatus.successful,
    time: DateTime(2026, 9, 8, 11, 5),
    upiId: 'bookstore@upi',
    upiApp: 'PhonePe',
  ),
  Tx(
    id: 't12',
    amount: 960,
    category: Category.home,
    merchant: 'Torrent Power',
    description: 'Electricity bill',
    status: PayStatus.successful,
    time: DateTime(2026, 9, 5, 9, 30),
    upiId: 'torrent@billdesk',
    upiApp: 'Paytm',
  ),
  // August (₹9,300).
  Tx(
    id: 't13',
    amount: 2400,
    category: Category.home,
    merchant: 'D-Mart',
    description: 'Groceries',
    status: PayStatus.successful,
    time: DateTime(2026, 8, 28, 19, 12),
    upiId: 'dmart@upi',
    upiApp: 'Google Pay',
  ),
  Tx(
    id: 't14',
    amount: 1800,
    category: Category.petrol,
    merchant: 'Shell Ranip',
    status: PayStatus.successful,
    time: DateTime(2026, 8, 25, 8, 45),
  ),
  Tx(
    id: 't15',
    amount: 1200,
    category: Category.food,
    merchant: "McDonald's",
    status: PayStatus.successful,
    time: DateTime(2026, 8, 20, 21, 5),
  ),
  Tx(
    id: 't16',
    amount: 550,
    category: Category.petrol,
    merchant: 'Essar Petrol',
    status: PayStatus.successful,
    time: DateTime(2026, 8, 18, 9, 0),
  ),
  Tx(
    id: 't17',
    amount: 1100,
    category: Category.college,
    merchant: 'Stationery Hub',
    description: 'Exam pads',
    status: PayStatus.successful,
    time: DateTime(2026, 8, 15, 12, 40),
  ),
  Tx(
    id: 't18',
    amount: 900,
    category: Category.personal,
    merchant: 'Decathlon',
    description: 'Bottle',
    status: PayStatus.successful,
    time: DateTime(2026, 8, 10, 16, 25),
  ),
  Tx(
    id: 't19',
    amount: 700,
    category: Category.home,
    merchant: 'Apartment Maintenance',
    status: PayStatus.successful,
    time: DateTime(2026, 8, 5, 10, 0),
  ),
  Tx(
    id: 't20',
    amount: 650,
    category: Category.food,
    merchant: 'Karnavati Dabeli',
    status: PayStatus.successful,
    time: DateTime(2026, 8, 2, 19, 50),
  ),
  // July (₹7,140).
  Tx(
    id: 't21',
    amount: 1800,
    category: Category.home,
    merchant: 'Rent Share',
    status: PayStatus.successful,
    time: DateTime(2026, 7, 28, 9, 0),
  ),
  Tx(
    id: 't22',
    amount: 980,
    category: Category.food,
    merchant: 'Pizza Hut',
    status: PayStatus.successful,
    time: DateTime(2026, 7, 22, 20, 15),
  ),
  Tx(
    id: 't23',
    amount: 1500,
    category: Category.petrol,
    merchant: 'Shell Ranip',
    status: PayStatus.successful,
    time: DateTime(2026, 7, 18, 8, 30),
  ),
  Tx(
    id: 't24',
    amount: 760,
    category: Category.college,
    merchant: 'College Bookstore',
    description: 'Files',
    status: PayStatus.successful,
    time: DateTime(2026, 7, 12, 11, 20),
  ),
  Tx(
    id: 't25',
    amount: 1100,
    category: Category.personal,
    merchant: 'Myntra',
    description: 'T-shirt',
    status: PayStatus.successful,
    time: DateTime(2026, 7, 8, 22, 10),
  ),
  Tx(
    id: 't26',
    amount: 1000,
    category: Category.food,
    merchant: 'Honest Restaurant',
    status: PayStatus.successful,
    time: DateTime(2026, 7, 3, 13, 45),
  ),
];

final seedSavings = <SavingEntry>[
  SavingEntry(
    id: 's1',
    amount: 2000,
    description: 'September savings',
    date: DateTime(2026, 9, 5),
  ),
  SavingEntry(
    id: 's2',
    amount: 1580,
    description: 'September savings',
    date: DateTime(2026, 9, 18),
  ),
];
