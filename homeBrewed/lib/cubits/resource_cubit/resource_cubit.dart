import 'package:bloc/bloc.dart';
import 'package:homeBrewed/models/resource.dart';
import 'package:homeBrewed/service/dnd_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'resource_state.dart';

class ResourceCubit extends Cubit<ResourceState> {
  final DndService dndService;

  ResourceCubit({DndService? dndService})
      : dndService = dndService ?? DndService(),
        super(
          ResourceInitial(),
        );

  Future<void> resourceEdit(bool resourceEdit) async {
    emit(state.copyWith(resourceEdit: resourceEdit));
  }

  // Future<void> readResourceData(String charID) async {
  //   final Resource resource = await dndService.readResourcesData(charID: charID);
  //   emit(state.copyWith(resource: resource));
  // }

  Future<void> setResourcesData(Resource resource) async {
    await dndService.setResourcesData(resource: resource);
    //emit(state.copyWith(resources: [...?state.resources, resource]));
  }

  Future<void> readResourcesByCharID(String? charID) async {
    try {
      final List<Resource> resources = await dndService.readResourcesByCharID(charID: charID);
      emit(state.copyWith(resources: resources));
    } catch (e) {
      print('error reading resources from state');
    }
  }

  Future<void> deleteResourceByResourceID(String resourceID) async {
    await dndService.deleteResourceByResourceID(resourceID: resourceID);
  }
}
