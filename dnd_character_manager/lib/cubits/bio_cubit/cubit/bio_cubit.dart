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
        super(const BioInitial());

  Future<void> bioEdit(bool bioEdit) async {
    emit(state.copyWith(bioEdit: bioEdit));
  }

  Future<void> readBioData(String charID) async {
    final Bio bio = await dndService.readBioData(charID: charID);
    emit(state.copyWith(bio: bio));
  }

  Future<void> setBioData(Bio bio) async {
    emit(state.copyWith(bio: bio));
    await dndService.setBioData(bio: bio);
  }
}
