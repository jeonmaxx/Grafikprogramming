Shader "Custom/08. Glass"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _RefractionMap1 ("Refraction Map 1", 2D) = "bump" {}
		_RefractionStrength1 ("Refraction Strength 1", float) = 8
        _RefractionMap2 ("Refraction Map 2", 2D) = "bump" {}
		_RefractionStrength2 ("Refraction Strength 2", float) = 8
        _Speed("Speed", Vector) = (0,0,0,0)
    }
    SubShader
    {
		Tags { "RenderType" = "Transparent" "Queue" = "Transparent+3000" }
        LOD 100

        GrabPass
        {
            "_ScreenGrab"
        }

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

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float4 uvgrab : TEXCOORD2;
                float2 uvbump : TEXCOORD1;
                float2 uvbump2 : TEXCOORD3;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _ScreenGrab;
            float4 _ScreenGrab_TexelSize;

            sampler2D _RefractionMap1;
            float4 _RefractionMap1_ST;
            float _RefractionStrength1;

            sampler2D _RefractionMap2;
            float4 _RefractionMap2_ST;
            float _RefractionStrength2;

            float4 _Speed;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.uvbump = TRANSFORM_TEX(v.uv, _RefractionMap1);
                o.uvbump2 = TRANSFORM_TEX(v.uv, _RefractionMap2);
                o.uvgrab = ComputeGrabScreenPos(o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
				half2 bump = UnpackNormal(tex2D(_RefractionMap1, i.uvbump + _Speed.xy * _Time.x)).rg;
				float2 offset = bump * _ScreenGrab_TexelSize.xy * (_RefractionStrength1 * _RefractionStrength1);

				bump = UnpackNormal(tex2D(_RefractionMap2, i.uvbump2 + _Speed.zw * _Time.x)).rg;
				offset += bump * _ScreenGrab_TexelSize.xy * (_RefractionStrength2 * _RefractionStrength2);

                fixed4 col = tex2D(_MainTex, i.uv);
                col.a = 0;

                i.uvgrab.xy = offset * i.uvgrab.z + i.uvgrab.xy;
                fixed4 grab = tex2Dproj(_ScreenGrab, i.uvgrab);
                return col * grab;
            }
            ENDCG
        }
    }
}
