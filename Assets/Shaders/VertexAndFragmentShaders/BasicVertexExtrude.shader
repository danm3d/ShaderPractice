Shader "ShaderPractice/VertexAndFragmentShaders/BasicVertexExtrude"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Extrude ("Extrude", Range(-1.0, 1)) = 0.0
    }
    SubShader
    {
        Tags
        {
            "Queue"="Geometry"
        }

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

        sampler2D _MainTex;
        half _Extrude;
        
        void vert(inout appdata v)
        {
            v.vertex.xyz += v.normal * _Extrude;
        }

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo.rgb = tex2D(_MainTex, IN.uv_MainTex).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}