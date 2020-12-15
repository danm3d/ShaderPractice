Shader "ShaderPractice/VertexAndFragmentShaders/Toon Outline"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _OutlineColor ("Outline Color", Color) = (0, 0, 0, 1)
        _OutlineWidth ("Outline Width", Range(0.01, 1.0)) = 0.01
        _NormalMap ("Normal Map", 2D) = "bump" {}
        _NormalIntensity ("Normal Amount", Range(0, 1)) = 0.1
        _RampTex ("Lighting Ramp Texture", 2D)= "white"{}
    }
    SubShader
    {
        // In this version of the outline shader, instead of drawing the mesh in another pass after the outline and using the Transparent queue, 
        // we use a vertex fragment shader to draw the outline AFTER the mesh has been rendered
        CGPROGRAM
        #pragma surface surf RampedLight

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_NormalMap;
        };

        sampler2D _MainTex;
        sampler2D _NormalMap;
        half _NormalIntensity;
        sampler2D _RampTex;


        // SurfaceOutput s = the output of the surf method
        // lightDir = light direction
        // viewDir = direction of camera or "viewer"
        // atten = light intensity when it hits the surface
        half4 LightingRampedLight(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
        {
            half3 halfway = normalize(lightDir + viewDir);

            half diffuseValue = max(0, dot(s.Normal, lightDir));

            float specularFallof = max(0, dot(s.Normal, halfway));

            float specularValue = pow(specularFallof, 48.0);

            float3 ramp = tex2D(_RampTex, specularFallof).rgb;

            // work out the dot prod of the surface normals and the lightDir
            half4 color;
            color.rgb = ((s.Albedo * _LightColor0.rgb * diffuseValue) * ramp) + ((_LightColor0.rgb * specularValue));
            color.a = s.Alpha;
            return color;
        }

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
            o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap)) * float3(_NormalIntensity, _NormalIntensity, 1);
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
                float4 pos : SV_POSITION;
                fixed4 color : COLOR;
            };

            float _OutlineWidth;
            float4 _OutlineColor;

            v2f vert(appdata v)
            {
                v2f o;

                o.pos = UnityObjectToClipPos(v.vertex);
                // UNITY_MATRIX_IT_MV is the Inverse transpose of model * view matrix.  This rotates the normals from object space to observer space.
                float3 norm = normalize(mul((float3x3)UNITY_MATRIX_IT_MV, v.normal));
                float2 offset = TransformViewToProjection(norm.xy);

                // o.pos.z is the clip/view z to calculate outline thickness relative to the view
                o.pos.xy += offset * o.pos.z * _OutlineWidth;
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
    //FallBack "Diffuse"
}