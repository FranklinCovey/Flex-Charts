/**
 * Loyalty Charts
 *
 * LICENSE
 *
 * This source file is subject to the new BSD license that is bundled
 * with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.franklincovey.com/license/new-bsd
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to opensource@franklincovey.com so we can send you a copy immediately.
 *
 * @category   Loyalty
 * @package    Charts
 * @copyright  Copyright (c) 2012 Franklin Covey Inc Inc. (http://www.franklincovey.com)
 * @license    http://opensource.franklincovey.com/license/new-bsd     New BSD License
 * @author     Sean Thayne <sean.thayne@franklincovey.com>
 */
package com.franklincovey.loyalty.chart.api
{

	public class ScoreGraphChartType
	{

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ScoreGraphChartType( type:uint )
		{
			this.type = type;
		}

		//--------------------------------------------------------------------------
		//
		//  Public Static Constants
		//
		//--------------------------------------------------------------------------

		public static const COLUMN:uint = 1;

		public static const LINE:uint = 2;

		public static const PIE:uint = 3;

		//--------------------------------------------------------------------------
		//
		//  Public Static Embeded Images
		//
		//--------------------------------------------------------------------------

		[Embed( source = "/com/franklincovey/loyalty/chart/assets/icons/silk/chart_bar.png" )]
		public static var chart_bar_icon:Class;

		[Embed( source = "/com/franklincovey/loyalty/chart/assets/icons/silk/chart_line.png" )]
		public static var chart_line_icon:Class;

		[Embed( source = "/com/franklincovey/loyalty/chart/assets/icons/silk/chart_pie.png" )]
		public static var chart_pie_icon:Class;

		//--------------------------------------------------------------------------
		//
		//  Public Properties
		//
		//--------------------------------------------------------------------------

		//----------------------------------
		//  type
		//----------------------------------

		/**
		 * Chart Type
		 */
		public var type:uint;

		//----------------------------------
		//  label
		//----------------------------------

		/**
		 * Chart Type Label
		 */
		public function get label():String
		{
			switch ( type )
			{
				case COLUMN:
					return "Bar Chart";

				case LINE:
					return "Line Chart";

				case PIE:
					return "Pie Chart";
			}

			return "";
		}

		//----------------------------------
		//  icon
		//----------------------------------

		/**
		 * Chart Type Icon
		 */
		public function get icon():*
		{
			switch ( type )
			{
				case COLUMN:
					return chart_bar_icon;

				case LINE:
					return chart_line_icon;

				case PIE:
					return chart_pie_icon
			}

			return null;
		}
	}
}


