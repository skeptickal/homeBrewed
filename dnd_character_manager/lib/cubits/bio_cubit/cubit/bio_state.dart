part of 'bio_cubit.dart';

@immutable
class BioState extends Equatable {
  final Bio? bio;
  final bool? bioEdit;

  const BioState({this.bio, this.bioEdit});

  BioState copyWith({bio, bioEdit}) {
    return BioState(bio: bio ?? this.bio, bioEdit: bioEdit ?? this.bioEdit);
  }

  @override
  List<Object?> get props => [bio, bioEdit];
}

final class BioInitial extends BioState {
  const BioInitial()
      : super(
            bio: const Bio(
              alignment: 'Neutral',
              background: 'test',
              personality: 'test personality',
              flaws: 'test flaws',
              bonds: 'test bonds',
            ),
            bioEdit: false);
}
