Shader "ShaderPractice/VertexAndFragmentShaders/Vertex Colour Manipulation"
{
    Properties
    {
        _Speed ("Speed", Float) = 10.0
        _Frequency ("Frequency", Float) = 10.0
    }
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

            half _Speed;
            half _Frequency;

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

                // Fixes the warning "Output value 'vert' is not completely initialized at line XX (on d3d11)"
                UNITY_INITIALIZE_OUTPUT(v2f, o);

                o.color.r = sin(((_Speed * _Time) + v.vertex.x) * _Frequency);
                v.vertex.y -= o.color.r;
                
                // Advice from Gazza_N (from the internet!) that UnityObjectToClipPos should
                // be called AFTER vert manipulation to avoid weird object space to clip space conversion issues
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }


            fixed4 frag(v2f i) : SV_Target
            {
                fixed4 col = i.color;
                col.r = abs(i.color.r);
                return col;
            }
            ENDCG
        }
    }
}