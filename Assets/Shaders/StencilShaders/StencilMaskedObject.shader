Shader "ShaderPractice/Basic Stencil Object With Properties"
{
    Properties
    {
        _MainTex ("Main Texture", 2D) = "white" {}
        _SRef("Stencil Ref", Float) = 1

        [Enum(UnityEngine.Rendering.CompareFunction)] _SComp("Stencil Compare", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)] _SOp("Stencil Operation", Float) = 2

    }
    SubShader
    {
        Tags
        {
            "Queue" = "Geometry-1"
        }

        // Don't write it to the ZBuffer
        ZWrite off
        // Don't show any color
        ColorMask 0


        Stencil
        {
            Ref [_SRef]
            // Comp stands for comparison
            Comp [_SComp]

            // Now we tell it what we want to do with pixel to draw
            Pass [_SOp]
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
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
        }
        ENDCG
    }
}