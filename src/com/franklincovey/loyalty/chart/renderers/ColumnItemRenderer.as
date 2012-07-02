package com.franklincovey.loyalty.chart.renderers
{



	import com.franklincovey.loyalty.chart.api.IScoreGraphChart;

	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;

	import mx.charts.ChartItem;
	import mx.charts.series.items.ColumnSeriesItem;
	import mx.containers.Panel;
	import mx.controls.Label;
	import mx.controls.ToolTip;
	import mx.core.IDataRenderer;
	import mx.core.UIComponent;
	import mx.events.ToolTipEvent;
	import mx.formatters.NumberFormatter;
	import mx.graphics.IStroke;
	import mx.graphics.SolidColor;
	import mx.graphics.Stroke;

	public class ColumnItemRenderer extends UIComponent implements IDataRenderer
	{

		//--------------------------------------------------------------------------
		//
		// Constructor
		// 
		//--------------------------------------------------------------------------

		public function ColumnItemRenderer()
		{
			addEventListener( MouseEvent.ROLL_OVER, mouseRollOverHandler );
			addEventListener( MouseEvent.ROLL_OUT, mouseRollOutHandler );
			addEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler );

			label = new Label();
			addChild( label );

			addEventListener( ToolTipEvent.TOOL_TIP_CREATE, handleToolTipCreate );
			addEventListener( ToolTipEvent.TOOL_TIP_SHOW, handleToolTipShow );
			toolTip = " ";
		}

		public var chart:IScoreGraphChart;

		private function handleToolTipCreate( event:ToolTipEvent ):void
		{
			if ( chart )
			{
				event.toolTip = chart.createToolTip( ChartItem( data ).item );
			}

			//If no tooltip created, then give it a hidden tool tip renderer. Show nothing!
			if ( !event.toolTip )
				event.toolTip = new HiddenToolTip();
		}

		/**
		 * We custom position the tooltip to avoid bottom-right flickering.
		 */
		private function handleToolTipShow( event:ToolTipEvent ):void
		{

			if ( parentApplication.mouseX + event.toolTip.width > parentApplication.width )
			{
				event.toolTip.x = ( parentApplication.mouseX - event.toolTip.width ) - 3;
			}
		}

		//--------------------------------------------------------------------------
		//
		// Public Properties
		// 
		//--------------------------------------------------------------------------

		//----------------------------------
		//  color
		//----------------------------------

		/**
		 * Returns the current color of the column.
		 *
		 */
		private function get color():uint
		{

			return 0x1E90FF;
		}

		//----------------------------------
		//  textColor
		//----------------------------------

		/**
		 * Returns the current color of the column.
		 *
		 */
		private function get textColor():uint
		{


			return 0x00008B;
		}

		//----------------------------------
		//  data
		//----------------------------------

		/**
		 * @private
		 * Storage container for the data property.
		 */
		private var _data:Object;

		/**
		 * DataProvider for this itemRenderer
		 */
		public function get data():Object
		{
			return _data;
		}

		public var _currentValue:Number = 0;

		public function set data( value:Object ):void
		{
			if ( _data == value )
				return;

			var chartItem:ChartItem = ChartItem( value );
			if ( chartItem == null )
			{
				return;
			}

			var columnItem:ColumnSeriesItem = ColumnSeriesItem( chartItem );
			if ( columnItem.yValue )
			{
				var fmt:NumberFormatter = new NumberFormatter();
				_currentValue = Number( columnItem.yValue );
				var yValue:Number = Math.abs( _currentValue );
				fmt.precision = 2;

				if ( yValue < 1000 )
				{
					label.text = _currentValue.toString();
				}
				else if ( yValue < 1000000 )
				{
					label.text = fmt.format( _currentValue / 1000 ) + "K";
					;
				}
				else
				{
					label.text = fmt.format( _currentValue / 1000000 ) + "M";
					;
				}
			}

			_data = value;
		}



		//----------------------------------
		//  isMouseOver
		//----------------------------------

		/**
		 * Defines if the mouse curor is currently on top of this column.
		 */
		public var isMouseOver:Boolean = false;

		//----------------------------------
		//  isMouseDown
		//----------------------------------

		/**
		 * Defines if the user is currently clicking this column.
		 */
		public var isMouseDown:Boolean = false;

		//----------------------------------
		//  label
		//----------------------------------

		/**
		 * Label for column itemRenderer
		 */
		public var label:Label;


		//--------------------------------------------------------------------------
		//
		// Overriden Functions
		// 
		//--------------------------------------------------------------------------

		override protected function updateDisplayList( unscaledWidth:Number, unscaledHeight:Number ):void
		{

			label.text = _currentValue.toString();


			super.updateDisplayList( unscaledWidth, unscaledHeight );

			//Stroke Settings
			var strokeWidth:uint = 1;

			//Bar Dimensions
			var padding:Number = strokeWidth / 2;
			var rc:Rectangle = new Rectangle( padding, padding, width - 2 * padding, height - 2 * padding );

			//Create new graphic (to fill with our pretty colors)
			var g:Graphics = graphics;
			g.clear();
			g.moveTo( rc.left, rc.top );

			var matrix:Matrix = new Matrix();
			matrix.rotate( 90 );

			//Add Fill
			if ( isMouseDown )
			{
				g.beginGradientFill( GradientType.RADIAL, [ 0xFFFFFF, color ], [ 1, 1 ], [ 0, 20 ], matrix );
			}
			else if ( isMouseOver )
			{
				g.beginGradientFill( GradientType.RADIAL, [ 0xFFFFFF, color ], [ 1, 1 ], [ 0, 35 ], matrix );
			}
			else
			{
				g.beginGradientFill( GradientType.RADIAL, [ 0xFFFFFF, color ], [ 1, 1 ], [ 0, 50 ], matrix );
			}

			//Add Stroke
			var stroke:IStroke = new Stroke( color, strokeWidth );
			setStyle( 'stroke', stroke );
			stroke.apply( g );

			//Move Label
			label.setStyle( 'color', textColor );
			label.setStyle( 'fontSize', '12' );
			label.setActualSize( label.getExplicitOrMeasuredWidth(), label.getExplicitOrMeasuredHeight());

			//Draw Shape.
			g.drawRect( rc.left, rc.top, rc.width, rc.height );
			g.endFill();

			//Get Label Position.
			var labelRect:Rectangle = new Rectangle();
			labelRect.width = label.getExplicitOrMeasuredWidth();
			labelRect.height = label.getExplicitOrMeasuredHeight();
			labelRect.x = unscaledWidth / 2 - labelRect.width / 2;
			labelRect.y = _currentValue >= 0 ? 0 - labelRect.height : 0;

			//Move label into position.
			label.move( labelRect.x, labelRect.y );

		}

		//--------------------------------------------------------------------------
		//
		// Event Handlers
		// 
		//--------------------------------------------------------------------------

		protected function mouseRollOverHandler( event:MouseEvent ):void
		{
			isMouseOver = true;
			invalidateDisplayList();
		}

		protected function mouseRollOutHandler( event:MouseEvent ):void
		{
			isMouseOver = false;
			invalidateDisplayList();
		}

		protected function mouseDownHandler( e:MouseEvent ):void
		{
			isMouseDown = true;
			systemManager.addEventListener( MouseEvent.MOUSE_UP, mouseUpHandler, true );
			invalidateDisplayList();
		}

		protected function mouseUpHandler( e:MouseEvent ):void
		{
			isMouseDown = false;
			systemManager.removeEventListener( MouseEvent.MOUSE_UP, mouseUpHandler, true );
			invalidateDisplayList();
		}
	}
}


import mx.controls.Label;
import mx.core.IToolTip;

class HiddenToolTip extends Label implements IToolTip
{
	function HiddenToolTip()
	{
		width = 0;
		height = 0;
	}
}


