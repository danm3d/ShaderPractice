Shader "ShaderPractice/PBRBasic"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MetallicTex ("Metallic Texture", 2D) = "white" {}
        _Metallic("Metallic", Range(0.0, 1.0)) = 0.0

    }
    SubShader
    {
        Tags
        {
            "Queue"="Geometry"
        }
        
        CGPROGRAM
        #pragma surface surf Standard

        fixed4 _Color;
        half _Metallic;
        sampler2D _MetallicTex;

        struct Input
        {
            float2 uv_MetallicTex;
        };

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = _Color.rgb;
            // 1 - makes it "roughness" as per Blender
            o.Smoothness = tex2D(_MetallicTex, IN.uv_MetallicTex).rgb;
            o.Metallic = _Metallic;
        }
        ENDCG
    }
    FallBack "Diffuse"
}