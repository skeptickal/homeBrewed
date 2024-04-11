part of 'income_cubit.dart';

@immutable
class IncomeState extends Equatable {
  final Income? income;
  final List<Income>? incomes;

  const IncomeState({this.income, required this.incomes});

  IncomeState copyWith({income, incomeEdit, incomes}) {
    return IncomeState(income: income ?? this.income, incomes: incomes ?? this.incomes);
  }

  @override
  List<Object?> get props => [income, incomes];
}

final class IncomeInitial extends IncomeState {
  IncomeInitial()
      : super(
          incomes: [],
          income: const Income(
            copper: '0',
            silver: '0',
            electrum: '0',
            gold: '0',
            platinum: '0',
          ),
        );
}
