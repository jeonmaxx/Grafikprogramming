using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;
/*
[Serializable]
[PostProcess (typeof(GrayscaleRenderer),PostProcessEvent, AfterStack, "Custom/Grayscale")]
public sealed class Grayscale : PostProcessEffectSettings
{
    [Range(0f, 1f), Tooltip("Grayscale effect intensity")]
    public FloatParameter blend = new FloatParameter() { value = 0.5f };
}

public sealed class GrayscaleRenderer : PostProcessEffectRenderer
{
    public override void Render(PostProcessRenderContext context)
    {
        PropertySheet sheet = context.propertySheet.Get("Hidden/Custom/Grayscale");
        sheet.properties.SetFloat("_Blend", settings.blend);
        context.command.BlitFullScreenTriangle(context.source, context.destination, sheet, 0);
    }
}*/
