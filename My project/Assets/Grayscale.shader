Shader "Hidden/Custom/Grayscale"
{
	Subshader
	{
		Cull Off
		ZWrite Off
		ZTest Always
		Pass
		{
			HLSLPROGRAM

			#include "Packages/.com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"
			#pragma vertex VertDefault
			#pragma fragment frag

			float _Blend;
			TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);

			float4 frag(VaryingsDefault i) : SV_TARGET
			{
				float4 color = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoord);
				float grayscale = dot(color.rgb, float(0.2126729, 0.7151522, 0.0721750));
				color.rgb = lerp(color.rgb, grayscale.xxx, _Blend.xxx);
				return color;
			}

			ENDHLSL
		}
	}
}
