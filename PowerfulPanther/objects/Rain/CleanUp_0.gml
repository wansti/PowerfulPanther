// Free raw memory streams instantly to prevent memory leaks when restarting rooms
part_type_destroy(rain_type);
part_emitter_destroy(rain_system, rain_emitter);
part_system_destroy(rain_system);