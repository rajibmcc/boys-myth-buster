package com.bbc_icontent
{
	import com.mcc.interactives.utils.Pair;
	
	import flash.utils.Dictionary;

	public class InfoGame
	{
		public static const LEVEL_ALL:String = 'level_all';
		public static const LEVEL_FIRMFIELD:String = 'level_firmfield';
		public static const LEVEL_PLAYFIELD:String = 'level_playfield';
		public static const LEVEL_JUNGLE:String = 'level_jungle';
		public static const LEVEL_CINEMA:String = 'level_cinema';
		public static const LEVEL_MARKET:String = 'level_market';
		public static const LEVEL_RIVER:String = 'level_river';
		
		//Score Feedback Message KEYs
		public static const SCORE_FEEDBACK_NO_KEY:String = 'score_feedback_no_key';
		public static const SCORE_FEEDBACK_ALL_KEY:String = 'score_feedback_all_key';
		public static const SCORE_FEEDBACK_NOT_ALL_KEY:String = 'score_feedback_not_all_key';
		public static const SCORE_FEEDBACK_TIMEUP:String = 'score_feedback_timeup';
		public static const SCORE_FEEDBACK_A:String = 'score_feedback_a';
		public static const SCORE_FEEDBACK_B:String = 'score_feedback_b';
		public static const SCORE_FEEDBACK_C:String = 'score_feedback_c';
		
		//Language Bangla. text formated with return (\n)
		/*private const SIGN_LEBEL_FIRMFIELD:String = 'K…l‡Ki \n †ÿZ';
		private const SIGN_LEBEL_PLAYFIELD:String = '†Ljvi \n gvV';
		private const SIGN_LEBEL_JUNGBLE:String = 'cyi‡bv \n eb';
		private const SIGN_LEBEL_BOOKSTALL:String = 'eB Gi \n †`vKvb';
		private const SIGN_LEBEL_MARKET:String = 'e¨¯Í \n evRvi';
		private const SIGN_LEBEL_RIVER:String = 'cÖengvb \n b`x';*/
		
		private static var labels:Dictionary = new Dictionary();
		private static var signPositions:Dictionary = new Dictionary();
		private static var levelendMessage:Dictionary = new Dictionary();
		private static var scoreFeedbackMessages:Dictionary = new Dictionary();
		
		public static function getSignLebel(key:String):String{
			return labels[key];
		}
		
		public static function getSignPos(key:String):Pair{
			return signPositions[key];
		}
		
		public static function getScoreFeedbackMsg(key:String):String{
			return scoreFeedbackMessages[key];
		}
		
		public static function getEndMessage(key:String):String{
			return levelendMessage[key];
		}
		
		public static function initializeInfo():void{
			labels[LEVEL_ALL] = 'na';
			labels[LEVEL_FIRMFIELD] = 'K…l‡Ki \n †ÿZ';
			labels[LEVEL_PLAYFIELD] = '†Ljvi \n gvV';
			labels[LEVEL_JUNGLE] = 'cyi‡bv \n eb';
			labels[LEVEL_CINEMA] = 'MÖv‡gi \n wm‡bgv nj';
			labels[LEVEL_MARKET] = 'e¨¯Í \n evRvi';
			labels[LEVEL_RIVER] = 'cÖengvb \n b`x';
			
			signPositions[LEVEL_FIRMFIELD] = new Pair(332, 252);
			signPositions[LEVEL_PLAYFIELD] = new Pair(595, 115);
			signPositions[LEVEL_JUNGLE] = new Pair(228, 42);
			signPositions[LEVEL_CINEMA] = new Pair(888, 368);
			signPositions[LEVEL_MARKET] = new Pair(978, 68);
			signPositions[LEVEL_RIVER] = new Pair(60, 185);
			
			levelendMessage[LEVEL_FIRMFIELD] = '`viæY! dm‡ji †¶‡Z ¸ßab †LvuRvi P¨v‡jÄwU Zzwg m¤úbœ K‡i‡Qv| Zzwg cybivq GB P¨v‡jÄwU‡Z Ask wb‡Z cv‡iv, A_ev cieZ©x P¨v‡j‡Ä GwM‡q †h‡Z cv‡iv|';
			levelendMessage[LEVEL_PLAYFIELD] = '`viæY! †Ljvi gv‡V ¸ßab †LvuRvi P¨v‡jÄwU Zzwg m¤úbœ K‡i‡Qv| Zywg cybivq GB P¨v‡jÄwU‡Z Ask wb‡Z cv‡iv A_ev cieZ©x P¨v‡j‡Ä GwM‡q †h‡Z cv‡iv|';
			levelendMessage[LEVEL_JUNGLE] = '`viæY! cyi‡bv e‡b ¸ßab †LvuRvi P¨v‡jÄwU Zzwg m¤úbœ K‡i‡Qv| Zzwg cybivq GB P¨v‡jÄwU‡Z Ask wb‡Z cv‡iv A_ev `yišÍ wK‡kvi nIqvi j‡¶¨ cieZ©x P¨v‡j‡Ä GwM‡q †h‡Z cv‡iv|';
			levelendMessage[LEVEL_CINEMA] = '`viæY! MÖv‡gi wm‡bgv n‡j ¸ßab †LvuRvi P¨v‡jÄwU Zzwg m¤úbœ K‡i‡Qv| Zzwg cybivq GB P¨v‡jÄwU‡Z Ask wb‡Z cv‡iv A_ev `yišÍ wK‡kvi nIqvi j‡¶¨ cieZ©x P¨v‡j‡Ä GwM‡q †h‡Z cv‡iv|';
			levelendMessage[LEVEL_MARKET] = '`viæY! e¨¯Í evRv‡i ¸ßab †LvuRvi P¨v‡jÄwU Zzwg m¤úbœ K‡i‡Qv| Zzwg cybivq GB P¨v‡jÄwU‡Z Ask wb‡Z cv‡iv A_ev cieZ©x P¨v‡j‡Ä GwM‡q †h‡Z cv‡iv|';
			levelendMessage[LEVEL_RIVER] = '`viæY! e‡q Pjv b`xi Zx‡i ¸ßab †LvuRvi P¨v‡jÄwU Zzwg m¤úbœ K‡i‡Qv| Zzwg cybivq GB P¨v‡jÄwU‡Z Ask wb‡Z cv‡iv A_ev cieZ©x P¨v‡j‡Ä GwM‡q †h‡Z cv‡iv|';
			
			scoreFeedbackMessages[SCORE_FEEDBACK_ALL_KEY] = 'mvevm Zzwg me¸‡jv Pvwe msMÖn Ki‡Z †c‡i‡Qv|';
			scoreFeedbackMessages[SCORE_FEEDBACK_NO_KEY] = 'Pvwe †c‡Z n‡j †Zvgv‡K Avev‡iv †Lj‡Z n‡e| \n bv PvB‡j Zzwg cieZ©x †j‡f‡j †h‡Z cv‡iv|';
			scoreFeedbackMessages[SCORE_FEEDBACK_NOT_ALL_KEY] = 'mvevm! \n Z‡e me¸‡jv Pvwe †c‡Z n‡j Avevi †Lj‡Z cv‡iv A_ev cieZ©x †j‡f‡j †h‡Z cv‡iv|';
			scoreFeedbackMessages[SCORE_FEEDBACK_TIMEUP] = 'mgq †kl| \n Pvwe †c‡Z n‡j mg‡qi g‡a¨B †Zvgv‡K †j‡fj †kl Ki‡Z n‡e|';
			scoreFeedbackMessages[SCORE_FEEDBACK_A] = 'Awfb›`b! Zzwg Avm‡jB GKRb `yišÍ wK‡kvi/wK‡kvix ev mycvi wUb| eqtmwÜKv‡j †g‡qiv Kx ai‡bi kvixwiK I gvbwmK cwieZ©‡bi ga¨ w`‡q hvB †m wel‡q †Zvgvi ¯úó aviYv i‡q‡Q| GB †MgwU †L‡j Zzwg hv wKQy Rvb‡j Zv †Zvgvi cwievi I eÜz‡`i mv‡_ †kqvi Ki‡Z fz‡jv bv|';
			scoreFeedbackMessages[SCORE_FEEDBACK_B] = '`viæY! `yišÍ wK‡kvi/wK‡kvix nIqvi c‡_ Zzwg GwM‡q hv‡”Qv| wKš‘ wKQy welq †Zvgv‡K Av‡iv fv‡jvfv‡e Rvb‡Z n‡e| †MgwU Avevi †L‡j †`‡Lv ‡Zv GKRb `yišÍ wK‡kvi/wK‡kvix n‡Z cv‡iv wKbv!  AvR hv wKQy wkL‡j Zv †Zvgvi cwievi I eÜz‡`i mv‡_ †kqvi Ki‡Z fz‡jv bv †hb| ';
			scoreFeedbackMessages[SCORE_FEEDBACK_C] = 'Zzwg `ytLRbKfv‡e †Zvgvi Rb¨ Lye Kg ¸ßab i‡q‡Q| ïiæ wn‡m‡e fvj wKš‘ `yišÍ wK‡kvi n‡Z n‡j †Zvgv‡K †ek wKQyUv c_ cvwo w`‡Z n‡e| †MgwU Avevi †L‡j †`‡Lv †Zv GKRb `yišÍ wK‡kvi/wK‡kvix n‡Z cv‡iv wKbv!';
		}		
	}
}