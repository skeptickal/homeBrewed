// ignore_for_file: file_names

part of 'item_cubit.dart';

@immutable
class ItemState extends Equatable {
  final List<Item>? items;

  const ItemState({
    required this.items,
  });

  ItemState copyWith({items, currentSelectedItem}) {
    return ItemState(items: items ?? this.items);
  }

  @override
  List<Object?> get props => [items];
}

final class ItemInitial extends ItemState {
  ItemInitial()
      : super(
          items: [],
        );
}
