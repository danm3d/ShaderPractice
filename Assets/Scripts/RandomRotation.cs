using UnityEngine;

public class RandomRotation : MonoBehaviour
{
    [SerializeField] private float rotationSpeed = 0.25f;
    [SerializeField] private float randomRange = 10f;
    [SerializeField] private Vector3 rotationEuler;

    private void Start()
    {
        float randomX = Random.Range(-randomRange, randomRange);
        float randomY = Random.Range(-randomRange, randomRange);
        float randomZ = Random.Range(-randomRange, randomRange);

        rotationEuler = new Vector3(randomX, randomY, randomZ);
    }

    void Update()
    {
        transform.Rotate(rotationEuler * rotationSpeed, Space.Self);
    }
}