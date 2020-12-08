Shader "ShaderPractice/Fraction Bands"
{
    Properties
    {
        _Color1 ("Color 1", Color) = (0,1,0,1)
        _Color2 ("Color 2", Color) = (0,0,1,1)
        
        // Favor 1 color over the other
        _ColorBias ("Bias", Range(0.0, 1.0)) = 0.5
        // TODO: Maybe rename because multiplier doesn't really make sense in this instance
        _FractionMultiplier ("Fraction Multiplier", Range(0, 10)) = 1.0
        _Divisor ("Divisor", Range(0, 10)) = 0.5
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

        half _ColorBias;
        half _FractionMultiplier;
        half _Divisor;

        float4 _Color1;
        float4 _Color2;

        void surf (Input IN, inout SurfaceOutput o)
        {
            half rim = saturate(dot(normalize(IN.viewDir), o.Normal));
            
            half fraction = frac(IN.worldPos.y * _FractionMultiplier * _Divisor);
            o.Emission = fraction > _ColorBias ? _Color1 * rim : _Color2 * rim;
        }
        ENDCG
    }
    FallBack "Diffuse"
}