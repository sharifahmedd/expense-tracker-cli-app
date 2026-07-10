import 'dart:io';

// Parent class
class Expense {
  String title;
  double amount;
  String category;

  Expense(this.title, this.amount, this.category);

  String displayExpense() {
    return '$title - ${amount.toCurrency()} - $category';
  }
}

// Child classes
class Food extends Expense {
  Food(String title, double amount) : super(title, amount, 'Food');

  @override
  String displayExpense() {
    return '${super.displayExpense()}';
  }
}

class Transport extends Expense {
  Transport(String title, double amount) : super(title, amount, 'Transport');

  @override
  String displayExpense() {
    return '${super.displayExpense()}';
  }
}

class Entertainment extends Expense {
  Entertainment(String title, double amount)
    : super(title, amount, 'Entertainment');

  @override
  String displayExpense() {
    return '${super.displayExpense()}';
  }
}

// Currency formatting
extension CurrencyFormat on double {
  String toCurrency() {
    return '৳${toStringAsFixed(2)}';
  }
}

// Display menu
void displayMenu() {
  print('''
\n===== Expense Tracker =====
1. Add Expense
2. View All Expenses
3. Show Total Expenses
4. Exit
Choose Option: ''');
}

String normalizeCategory(String input) {
  String value = input.trim().toLowerCase();

  switch (value) {
    case 'food':
      return 'Food';
    case 'transport':
      return 'Transport';
    case 'entertainment':
      return 'Entertainment';
    default:
      return input.trim().isEmpty ? 'Other' : input.trim();
  }
}

// Create expense object
Expense createExpense(String title, double amount, String category) {
  switch (category.toLowerCase()) {
    case 'food':
      return Food(title, amount);
    case 'transport':
      return Transport(title, amount);
    case 'entertainment':
      return Entertainment(title, amount);
    default:
      return Expense(title, amount, category);
  }
}

// Add new expense
void addExpense(List<Expense> expenses) {
  print('\nEnter Expense Title: ');
  String title = stdin.readLineSync() ?? '';

  print('Enter Expense Amount: ');
  double amount = double.tryParse(stdin.readLineSync() ?? '') ?? 0.0;

  print('Enter Category: ');
  String categoryInput = stdin.readLineSync() ?? '';
  String category = normalizeCategory(categoryInput);

  expenses.add(createExpense(title, amount, category));
  print('Expense Added Successfully!');
}

// View all expenses
void viewExpenses(List<Expense> expenses) {
  print('\n===== All Expenses =====');

  if (expenses.isEmpty) {
    print('No expenses recorded yet.');
    return;
  }

  for (int i = 0; i < expenses.length; i++) {
    print('${i + 1}. ${expenses[i].displayExpense()}');
  }
}

// Show total expense amount
void showTotal(List<Expense> expenses) {
  double total = expenses.fold(0.0, (sum, expense) => sum + expense.amount);
  print('\nTotal Expenses: ${total.toCurrency()}');
}

// Main program
void main() {
  List<Expense> expenses = [];

  while (true) {
    displayMenu();

    String? choice = stdin.readLineSync()?.trim();

    switch (choice) {
      case '1':
        addExpense(expenses);
        break;
      case '2':
        viewExpenses(expenses);
        break;
      case '3':
        showTotal(expenses);
        break;
      case '4':
        print('\nThank you for using Expense Tracker!');
        return;
      default:
        print('Invalid option. Please choose 1-4.');
    }
  }
}
