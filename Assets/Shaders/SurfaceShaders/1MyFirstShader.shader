Shader "ShaderPractice/MyFirstShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _EmissionColor ("Emission Color", Color) = (0,0,0,1)
        _Normal ("Normal", Color) = (0,1,0,1)
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input
        {
            float2 uvMainTex;
        };
        
        fixed4 _Color;
        fixed4 _EmissionColor;
        fixed4 _Normal;

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color.rgb;
            o.Emission = _EmissionColor.rgb;
            o.Normal = _Normal.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}