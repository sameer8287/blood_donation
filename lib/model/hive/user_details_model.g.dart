// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDetailsModelAdapter extends TypeAdapter<UserDetailsModel> {
  @override
  final int typeId = 0;

  @override
  UserDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDetailsModel(
      firstName: fields[0] as String,
      lastName: fields[1] as String,
      dob: fields[2] as String,
      country: fields[3] as String,
      state: fields[4] as String,
      city: fields[5] as String,
      gender: fields[6] as String,
      bloodGroup: fields[7] as String,
      covid19: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserDetailsModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.dob)
      ..writeByte(3)
      ..write(obj.country)
      ..writeByte(4)
      ..write(obj.state)
      ..writeByte(5)
      ..write(obj.city)
      ..writeByte(6)
      ..write(obj.gender)
      ..writeByte(7)
      ..write(obj.bloodGroup)
      ..writeByte(8)
      ..write(obj.covid19);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
