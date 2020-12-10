Shader "ShaderPractice/MyLambert"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags
        {
            "Queue" = "Geometry"
        }
        
        CGPROGRAM
        #pragma surface surf MyLambert

        // SurfaceOutput s = the output of the surf method
        // lightDir = light direction
        // atten = light intensity when it hits the surface
        half4 LightingMyLambert(SurfaceOutput s, half3 lightDir, half atten)
        {
            // work out the dot prod of the surface normals and the lightDir
            half NdotL = dot(s.Normal, lightDir);
            half4 color;
            color.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
            color.a = s.Alpha;
            return color;
        }

        float4 _Color;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}