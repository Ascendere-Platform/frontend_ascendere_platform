// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postulacion_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquipoRegister _$EquipoRegisterFromJson(Map<String, dynamic> json) =>
    EquipoRegister(
      id: json['id'] as String,
      asignaturaId: json['asignaturaId'] as String?,
      cargo: json['cargo'] as String?,
    );

Map<String, dynamic> _$EquipoRegisterToJson(EquipoRegister instance) =>
    <String, dynamic>{
      'id': instance.id,
      'asignaturaId': instance.asignaturaId,
      'cargo': instance.cargo,
    };
