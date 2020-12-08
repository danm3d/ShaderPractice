Shader "ShaderPractice/SuzanneShaderTest"
{
    Properties
    {
        _Tint ("Albedo Tint", Color) = (1,1,1,1)
        _EmissionColor ("Emission Color", Color) = (0,0,0,1)

        _AlbedoTexture ("Albedo Texture", 2D) = "white" {}
        _EmissionTexture ("Emission Map", 2D) = "white" {}
        _NormalMap ("Normal Map", 2D) = "bump" {} // "bump" needs to be defined here to indicate it's not a regular texture
        _NormalIntensity ("Normal Amount", Range(0, 10)) = 1


        _CubeMap ("Cube Map", CUBE) = "white" {}
    }
    SubShader
    {
        Tags {"Queue" = "Geometry+100"}
        //ZWrite Off
        CGPROGRAM
        #pragma surface surf Lambert
        
        fixed4 _Tint;
        fixed4 _EmissionColor;
        
        sampler2D _AlbedoTexture;
        sampler2D _EmissionTexture;
        sampler2D _NormalMap;
        half _NormalIntensity;
        
        half _Range;
        samplerCUBE _CubeMap;

        struct Input
        {
            float2 uv_AlbedoTexture;
            float2 uv_EmissionTexture;
            float2 uv_NormalMap;
            
            float3 viewDir;
            float3 worldRefl; INTERNAL_DATA
        };
        

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = (tex2D(_AlbedoTexture, IN.uv_AlbedoTexture) * _Tint).rgb;
            //o.Albedo = texCUBE(_CubeMap, IN.worldRefl).rgb;
            o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap)) * float3(_NormalIntensity, _NormalIntensity, 1);
            half dotProd = dot(IN.viewDir, o.Normal);
            o.Emission = texCUBE(_CubeMap, WorldReflectionVector (IN, o.Normal)).rgb*float3(dotProd,1,1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}