@tool
extends EditorScript

func _run():
	var editorInterface = get_editor_interface()

	var selectedNodes = editorInterface.get_selection().get_selected_nodes()

	if selectedNodes.size() == 0:
		print("No node selected.")
		return

	var selectedNode = selectedNodes[0]

	if selectedNode is MultiMeshInstance3D:
		var multiMeshInstance = selectedNode as MultiMeshInstance3D
 
		multiMeshInstance.multimesh.instance_count = multiMeshInstance.get_child_count()

		# Iterate through child nodes
		for i in range(multiMeshInstance.multimesh.instance_count):
			var child = multiMeshInstance.get_child(i)
			if child is MeshInstance3D:
				var meshInstance = child as MeshInstance3D

				# Set the transform and custom data for each instance
				multiMeshInstance.multimesh.set_instance_transform(i, meshInstance.global_transform)
				multiMeshInstance.multimesh.set_instance_custom_data(i, Color(1, 1, 1, 1))  # Set custom data as needed

				# Set the mesh for the whole MultiMesh
				if i == 0:
					multiMeshInstance.multimesh.mesh = meshInstance.mesh

		print("Converted nodes to MultiMeshInstance3D.")
	else:
		print("Selected node is not a MultiMeshInstance3D.")
