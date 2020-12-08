Shader "ShaderPractice/My Blinn"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        // Testing what the power of 48 is supposed to do.
        // Looks like it just changes the "sharpness" of surface reflections.
        _ExponentTest("Exponent Test", Range(0.0, 48.0)) = 48.0
    }
    SubShader
    {
        Tags
        {
            "Queue" = "Geometry"
        }
        
        CGPROGRAM
        #pragma surface surf MyBlinn
        
        float4 _Color;
        fixed _ExponentTest;
        // SurfaceOutput s = the output of the surf method
        // lightDir = light direction
        // viewDir = direction of camera or "viewer"
        // atten = light intensity when it hits the surface
        half4 LightingMyBlinn(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
        {
            half3 halfway = normalize(lightDir + viewDir);

            half diffuseValue = max (0, dot(s.Normal, lightDir));

            float specularFallof = max(0, dot(s.Normal, halfway));
            
            float specularValue = pow(specularFallof, _ExponentTest);
            // work out the dot prod of the surface normals and the lightDir
            half4 color;
            color.rgb = (s.Albedo * _LightColor0.rgb * diffuseValue + _LightColor0.rgb * specularValue);
            color.a = s.Alpha;
            return color;
        }


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