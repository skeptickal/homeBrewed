import 'package:bloc/bloc.dart';
import 'package:dnd_character_manager/models/bio.dart';
import 'package:dnd_character_manager/service/dnd_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'bio_state.dart';

class BioCubit extends Cubit<BioState> {
  final DndService dndService;

  BioCubit({DndService? dndService})
      : dndService = dndService ?? DndService(),
        super(BioInitial());

  Future<void> bioEdit(bool bioEdit) async {
    emit(state.copyWith(bioEdit: bioEdit));
  }

  Future<void> readBioData(String charID) async {
    final Bio bio = await dndService.readBioData(charID: charID);
    emit(state.copyWith(bio: bio));
  }

  Future<void> setBioData(Bio bio) async {
    emit(state.copyWith(bio: bio, bios: [...state.bios, bio]));
    await dndService.setBioData(bio: bio);
  }

  Future<void> readBiosByUserID(String? userID) async {
    try {
      final List<Bio> bios = await dndService.readBiosUserID(userID: userID);
      emit(state.copyWith(bios: bios));
    } catch (e) {
      print('error reading characters from state');
    }
  }

  Future<void> deleteBiosByCharID(String charID) async {
    await dndService.deleteDocumentByName(charID: charID);
  }
}
