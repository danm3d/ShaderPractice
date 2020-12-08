Shader "ShaderPractice/Hologram Banded"
{
	Properties
	{
		_RimColor ("Rim Color", Color) = (0, 0.5, 0.5, 0)
		_RimPower ("Rim Power", Range(0.5, 8.0)) = 3.0
		_RimIntensity ("Rim Intensity", Range(0, 20)) = 10.0
		// Favor 1 color over the other
		_ColorBias ("Bias", Range(0.0, 1.0)) = 0.5
		// TODO: Maybe rename because multiplier doesn't really make sense in this instance
		_FractionMultiplier ("Fraction Multiplier", Range(0, 10)) = 1.0
		_Divisor ("Divisor", Range(0, 10)) = 0.5
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
		
		CGPROGRAM
		#pragma surface surf Lambert alpha:fade
		
		float4 _RimColor;
		float _RimPower;
		half _RimIntensity;
		half _ColorBias;
		half _FractionMultiplier;
		half _Divisor;

		struct Input
		{
			float3 viewDir;
			float3 worldPos;
		};
		

		void surf (Input IN, inout SurfaceOutput o)
		{
			half dotProd = dot (normalize(IN.viewDir), o.Normal);
			half rim = 1.0 - saturate(dotProd);
			half fraction = frac(IN.worldPos.y * _FractionMultiplier * _Divisor);

			o.Emission = _RimColor.rgb * pow(rim, _RimPower) * _RimIntensity;
			o.Alpha = pow(rim, _RimPower) * fraction;
		}
		ENDCG
	}
	FallBack "Diffuse"
}