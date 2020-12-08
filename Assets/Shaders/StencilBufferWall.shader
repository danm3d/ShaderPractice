Shader "ShaderPractice/Stencil Buffer - Wall"
{
    Properties
    {
        _MainTex ("Main Texture", 2D) = "white" {}

    }
    SubShader
    {
        Tags
        {
            "Queue" = "Geometry"
        }

        Stencil
        {
            Ref 1
            Comp notequal
            Pass keep
        }

        CGPROGRAM
        #pragma surface surf Lambert

        struct Input
        {
            float2 uv_MainTex;
        };

        sampler2D _MainTex;

        void surf(Input IN, inout SurfaceOutput o)
        {
            fixed4 a = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = a.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}