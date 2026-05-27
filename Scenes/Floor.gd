extends StaticBody3D

func resize(x,z):
	$FloorCollisionShape.shape.size.x = x
	$FloorCollisionShape.shape.size.z = z
	$FloorCollisionShape.position.x = x*0.5
	$FloorCollisionShape.position.z = z*0.5
	$MeshInstance3D.mesh.size.x = x
	$MeshInstance3D.mesh.size.z = z
	$MeshInstance3D.position.x = x*0.5
	$MeshInstance3D.position.z = z*0.5
