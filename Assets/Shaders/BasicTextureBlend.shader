Shader "ShaderPractice/Basic Texture Blend"
{
    Properties
    {
        _MainTex ("Main Texture", 2D) = "white" {}
        _Decal ("Decal Texture", 2D) = "white" {}
        [Toggle] _EnableMask("Enable Mask", Float) = 1
    }
    SubShader
    {
        Tags
        {
            "Queue" = "Geometry"
        }

        CGPROGRAM
        #pragma surface surf Lambert

        struct Input
        {
            float2 uv_MainTex;
        };

        sampler2D _MainTex;
        sampler2D _Decal;
        float _EnableMask;

        void surf(Input IN, inout SurfaceOutput o)
        {
            fixed4 a = tex2D(_MainTex, IN.uv_MainTex);
            fixed4 b = tex2D(_Decal, IN.uv_MainTex) * _EnableMask;
            o.Albedo = b.r > 0.9 ? b.rgb : a.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}