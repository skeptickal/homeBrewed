part of 'bio_cubit.dart';

@immutable
class BioState extends Equatable {
  final Bio? bio;
  final bool? bioEdit;
  final List<Bio> bios;

  const BioState({this.bio, this.bioEdit, required this.bios});

  BioState copyWith({bio, bioEdit, bios}) {
    return BioState(bio: bio ?? this.bio, bioEdit: bioEdit ?? this.bioEdit, bios: bios ?? this.bios);
  }

  @override
  List<Object?> get props => [bio, bioEdit, bios];
}

final class BioInitial extends BioState {
  BioInitial()
      : super(
            bios: [
              const Bio(
                alignment: 'Neutral',
                background: 'test',
                personality: 'test personality',
                flaws: 'test flaws',
                bonds: 'test bonds',
              ),
            ],
            bio: const Bio(
              alignment: 'Neutral',
              background: 'test',
              personality: 'test personality',
              flaws: 'test flaws',
              bonds: 'test bonds',
            ),
            bioEdit: false);
}
