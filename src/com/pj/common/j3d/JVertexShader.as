package com.pj.common.j3d
{
	import flash.display3D.Context3DProgramType;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class JVertexShader extends JShader
	{
		public static const TYPE_TEST:int = 1;
		
		public static const POS_DEFAULT:int = 0;
		public static const POS_0TO2_XYZ:int = 1;
		
		public static const DIFFUSE_DEFAULT:int = 0;
		public static const DIFFUSE_3TO5_RGB:int = 1;
		
		public static function checkFormat(p_data:Object):Boolean
		{
			if (!p_data)
			{
				return false;
			}
			for (var key:String in p_data)
			{
				switch (key)
				{
				case "diffuse": 
				case "pos": 
					break;
				default: 
					return false;
				}
			}
			return true;
		}
		
		private var _format:Object = null;
		
		public function JVertexShader(p_type:int):void
		{
			super();
			var code:String = "";
			switch (p_type)
			{
			case TYPE_TEST: 
			default: 
				this._format = { //
					pos: POS_0TO2_XYZ //
					, diffuse: DIFFUSE_3TO5_RGB //
				};
				code = this.line(["" // nothing
				, "mov v0, va1" // copy va1 (myDiffuse) to v0(=color channel 0)
				, "m44 op, va0, vc0" // transform va0(myPos) by vc0(matrix) to op(vertex output)
				]);
			}
			
			if (!JVertexShader.checkFormat(this._format))
			{
				throw new Error("JVertexShader Format Error");
			}
			
			this._assembler.assemble(Context3DProgramType.VERTEX, code);
		}
		
		override public function dispose():void
		{
			this._format = null;
			super.dispose();
		}
		
	}
}