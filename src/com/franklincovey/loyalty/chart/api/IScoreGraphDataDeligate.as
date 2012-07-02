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
	import flash.events.IEventDispatcher;

	import mx.collections.ArrayCollection;

	public interface IScoreGraphDataDeligate extends IEventDispatcher
	{

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		//----------------------------------
		//  Chart Label
		//----------------------------------

		function get label():String;

		//----------------------------------
		//  Chart Data
		//----------------------------------

		function get data():ArrayCollection;

		//----------------------------------
		//  Chart Class
		//----------------------------------

		function get chartClass():Class;

		//----------------------------------
		//  Chart
		//----------------------------------

		function get chart():IScoreGraphChart;
		function set chart( value:IScoreGraphChart ):void;

		//----------------------------------
		//  Report Types
		//----------------------------------

		[Bindable( event = "chartReportChanged" )]
		function get reportTypes():ArrayCollection;

		//----------------------------------
		//  Selected Report Type
		//----------------------------------

		[Bindable( event = "chartReportChanged" )]
		function get selectedReportType():IScoreGraphReportType;
		function set selectedReportType( value:IScoreGraphReportType ):void;


		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------

		function canDrill( index:uint ):Boolean;

		function drillDown( index:uint ):IScoreGraphDataDeligate;

		function drillUp():void;

		function activate():void;
	}
}
