/**
* ...
* @author R.C.Balajee
* @version 0.1
*/

package  {
	
	import flash.display.Sprite; 
	import flash.events.Event;
	import flash.events.Event;
	import mx.core.BitmapAsset;
 
	import org.papervision3d.core.proto.CameraObject3D;
	
	import org.papervision3d.view.Viewport3D; 
	import org.papervision3d.cameras.*;
	import org.papervision3d.scenes.Scene3D; 
	import org.papervision3d.render.BasicRenderEngine;
	

	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.materials.BitmapFileMaterial;
 	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	
	public class Main extends Sprite { 
		
		public var viewport:Viewport3D; 
		public var renderer:BasicRenderEngine; 		
		public var current_scene:Scene3D;
		public var current_camera:CameraObject3D;
		public var current_viewport:Viewport3D;
	
		public var default_scene:Scene3D; // A Scene
		
		public var default_camera:Camera3D; // A Camera
		
		private var bmps:Array;
		private var list:MaterialsList;
		private var bmp:BitmapAsset;
		private var mat:BitmapMaterial;
		public var cube:Cube;
		
		[Embed(source="../assets/iProtester.png")]
		private var LogoImage:Class;

		public function Main() {
			init();
		}
		
		public function init(vpWidth:Number = 500, vpHeight:Number = 500):void {
			initPapervision(vpWidth, vpHeight); 
			init3d(); 
			init2d(); 
			initEvents(); 
		}
		
		protected function initPapervision(vpWidth:Number, vpHeight:Number):void {
			
			if (vpWidth == 0) {
				viewport = new Viewport3D(stage.width, stage.height, true, true);
			}else{
				viewport = new Viewport3D(vpWidth, vpHeight, false, true);
			}
			
			addChild(viewport); // Add the viewport to the stage.

			// Initialise the rendering engine.
			renderer = new BasicRenderEngine();

			// Initialise the Scenes 
			default_scene = new Scene3D();

			// Initialise the Cameras
			default_camera = new Camera3D();
			
			current_camera = default_camera;
			current_scene = default_scene;
			current_viewport = viewport;
			
		}
		
		protected function init3d():void {

			// Initialize the BitmapAsset from the embedded image
			bmp = new LogoImage();
			
			// Initialize Material from the BitmapAsset (need to get the bitmapData to make it work)
			mat = new BitmapMaterial(bmp.bitmapData);

			bmps = new Array();
			list = new MaterialsList();
			bmps.push(bmp);
			mat.smooth = true;
			list.addMaterial(mat, "all");

			cube = new Cube(list, 100, 100, 100, 2, 2, 2);
			cube.x = 20;
			cube.y = 60;
			current_scene.addChild(cube);
		}
		
		protected function init2d():void {
			// This function should create all of the 2d items
			// that will be overlayed on your papervision project.
			// User interfaces, Heads up displays etc.
		}
		
		protected function initEvents():void {
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
		}
		
		protected function processFrame():void {
			cube.yaw(2);

		}
		
		protected function onEnterFrame( ThisEvent:Event ):void {
			
			processFrame();
			renderer.renderScene(current_scene, current_camera, current_viewport);
		}
		
	}
	
}
