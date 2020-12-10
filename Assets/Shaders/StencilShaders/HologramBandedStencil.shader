Shader "ShaderPractice/HologramBandedStencilObject"
{
    Properties
    {
        _RimColor ("Rim Color", Color) = (0, 0.5, 0.5, 0)
        _RimPower ("Rim Power", Range(0.5, 8.0)) = 3.0
        _RimIntensity ("Rim Intensity", Range(0, 20)) = 10.0
        _FractionMultiplier ("Fraction Multiplier", Range(0, 10)) = 1.0
        _Divisor ("Divisor", Range(0, 10)) = 0.5

        _SRef("Stencil Ref", Float) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)] _SComp("Stencil Compare", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)] _SOp("Stencil Operation", Float) = 2
    }
    SubShader
    {
        Tags
        {
            "Queue" = "Transparent"
        }

        Pass
        {
            ZWrite On
            ColorMask 0
        }

        Stencil
        {
            Ref [_SRef]
            Comp [_SComp]
            Pass [_SOp]
        }

        CGPROGRAM
        #pragma surface surf Lambert alpha:fade

        float4 _RimColor;
        float _RimPower;
        half _RimIntensity;
        half _FractionMultiplier;
        half _Divisor;

        struct Input
        {
            float3 viewDir;
            float3 worldPos;
        };


        void surf(Input IN, inout SurfaceOutput o)
        {
            half dotProd = dot(normalize(IN.viewDir), o.Normal);
            half rim = 1.0 - saturate(dotProd);
            half fraction = frac(IN.worldPos.y * _FractionMultiplier * _Divisor);

            o.Emission = _RimColor.rgb * pow(rim, _RimPower) * _RimIntensity;
            o.Alpha = pow(rim, _RimPower) * fraction;
        }
        ENDCG
    }
    FallBack "Diffuse"
}