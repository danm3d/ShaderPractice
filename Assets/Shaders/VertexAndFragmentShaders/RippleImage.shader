Shader "ShaderPractice/VertexAndFragmentShaders/RippleImage"
{
    // Vertex and Fragment shaders (and, especially the Unity Unlit shader in this example) 
    // do NOT handle lighting out of the box like Surface shaders do, so we need to write 
    // our own lighting solutions for these cases.
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _ScaleUVX ("Scale X", Range(1,10)) = 1
        _ScaleUVY ("Scale Y", Range(1,10)) = 1
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            // V2F stands for Vertex to Fragment
            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };


            // NOTE: the _MainTex_ST which is additional to _MainTex and used in the vertex shader method. It is REQUIRED
            // Fiddly confusing extra thing. It is used to handle texture transformation.
            sampler2D _MainTex; // Used by the fragment shader
            float4 _MainTex_ST; // Used by TRANSFORM_TEX in the vert shader
            half _ScaleUVX;
            half _ScaleUVY;

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.uv.x = sin(o.uv.x * _ScaleUVX);
                o.uv.y = sin(o.uv.y * _ScaleUVY);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                return col;
            }
            ENDCG
        }
    }
}