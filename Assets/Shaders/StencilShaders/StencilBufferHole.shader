Shader "ShaderPractice/Stencil Buffer - Hole"
{
    Properties
    {
        _MainTex ("Main Texture", 2D) = "white" {}

    }
    SubShader
    {
        Tags
        {
            "Queue" = "Geometry-1"
        }
        
        // Don't show any color
        ColorMask 0
        
        // Don't write it to the ZBuffer
        ZWrite off
        
        Stencil
        {
            Ref 1
            // Comp stands for comparison
            Comp always
            
            // Now we tell it what we want to do with pixel to draw
            Pass replace
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
}