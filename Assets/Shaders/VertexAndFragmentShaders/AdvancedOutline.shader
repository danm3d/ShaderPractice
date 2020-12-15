Shader "ShaderPractice/VertexAndFragmentShaders/Advanced Outline"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _OutlineColor ("Outline Color", Color) = (0,0,0,1)
        _OutlineWidth ("Outline Width", Range(0.01, 0.1)) = 0.01
    }
    SubShader
    {
        // In this version of the outline shader, instead of drawing the mesh in another pass after the outline and using the Transparent queue, 
        // we use a vertex fragment shader to draw the outline AFTER the mesh has been rendered
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

        Pass
        {
            Cull Front

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 pos :SV_POSITION;
                fixed4 color : COLOR;
            };

            float4 _Outline;
            float4 _OutlineColor;

            v2f vert(appdata v)
            {
                v2f o;
                
                o.pos = UnityObjectToClipPos(v.vertex);
                // The world space normals to view space
                float3 norm = normalize(mul((float3x3)UNITY_MATRIX_IT_MV, v.normal));
                float2 offset = TransformViewToProjection(norm.xy);

                o.pos.xy += offset * o.pos.z * _Outline;
                o.color = _OutlineColor;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                return i.color;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}