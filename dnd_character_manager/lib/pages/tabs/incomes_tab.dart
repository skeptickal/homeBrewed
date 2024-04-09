import 'package:dnd_character_manager/client/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../constants/theme_data.dart';
import '../../cubits/income_cubit/income_cubit.dart';
import '../../models/income.dart';

class IncomesTab extends StatelessWidget {
  final String charID;
  const IncomesTab({super.key, required this.charID});

  @override
  Widget build(BuildContext context) {
    context.read<IncomeCubit>().readIncomeData(charID);
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        children: [
          _IncomesList(charID: charID),
        ],
      ),
    );
  }
}

//list with containers
class _IncomesList extends StatelessWidget {
  final String? charID;
  const _IncomesList({required this.charID});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncomeCubit, IncomeState>(
      builder: (context, state) {
        return Column(
          children: [
            seperation,
            SelectableText(
              'Incomes\n',
              style: dndFont.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            TextButton(
              onPressed: () => _onPressedRatios(context),
              child: Text(
                'What are Income Ratios?',
                style: TextStyle(fontSize: 14, color: themeColor),
              ),
            ),
            GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                children: [
                  _IncomeContainer(
                    title: 'Copper',
                    value: state.income!.copper,
                    state: state,
                    charID: charID,
                    onLongPress: () => _showEditDialog(context, state.income!.copper, 'Copper', charID!, state),
                    onIncrement: () {
                      int? copperValueAsInt = int.tryParse(state.income!.copper ?? '0')! + 1;
                      context.read<IncomeCubit>().setIncomesData(state.income!.copyWith(copper: copperValueAsInt.toString()));
                      context.read<IncomeCubit>().readIncomesByCharID(charID);
                    },
                    onDecrement: () {
                      int? copperValueAsInt = int.tryParse(state.income!.copper ?? '0')! - 1;
                      context.read<IncomeCubit>().setIncomesData(state.income!.copyWith(copper: copperValueAsInt.toString()));
                      context.read<IncomeCubit>().readIncomesByCharID(charID);
                    },
                    color: Colors.brown,
                  ),
                  _IncomeContainer(
                    title: 'Silver',
                    value: state.income!.silver,
                    state: state,
                    charID: charID,
                    onLongPress: () => _showEditDialog(context, state.income!.silver, 'Silver', charID!, state),
                    onIncrement: () {
                      int? silverValueAsInt = int.tryParse(state.income!.silver ?? '0')! + 1;
                      context.read<IncomeCubit>().setIncomesData(state.income!.copyWith(silver: silverValueAsInt.toString()));
                      context.read<IncomeCubit>().readIncomesByCharID(charID);
                    },
                    onDecrement: () {
                      int? silverValueAsInt = int.tryParse(state.income!.silver ?? '0')! - 1;
                      context.read<IncomeCubit>().setIncomesData(state.income!.copyWith(silver: silverValueAsInt.toString()));
                      context.read<IncomeCubit>().readIncomesByCharID(charID);
                    },
                    color: Colors.grey,
                  ),
                  _IncomeContainer(
                    title: 'Electrum',
                    value: state.income!.electrum,
                    state: state,
                    charID: charID,
                    onLongPress: () => _showEditDialog(context, state.income!.electrum, 'Electrum', charID!, state),
                    onIncrement: () {
                      int? electrumValueAsInt = int.tryParse(state.income!.electrum ?? '0')! + 1;
                      context.read<IncomeCubit>().setIncomesData(state.income!.copyWith(electrum: electrumValueAsInt.toString()));
                      context.read<IncomeCubit>().readIncomesByCharID(charID);
                    },
                    onDecrement: () {
                      int? electrumValueAsInt = int.tryParse(state.income!.electrum ?? '0')! - 1;
                      context.read<IncomeCubit>().setIncomesData(state.income!.copyWith(electrum: electrumValueAsInt.toString()));
                      context.read<IncomeCubit>().readIncomesByCharID(charID);
                    },
                    color: const Color.fromARGB(255, 90, 87, 87),
                  ),
                  _IncomeContainer(
                    title: 'Gold',
                    value: state.income!.gold,
                    state: state,
                    charID: charID,
                    onLongPress: () => _showEditDialog(context, state.income!.gold, 'Gold', charID!, state),
                    onIncrement: () {
                      int? goldValueAsInt = int.tryParse(state.income!.gold ?? '0')! + 1;
                      context.read<IncomeCubit>().setIncomesData(state.income!.copyWith(gold: goldValueAsInt.toString()));
                      context.read<IncomeCubit>().readIncomesByCharID(charID);
                    },
                    onDecrement: () {
                      int? goldValueAsInt = int.tryParse(state.income!.gold ?? '0')! - 1;
                      context.read<IncomeCubit>().setIncomesData(state.income!.copyWith(gold: goldValueAsInt.toString()));
                      context.read<IncomeCubit>().readIncomesByCharID(charID);
                    },
                    color: const Color.fromARGB(255, 212, 196, 49),
                  ),
                  // const Icon(
                  //   Icons.attach_money,
                  //   size: 45,
                  // ),
                  _IncomeContainer(
                    title: 'Platinum',
                    value: state.income!.platinum,
                    state: state,
                    charID: charID,
                    onLongPress: () => _showEditDialog(context, state.income!.platinum, 'Platinum', charID!, state),
                    onIncrement: () {
                      int? platinumValueAsInt = int.tryParse(state.income!.platinum ?? '0')! + 1;
                      context.read<IncomeCubit>().setIncomesData(state.income!.copyWith(platinum: platinumValueAsInt.toString()));
                      context.read<IncomeCubit>().readIncomesByCharID(charID);
                    },
                    onDecrement: () {
                      {
                        int? platinumValueAsInt = int.tryParse(state.income!.platinum ?? '0')! - 1;
                        context.read<IncomeCubit>().setIncomesData(state.income!.copyWith(
                              platinum: platinumValueAsInt.toString(),
                            ));
                        context.read<IncomeCubit>().readIncomesByCharID(charID);
                      }
                    },
                    color: const Color(0xffe5e4e2),
                  )
                ]),
          ],
        );
      },
    );
  }
}

