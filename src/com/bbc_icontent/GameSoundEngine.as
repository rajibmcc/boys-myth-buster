package  com.bbc_icontent{
	import flash.media.SoundChannel;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	
	public class GameSoundEngine {
		private static var _masterChannel:SoundChannel;
		private static var _voiceChannel:SoundChannel;
		private static var _soundTransform:SoundTransform;
		private static var _fxSoundChannel:SoundChannel;
		
		public static function set masterMusic(value:Class):void{
			//_soundTransform.volume = 2;
			if(_soundTransform == null){
				_soundTransform = new SoundTransform();
			}
			if(_masterChannel == null){
				_masterChannel = new SoundChannel();
			}
			_soundTransform.volume = .3;
			var _masterSound:Sound = new value();
			_masterChannel = _masterSound.play(0, 999);
			_masterChannel.soundTransform = _soundTransform;
			trace('MASTER SOUND playing......');
		}
		
		public static function set masterMusicVolume(value:Number):void{
			_soundTransform.volume = value;
			_masterChannel.soundTransform = _soundTransform;
			trace('MASTER SOUND volume changed.........');
		}
		
		public static function playVoiceOver(soundClass:Class):void{
			if(_voiceChannel == null){
				_voiceChannel = new SoundChannel();
			}
			var _voiceOver:Sound = new soundClass();
			_voiceChannel = _voiceOver.play();
			trace('VOICE SOUND playing..........');
		}
		
		public static function stopVoiceOver():void{
			if(_voiceChannel == null) return;
			_voiceChannel.stop();
			trace('VOICE SOUND stoped..........');
		}
		
		public static function playFx(soundClass:Class):void{
			if(_fxSoundChannel == null){
				_fxSoundChannel = new SoundChannel();
			}
			var _fxSound:Sound = new soundClass();
			_fxSoundChannel = _fxSound.play();
		}
		
		public static function stopFx():void{
			if(_fxSoundChannel == null) return;
			_fxSoundChannel.stop();
		}
		
		public static function stopMasterMusic():void{
			if(_masterChannel == null) return;
			_masterChannel.stop();
			trace('MASTER SOUND stoped......');
		}
	}
	
}
