part of 'resource_cubit.dart';

@immutable
class ResourceState extends Equatable {
  final Resource? resource;
  final bool? resourceEdit;
  final List<Resource>? resources;

  const ResourceState({this.resource, this.resourceEdit, required this.resources});

  ResourceState copyWith({resource, resourceEdit, resources}) {
    return ResourceState(resource: resource ?? this.resource, resourceEdit: resourceEdit ?? this.resourceEdit, resources: resources ?? this.resources);
  }

  @override
  List<Object?> get props => [resource, resourceEdit, resources];
}

final class ResourceInitial extends ResourceState {
  ResourceInitial()
      : super(
          resources: [],
          resource: null,
          resourceEdit: false,
        );
}
