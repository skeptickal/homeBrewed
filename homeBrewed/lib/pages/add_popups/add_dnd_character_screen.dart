import 'package:homeBrewed/constants/spacing.dart';
import 'package:homeBrewed/constants/text_fields.dart';
import 'package:homeBrewed/constants/theme_data.dart';
import 'package:homeBrewed/cubits/income_cubit/income_cubit.dart';
import 'package:homeBrewed/cubits/user_cubit/user_cubit.dart';
import 'package:homeBrewed/cubits/notes_cubit/cubit/notes_cubit.dart';
import 'package:homeBrewed/models/bio.dart';
import 'package:homeBrewed/models/income.dart';
import 'package:homeBrewed/models/notes.dart';
import 'package:homeBrewed/models/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../cubits/bio_cubit/cubit/bio_cubit.dart';
import '../../cubits/stat_cubit/cubit/stat_cubit.dart';

class AddDndCharacterScreen extends StatelessWidget {
  const AddDndCharacterScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController race = TextEditingController();
    TextEditingController dndClass = TextEditingController();

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        return BlocBuilder<BioCubit, BioState>(
          builder: (context, state) {
            return Form(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    CustomTextBox(
                      padding: const EdgeInsets.all(6),
                      controller: name,
                      hintText: 'Enter Your Character\'s name',
                      subtitle: 'Enter Your Character\'s name',
                      obscureText: false,
                    ),
                    Stack(children: [
                      CustomTextBox(
                        padding: const EdgeInsets.all(6),
                        controller: race,
                        hintText: 'Enter Your Character\'s race',
                        subtitle: 'Enter Your Character\'s race',
                        obscureText: false,
                      ),
                      // Positioned(
                      //   right: 0,
                      //   top: 0,
                      //   bottom: 0,
                      //   child: IconButton(
                      //     onPressed: () => _showPostEditPanel(context),
                      //     icon: const Icon(Icons.menu),
                      //   ),
                      // ),
                    ]),
                    CustomTextBox(
                      padding: const EdgeInsets.all(6),
                      controller: dndClass,
                      hintText: 'Enter Your Character\'s class',
                      subtitle: 'Enter Your Character\'s class',
                      obscureText: false,
                    ),
                    seperation,
                    seperation,
                    seperation,
                    TextButton(
                      onPressed: () => _addCharacter(context, userState, name.text, race.text, dndClass.text),
                      child: Text(
                        'Add Character',
                        style: dndFont.copyWith(color: black, fontSize: 18),
                      ),
                    ),
                    TextButton(
                        onPressed: () => context.pop(),
                        child: Text(
                          'Cancel',
                          style: dndFont.copyWith(color: black, fontSize: 18),
                        ))
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _addCharacter(BuildContext context, UserState userState, String name, String race, String dndClass) {
    //initialize bio data for new character
    const uuid = Uuid();
    Bio newDndCharacter = Bio(
      charID: uuid.v4(),
      userID: userState.myUser!.userID!,
      race: race,
      name: name,
      dndClass: dndClass,
      alignment: 'Select an Alignment',
    );
    context.read<BioCubit>().setBioData(newDndCharacter);

    //initialize stats for new character
    Stats newStats = Stats(charID: newDndCharacter.charID);
    context.read<StatCubit>().setStatsData(newStats);

    //initialize notes for new character
    Notes newNotes = Notes(charID: newDndCharacter.charID);
    context.read<NotesCubit>().setNotesData(newNotes);

    //initialize income for new character
    Income newIncomes = Income(
      charID: newDndCharacter.charID,
      gold: '0',
      platinum: '0',
      copper: '0',
      electrum: '0',
      silver: '0',
    );
    context.read<IncomeCubit>().setIncomesData(newIncomes);

    context.pop();
  }
}

// class _DndRaceOptions extends StatelessWidget {
//   _DndRaceOptions({super.key});

//     Future<List<String>> getRaceData() async {
//     http.Client client = http.Client();
//     Uri url = Uri.http('dnd5eapi.co', '/api/races');
//     var response = await client.get(url);

//     if (response.statusCode == 200) {
//       dynamic data = jsonDecode(response.body);
//       if (data is Map<String, dynamic> && data['results'] is List) {
//         return List<String>.from(data['results'].map((race) => race['name']));
//       }
//     } else {
//       throw Exception('Failed to load race data');
//     }
//     return [];
//   }

//   @override
//   Widget build(BuildContext context) {
//     getRaceData();
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
//       child: DropdownButtonFormField<String>(
//         value: 'Select an Alignment',
//         items:.map((alignment) {
//           return DropdownMenuItem<String>(
//             value: alignment,
//             child: Text(alignment),
//           );
//         }).toList(),
//         onChanged: (String? value) {},
//         decoration: dndFieldInputDecoration(enabled: true, hintText: 'Select an Alignment'),
//       ),
//     );
//   }
// }

// void _showPostEditPanel(BuildContext context) {
//   showDialog(
//     barrierDismissible: true,
//     context: context,
//     builder: (context) => Center(
//       child: SingleChildScrollView(
//         child: AlertDialog(
//           surfaceTintColor: backgroundColor,
//           backgroundColor: backgroundColor,
//           title: _DndRaceOptions(),
//         ),
//       ),
//     ),
//   );
// }
