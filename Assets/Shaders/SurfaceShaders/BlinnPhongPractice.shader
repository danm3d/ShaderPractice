Shader "ShaderPractice/BlinnPhongPractice"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        // Already defined in the Unity includes when the shader compiles, 
        // so no need to add it in the CGPROGRAM
        _SpecColor("Specular Color", Color) = (1,1,1,1)
        _Spec("Specular", Range(0, 1)) = 0.5
        _Gloss("Gloss", Range(0, 1)) = 0.5
    }
    SubShader
    {
        Tags
        {
            "Queue"="Geometry"
        }
        
        CGPROGRAM
        #pragma surface surf BlinnPhong

        float4 _Color;
        half _Spec;
        fixed _Gloss;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color.rgb;
            o.Specular = _Spec;
            o.Gloss = _Gloss;
        }
        ENDCG
    }
    FallBack "Diffuse"
}