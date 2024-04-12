// ignore_for_file: file_names

import 'package:bloc/bloc.dart';
import 'package:homeBrewed/service/dnd_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/item.dart';

part 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  final DndService dndService;

  ItemCubit({DndService? dndService})
      : dndService = dndService ?? DndService(),
        super(
          ItemInitial(),
        );

  Future<void> setItemsData(Item item) async {
    await dndService.setItemsData(item: item);
  }

  Future<void> readItemsByCharID(String? charID) async {
    try {
      final List<Item> items = await dndService.readItemsByCharID(charID: charID);
      emit(state.copyWith(items: items));
    } catch (e) {
      print('error reading items from state');
    }
  }

  Future<void> deleteItemByItemID(String itemID) async {
    await dndService.deleteItemByItemID(itemID: itemID);
  }
}
