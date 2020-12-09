using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class SimpleDragger : MonoBehaviour
{
    [SerializeField] private Camera screenCamera;
    private float currentZ;
    private Vector3 worldMousePos;
    private Vector2 screenMousePos;

    private void Start()
    {
        currentZ = transform.position.z;
    }
}