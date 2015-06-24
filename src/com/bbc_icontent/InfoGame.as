package com.bbc_icontent
{
	import com.mcc.interactives.utils.Pair;
	
	import flash.utils.Dictionary;

	public class InfoGame
	{
		public static const LEVEL_ALL:String = 'level_all';
		public static const LEVEL_BEDROOM:String = 'level_bedroom';
		public static const LEVEL_ROOMFLOOR:String = 'level_roomfloor';
		public static const LEVEL_STAIRS:String = 'level_stairs';
		public static const LEVEL_ROOM_DOWNSTAIRS:String = 'level_room_downstairs';
		public static const LEVEL_KITCHEN:String = 'level_kitchen';
		
		//Score Feedback Message KEYs
		public static const SCORE_FEEDBACK_POINT:String = 'score_feedback_point';
		public static const SCORE_FEEDBACK_NO_POINT:String = 'score_feedback_no_point';
		public static const SCORE_FEEDBACK_TIMEUP:String = 'score_feedback_timeup';
		public static const SCORE_FEEDBACK_BEDROOM_01:String = 'score_feedback_bedroom_01';
		public static const SCORE_FEEDBACK_BEDROOM_02:String = 'score_feedback_bedroom_02';
		public static const SCORE_FEEDBACK_BEDROOM_03:String = 'score_feedback_bedroom_03';
		public static const SCORE_FEEDBACK_BEDROOM_04:String = 'score_feedback_bedroom_04';
		public static const SCORE_FEEDBACK_BEDROOM_05:String = 'score_feedback_bedroom_05';
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
		
		public static function getScoreFeedbackMsg(key:String):String{
			return scoreFeedbackMessages[key];
		}
		
		public static function getEndMessage(key:String):String{
			return levelendMessage[key];
		}
				
		public static function initializeInfo():void{
			labels[LEVEL_ALL] = 'na';
			labels[LEVEL_BEDROOM] = 'K…l‡Ki \n †ÿZ';
			labels[LEVEL_ROOMFLOOR] = '†Ljvi \n gvV';
			labels[LEVEL_STAIRS] = 'cyi‡bv \n eb';
			labels[LEVEL_ROOM_DOWNSTAIRS] = 'MÖv‡gi \n wm‡bgv nj';
			labels[LEVEL_KITCHEN] = 'e¨¯Í \n evRvi';
			
			levelendMessage[LEVEL_BEDROOM] = '`viæY! dm‡ji †¶‡Z ¸ßab †LvuRvi P¨v‡jÄwU Zzwg m¤úbœ K‡i‡Qv| Zzwg cybivq GB P¨v‡jÄwU‡Z Ask wb‡Z cv‡iv, A_ev cieZ©x P¨v‡j‡Ä GwM‡q †h‡Z cv‡iv|';
			levelendMessage[LEVEL_ROOMFLOOR] = '`viæY! †Ljvi gv‡V ¸ßab †LvuRvi P¨v‡jÄwU Zzwg m¤úbœ K‡i‡Qv| Zywg cybivq GB P¨v‡jÄwU‡Z Ask wb‡Z cv‡iv A_ev cieZ©x P¨v‡j‡Ä GwM‡q †h‡Z cv‡iv|';
			levelendMessage[LEVEL_STAIRS] = '`viæY! cyi‡bv e‡b ¸ßab †LvuRvi P¨v‡jÄwU Zzwg m¤úbœ K‡i‡Qv| Zzwg cybivq GB P¨v‡jÄwU‡Z Ask wb‡Z cv‡iv A_ev `yišÍ wK‡kvi nIqvi j‡¶¨ cieZ©x P¨v‡j‡Ä GwM‡q †h‡Z cv‡iv|';
			levelendMessage[LEVEL_ROOM_DOWNSTAIRS] = '`viæY! MÖv‡gi wm‡bgv n‡j ¸ßab †LvuRvi P¨v‡jÄwU Zzwg m¤úbœ K‡i‡Qv| Zzwg cybivq GB P¨v‡jÄwU‡Z Ask wb‡Z cv‡iv A_ev `yišÍ wK‡kvi nIqvi j‡¶¨ cieZ©x P¨v‡j‡Ä GwM‡q †h‡Z cv‡iv|';
			levelendMessage[LEVEL_KITCHEN] = '`viæY! e¨¯Í evRv‡i ¸ßab †LvuRvi P¨v‡jÄwU Zzwg m¤úbœ K‡i‡Qv| Zzwg cybivq GB P¨v‡jÄwU‡Z Ask wb‡Z cv‡iv A_ev cieZ©x P¨v‡j‡Ä GwM‡q †h‡Z cv‡iv|';
			
			scoreFeedbackMessages[SCORE_FEEDBACK_NO_POINT] = 'In‡nv, †Zvgvi DËi fyj n‡q‡Q Z‡e g‡b †i‡Lv';
			scoreFeedbackMessages[SCORE_FEEDBACK_POINT] = 'PgrKvi! Zywg wKQy wg_ ev÷vi c‡q›U †c‡q‡Qv| Avi g‡b †i‡Lv';
			scoreFeedbackMessages[SCORE_FEEDBACK_TIMEUP] = 'mgq †kl| \n Pvwe †c‡Z n‡j mg‡qi g‡a¨B †Zvgv‡K †j‡fj †kl Ki‡Z n‡e|';
			scoreFeedbackMessages[SCORE_FEEDBACK_A] = 'Awfb›`b! Zzwg Avm‡jB GKRb `yišÍ wK‡kvi/wK‡kvix ev mycvi wUb| eqtmwÜKv‡j †g‡qiv Kx ai‡bi kvixwiK I gvbwmK cwieZ©‡bi ga¨ w`‡q hvB †m wel‡q †Zvgvi ¯úó aviYv i‡q‡Q| GB †MgwU †L‡j Zzwg hv wKQy Rvb‡j Zv †Zvgvi cwievi I eÜz‡`i mv‡_ †kqvi Ki‡Z fz‡jv bv|';
			scoreFeedbackMessages[SCORE_FEEDBACK_B] = '`viæY! `yišÍ wK‡kvi/wK‡kvix nIqvi c‡_ Zzwg GwM‡q hv‡”Qv| wKš‘ wKQy welq †Zvgv‡K Av‡iv fv‡jvfv‡e Rvb‡Z n‡e| †MgwU Avevi †L‡j †`‡Lv ‡Zv GKRb `yišÍ wK‡kvi/wK‡kvix n‡Z cv‡iv wKbv!  AvR hv wKQy wkL‡j Zv †Zvgvi cwievi I eÜz‡`i mv‡_ †kqvi Ki‡Z fz‡jv bv †hb| ';
			scoreFeedbackMessages[SCORE_FEEDBACK_C] = 'Zzwg `ytLRbKfv‡e †Zvgvi Rb¨ Lye Kg ¸ßab i‡q‡Q| ïiæ wn‡m‡e fvj wKš‘ `yišÍ wK‡kvi n‡Z n‡j †Zvgv‡K †ek wKQyUv c_ cvwo w`‡Z n‡e| †MgwU Avevi †L‡j †`‡Lv †Zv GKRb `yišÍ wK‡kvi/wK‡kvix n‡Z cv‡iv wKbv!';
			scoreFeedbackMessages[SCORE_FEEDBACK_BEDROOM_01] ='Ny‡gi g‡a¨ †Q‡j‡`i exh©cvZ nIqv‡K ejv nq ¯^cœ‡`vl| exh©cv‡Zi d‡j †Q‡j‡`i wj½ †_‡K GK ai‡bi wcw”Qj Zij †ei nq †hwU‡K ejv nq exh©| ïµvby I †mwgbvj d¬yBW bvgK GK ai‡bi Zi‡ji wgkÖ‡Y GB exh© ‰Zwi nq| i³ †_‡K exh© ˆZwi nqbv| ¯^cœ‡`v‡li d‡j †h exh©cvZ nq Zvi d‡j †Q‡j‡`i kix‡i ex‡h©i Drcv`‡bI †Kv‡bv KgwZ nq bv|';
			scoreFeedbackMessages[SCORE_FEEDBACK_BEDROOM_02] ='Ny‡gi g‡a¨ †Q‡j‡`i exh©cvZ nIqv‡K ejv nq ¯^cœ‡`vl| exh©cv‡Zi d‡j †Q‡j‡`i wj½ †_‡K GK ai‡bi wcw”Qj Zij †ei nq †hwU‡K ejv nq exh©| ïµvby I †mwgbvj d¬yBW bvgK GK ai‡bi Zi‡ji wgkÖ‡Y GB exh© ‰Zwi nq| i³ †_‡K exh© ˆZwi nqbv| ¯^cœ‡`v‡li d‡j †h exh©cvZ nq Zvi d‡j †Q‡j‡`i kix‡i ex‡h©i Drcv`‡bI †Kv‡bv KgwZ nq bv|';
			scoreFeedbackMessages[SCORE_FEEDBACK_BEDROOM_03] ='eqmwÜi mgq wK‡kvi‡`i ¯^cœ‡`vl nIqvUvB ¯^vfvweK| †Kv‡bv †Kv‡bv †Q‡ji ¯^cœ‡`vl GKUz †ewk ev Kv‡iv Kg n‡Z cv‡i| Avevi Kv‡iv G‡Kev‡i bvI n‡Z cv‡i|';
			scoreFeedbackMessages[SCORE_FEEDBACK_BEDROOM_04] ='†Kvb †Q‡ji ¯^cœ‡`vl nIqvi gv‡b GB bq †h †m `ye©j, ev Zvi ex‡h©i Drcv`b K‡g hv‡e wKsev †m cyiælZ¡nxb|';			
			scoreFeedbackMessages[SCORE_FEEDBACK_BEDROOM_05] ='¯^cœ‡`vl LyeB ¯^vfvweK GKwU welq| GwU †Kv‡bv †ivM bq| eqmwÜi mgq cÖvq me †Q‡j‡`iB GB AwfÁZv nq| Z‡e ¯^cœ‡`vl KviI †ewk ev KviI Kg n‡Z cv‡i| Avevi Kv‡iv G‡Kev‡i bvI n‡Z cv‡i|';			
		}		
	}
}