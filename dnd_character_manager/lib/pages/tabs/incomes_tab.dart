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

class _IncomesList extends StatelessWidget {
  final String? charID;
  const _IncomesList({required this.charID});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncomeCubit, IncomeState>(
      builder: (context, state) {
        return GridView(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Center(
                      child: SelectableText('100 copper (cp) = 1 silver (sp)\n\n'
                          '10 silver (sp) = 1 gold (gp)'),
                    ),
                    horizontalLine,
                  ],
                ),
              ),
              Center(
                child: SelectableText(
                  'Incomes\n',
                  style: dndFont.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Center(
                      child: SelectableText('2 electrum (ep) = 1 gold (gp)\n\n'
                          '10 gold (gp) = 1 platinum (pp)'),
                    ),
                    horizontalLine,
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: themeColor, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onLongPress: () => _showEditDialog(context, state.income!.copper, 'Copper', charID!, state),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SelectableText('Copper'),
                      const FaIcon(
                        FontAwesomeIcons.coins,
                        color: Colors.brown,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              int? copperValueAsInt = int.tryParse(state.income!.copper ?? '0')! - 1;
                              context.read<IncomeCubit>().setIncomesData(state.income!.copyWith(
                                    copper: copperValueAsInt.toString(),
                                  ));
                              context.read<IncomeCubit>().readIncomesByCharID(charID);
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          Flexible(
                            child: SelectableText(
                              state.income!.copper ?? '0',
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              int? copperValueAsInt = int.tryParse(state.income!.copper ?? '0')! + 1;
                              context.read<IncomeCubit>().setIncomesData(state.income!.copyWith(copper: copperValueAsInt.toString()));
                              context.read<IncomeCubit>().readIncomesByCharID(charID);
                            },
                            icon: const Icon(
                              Icons.add,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: themeColor, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onLongPress: () => _showEditDialog(context, state.income!.silver, 'Silver', charID!, state),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SelectableText('Silver'),
                      const FaIcon(
                        FontAwesomeIcons.coins,
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              int? silverValueAsInt = int.tryParse(state.income!.silver ?? '0')! - 1;
                              context.read<IncomeCubit>().setIncomesData(state.income!.copyWith(
                                    silver: silverValueAsInt.toString(),
                                  ));
                              context.read<IncomeCubit>().readIncomesByCharID(charID);
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          Flexible(
                            child: SelectableText(
                              state.income!.silver ?? '0',
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              int? silverValueAsInt = int.tryParse(state.income!.silver ?? '0')! + 1;
                              context.read<IncomeCubit>().setIncomesData(state.income!.copyWith(silver: silverValueAsInt.toString()));
                              context.read<IncomeCubit>().readIncomesByCharID(charID);
                            },
                            icon: const Icon(
                              Icons.add,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: themeColor, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onLongPress: () => _showEditDialog(context, state.income!.electrum, 'Electrum', charID!, state),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SelectableText('Electrum'),
                      const FaIcon(
                        FontAwesomeIcons.coins,
                        color: Color.fromARGB(255, 90, 87, 87),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              int? electrumValueAsInt = int.tryParse(state.income!.electrum ?? '0')! - 1;
                              context.read<IncomeCubit>().setIncomesData(state.income!.copyWith(
                                    electrum: electrumValueAsInt.toString(),
                                  ));
                              context.read<IncomeCubit>().readIncomesByCharID(charID);
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          Flexible(
                            child: SelectableText(
                              state.income!.electrum ?? '0',
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              int? electrumValueAsInt = int.tryParse(state.income!.electrum ?? '0')! + 1;
                              context.read<IncomeCubit>().setIncomesData(state.income!.copyWith(electrum: electrumValueAsInt.toString()));
                              context.read<IncomeCubit>().readIncomesByCharID(charID);
                            },
                            icon: const Icon(
                              Icons.add,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: themeColor, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onLongPress: () => _showEditDialog(context, state.income!.gold, 'Gold', charID!, state),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SelectableText('Gold'),
                      const FaIcon(
                        FontAwesomeIcons.coins,
                        color: Color.fromARGB(255, 212, 196, 49),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              int? goldValueAsInt = int.tryParse(state.income!.gold ?? '0')! - 1;
                              context.read<IncomeCubit>().setIncomesData(state.income!.copyWith(
                                    gold: goldValueAsInt.toString(),
                                  ));
                              context.read<IncomeCubit>().readIncomesByCharID(charID);
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          Flexible(
                            child: SelectableText(
                              state.income!.gold ?? '0',
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              int? goldValueAsInt = int.tryParse(state.income!.gold ?? '0')! + 1;
                              context.read<IncomeCubit>().setIncomesData(state.income!.copyWith(gold: goldValueAsInt.toString()));
                              context.read<IncomeCubit>().readIncomesByCharID(charID);
                            },
                            icon: const Icon(
                              Icons.add,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Icon(
                Icons.attach_money,
                size: 45,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: themeColor, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onLongPress: () => _showEditDialog(context, state.income!.platinum, 'Platinum', charID!, state),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SelectableText('Platinum'),
                      const FaIcon(
                        FontAwesomeIcons.coins,
                        color: Color(0xffe5e4e2),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              int? platinumValueAsInt = int.tryParse(state.income!.platinum ?? '0')! - 1;
                              context.read<IncomeCubit>().setIncomesData(state.income!.copyWith(
                                    platinum: platinumValueAsInt.toString(),
                                  ));
                              context.read<IncomeCubit>().readIncomesByCharID(charID);
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          Flexible(
                            child: SelectableText(
                              state.income!.platinum ?? '0',
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              int? platinumValueAsInt = int.tryParse(state.income!.platinum ?? '0')! + 1;
                              context.read<IncomeCubit>().setIncomesData(state.income!.copyWith(platinum: platinumValueAsInt.toString()));
                              context.read<IncomeCubit>().readIncomesByCharID(charID);
                            },
                            icon: const Icon(
                              Icons.add,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]);
      },
    );
  }
}

void _showEditDialog(BuildContext context, String? currentValue, String currencyType, String? charID, IncomeState incomeState) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: SelectableText(
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
            child: SelectableText(
              'Save',
              style: dndFont.copyWith(color: themeColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: SelectableText(
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
