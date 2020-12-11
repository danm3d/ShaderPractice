Shader "ShaderPractice/VertexAndFragmentShaders/VFLit"
{
    // Vertex and Fragment shaders (and, especially the Unity Unlit shader in this example) 
    // do NOT handle lighting out of the box like Surface shaders do, so we need to write 
    // our own lighting solutions for these cases.
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags
        {
            "LightMode"="ForwardBase"
        }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            // We need this to use light properties from unity's built in functions
            #include "UnityLightingCommon.cginc"


            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            // V2F stands for Vertex to Fragment
            struct v2f
            {
                float2 uv : TEXCOORD0;
                // Diffuse value for surface affected by light
                float4 diff : COLOR0;
                float4 vertex : SV_POSITION;
            };


            // NOTE: the _MainTex_ST which is additional to _MainTex and used in the vertex shader method. It is REQUIRED
            // Fiddly confusing extra thing. It is used to handle texture transformation.
            sampler2D _MainTex; // Used by the fragment shader
            float4 _MainTex_ST; // Used by TRANSFORM_TEX in the vert shader

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);

                half3 worldNormal = UnityObjectToWorldNormal(v.normal);
                half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
                o.diff = nl * _LightColor0;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                col *= i.diff;
                return col;
            }
            ENDCG
        }
    }
}