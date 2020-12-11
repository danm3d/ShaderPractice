Shader "ShaderPractice/VertexAndFragmentShaders/VFLitShadowed"
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

        // To create shadows, we need to do another pass after this one.
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag


            #include "UnityCG.cginc"
            // We need this to use light properties from unity's built in functions
            #include "UnityLightingCommon.cginc"

            // To receive shadows on the surface, we need to tell the shader to do so.
            #pragma multi_compile_fwdbase nolightmap nodirlightmap nodynlightmap novertexlight
            #include "Lighting.cginc"
            #include  "AutoLight.cginc"


            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord : TEXCOORD0;
            };

            // V2F stands for Vertex to Fragment
            struct v2f
            {
                float2 uv : TEXCOORD0;
                // Diffuse value for surface affected by light
                float4 diff : COLOR0;
                // need to call this "pos" explicitly because TRANSFER_SHADOW below is looking for the string specifically
                float4 pos : SV_POSITION;
                SHADOW_COORDS(1)
            };


            // NOTE: the _MainTex_ST which is additional to _MainTex and used in the vertex shader method. It is REQUIRED
            // Fiddly confusing extra thing. It is used to handle texture transformation.
            sampler2D _MainTex; // Used by the fragment shader
            float4 _MainTex_ST; // Used by TRANSFORM_TEX in the vert shader

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);

                half3 worldNormal = UnityObjectToWorldNormal(v.normal);
                half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
                o.diff = nl * _LightColor0;

                // this needs o.pos
                TRANSFER_SHADOW(o)
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                fixed shadow = SHADOW_ATTENUATION(i);
                col *= i.diff * shadow;
                return col;
            }
            ENDCG
        }

        // Shadow cast pass
        Pass
        {
            Tags
            {
                "LightMode"="ShadowCaster"
            }

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_shadowcaster
            #include "UnityCG.cginc"


            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                V2F_SHADOW_CASTER;
            };

            v2f vert(appdata v)
            {
                v2f o;
                TRANSFER_SHADOW_CASTER_NORMALOFFSET(o);
                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                SHADOW_CASTER_FRAGMENT(i);
            }
            ENDCG
        }
    }
}