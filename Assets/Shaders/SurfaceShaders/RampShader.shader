Shader "ShaderPractice/Ramp Texture"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _RampTex ("Ramp Texture", 2D)= "white"{}
    }
    SubShader
    {
        Tags
        {
            "Queue" = "Geometry"
        }
        
        CGPROGRAM
        #pragma surface surf RampedLight
        
        float4 _Color;
        sampler2D _RampTex;
        
        // SurfaceOutput s = the output of the surf method
        // lightDir = light direction
        // viewDir = direction of camera or "viewer"
        // atten = light intensity when it hits the surface
        half4 LightingRampedLight(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
        {
            half3 halfway = normalize(lightDir + viewDir);

            half diffuseValue = max (0, dot(s.Normal, lightDir));

            float specularFallof = max(0, dot(s.Normal, halfway));
            
            float specularValue = pow(specularFallof, 48.0);

            float3 ramp = tex2D(_RampTex, specularFallof).rgb;
            
            // work out the dot prod of the surface normals and the lightDir
            half4 color;
            color.rgb = ((s.Albedo * _LightColor0.rgb * diffuseValue) * ramp) + ((_LightColor0.rgb * specularValue));
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