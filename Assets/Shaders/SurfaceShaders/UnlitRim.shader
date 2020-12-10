Shader "ShaderPractice/UnlitRim"
{
    Properties
    {
        _RimColor ("Rim Color", Color) = (0, 0.5, 0.5, 0.0)
        _Exponent ("Exponent", Range(0.25, 8.0)) = 1.0
        _RimCutoff ("Rim Cutoff", Range(0.0,1.0)) = 0.0
        _Color1 ("Color 1", Color) = (0,1,0,1)
        _Color2 ("Color 2", Color) = (0,0,1,1)
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input
        {
            float3 viewDir;
            float3 worldPos;
        };

        float4 _RimColor;
        half _Exponent;
        half _RimCutoff;

        void surf (Input IN, inout SurfaceOutput o)
        {
            half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
            // Color ramp esque
            o.Emission = _RimColor.rgb * rim > _RimCutoff ? pow(rim, _Exponent) : 0;
        }
        ENDCG
    }
    FallBack "Diffuse"
}