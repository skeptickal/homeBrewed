import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constants/theme_data.dart';
import '../../cubits/income_cubit/income_cubit.dart';

class IncomesTab extends StatelessWidget {
  final String charID;
  const IncomesTab({super.key, required this.charID});

  @override
  Widget build(BuildContext context) {
    context.read<IncomeCubit>().readIncomeData(charID);
    return SingleChildScrollView(
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
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              children: [
                const Center(
                  child: Text('100 copper (cp) = 1 silver (sp)\n\n'
                      '10 silver (sp) = 1 gold (gp)'),
                ),
                Center(
                  child: Text(
                    'Incomes\n',
                    style: dndFont.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Center(
                  child: Text('2 electrum (ep) = 1 gold (gp)\n\n'
                      '10 gold (gp) = 1 platinum (pp)'),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: themeColor, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onLongPress: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Copper'),
                        const FaIcon(
                          FontAwesomeIcons.coins,
                          color: Colors.brown,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                child: TextField(
                              enabled: false,
                              controller: TextEditingController(text: state.income!.copper ?? '0'),
                              style: const TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '0',
                                hintStyle: TextStyle(fontSize: 18),
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                              ),
                            )),
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
                    onLongPress: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Silver'),
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
                                child: TextField(
                              enabled: false,
                              controller: TextEditingController(text: state.income!.silver ?? '0'),
                              style: const TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '0',
                                hintStyle: TextStyle(fontSize: 18),
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                              ),
                            )),
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
                    onLongPress: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Electrum'),
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
                                child: TextField(
                              enabled: false,
                              controller: TextEditingController(text: state.income!.electrum ?? '0'),
                              style: const TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '0',
                                hintStyle: TextStyle(fontSize: 18),
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                              ),
                            )),
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
                    onLongPress: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Gold'),
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
                                child: TextField(
                              enabled: false,
                              controller: TextEditingController(text: state.income!.gold ?? '0'),
                              style: const TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '0',
                                hintStyle: TextStyle(fontSize: 18),
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                              ),
                            )),
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
                    onLongPress: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Platinum'),
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
                                child: TextField(
                              enabled: false,
                              controller: TextEditingController(text: state.income!.platinum ?? '0'),
                              style: const TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '0',
                                hintStyle: TextStyle(fontSize: 18),
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                              ),
                            )),
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
              ]),
        );
      },
    );
  }
}
