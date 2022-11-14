Shader "Custom/10.Desolve"

{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _Clip("Alpha Clip", Range(0,1))= 0.5
        _NoiseScale("NoiseScale", float) = 0
        _EdgeColor("Edge Color", Color) = (1,1,1,1)
        _EdgeWidth("Edge Width", float) = 0.03
        _Emission("Emission", float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200
        Cull Off

        CGPROGRAM

        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

        #include "noiseSimplex.cginc"

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float3 worldPos;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
        float _Clip;
        float _NoiseScale;
        float _EdgeWidth;
        fixed4 _EdgeColor;



        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed noise = snoise(IN.worldPos * _NoiseScale) * 0.5 + 0.5;
            fixed edge = _Clip + _EdgeWidth;

            if(noise < _Clip)
            {
                discard;
            }

            fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;

            if (noise > _Clip && noise < edge)
            {
                o.Albedo = _EdgeColor;
                o.Alpha = _EdgeColor;
                o.Emission = _EdgeColor.rgb;
            }

        }
        ENDCG
    }
    FallBack "Diffuse"
}
