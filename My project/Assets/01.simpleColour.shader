Shader "MDH/01 - Simple Colour"
{
	Properties
	{
		_Color("Color", Color) = (1,0,0,1)
	}

	SubShader //Reihenfolge wichtig
	{
		Pass //je mehr passes, desto länger dauert es
		{
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			float4 _Color;

			float4 vert(float4 vertexPos : POSITION) : SV_POSITION
			{
				return UnityObjectToClipPos(vertexPos);
			}

			float4 frag(void) : COLOR //void nur in dieser Übung
			{
				return _Color;
			}

			ENDCG
		}
	}
}