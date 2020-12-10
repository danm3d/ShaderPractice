using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SimpleRotator : MonoBehaviour
{
    [SerializeField] private Vector3 rotationVector;
    
    private void LateUpdate()
    {
        transform.Rotate(rotationVector);
    }
}