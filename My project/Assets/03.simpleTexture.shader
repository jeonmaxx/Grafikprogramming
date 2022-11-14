Shader "MDH/03 - Simple Texture"
{
	Properties
	{
		_Color("Color", Color) = (1,0,0,1)
		_MainTex("Texture", 2D) = "white" {}
	}
	SubShader //Reihenfolge wichtig
	{
		Pass //je mehr passes, desto länger dauert es
		{
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			float4 _Color;
			sampler2D _MainTex;
			float4 _MainTex_ST; //wichtig 

			struct vertexInput
			{
				float4 vertexPos : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertexPos : SV_POSITION;
				float2 uv : TEXCOORD0;
			}; //nur bei struct

			v2f vert(vertexInput input)
			{
				v2f output;
				output.vertexPos = UnityObjectToClipPos(input.vertexPos);
				output.uv = TRANSFORM_TEX(input.uv, _MainTex);
				return output;
			}

			float4 frag(v2f input) : COLOR
			{
				return tex2D(_MainTex, input.uv);
			}

			ENDCG
		}
	}
}