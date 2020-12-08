using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Renderer))]
public class ShaderControl : MonoBehaviour
{
    [SerializeField] private string decalMaskToggleName = "_EnableMask";

    private bool isEnabled = false;
    private Renderer rend;
    private Material mat;

    private void Awake()
    {
        rend = GetComponent<Renderer>();
        if (rend != null)
        {
            mat = rend.sharedMaterial;
        }

        isEnabled = mat.GetFloat(decalMaskToggleName) > 0;
    }

    private void OnMouseDown()
    {
        isEnabled = !isEnabled;
        if (mat != null)
        {
            mat.SetFloat(decalMaskToggleName, isEnabled ? 1f : 0f);
        }
    }
}