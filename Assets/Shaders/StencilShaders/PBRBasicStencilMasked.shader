Shader "ShaderPractice/PBR Basic Stencil Object"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MetallicTex ("Metallic Texture", 2D) = "white" {}
        _Metallic("Metallic", Range(0.0, 1.0)) = 0.0
        _NormalMap ("Normal Map", 2D) = "bump" {} // "bump" needs to be defined here to indicate it's not a regular texture
        _NormalIntensity ("Normal Amount", Range(0, 10)) = 1
        
         _SRef("Stencil Ref", Float) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)] _SComp("Stencil Compare", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)] _SOp("Stencil Operation", Float) = 2
    }
    SubShader
    {
        Tags
        {
            "Queue"="Geometry"
        }
        
        Stencil
        {
            Ref [_SRef]
            Comp [_SComp]
            Pass [_SOp]
        }
        
        CGPROGRAM
        #pragma surface surf Standard

        fixed4 _Color;
        half _Metallic;
        sampler2D _MetallicTex;
        sampler2D _NormalMap;
        half _NormalIntensity;
        
        struct Input
        {
            float2 uv_MetallicTex;
            float2 uv_NormalMap;
        };

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = _Color.rgb;
            // 1 - makes it "roughness" as per Blender
            o.Smoothness = tex2D(_MetallicTex, IN.uv_MetallicTex).rgb;
            o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap)) * float3(_NormalIntensity, _NormalIntensity, 1);
            o.Metallic = _Metallic;
        }
        ENDCG
    }
    FallBack "Diffuse"
}