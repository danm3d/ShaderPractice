Shader "ShaderPractice/PracticeShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _EmissionColor ("Emission Color", Color) = (0,0,0,1)
        _Range ("Alpha", Range(0,5)) = 1
        _Texture ("Texture 1", 2D) = "white" {}
        _CubeMap ("Cube Map", CUBE) = "" {}
        _MyFloat ("Float Test", Float) = 0.5
        _MyVector ("Vec Test", Vector) = (0.5,1,1,1)
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        fixed4 _Color;
        fixed4 _EmissionColor;
        half _Range;
        sampler2D _Texture;
        samplerCUBE _CubeMap;

        struct Input
        {
            float2 uv_Texture;
            float3 viewDir;
            float3 worldRefl;
        };
        

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = (tex2D(_Texture, IN.uv_Texture) * _Color).rgb;
            o.Emission = texCUBE(_CubeMap, IN.worldRefl).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}