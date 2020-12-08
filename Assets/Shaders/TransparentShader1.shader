Shader "ShaderPractice/Transparent Shader 1"
{
    Properties
    {
        _Texture ("Texture 1", 2D) = "white" {}
    }
    SubShader
    {
        Tags
        {
            "Queue" = "Transparent"
        }
        
        CGPROGRAM
        #pragma surface surf Lambert alpha:fade

        struct Input
        {
            float2 uv_Texture;
        };

        sampler2D _Texture;

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D(_Texture, IN.uv_Texture);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}