void _showEditDialog(BuildContext context, String? currentValue, String currencyType, String? charID, IncomeState incomeState) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        surfaceTintColor: backgroundColor,
        backgroundColor: backgroundColor,
        title: Text(
          'Edit $currencyType',
          style: dndFont,
        ),
        content: TextField(
          maxLength: 3,
          controller: TextEditingController(text: currentValue),
          keyboardType: TextInputType.number,
          onChanged: (newValue) {
            currentValue = newValue;
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              context.read<IncomeCubit>().setIncomesData(_updateIncome(incomeState.income!, currencyType, currentValue));
              context.read<IncomeCubit>().readIncomeData(charID!);
              context.pop();
            },
            child: Text(
              'Save',
              style: dndFont.copyWith(color: themeColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: dndFont.copyWith(color: themeColor),
            ),
          ),
        ],
      );
    },
  );
}

Income _updateIncome(Income income, String currencyType, String? value) {
  switch (currencyType) {
    case 'Copper':
      return income.copyWith(copper: value);
    case 'Silver':
      return income.copyWith(silver: value);
    case 'Electrum':
      return income.copyWith(electrum: value);
    case 'Gold':
      return income.copyWith(gold: value);
    case 'Platinum':
      return income.copyWith(platinum: value);
    default:
      return income;
  }
}

void _onPressedRatios(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          title: Column(
            children: [
              SelectableText(
                'Income Ratios:\n',
                style: TextStyle(fontSize: 22, color: white, fontWeight: FontWeight.bold),
              ),
              SelectableText(
                '• 100 copper (cp) = 1 silver (sp)\n\n'
                '• 10 silver (sp) = 1 gold (gp).\n\n'
                '• 2 electrum (ep) = 1 gold (gp)\n\n'
                '• 10 gold (gp) = 1 platinum (pp)',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 18, color: white),
              ),
            ],
          ),
          backgroundColor: themeColor,
          surfaceTintColor: themeColor,
          actions: [
            TextButton(
              child: Text(
                'Back',
                style: TextStyle(color: white),
              ),
              onPressed: () {
                context.pop();
              },
            ),
          ],
        ),
      ),
    ),
  );
}

class _IncomeContainer extends StatelessWidget {
  final String? title;
  final String? value;
  final IncomeState state;
  final String? charID;
  final void Function() onLongPress;
  final void Function() onIncrement;
  final void Function() onDecrement;
  final Color color;

  const _IncomeContainer({
    required this.title,
    required this.value,
    required this.state,
    required this.charID,
    required this.onLongPress,
    required this.onIncrement,
    required this.onDecrement,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: themeColor, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onLongPress: () => onLongPress(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SelectableText(title!),
            FaIcon(
              FontAwesomeIcons.coins,
              color: color,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => onDecrement(),
                  icon: const Icon(Icons.remove),
                ),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: SelectableText(
                      value!,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => onIncrement(),
                  icon: const Icon(
                    Icons.add,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
