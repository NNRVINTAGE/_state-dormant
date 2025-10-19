extends StaticBody3D
@export var obj: Node
@export var objmtr: Node
@export var changed_material: Material

func Interact():
	if objmtr and objmtr.has_method("Changes"):
		objmtr.Changes(changed_material)
	
	if obj and obj.has_method("targetTransform"):
		obj.targetTransform(Vector3(0.673,4.707,0.0), Vector3(0.0,0.0,-89.0))
