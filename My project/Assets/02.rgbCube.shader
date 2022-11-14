Shader "MDH/02 - RGBCube"
{
	SubShader //Reihenfolge wichtig
	{
		Pass //je mehr passes, desto länger dauert es
		{
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			struct v2f
			{
				float4 vertexPos : SV_POSITION;
				float4 color : TEXCOORD0;
			}; //nur bei struct

			v2f vert(float4 vertexPos : POSITION)
			{
				v2f output;
				output.vertexPos = UnityObjectToClipPos(vertexPos);
				output.color = vertexPos  + float4(0.5, 0.5, 0.5, 0);
				return output;
			}

			float4 frag(v2f input) : COLOR
			{
				return input.color;
			}

			ENDCG
		}
	}
}