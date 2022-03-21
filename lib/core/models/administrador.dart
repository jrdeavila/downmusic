// ignore_for_file: overridden_fields


import 'package:downmusic/core/models/usuario.dart';

class Administrador extends Usuario {
  @override
  final String nombres, apellidos, email, telefono, usuarioId;
  @override
  final Identificacion identificacion;

  Administrador({
    required this.nombres,
    required this.apellidos,
    required this.identificacion,
    required this.email,
    required this.telefono,
    required this.usuarioId,
  }) : super(
          nombres: nombres,
          apellidos: apellidos,
          telefono: telefono,
          identificacion: identificacion,
          usuarioId: usuarioId,
        );
}
