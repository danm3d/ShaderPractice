Shader "ShaderPractice/PBR Basic Specular (Roughness)"
{
    Properties
    {
        _Color ("Albedo Color", Color) = (1,1,1,1)
        _SpecColor("Specular Color", Color) = (1,1,1,1)
        _RoughnessMap ("Roughness Map", 2D) = "white" {}
        _Specular("Specular Intensity", Range(0.0, 1.0)) = 0.0
        
        _EmissionIntensity("Emission Intensity", Range(0,5)) = 0

    }
    SubShader
    {
        Tags
        {
            "Queue" = "Geometry"
        }
        
        CGPROGRAM
        #pragma surface surf StandardSpecular

        fixed4 _Color;
        half _Specular;
        half _EmissionIntensity;
        sampler2D _RoughnessMap;

        struct Input
        {
            float2 uv_RoughnessMap;
        };

        void surf(Input IN, inout SurfaceOutputStandardSpecular o)
        {
            o.Albedo = _Color.rgb;
            // 1 - makes it "roughness" as per Blender
            o.Smoothness = (1 - tex2D(_RoughnessMap, IN.uv_RoughnessMap)).rgb;
            o.Specular = _SpecColor.rgb;
            o.Emission = tex2D(_RoughnessMap, IN.uv_RoughnessMap).rgb * _EmissionIntensity;
        }
        ENDCG
    }
    FallBack "Diffuse"
}