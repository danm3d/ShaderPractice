Shader "ShaderPractice/VertexAndFragmentShaders/Vertex Colour Manipulation"
{
    // Vertex and Fragment shaders (and, especially the Unity Unlit shader in this example) 
    // do NOT handle lighting out of the box like Surface shaders do, so we need to write 
    // our own lighting solutions for these cases.
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
            };

            // V2F stands for Vertex to Fragment
            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 color : COLOR;
            };

            // o is returned as i in the frag
            v2f vert(appdata v)
            {
                // convert vertex data to "fragments" for frag to process
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.color.r = abs(v.vertex.x);
                return o;
            }


            fixed4 frag(v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = i.color;
                col=i.color.r;
                return col;
            }
            ENDCG
        }
    }
}