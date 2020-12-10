using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MeshData : MonoBehaviour
{
    private Mesh mesh;

    void Start()
    {
        var meshFilter = GetComponent<MeshFilter>();
        if (meshFilter == null)
        {
            return;
        }

        mesh = meshFilter.mesh;
        var verts = mesh.vertices;
        if (verts == null || verts.Length <= 0)
        {
            return;
        }

        foreach (var vert in verts)
        {
            Debug.Log(vert);
        }
    }

    void Update()
    {
    }
}