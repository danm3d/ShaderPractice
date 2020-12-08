using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RandomRotation : MonoBehaviour
{
	[SerializeField] private float rotationSpeed = 0.25f;
	[SerializeField] private Vector3 rotationEuler;

	void Update()
	{
		transform.Rotate(rotationEuler * rotationSpeed, Space.Self);
	}
}
