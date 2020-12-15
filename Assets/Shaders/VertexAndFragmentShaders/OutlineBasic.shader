Shader "ShaderPractice/VertexAndFragmentShaders/BasicOutline"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _OutlineColor ("Outline Color", Color) = (0,0,0,1)
        _OutlineWidth ("Outline Width", Range(0.01, 0.1)) = 0.01
    }
    SubShader
    {
        Tags
        {
            "Queue"="Transparent"
        }
        // Outline pass
        ZWrite off
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert


        struct Input
        {
            float2 uv_MainTex;
        };

        struct appdata
        {
            float4 vertex: POSITION;
            float3 normal: NORMAL;
            float4 texcoord: TEXCOORD0;
        };

        float4 _OutlineColor;
        half _OutlineWidth;

        void vert(inout appdata v)
        {
            v.vertex.xyz += v.normal * _OutlineWidth;
        }

        sampler2D _MainTex;

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Emission = _OutlineColor.rgb;
        }
        ENDCG

        // Surface pass
        ZWrite on
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input
        {
            float2 uv_MainTex;
        };

        sampler2D _MainTex;

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}