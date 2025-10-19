extends MeshInstance3D

func Changes(new_material_path: Material):
	#var material = load(new_material_path)
	if new_material_path:
		set_surface_override_material(0, new_material_path)
	else:
		print("Failed to load material: ", new_material_path)
