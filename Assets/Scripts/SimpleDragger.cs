using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class SimpleDragger : MonoBehaviour
{
	private float currentZ;
	private Vector3 worldMousePos;
	private void Start()
	{
		currentZ = transform.position.z;
	}
	private void OnMouseDown()
	{
		Debug.Log($"{gameObject.name} mouse down.");
	}
	private void OnMouseDrag()
	{
		Debug.Log($"{gameObject.name} mouse drag.");
		worldMousePos = Camera.main.ScreenToWorldPoint(Input.mousePosition);
		transform.position = new Vector3(worldMousePos.x, worldMousePos.y, currentZ);
	}

	private void OnMouseUp()
	{
		Debug.Log($"{gameObject.name} mouse up.");

	}
}
