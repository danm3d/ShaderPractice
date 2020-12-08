Shader "ShaderPractice/Blend Test"
{
    Properties
    {
        _Texture ("Texture 1", 2D) = "black" {}
    }
    SubShader
    {
        Tags { "Queue" = "Transparent" }
        Blend SrcAlpha OneMinusSrcAlpha
        Cull Off
        Pass
        {
            SetTexture [_Texture] {combine texture}
        }
    }
}