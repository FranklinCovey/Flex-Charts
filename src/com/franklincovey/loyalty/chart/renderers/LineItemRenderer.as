package com.franklincovey.loyalty.chart.renderers
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	import mx.controls.Label;
	import mx.core.IDataRenderer;
	import mx.core.UIComponent;
	import mx.graphics.IFill;
	import mx.graphics.IStroke;
	import mx.graphics.SolidColor;
	import mx.graphics.Stroke;

	public class LineItemRenderer extends UIComponent implements IDataRenderer
	{
		public var label:Label;

		public function LineItemRenderer()
		{
			super();

			label = new Label();
			addChild( label );
		}

		public function get data():Object
		{
			return null;
		}

		public function set data( value:Object ):void
		{
		}

		override protected function updateDisplayList( unscaledWidth:Number, unscaledHeight:Number ):void
		{
			super.updateDisplayList( unscaledWidth, unscaledHeight );

			//Stroke Settings
			var strokeWidth:uint = 1;

			//Create new graphic (to fill with our pretty colors)
			var g:Graphics = graphics;
			g.clear();
			g.moveTo( 0, 0 );

			var matrix:Matrix = new Matrix();
			matrix.rotate( 90 );

			g.beginFill( 0x666666 );


			//Draw Shape.
			g.drawCircle( 3, 3, 6 );
			g.endFill();

			//Move Label
			label.setStyle( 'color', 0x666666 );
			label.setStyle( 'fontSize', '12' );
			label.setActualSize( label.getExplicitOrMeasuredWidth(), label.getExplicitOrMeasuredHeight());

			label.move( unscaledWidth / 2 - label.getExplicitOrMeasuredWidth() / 2, 0 - ( label.getExplicitOrMeasuredHeight() * 1.5 ));
		}
	}
}


