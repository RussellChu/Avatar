package com.unusual.avatar
{
	import com.unusual.utils.IDisposable;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class AssetsManager implements IDisposable
	{
		[Embed(source = "../../../../assets/bag_a041a_p77.swf")]
		private var bag_a041a_p77:Class;
		[Embed(source = "../../../../assets/base_a000_p27.swf")]
		private var base_a000_p27:Class;
		[Embed(source = "../../../../assets/base_a000_p31.swf")]
		private var base_a000_p31:Class;
		[Embed(source = "../../../../assets/base_a000_p33.swf")]
		private var base_a000_p33:Class;
		[Embed(source = "../../../../assets/base_a000_p44.swf")]
		private var base_a000_p44:Class;
		[Embed(source = "../../../../assets/base_a000_p48.swf")]
		private var base_a000_p48:Class;
		[Embed(source = "../../../../assets/base_a000_p51.swf")]
		private var base_a000_p51:Class;
		[Embed(source = "../../../../assets/base_a000_p53.swf")]
		private var base_a000_p53:Class;
		[Embed(source = "../../../../assets/base_a000_p55.swf")]
		private var base_a000_p55:Class;
		[Embed(source = "../../../../assets/base_a000_p59.swf")]
		private var base_a000_p59:Class;
		[Embed(source = "../../../../assets/base_a000_p62.swf")]
		private var base_a000_p62:Class;
		[Embed(source = "../../../../assets/base_a000_p67.swf")]
		private var base_a000_p67:Class;
		[Embed(source = "../../../../assets/base_a000_p81.swf")]
		private var base_a000_p81:Class;
		[Embed(source = "../../../../assets/base_a000_p85.swf")]
		private var base_a000_p85:Class;
		[Embed(source = "../../../../assets/base_a000_p87.swf")]
		private var base_a000_p87:Class;
		[Embed(source = "../../../../assets/base_a000_p97.swf")]
		private var base_a000_p97:Class;
		[Embed(source = "../../../../assets/basket_x002a_p78.swf")]
		private var basket_x002a_p78:Class;
		[Embed(source = "../../../../assets/basket_z011a_p78.swf")]
		private var basket_z011a_p78:Class;
		[Embed(source = "../../../../assets/basket_z030a_p78.swf")]
		private var basket_z030a_p78:Class;
		[Embed(source = "../../../../assets/basket_z052a_p78.swf")]
		private var basket_z052a_p78:Class;
		[Embed(source = "../../../../assets/basket_z101a_p78.swf")]
		private var basket_z101a_p78:Class;
		[Embed(source = "../../../../assets/basket_z102a_p78.swf")]
		private var basket_z102a_p78:Class;
		[Embed(source = "../../../../assets/basket_z103a_p78.swf")]
		private var basket_z103a_p78:Class;
		[Embed(source = "../../../../assets/basket_z103b_p78.swf")]
		private var basket_z103b_p78:Class;
		[Embed(source = "../../../../assets/basket_z104a_p78.swf")]
		private var basket_z104a_p78:Class;
		[Embed(source = "../../../../assets/basket_z106a_p78.swf")]
		private var basket_z106a_p78:Class;
		[Embed(source = "../../../../assets/basket_z107a_p78.swf")]
		private var basket_z107a_p78:Class;
		[Embed(source = "../../../../assets/basket_z108a_p78.swf")]
		private var basket_z108a_p78:Class;
		[Embed(source = "../../../../assets/basket_z109a_p78.swf")]
		private var basket_z109a_p78:Class;
		[Embed(source = "../../../../assets/basket_z110a_p78.swf")]
		private var basket_z110a_p78:Class;
		[Embed(source = "../../../../assets/basket_z111b_p78.swf")]
		private var basket_z111b_p78:Class;
		[Embed(source = "../../../../assets/basket_z113a_p78.swf")]
		private var basket_z113a_p78:Class;
		[Embed(source = "../../../../assets/basket_z114a_p78.swf")]
		private var basket_z114a_p78:Class;
		[Embed(source = "../../../../assets/basket_z115a_p78.swf")]
		private var basket_z115a_p78:Class;
		[Embed(source = "../../../../assets/basket_z116a_p78.swf")]
		private var basket_z116a_p78:Class;
		[Embed(source = "../../../../assets/basket_z117a_p78.swf")]
		private var basket_z117a_p78:Class;
		[Embed(source = "../../../../assets/basket_z118a_p78.swf")]
		private var basket_z118a_p78:Class;
		[Embed(source = "../../../../assets/basket_z119a_p78.swf")]
		private var basket_z119a_p78:Class;
		[Embed(source = "../../../../assets/basket_z121a_p78.swf")]
		private var basket_z121a_p78:Class;
		[Embed(source = "../../../../assets/basket_z122a_p78.swf")]
		private var basket_z122a_p78:Class;
		[Embed(source = "../../../../assets/basket_z122a_p85.swf")]
		private var basket_z122a_p85:Class;
		[Embed(source = "../../../../assets/basket_z123a_p78.swf")]
		private var basket_z123a_p78:Class;
		[Embed(source = "../../../../assets/basket_z124a_p78.swf")]
		private var basket_z124a_p78:Class;
		[Embed(source = "../../../../assets/basket_z125a_p78.swf")]
		private var basket_z125a_p78:Class;
		[Embed(source = "../../../../assets/basket_z126a_p78.swf")]
		private var basket_z126a_p78:Class;
		[Embed(source = "../../../../assets/basket_z126a_p85.swf")]
		private var basket_z126a_p85:Class;
		[Embed(source = "../../../../assets/basket_z127a_p78.swf")]
		private var basket_z127a_p78:Class;
		[Embed(source = "../../../../assets/basket_z128a_p78.swf")]
		private var basket_z128a_p78:Class;
		[Embed(source = "../../../../assets/basket_z129a_p78.swf")]
		private var basket_z129a_p78:Class;
		[Embed(source = "../../../../assets/basket_z131a_p78.swf")]
		private var basket_z131a_p78:Class;
		[Embed(source = "../../../../assets/basket_z132a_p78.swf")]
		private var basket_z132a_p78:Class;
		[Embed(source = "../../../../assets/basket_z134a_p78.swf")]
		private var basket_z134a_p78:Class;
		[Embed(source = "../../../../assets/basket_z135a_p78.swf")]
		private var basket_z135a_p78:Class;
		[Embed(source = "../../../../assets/basket_z138a_p78.swf")]
		private var basket_z138a_p78:Class;
		[Embed(source = "../../../../assets/basket_z139a_p78.swf")]
		private var basket_z139a_p78:Class;
		[Embed(source = "../../../../assets/basket_z141a_p78.swf")]
		private var basket_z141a_p78:Class;
		[Embed(source = "../../../../assets/basket_z146a_p78.swf")]
		private var basket_z146a_p78:Class;
		[Embed(source = "../../../../assets/basket_z147a_p78.swf")]
		private var basket_z147a_p78:Class;
		[Embed(source = "../../../../assets/basket_z153a_p78.swf")]
		private var basket_z153a_p78:Class;
		[Embed(source = "../../../../assets/basket_z162a_p78.swf")]
		private var basket_z162a_p78:Class;
		[Embed(source = "../../../../assets/basket_z163a_p78.swf")]
		private var basket_z163a_p78:Class;
		[Embed(source = "../../../../assets/basket_z175a_p78.swf")]
		private var basket_z175a_p78:Class;
		[Embed(source = "../../../../assets/blouse_a000a_p31.swf")]
		private var blouse_a000a_p31:Class;
		[Embed(source = "../../../../assets/blouse_a000a_p33.swf")]
		private var blouse_a000a_p33:Class;
		[Embed(source = "../../../../assets/blouse_a000a_p67.swf")]
		private var blouse_a000a_p67:Class;
		[Embed(source = "../../../../assets/blouse_a000a_p85.swf")]
		private var blouse_a000a_p85:Class;
		[Embed(source = "../../../../assets/blouse_a000a_p87.swf")]
		private var blouse_a000a_p87:Class;
		[Embed(source = "../../../../assets/blouse_x000a_p33.swf")]
		private var blouse_x000a_p33:Class;
		[Embed(source = "../../../../assets/blouse_x000a_p67.swf")]
		private var blouse_x000a_p67:Class;
		[Embed(source = "../../../../assets/blouse_x000a_p87.swf")]
		private var blouse_x000a_p87:Class;
		[Embed(source = "../../../../assets/blouse_z001a_p33.swf")]
		private var blouse_z001a_p33:Class;
		[Embed(source = "../../../../assets/blouse_z001a_p40.swf")]
		private var blouse_z001a_p40:Class;
		[Embed(source = "../../../../assets/blouse_z001a_p67.swf")]
		private var blouse_z001a_p67:Class;
		[Embed(source = "../../../../assets/blouse_z001a_p87.swf")]
		private var blouse_z001a_p87:Class;
		[Embed(source = "../../../../assets/blouse_z001b_p33.swf")]
		private var blouse_z001b_p33:Class;
		[Embed(source = "../../../../assets/blouse_z001b_p67.swf")]
		private var blouse_z001b_p67:Class;
		[Embed(source = "../../../../assets/blouse_z001b_p87.swf")]
		private var blouse_z001b_p87:Class;
		[Embed(source = "../../../../assets/blouse_z002a_p33.swf")]
		private var blouse_z002a_p33:Class;
		[Embed(source = "../../../../assets/blouse_z002a_p67.swf")]
		private var blouse_z002a_p67:Class;
		[Embed(source = "../../../../assets/blouse_z002a_p87.swf")]
		private var blouse_z002a_p87:Class;
		[Embed(source = "../../../../assets/blouse_z003a_p33.swf")]
		private var blouse_z003a_p33:Class;
		[Embed(source = "../../../../assets/blouse_z003a_p67.swf")]
		private var blouse_z003a_p67:Class;
		[Embed(source = "../../../../assets/blouse_z003a_p87.swf")]
		private var blouse_z003a_p87:Class;
		[Embed(source = "../../../../assets/blouse_z003b_p33.swf")]
		private var blouse_z003b_p33:Class;
		[Embed(source = "../../../../assets/blouse_z003b_p40.swf")]
		private var blouse_z003b_p40:Class;
		[Embed(source = "../../../../assets/blouse_z003b_p67.swf")]
		private var blouse_z003b_p67:Class;
		[Embed(source = "../../../../assets/blouse_z003b_p87.swf")]
		private var blouse_z003b_p87:Class;
		[Embed(source = "../../../../assets/blouse_z006a_p33.swf")]
		private var blouse_z006a_p33:Class;
		[Embed(source = "../../../../assets/blouse_z006a_p67.swf")]
		private var blouse_z006a_p67:Class;
		[Embed(source = "../../../../assets/blouse_z006a_p87.swf")]
		private var blouse_z006a_p87:Class;
		[Embed(source = "../../../../assets/blouse_z008b_p33.swf")]
		private var blouse_z008b_p33:Class;
		[Embed(source = "../../../../assets/blouse_z008b_p40.swf")]
		private var blouse_z008b_p40:Class;
		[Embed(source = "../../../../assets/blouse_z008b_p67.swf")]
		private var blouse_z008b_p67:Class;
		[Embed(source = "../../../../assets/blouse_z008b_p75.swf")]
		private var blouse_z008b_p75:Class;
		[Embed(source = "../../../../assets/blouse_z008b_p87.swf")]
		private var blouse_z008b_p87:Class;
		[Embed(source = "../../../../assets/blouse_z013a_p33.swf")]
		private var blouse_z013a_p33:Class;
		[Embed(source = "../../../../assets/blouse_z013a_p40.swf")]
		private var blouse_z013a_p40:Class;
		[Embed(source = "../../../../assets/blouse_z013a_p67.swf")]
		private var blouse_z013a_p67:Class;
		[Embed(source = "../../../../assets/blouse_z013a_p87.swf")]
		private var blouse_z013a_p87:Class;
		[Embed(source = "../../../../assets/blouse_z017a_p33.swf")]
		private var blouse_z017a_p33:Class;
		[Embed(source = "../../../../assets/blouse_z017a_p67.swf")]
		private var blouse_z017a_p67:Class;
		[Embed(source = "../../../../assets/blouse_z017a_p87.swf")]
		private var blouse_z017a_p87:Class;
		[Embed(source = "../../../../assets/blouse_z019a_p107.swf")]
		private var blouse_z019a_p107:Class;
		[Embed(source = "../../../../assets/blouse_z019a_p33.swf")]
		private var blouse_z019a_p33:Class;
		[Embed(source = "../../../../assets/blouse_z019a_p67.swf")]
		private var blouse_z019a_p67:Class;
		[Embed(source = "../../../../assets/blouse_z019a_p87.swf")]
		private var blouse_z019a_p87:Class;
		[Embed(source = "../../../../assets/blouse_z020a_p33.swf")]
		private var blouse_z020a_p33:Class;
		[Embed(source = "../../../../assets/blouse_z020a_p67.swf")]
		private var blouse_z020a_p67:Class;
		[Embed(source = "../../../../assets/blouse_z020a_p87.swf")]
		private var blouse_z020a_p87:Class;
		[Embed(source = "../../../../assets/blouse_z021a_p33.swf")]
		private var blouse_z021a_p33:Class;
		[Embed(source = "../../../../assets/blouse_z021a_p40.swf")]
		private var blouse_z021a_p40:Class;
		[Embed(source = "../../../../assets/blouse_z021a_p67.swf")]
		private var blouse_z021a_p67:Class;
		[Embed(source = "../../../../assets/blouse_z021a_p87.swf")]
		private var blouse_z021a_p87:Class;
		[Embed(source = "../../../../assets/blouse_z024a_p33.swf")]
		private var blouse_z024a_p33:Class;
		[Embed(source = "../../../../assets/blouse_z024a_p67.swf")]
		private var blouse_z024a_p67:Class;
		[Embed(source = "../../../../assets/blouse_z024a_p87.swf")]
		private var blouse_z024a_p87:Class;
		[Embed(source = "../../../../assets/blouse_z024b_p33.swf")]
		private var blouse_z024b_p33:Class;
		[Embed(source = "../../../../assets/blouse_z024b_p40.swf")]
		private var blouse_z024b_p40:Class;
		[Embed(source = "../../../../assets/blouse_z024b_p67.swf")]
		private var blouse_z024b_p67:Class;
		[Embed(source = "../../../../assets/blouse_z024b_p87.swf")]
		private var blouse_z024b_p87:Class;
		[Embed(source = "../../../../assets/blouse_z026a_p33.swf")]
		private var blouse_z026a_p33:Class;
		[Embed(source = "../../../../assets/blouse_z026a_p40.swf")]
		private var blouse_z026a_p40:Class;
		[Embed(source = "../../../../assets/blouse_z026a_p67.swf")]
		private var blouse_z026a_p67:Class;
		[Embed(source = "../../../../assets/blouse_z026a_p87.swf")]
		private var blouse_z026a_p87:Class;
		[Embed(source = "../../../../assets/blouse_z030a_p33.swf")]
		private var blouse_z030a_p33:Class;
		[Embed(source = "../../../../assets/blouse_z030a_p67.swf")]
		private var blouse_z030a_p67:Class;
		[Embed(source = "../../../../assets/blouse_z030a_p87.swf")]
		private var blouse_z030a_p87:Class;
		[Embed(source = "../../../../assets/blouse_z030b_p33.swf")]
		private var blouse_z030b_p33:Class;
		[Embed(source = "../../../../assets/blouse_z030b_p67.swf")]
		private var blouse_z030b_p67:Class;
		[Embed(source = "../../../../assets/blouse_z030b_p87.swf")]
		private var blouse_z030b_p87:Class;
		[Embed(source = "../../../../assets/blouse_z032a_p33.swf")]
		private var blouse_z032a_p33:Class;
		[Embed(source = "../../../../assets/blouse_z032a_p40.swf")]
		private var blouse_z032a_p40:Class;
		[Embed(source = "../../../../assets/blouse_z032a_p67.swf")]
		private var blouse_z032a_p67:Class;
		[Embed(source = "../../../../assets/blouse_z032a_p87.swf")]
		private var blouse_z032a_p87:Class;
		[Embed(source = "../../../../assets/blouse_z034a_p33.swf")]
		private var blouse_z034a_p33:Class;
		[Embed(source = "../../../../assets/blouse_z034a_p67.swf")]
		private var blouse_z034a_p67:Class;
		[Embed(source = "../../../../assets/blouse_z034a_p87.swf")]
		private var blouse_z034a_p87:Class;
		[Embed(source = "../../../../assets/blouse_z037a_p33.swf")]
		private var blouse_z037a_p33:Class;
		[Embed(source = "../../../../assets/blouse_z037a_p67.swf")]
		private var blouse_z037a_p67:Class;
		[Embed(source = "../../../../assets/blouse_z037a_p87.swf")]
		private var blouse_z037a_p87:Class;
		[Embed(source = "../../../../assets/blouse_z042a_p33.swf")]
		private var blouse_z042a_p33:Class;
		[Embed(source = "../../../../assets/blouse_z042a_p40.swf")]
		private var blouse_z042a_p40:Class;
		[Embed(source = "../../../../assets/blouse_z042a_p67.swf")]
		private var blouse_z042a_p67:Class;
		[Embed(source = "../../../../assets/blouse_z042a_p87.swf")]
		private var blouse_z042a_p87:Class;
		[Embed(source = "../../../../assets/blouse_z048a_p33.swf")]
		private var blouse_z048a_p33:Class;
		[Embed(source = "../../../../assets/blouse_z048a_p40.swf")]
		private var blouse_z048a_p40:Class;
		[Embed(source = "../../../../assets/blouse_z048a_p67.swf")]
		private var blouse_z048a_p67:Class;
		[Embed(source = "../../../../assets/blouse_z048a_p87.swf")]
		private var blouse_z048a_p87:Class;
		[Embed(source = "../../../../assets/blouse_z054a_p33.swf")]
		private var blouse_z054a_p33:Class;
		[Embed(source = "../../../../assets/blouse_z054a_p67.swf")]
		private var blouse_z054a_p67:Class;
		[Embed(source = "../../../../assets/blouse_z054a_p87.swf")]
		private var blouse_z054a_p87:Class;
		[Embed(source = "../../../../assets/blouse_z058a_p111.swf")]
		private var blouse_z058a_p111:Class;
		[Embed(source = "../../../../assets/blouse_z058a_p33.swf")]
		private var blouse_z058a_p33:Class;
		[Embed(source = "../../../../assets/blouse_z058a_p40.swf")]
		private var blouse_z058a_p40:Class;
		[Embed(source = "../../../../assets/blouse_z058a_p67.swf")]
		private var blouse_z058a_p67:Class;
		[Embed(source = "../../../../assets/blouse_z058a_p87.swf")]
		private var blouse_z058a_p87:Class;
		[Embed(source = "../../../../assets/blouse_z064a_p33.swf")]
		private var blouse_z064a_p33:Class;
		[Embed(source = "../../../../assets/blouse_z064a_p67.swf")]
		private var blouse_z064a_p67:Class;
		[Embed(source = "../../../../assets/blouse_z064a_p74.swf")]
		private var blouse_z064a_p74:Class;
		[Embed(source = "../../../../assets/blouse_z064a_p87.swf")]
		private var blouse_z064a_p87:Class;
		[Embed(source = "../../../../assets/blouse_z068a_p33.swf")]
		private var blouse_z068a_p33:Class;
		[Embed(source = "../../../../assets/blouse_z068a_p67.swf")]
		private var blouse_z068a_p67:Class;
		[Embed(source = "../../../../assets/blouse_z068a_p87.swf")]
		private var blouse_z068a_p87:Class;
		[Embed(source = "../../../../assets/blouse_z069a_p33.swf")]
		private var blouse_z069a_p33:Class;
		[Embed(source = "../../../../assets/blouse_z069a_p40.swf")]
		private var blouse_z069a_p40:Class;
		[Embed(source = "../../../../assets/blouse_z069a_p67.swf")]
		private var blouse_z069a_p67:Class;
		[Embed(source = "../../../../assets/blouse_z069a_p87.swf")]
		private var blouse_z069a_p87:Class;
		[Embed(source = "../../../../assets/blouse_z074a_p33.swf")]
		private var blouse_z074a_p33:Class;
		[Embed(source = "../../../../assets/blouse_z074a_p67.swf")]
		private var blouse_z074a_p67:Class;
		[Embed(source = "../../../../assets/blouse_z074a_p87.swf")]
		private var blouse_z074a_p87:Class;
		[Embed(source = "../../../../assets/dress_a004a_p31.swf")]
		private var dress_a004a_p31:Class;
		[Embed(source = "../../../../assets/dress_a004a_p33.swf")]
		private var dress_a004a_p33:Class;
		[Embed(source = "../../../../assets/dress_a004a_p64.swf")]
		private var dress_a004a_p64:Class;
		[Embed(source = "../../../../assets/dress_a004a_p67.swf")]
		private var dress_a004a_p67:Class;
		[Embed(source = "../../../../assets/dress_a004a_p85.swf")]
		private var dress_a004a_p85:Class;
		[Embed(source = "../../../../assets/dress_a004a_p87.swf")]
		private var dress_a004a_p87:Class;
		[Embed(source = "../../../../assets/dress_a004b_p31.swf")]
		private var dress_a004b_p31:Class;
		[Embed(source = "../../../../assets/dress_a004b_p33.swf")]
		private var dress_a004b_p33:Class;
		[Embed(source = "../../../../assets/dress_a004b_p64.swf")]
		private var dress_a004b_p64:Class;
		[Embed(source = "../../../../assets/dress_a004b_p67.swf")]
		private var dress_a004b_p67:Class;
		[Embed(source = "../../../../assets/dress_a004b_p85.swf")]
		private var dress_a004b_p85:Class;
		[Embed(source = "../../../../assets/dress_a004b_p87.swf")]
		private var dress_a004b_p87:Class;
		[Embed(source = "../../../../assets/dress_a004c_p31.swf")]
		private var dress_a004c_p31:Class;
		[Embed(source = "../../../../assets/dress_a004c_p33.swf")]
		private var dress_a004c_p33:Class;
		[Embed(source = "../../../../assets/dress_a004c_p64.swf")]
		private var dress_a004c_p64:Class;
		[Embed(source = "../../../../assets/dress_a004c_p67.swf")]
		private var dress_a004c_p67:Class;
		[Embed(source = "../../../../assets/dress_a004c_p85.swf")]
		private var dress_a004c_p85:Class;
		[Embed(source = "../../../../assets/dress_a004c_p87.swf")]
		private var dress_a004c_p87:Class;
		[Embed(source = "../../../../assets/dress_a006a_p33.swf")]
		private var dress_a006a_p33:Class;
		[Embed(source = "../../../../assets/dress_a006a_p67.swf")]
		private var dress_a006a_p67:Class;
		[Embed(source = "../../../../assets/dress_a006a_p87.swf")]
		private var dress_a006a_p87:Class;
		[Embed(source = "../../../../assets/dress_a007a_p33.swf")]
		private var dress_a007a_p33:Class;
		[Embed(source = "../../../../assets/dress_a007a_p67.swf")]
		private var dress_a007a_p67:Class;
		[Embed(source = "../../../../assets/dress_a007a_p87.swf")]
		private var dress_a007a_p87:Class;
		[Embed(source = "../../../../assets/dress_a009a_p33.swf")]
		private var dress_a009a_p33:Class;
		[Embed(source = "../../../../assets/dress_a009a_p43.swf")]
		private var dress_a009a_p43:Class;
		[Embed(source = "../../../../assets/dress_a009a_p67.swf")]
		private var dress_a009a_p67:Class;
		[Embed(source = "../../../../assets/dress_a009a_p87.swf")]
		private var dress_a009a_p87:Class;
		[Embed(source = "../../../../assets/dress_a010c_p33.swf")]
		private var dress_a010c_p33:Class;
		[Embed(source = "../../../../assets/dress_a010c_p67.swf")]
		private var dress_a010c_p67:Class;
		[Embed(source = "../../../../assets/dress_a010c_p87.swf")]
		private var dress_a010c_p87:Class;
		[Embed(source = "../../../../assets/dress_a011a_p33.swf")]
		private var dress_a011a_p33:Class;
		[Embed(source = "../../../../assets/dress_a011a_p67.swf")]
		private var dress_a011a_p67:Class;
		[Embed(source = "../../../../assets/dress_a011a_p87.swf")]
		private var dress_a011a_p87:Class;
		[Embed(source = "../../../../assets/dress_b000a_p67.swf")]
		private var dress_b000a_p67:Class;
		[Embed(source = "../../../../assets/dress_b000b_p67.swf")]
		private var dress_b000b_p67:Class;
		[Embed(source = "../../../../assets/dress_b001a_p67.swf")]
		private var dress_b001a_p67:Class;
		[Embed(source = "../../../../assets/dress_b002a_p67.swf")]
		private var dress_b002a_p67:Class;
		[Embed(source = "../../../../assets/dress_b003a_p67.swf")]
		private var dress_b003a_p67:Class;
		[Embed(source = "../../../../assets/dress_x003a_p33.swf")]
		private var dress_x003a_p33:Class;
		[Embed(source = "../../../../assets/dress_x003a_p40.swf")]
		private var dress_x003a_p40:Class;
		[Embed(source = "../../../../assets/dress_x003a_p67.swf")]
		private var dress_x003a_p67:Class;
		[Embed(source = "../../../../assets/dress_x003a_p87.swf")]
		private var dress_x003a_p87:Class;
		[Embed(source = "../../../../assets/dress_x004a_p33.swf")]
		private var dress_x004a_p33:Class;
		[Embed(source = "../../../../assets/dress_x004a_p48.swf")]
		private var dress_x004a_p48:Class;
		[Embed(source = "../../../../assets/dress_x004a_p59.swf")]
		private var dress_x004a_p59:Class;
		[Embed(source = "../../../../assets/dress_x004a_p67.swf")]
		private var dress_x004a_p67:Class;
		[Embed(source = "../../../../assets/dress_x004a_p87.swf")]
		private var dress_x004a_p87:Class;
		[Embed(source = "../../../../assets/dress_x005a_p33.swf")]
		private var dress_x005a_p33:Class;
		[Embed(source = "../../../../assets/dress_x005a_p67.swf")]
		private var dress_x005a_p67:Class;
		[Embed(source = "../../../../assets/dress_x005a_p87.swf")]
		private var dress_x005a_p87:Class;
		[Embed(source = "../../../../assets/dress_x007a_p33.swf")]
		private var dress_x007a_p33:Class;
		[Embed(source = "../../../../assets/dress_x007a_p67.swf")]
		private var dress_x007a_p67:Class;
		[Embed(source = "../../../../assets/dress_x007a_p87.swf")]
		private var dress_x007a_p87:Class;
		[Embed(source = "../../../../assets/dress_x008a_p33.swf")]
		private var dress_x008a_p33:Class;
		[Embed(source = "../../../../assets/dress_x008a_p67.swf")]
		private var dress_x008a_p67:Class;
		[Embed(source = "../../../../assets/dress_x008a_p87.swf")]
		private var dress_x008a_p87:Class;
		[Embed(source = "../../../../assets/dress_x014a_p33.swf")]
		private var dress_x014a_p33:Class;
		[Embed(source = "../../../../assets/dress_x014a_p67.swf")]
		private var dress_x014a_p67:Class;
		[Embed(source = "../../../../assets/dress_x014a_p87.swf")]
		private var dress_x014a_p87:Class;
		[Embed(source = "../../../../assets/dress_x015a_p33.swf")]
		private var dress_x015a_p33:Class;
		[Embed(source = "../../../../assets/dress_x015a_p67.swf")]
		private var dress_x015a_p67:Class;
		[Embed(source = "../../../../assets/dress_x015a_p87.swf")]
		private var dress_x015a_p87:Class;
		[Embed(source = "../../../../assets/dress_z011a_p33.swf")]
		private var dress_z011a_p33:Class;
		[Embed(source = "../../../../assets/dress_z011a_p67.swf")]
		private var dress_z011a_p67:Class;
		[Embed(source = "../../../../assets/dress_z011a_p87.swf")]
		private var dress_z011a_p87:Class;
		[Embed(source = "../../../../assets/dress_z011c_p33.swf")]
		private var dress_z011c_p33:Class;
		[Embed(source = "../../../../assets/dress_z011c_p67.swf")]
		private var dress_z011c_p67:Class;
		[Embed(source = "../../../../assets/dress_z011c_p87.swf")]
		private var dress_z011c_p87:Class;
		[Embed(source = "../../../../assets/dress_z016a_p33.swf")]
		private var dress_z016a_p33:Class;
		[Embed(source = "../../../../assets/dress_z016a_p67.swf")]
		private var dress_z016a_p67:Class;
		[Embed(source = "../../../../assets/dress_z016a_p87.swf")]
		private var dress_z016a_p87:Class;
		[Embed(source = "../../../../assets/dress_z016b_p33.swf")]
		private var dress_z016b_p33:Class;
		[Embed(source = "../../../../assets/dress_z016b_p67.swf")]
		private var dress_z016b_p67:Class;
		[Embed(source = "../../../../assets/dress_z016b_p87.swf")]
		private var dress_z016b_p87:Class;
		[Embed(source = "../../../../assets/dress_z038a_p33.swf")]
		private var dress_z038a_p33:Class;
		[Embed(source = "../../../../assets/dress_z038a_p48.swf")]
		private var dress_z038a_p48:Class;
		[Embed(source = "../../../../assets/dress_z038a_p59.swf")]
		private var dress_z038a_p59:Class;
		[Embed(source = "../../../../assets/dress_z038a_p67.swf")]
		private var dress_z038a_p67:Class;
		[Embed(source = "../../../../assets/dress_z038a_p87.swf")]
		private var dress_z038a_p87:Class;
		[Embed(source = "../../../../assets/dress_z041a_p33.swf")]
		private var dress_z041a_p33:Class;
		[Embed(source = "../../../../assets/dress_z041a_p48.swf")]
		private var dress_z041a_p48:Class;
		[Embed(source = "../../../../assets/dress_z041a_p59.swf")]
		private var dress_z041a_p59:Class;
		[Embed(source = "../../../../assets/dress_z041a_p67.swf")]
		private var dress_z041a_p67:Class;
		[Embed(source = "../../../../assets/dress_z041a_p87.swf")]
		private var dress_z041a_p87:Class;
		[Embed(source = "../../../../assets/dress_z047a_p33.swf")]
		private var dress_z047a_p33:Class;
		[Embed(source = "../../../../assets/dress_z047a_p48.swf")]
		private var dress_z047a_p48:Class;
		[Embed(source = "../../../../assets/dress_z047a_p59.swf")]
		private var dress_z047a_p59:Class;
		[Embed(source = "../../../../assets/dress_z047a_p67.swf")]
		private var dress_z047a_p67:Class;
		[Embed(source = "../../../../assets/dress_z047a_p87.swf")]
		private var dress_z047a_p87:Class;
		[Embed(source = "../../../../assets/dress_z051a_p33.swf")]
		private var dress_z051a_p33:Class;
		[Embed(source = "../../../../assets/dress_z051a_p48.swf")]
		private var dress_z051a_p48:Class;
		[Embed(source = "../../../../assets/dress_z051a_p59.swf")]
		private var dress_z051a_p59:Class;
		[Embed(source = "../../../../assets/dress_z051a_p67.swf")]
		private var dress_z051a_p67:Class;
		[Embed(source = "../../../../assets/dress_z051a_p87.swf")]
		private var dress_z051a_p87:Class;
		[Embed(source = "../../../../assets/dress_z055a_p33.swf")]
		private var dress_z055a_p33:Class;
		[Embed(source = "../../../../assets/dress_z055a_p67.swf")]
		private var dress_z055a_p67:Class;
		[Embed(source = "../../../../assets/dress_z055a_p87.swf")]
		private var dress_z055a_p87:Class;
		[Embed(source = "../../../../assets/dress_z057a_p33.swf")]
		private var dress_z057a_p33:Class;
		[Embed(source = "../../../../assets/dress_z057a_p40.swf")]
		private var dress_z057a_p40:Class;
		[Embed(source = "../../../../assets/dress_z057a_p48.swf")]
		private var dress_z057a_p48:Class;
		[Embed(source = "../../../../assets/dress_z057a_p59.swf")]
		private var dress_z057a_p59:Class;
		[Embed(source = "../../../../assets/dress_z057a_p67.swf")]
		private var dress_z057a_p67:Class;
		[Embed(source = "../../../../assets/dress_z057a_p87.swf")]
		private var dress_z057a_p87:Class;
		[Embed(source = "../../../../assets/earring_m000c_p104.swf")]
		private var earring_m000c_p104:Class;
		[Embed(source = "../../../../assets/eyemask_z030a_p105.swf")]
		private var eyemask_z030a_p105:Class;
		[Embed(source = "../../../../assets/eyepatch_m000a_p105.swf")]
		private var eyepatch_m000a_p105:Class;
		[Embed(source = "../../../../assets/eyepatch_m000b_p105.swf")]
		private var eyepatch_m000b_p105:Class;
		[Embed(source = "../../../../assets/eyepatch_z002a_p105.swf")]
		private var eyepatch_z002a_p105:Class;
		[Embed(source = "../../../../assets/eyewear_z001a_p105.swf")]
		private var eyewear_z001a_p105:Class;
		[Embed(source = "../../../../assets/eyewear_z019a_p105.swf")]
		private var eyewear_z019a_p105:Class;
		[Embed(source = "../../../../assets/eye_a000a_p102.swf")]
		private var eye_a000a_p102:Class;
		[Embed(source = "../../../../assets/eye_a000b_p102.swf")]
		private var eye_a000b_p102:Class;
		[Embed(source = "../../../../assets/eye_a000c_p102.swf")]
		private var eye_a000c_p102:Class;
		[Embed(source = "../../../../assets/eye_a000d_p102.swf")]
		private var eye_a000d_p102:Class;
		[Embed(source = "../../../../assets/eye_a000e_p102.swf")]
		private var eye_a000e_p102:Class;
		[Embed(source = "../../../../assets/eye_a001a_p102.swf")]
		private var eye_a001a_p102:Class;
		[Embed(source = "../../../../assets/eye_a001b_p102.swf")]
		private var eye_a001b_p102:Class;
		[Embed(source = "../../../../assets/eye_a001c_p102.swf")]
		private var eye_a001c_p102:Class;
		[Embed(source = "../../../../assets/eye_a001d_p102.swf")]
		private var eye_a001d_p102:Class;
		[Embed(source = "../../../../assets/eye_a001e_p102.swf")]
		private var eye_a001e_p102:Class;
		[Embed(source = "../../../../assets/eye_a002a_p102.swf")]
		private var eye_a002a_p102:Class;
		[Embed(source = "../../../../assets/eye_a002b_p102.swf")]
		private var eye_a002b_p102:Class;
		[Embed(source = "../../../../assets/eye_a002c_p102.swf")]
		private var eye_a002c_p102:Class;
		[Embed(source = "../../../../assets/eye_a002d_p102.swf")]
		private var eye_a002d_p102:Class;
		[Embed(source = "../../../../assets/eye_a002e_p102.swf")]
		private var eye_a002e_p102:Class;
		[Embed(source = "../../../../assets/eye_x000a_p102.swf")]
		private var eye_x000a_p102:Class;
		[Embed(source = "../../../../assets/eye_x001a_p102.swf")]
		private var eye_x001a_p102:Class;
		[Embed(source = "../../../../assets/fairy_a001a_p4.swf")]
		private var fairy_a001a_p4:Class;
		[Embed(source = "../../../../assets/fairy_m000b_p126.swf")]
		private var fairy_m000b_p126:Class;
		[Embed(source = "../../../../assets/fairy_m000c_p126.swf")]
		private var fairy_m000c_p126:Class;
		[Embed(source = "../../../../assets/fairy_x000a_p3.swf")]
		private var fairy_x000a_p3:Class;
		[Embed(source = "../../../../assets/fairy_x001a_p2.swf")]
		private var fairy_x001a_p2:Class;
		[Embed(source = "../../../../assets/fairy_x002a_p2.swf")]
		private var fairy_x002a_p2:Class;
		[Embed(source = "../../../../assets/fairy_x002b_p2.swf")]
		private var fairy_x002b_p2:Class;
		[Embed(source = "../../../../assets/fairy_x003a_p3.swf")]
		private var fairy_x003a_p3:Class;
		[Embed(source = "../../../../assets/fairy_x003b_p3.swf")]
		private var fairy_x003b_p3:Class;
		[Embed(source = "../../../../assets/fairy_z003a_p2.swf")]
		private var fairy_z003a_p2:Class;
		[Embed(source = "../../../../assets/fairy_z006a_p120.swf")]
		private var fairy_z006a_p120:Class;
		[Embed(source = "../../../../assets/fairy_z006a_p8.swf")]
		private var fairy_z006a_p8:Class;
		[Embed(source = "../../../../assets/fairy_z006b_p120.swf")]
		private var fairy_z006b_p120:Class;
		[Embed(source = "../../../../assets/fairy_z006b_p8.swf")]
		private var fairy_z006b_p8:Class;
		[Embed(source = "../../../../assets/fairy_z011a_p124.swf")]
		private var fairy_z011a_p124:Class;
		[Embed(source = "../../../../assets/fairy_z015a_p125.swf")]
		private var fairy_z015a_p125:Class;
		[Embed(source = "../../../../assets/fairy_z026a_p2.swf")]
		private var fairy_z026a_p2:Class;
		[Embed(source = "../../../../assets/fairy_z028a_p124.swf")]
		private var fairy_z028a_p124:Class;
		[Embed(source = "../../../../assets/fairy_z037a_p120.swf")]
		private var fairy_z037a_p120:Class;
		[Embed(source = "../../../../assets/fairy_z037a_p8.swf")]
		private var fairy_z037a_p8:Class;
		[Embed(source = "../../../../assets/fairy_z046a_p125.swf")]
		private var fairy_z046a_p125:Class;
		[Embed(source = "../../../../assets/fairy_z052a_p125.swf")]
		private var fairy_z052a_p125:Class;
		[Embed(source = "../../../../assets/hairpin_a000a_p117.swf")]
		private var hairpin_a000a_p117:Class;
		[Embed(source = "../../../../assets/hairpin_a000b_p117.swf")]
		private var hairpin_a000b_p117:Class;
		[Embed(source = "../../../../assets/hairpin_a000d_p117.swf")]
		private var hairpin_a000d_p117:Class;
		[Embed(source = "../../../../assets/hair_a000a_p108.swf")]
		private var hair_a000a_p108:Class;
		[Embed(source = "../../../../assets/hair_a000a_p18.swf")]
		private var hair_a000a_p18:Class;
		[Embed(source = "../../../../assets/hair_a000b_p108.swf")]
		private var hair_a000b_p108:Class;
		[Embed(source = "../../../../assets/hair_a000b_p18.swf")]
		private var hair_a000b_p18:Class;
		[Embed(source = "../../../../assets/hair_a000c_p108.swf")]
		private var hair_a000c_p108:Class;
		[Embed(source = "../../../../assets/hair_a000c_p18.swf")]
		private var hair_a000c_p18:Class;
		[Embed(source = "../../../../assets/hair_a000d_p108.swf")]
		private var hair_a000d_p108:Class;
		[Embed(source = "../../../../assets/hair_a000d_p18.swf")]
		private var hair_a000d_p18:Class;
		[Embed(source = "../../../../assets/hair_a001g_p108.swf")]
		private var hair_a001g_p108:Class;
		[Embed(source = "../../../../assets/hair_a001g_p18.swf")]
		private var hair_a001g_p18:Class;
		[Embed(source = "../../../../assets/hair_b000a_p108.swf")]
		private var hair_b000a_p108:Class;
		[Embed(source = "../../../../assets/hair_b000a_p18.swf")]
		private var hair_b000a_p18:Class;
		[Embed(source = "../../../../assets/hair_b000b_p108.swf")]
		private var hair_b000b_p108:Class;
		[Embed(source = "../../../../assets/hair_b000b_p18.swf")]
		private var hair_b000b_p18:Class;
		[Embed(source = "../../../../assets/hair_b000c_p108.swf")]
		private var hair_b000c_p108:Class;
		[Embed(source = "../../../../assets/hair_b000c_p18.swf")]
		private var hair_b000c_p18:Class;
		[Embed(source = "../../../../assets/hair_b001b_p108.swf")]
		private var hair_b001b_p108:Class;
		[Embed(source = "../../../../assets/hair_b001d_p108.swf")]
		private var hair_b001d_p108:Class;
		[Embed(source = "../../../../assets/hair_c000d_p108.swf")]
		private var hair_c000d_p108:Class;
		[Embed(source = "../../../../assets/hair_c000d_p18.swf")]
		private var hair_c000d_p18:Class;
		[Embed(source = "../../../../assets/hair_c002i_p108.swf")]
		private var hair_c002i_p108:Class;
		[Embed(source = "../../../../assets/hair_c002i_p18.swf")]
		private var hair_c002i_p18:Class;
		[Embed(source = "../../../../assets/hair_c002m_p108.swf")]
		private var hair_c002m_p108:Class;
		[Embed(source = "../../../../assets/hair_c002m_p18.swf")]
		private var hair_c002m_p18:Class;
		[Embed(source = "../../../../assets/hair_c003h_p108.swf")]
		private var hair_c003h_p108:Class;
		[Embed(source = "../../../../assets/hair_c003h_p18.swf")]
		private var hair_c003h_p18:Class;
		[Embed(source = "../../../../assets/hair_d000a_p108.swf")]
		private var hair_d000a_p108:Class;
		[Embed(source = "../../../../assets/hair_d000a_p18.swf")]
		private var hair_d000a_p18:Class;
		[Embed(source = "../../../../assets/hair_d000a_p94.swf")]
		private var hair_d000a_p94:Class;
		[Embed(source = "../../../../assets/hair_d000b_p108.swf")]
		private var hair_d000b_p108:Class;
		[Embed(source = "../../../../assets/hair_d000b_p18.swf")]
		private var hair_d000b_p18:Class;
		[Embed(source = "../../../../assets/hair_d000b_p94.swf")]
		private var hair_d000b_p94:Class;
		[Embed(source = "../../../../assets/hair_d000c_p108.swf")]
		private var hair_d000c_p108:Class;
		[Embed(source = "../../../../assets/hair_d000c_p18.swf")]
		private var hair_d000c_p18:Class;
		[Embed(source = "../../../../assets/hair_d000c_p94.swf")]
		private var hair_d000c_p94:Class;
		[Embed(source = "../../../../assets/hair_d000d_p108.swf")]
		private var hair_d000d_p108:Class;
		[Embed(source = "../../../../assets/hair_d000d_p18.swf")]
		private var hair_d000d_p18:Class;
		[Embed(source = "../../../../assets/hair_d000d_p94.swf")]
		private var hair_d000d_p94:Class;
		[Embed(source = "../../../../assets/hair_d000k_p108.swf")]
		private var hair_d000k_p108:Class;
		[Embed(source = "../../../../assets/hair_d000k_p18.swf")]
		private var hair_d000k_p18:Class;
		[Embed(source = "../../../../assets/hair_d000k_p94.swf")]
		private var hair_d000k_p94:Class;
		[Embed(source = "../../../../assets/hair_d001h_p108.swf")]
		private var hair_d001h_p108:Class;
		[Embed(source = "../../../../assets/hair_d001h_p18.swf")]
		private var hair_d001h_p18:Class;
		[Embed(source = "../../../../assets/hair_d002c_p108.swf")]
		private var hair_d002c_p108:Class;
		[Embed(source = "../../../../assets/hair_d002c_p18.swf")]
		private var hair_d002c_p18:Class;
		[Embed(source = "../../../../assets/hair_d002d_p108.swf")]
		private var hair_d002d_p108:Class;
		[Embed(source = "../../../../assets/hair_d002d_p18.swf")]
		private var hair_d002d_p18:Class;
		[Embed(source = "../../../../assets/hair_d002h_p108.swf")]
		private var hair_d002h_p108:Class;
		[Embed(source = "../../../../assets/hair_d002h_p18.swf")]
		private var hair_d002h_p18:Class;
		[Embed(source = "../../../../assets/hair_d003i_p108.swf")]
		private var hair_d003i_p108:Class;
		[Embed(source = "../../../../assets/hair_d003i_p18.swf")]
		private var hair_d003i_p18:Class;
		[Embed(source = "../../../../assets/hair_d003i_p37.swf")]
		private var hair_d003i_p37:Class;
		[Embed(source = "../../../../assets/hair_x003a_p108.swf")]
		private var hair_x003a_p108:Class;
		[Embed(source = "../../../../assets/hair_x003a_p18.swf")]
		private var hair_x003a_p18:Class;
		[Embed(source = "../../../../assets/hair_z001a_p108.swf")]
		private var hair_z001a_p108:Class;
		[Embed(source = "../../../../assets/hair_z006a_p108.swf")]
		private var hair_z006a_p108:Class;
		[Embed(source = "../../../../assets/hair_z006a_p18.swf")]
		private var hair_z006a_p18:Class;
		[Embed(source = "../../../../assets/hair_z007a_p108.swf")]
		private var hair_z007a_p108:Class;
		[Embed(source = "../../../../assets/hair_z007a_p18.swf")]
		private var hair_z007a_p18:Class;
		[Embed(source = "../../../../assets/hair_z007a_p94.swf")]
		private var hair_z007a_p94:Class;
		[Embed(source = "../../../../assets/hair_z011b_p108.swf")]
		private var hair_z011b_p108:Class;
		[Embed(source = "../../../../assets/hair_z011b_p18.swf")]
		private var hair_z011b_p18:Class;
		[Embed(source = "../../../../assets/hair_z011b_p94.swf")]
		private var hair_z011b_p94:Class;
		[Embed(source = "../../../../assets/hair_z016a_p108.swf")]
		private var hair_z016a_p108:Class;
		[Embed(source = "../../../../assets/hair_z016a_p18.swf")]
		private var hair_z016a_p18:Class;
		[Embed(source = "../../../../assets/hair_z016b_p108.swf")]
		private var hair_z016b_p108:Class;
		[Embed(source = "../../../../assets/hair_z016b_p18.swf")]
		private var hair_z016b_p18:Class;
		[Embed(source = "../../../../assets/hair_z022a_p108.swf")]
		private var hair_z022a_p108:Class;
		[Embed(source = "../../../../assets/hair_z022a_p18.swf")]
		private var hair_z022a_p18:Class;
		[Embed(source = "../../../../assets/hair_z022a_p75.swf")]
		private var hair_z022a_p75:Class;
		[Embed(source = "../../../../assets/hair_z030a_p108.swf")]
		private var hair_z030a_p108:Class;
		[Embed(source = "../../../../assets/hair_z030a_p18.swf")]
		private var hair_z030a_p18:Class;
		[Embed(source = "../../../../assets/hair_z031a_p108.swf")]
		private var hair_z031a_p108:Class;
		[Embed(source = "../../../../assets/hair_z031a_p18.swf")]
		private var hair_z031a_p18:Class;
		[Embed(source = "../../../../assets/hair_z031a_p94.swf")]
		private var hair_z031a_p94:Class;
		[Embed(source = "../../../../assets/hair_z032a_p108.swf")]
		private var hair_z032a_p108:Class;
		[Embed(source = "../../../../assets/hair_z032a_p18.swf")]
		private var hair_z032a_p18:Class;
		[Embed(source = "../../../../assets/hair_z032a_p94.swf")]
		private var hair_z032a_p94:Class;
		[Embed(source = "../../../../assets/hair_z034b_p108.swf")]
		private var hair_z034b_p108:Class;
		[Embed(source = "../../../../assets/hair_z034b_p18.swf")]
		private var hair_z034b_p18:Class;
		[Embed(source = "../../../../assets/hair_z034c_p108.swf")]
		private var hair_z034c_p108:Class;
		[Embed(source = "../../../../assets/hair_z034c_p18.swf")]
		private var hair_z034c_p18:Class;
		[Embed(source = "../../../../assets/hair_z036a_p108.swf")]
		private var hair_z036a_p108:Class;
		[Embed(source = "../../../../assets/hair_z036a_p18.swf")]
		private var hair_z036a_p18:Class;
		[Embed(source = "../../../../assets/hair_z036a_p94.swf")]
		private var hair_z036a_p94:Class;
		[Embed(source = "../../../../assets/hair_z041a_p108.swf")]
		private var hair_z041a_p108:Class;
		[Embed(source = "../../../../assets/hair_z041a_p18.swf")]
		private var hair_z041a_p18:Class;
		[Embed(source = "../../../../assets/hair_z046a_p108.swf")]
		private var hair_z046a_p108:Class;
		[Embed(source = "../../../../assets/hair_z047a_p108.swf")]
		private var hair_z047a_p108:Class;
		[Embed(source = "../../../../assets/hair_z047a_p18.swf")]
		private var hair_z047a_p18:Class;
		[Embed(source = "../../../../assets/hair_z048a_p108.swf")]
		private var hair_z048a_p108:Class;
		[Embed(source = "../../../../assets/hair_z048a_p18.swf")]
		private var hair_z048a_p18:Class;
		[Embed(source = "../../../../assets/hair_z055a_p108.swf")]
		private var hair_z055a_p108:Class;
		[Embed(source = "../../../../assets/hair_z055a_p18.swf")]
		private var hair_z055a_p18:Class;
		[Embed(source = "../../../../assets/hair_z064a_p108.swf")]
		private var hair_z064a_p108:Class;
		[Embed(source = "../../../../assets/hair_z064a_p18.swf")]
		private var hair_z064a_p18:Class;
		[Embed(source = "../../../../assets/hat_m000a_p112.swf")]
		private var hat_m000a_p112:Class;
		[Embed(source = "../../../../assets/hat_x000a_p112.swf")]
		private var hat_x000a_p112:Class;
		[Embed(source = "../../../../assets/hat_x000a_p17.swf")]
		private var hat_x000a_p17:Class;
		[Embed(source = "../../../../assets/hat_x002a_p112.swf")]
		private var hat_x002a_p112:Class;
		[Embed(source = "../../../../assets/hat_x002a_p17.swf")]
		private var hat_x002a_p17:Class;
		[Embed(source = "../../../../assets/hat_x004a_p117.swf")]
		private var hat_x004a_p117:Class;
		[Embed(source = "../../../../assets/hat_x005a_p114.swf")]
		private var hat_x005a_p114:Class;
		[Embed(source = "../../../../assets/hat_x011a_p112.swf")]
		private var hat_x011a_p112:Class;
		[Embed(source = "../../../../assets/hat_x011a_p17.swf")]
		private var hat_x011a_p17:Class;
		[Embed(source = "../../../../assets/hat_x012a_p117.swf")]
		private var hat_x012a_p117:Class;
		[Embed(source = "../../../../assets/hat_x014a_p117.swf")]
		private var hat_x014a_p117:Class;
		[Embed(source = "../../../../assets/hat_x015a_p111.swf")]
		private var hat_x015a_p111:Class;
		[Embed(source = "../../../../assets/hat_x015a_p17.swf")]
		private var hat_x015a_p17:Class;
		[Embed(source = "../../../../assets/hat_z008a_p112.swf")]
		private var hat_z008a_p112:Class;
		[Embed(source = "../../../../assets/hat_z011a_p111.swf")]
		private var hat_z011a_p111:Class;
		[Embed(source = "../../../../assets/hat_z016a_p111.swf")]
		private var hat_z016a_p111:Class;
		[Embed(source = "../../../../assets/hat_z021a_p112.swf")]
		private var hat_z021a_p112:Class;
		[Embed(source = "../../../../assets/hat_z021a_p17.swf")]
		private var hat_z021a_p17:Class;
		[Embed(source = "../../../../assets/hat_z030b_p112.swf")]
		private var hat_z030b_p112:Class;
		[Embed(source = "../../../../assets/hat_z041a_p111.swf")]
		private var hat_z041a_p111:Class;
		[Embed(source = "../../../../assets/hat_z051a_p111.swf")]
		private var hat_z051a_p111:Class;
		[Embed(source = "../../../../assets/hat_z051a_p17.swf")]
		private var hat_z051a_p17:Class;
		[Embed(source = "../../../../assets/hat_z057a_p112.swf")]
		private var hat_z057a_p112:Class;
		[Embed(source = "../../../../assets/hat_z057a_p17.swf")]
		private var hat_z057a_p17:Class;
		[Embed(source = "../../../../assets/hat_z101a_p112.swf")]
		private var hat_z101a_p112:Class;
		[Embed(source = "../../../../assets/hat_z101b_p112.swf")]
		private var hat_z101b_p112:Class;
		[Embed(source = "../../../../assets/hat_z102a_p112.swf")]
		private var hat_z102a_p112:Class;
		[Embed(source = "../../../../assets/hat_z103a_p112.swf")]
		private var hat_z103a_p112:Class;
		[Embed(source = "../../../../assets/hat_z106a_p112.swf")]
		private var hat_z106a_p112:Class;
		[Embed(source = "../../../../assets/hat_z107a_p112.swf")]
		private var hat_z107a_p112:Class;
		[Embed(source = "../../../../assets/hat_z108a_p112.swf")]
		private var hat_z108a_p112:Class;
		[Embed(source = "../../../../assets/hat_z112a_p112.swf")]
		private var hat_z112a_p112:Class;
		[Embed(source = "../../../../assets/hat_z113a_p112.swf")]
		private var hat_z113a_p112:Class;
		[Embed(source = "../../../../assets/hat_z115a_p112.swf")]
		private var hat_z115a_p112:Class;
		[Embed(source = "../../../../assets/hat_z116a_p112.swf")]
		private var hat_z116a_p112:Class;
		[Embed(source = "../../../../assets/hat_z117a_p112.swf")]
		private var hat_z117a_p112:Class;
		[Embed(source = "../../../../assets/hat_z119a_p112.swf")]
		private var hat_z119a_p112:Class;
		[Embed(source = "../../../../assets/hat_z120a_p112.swf")]
		private var hat_z120a_p112:Class;
		[Embed(source = "../../../../assets/hat_z122a_p112.swf")]
		private var hat_z122a_p112:Class;
		[Embed(source = "../../../../assets/hat_z123a_p112.swf")]
		private var hat_z123a_p112:Class;
		[Embed(source = "../../../../assets/hat_z129a_p112.swf")]
		private var hat_z129a_p112:Class;
		[Embed(source = "../../../../assets/hat_z131a_p112.swf")]
		private var hat_z131a_p112:Class;
		[Embed(source = "../../../../assets/hat_z134a_p112.swf")]
		private var hat_z134a_p112:Class;
		[Embed(source = "../../../../assets/hat_z135a_p112.swf")]
		private var hat_z135a_p112:Class;
		[Embed(source = "../../../../assets/hat_z141a_p112.swf")]
		private var hat_z141a_p112:Class;
		[Embed(source = "../../../../assets/hat_z148a_p112.swf")]
		private var hat_z148a_p112:Class;
		[Embed(source = "../../../../assets/hat_z151a_p112.swf")]
		private var hat_z151a_p112:Class;
		[Embed(source = "../../../../assets/hat_z153a_p112.swf")]
		private var hat_z153a_p112:Class;
		[Embed(source = "../../../../assets/hat_z155a_p112.swf")]
		private var hat_z155a_p112:Class;
		[Embed(source = "../../../../assets/hat_z157a_p112.swf")]
		private var hat_z157a_p112:Class;
		[Embed(source = "../../../../assets/hat_z159a_p112.swf")]
		private var hat_z159a_p112:Class;
		[Embed(source = "../../../../assets/hat_z162a_p112.swf")]
		private var hat_z162a_p112:Class;
		[Embed(source = "../../../../assets/lefthand_x002a_p34.swf")]
		private var lefthand_x002a_p34:Class;
		[Embed(source = "../../../../assets/lefthand_z001a_p34.swf")]
		private var lefthand_z001a_p34:Class;
		[Embed(source = "../../../../assets/lefthand_z003a_p34.swf")]
		private var lefthand_z003a_p34:Class;
		[Embed(source = "../../../../assets/lefthand_z004a_p34.swf")]
		private var lefthand_z004a_p34:Class;
		[Embed(source = "../../../../assets/lefthand_z068b_p34.swf")]
		private var lefthand_z068b_p34:Class;
		[Embed(source = "../../../../assets/lefthand_z101b_p34.swf")]
		private var lefthand_z101b_p34:Class;
		[Embed(source = "../../../../assets/lefthand_z101p_p34.swf")]
		private var lefthand_z101p_p34:Class;
		[Embed(source = "../../../../assets/lefthand_z103p_p34.swf")]
		private var lefthand_z103p_p34:Class;
		[Embed(source = "../../../../assets/lefthand_z111p_p34.swf")]
		private var lefthand_z111p_p34:Class;
		[Embed(source = "../../../../assets/lefthand_z115p_p34.swf")]
		private var lefthand_z115p_p34:Class;
		[Embed(source = "../../../../assets/lefthand_z119b_p34.swf")]
		private var lefthand_z119b_p34:Class;
		[Embed(source = "../../../../assets/mant_x000a_p21.swf")]
		private var mant_x000a_p21:Class;
		[Embed(source = "../../../../assets/mant_x000a_p91.swf")]
		private var mant_x000a_p91:Class;
		[Embed(source = "../../../../assets/mant_x001a_p108.swf")]
		private var mant_x001a_p108:Class;
		[Embed(source = "../../../../assets/mant_x001a_p21.swf")]
		private var mant_x001a_p21:Class;
		[Embed(source = "../../../../assets/mant_x001a_p91.swf")]
		private var mant_x001a_p91:Class;
		[Embed(source = "../../../../assets/mant_z001a_p21.swf")]
		private var mant_z001a_p21:Class;
		[Embed(source = "../../../../assets/mant_z001a_p91.swf")]
		private var mant_z001a_p91:Class;
		[Embed(source = "../../../../assets/mant_z010a_p21.swf")]
		private var mant_z010a_p21:Class;
		[Embed(source = "../../../../assets/mant_z010a_p91.swf")]
		private var mant_z010a_p91:Class;
		[Embed(source = "../../../../assets/mant_z012a_p21.swf")]
		private var mant_z012a_p21:Class;
		[Embed(source = "../../../../assets/mant_z012a_p75.swf")]
		private var mant_z012a_p75:Class;
		[Embed(source = "../../../../assets/mant_z012a_p91.swf")]
		private var mant_z012a_p91:Class;
		[Embed(source = "../../../../assets/mant_z018a_p21.swf")]
		private var mant_z018a_p21:Class;
		[Embed(source = "../../../../assets/mant_z018a_p91.swf")]
		private var mant_z018a_p91:Class;
		[Embed(source = "../../../../assets/mant_z038a_p21.swf")]
		private var mant_z038a_p21:Class;
		[Embed(source = "../../../../assets/mant_z038a_p91.swf")]
		private var mant_z038a_p91:Class;
		[Embed(source = "../../../../assets/mant_z047a_p21.swf")]
		private var mant_z047a_p21:Class;
		[Embed(source = "../../../../assets/mant_z047a_p91.swf")]
		private var mant_z047a_p91:Class;
		[Embed(source = "../../../../assets/mask_x002a_p105.swf")]
		private var mask_x002a_p105:Class;
		[Embed(source = "../../../../assets/mask_z005a_p105.swf")]
		private var mask_z005a_p105:Class;
		[Embed(source = "../../../../assets/mask_z022a_p105.swf")]
		private var mask_z022a_p105:Class;
		[Embed(source = "../../../../assets/mouth_a000a_p101.swf")]
		private var mouth_a000a_p101:Class;
		[Embed(source = "../../../../assets/mouth_a001a_p101.swf")]
		private var mouth_a001a_p101:Class;
		[Embed(source = "../../../../assets/mouth_b000a_p101.swf")]
		private var mouth_b000a_p101:Class;
		[Embed(source = "../../../../assets/mouth_x000a_p101.swf")]
		private var mouth_x000a_p101:Class;
		[Embed(source = "../../../../assets/mouth_x001a_p101.swf")]
		private var mouth_x001a_p101:Class;
		[Embed(source = "../../../../assets/paint_z014a_p98.swf")]
		private var paint_z014a_p98:Class;
		[Embed(source = "../../../../assets/paint_z021a_p98.swf")]
		private var paint_z021a_p98:Class;
		[Embed(source = "../../../../assets/paint_z037a_p98.swf")]
		private var paint_z037a_p98:Class;
		[Embed(source = "../../../../assets/paint_z050a_p98.swf")]
		private var paint_z050a_p98:Class;
		[Embed(source = "../../../../assets/paint_z071a_p98.swf")]
		private var paint_z071a_p98:Class;
		[Embed(source = "../../../../assets/ribbon_a000a_p112.swf")]
		private var ribbon_a000a_p112:Class;
		[Embed(source = "../../../../assets/ribbon_a001a_p112.swf")]
		private var ribbon_a001a_p112:Class;
		[Embed(source = "../../../../assets/ribbon_a001b_p112.swf")]
		private var ribbon_a001b_p112:Class;
		[Embed(source = "../../../../assets/ribbon_a002a_p112.swf")]
		private var ribbon_a002a_p112:Class;
		[Embed(source = "../../../../assets/ribbon_x000a_p114.swf")]
		private var ribbon_x000a_p114:Class;
		[Embed(source = "../../../../assets/ribbon_x001a_p117.swf")]
		private var ribbon_x001a_p117:Class;
		[Embed(source = "../../../../assets/ribbon_x001a_p16.swf")]
		private var ribbon_x001a_p16:Class;
		[Embed(source = "../../../../assets/ribbon_x002a_p117.swf")]
		private var ribbon_x002a_p117:Class;
		[Embed(source = "../../../../assets/ribbon_x002a_p16.swf")]
		private var ribbon_x002a_p16:Class;
		[Embed(source = "../../../../assets/ring_m000a_p82.swf")]
		private var ring_m000a_p82:Class;
		[Embed(source = "../../../../assets/shoes_a000a_p48.swf")]
		private var shoes_a000a_p48:Class;
		[Embed(source = "../../../../assets/shoes_a000a_p51.swf")]
		private var shoes_a000a_p51:Class;
		[Embed(source = "../../../../assets/shoes_a000a_p59.swf")]
		private var shoes_a000a_p59:Class;
		[Embed(source = "../../../../assets/shoes_a000a_p62.swf")]
		private var shoes_a000a_p62:Class;
		[Embed(source = "../../../../assets/shoes_b000a_p51.swf")]
		private var shoes_b000a_p51:Class;
		[Embed(source = "../../../../assets/shoes_b000a_p62.swf")]
		private var shoes_b000a_p62:Class;
		[Embed(source = "../../../../assets/shoes_c000a_p51.swf")]
		private var shoes_c000a_p51:Class;
		[Embed(source = "../../../../assets/shoes_c000a_p62.swf")]
		private var shoes_c000a_p62:Class;
		[Embed(source = "../../../../assets/shoes_c000b_p51.swf")]
		private var shoes_c000b_p51:Class;
		[Embed(source = "../../../../assets/shoes_c000b_p62.swf")]
		private var shoes_c000b_p62:Class;
		[Embed(source = "../../../../assets/shoes_x003a_p51.swf")]
		private var shoes_x003a_p51:Class;
		[Embed(source = "../../../../assets/shoes_x003a_p62.swf")]
		private var shoes_x003a_p62:Class;
		[Embed(source = "../../../../assets/shoes_x004a_p51.swf")]
		private var shoes_x004a_p51:Class;
		[Embed(source = "../../../../assets/shoes_x004a_p62.swf")]
		private var shoes_x004a_p62:Class;
		[Embed(source = "../../../../assets/shoes_x005a_p51.swf")]
		private var shoes_x005a_p51:Class;
		[Embed(source = "../../../../assets/shoes_x005a_p62.swf")]
		private var shoes_x005a_p62:Class;
		[Embed(source = "../../../../assets/shoes_x006a_p51.swf")]
		private var shoes_x006a_p51:Class;
		[Embed(source = "../../../../assets/shoes_x006a_p62.swf")]
		private var shoes_x006a_p62:Class;
		[Embed(source = "../../../../assets/shoes_x007a_p51.swf")]
		private var shoes_x007a_p51:Class;
		[Embed(source = "../../../../assets/shoes_x007a_p62.swf")]
		private var shoes_x007a_p62:Class;
		[Embed(source = "../../../../assets/shoes_x008a_p51.swf")]
		private var shoes_x008a_p51:Class;
		[Embed(source = "../../../../assets/shoes_x008a_p62.swf")]
		private var shoes_x008a_p62:Class;
		[Embed(source = "../../../../assets/shoes_x010a_p51.swf")]
		private var shoes_x010a_p51:Class;
		[Embed(source = "../../../../assets/shoes_x010a_p62.swf")]
		private var shoes_x010a_p62:Class;
		[Embed(source = "../../../../assets/shoes_x011a_p51.swf")]
		private var shoes_x011a_p51:Class;
		[Embed(source = "../../../../assets/shoes_x011a_p62.swf")]
		private var shoes_x011a_p62:Class;
		[Embed(source = "../../../../assets/shoes_x014a_p51.swf")]
		private var shoes_x014a_p51:Class;
		[Embed(source = "../../../../assets/shoes_x014a_p62.swf")]
		private var shoes_x014a_p62:Class;
		[Embed(source = "../../../../assets/shoes_x015a_p51.swf")]
		private var shoes_x015a_p51:Class;
		[Embed(source = "../../../../assets/shoes_x015a_p62.swf")]
		private var shoes_x015a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z002a_p51.swf")]
		private var shoes_z002a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z002a_p62.swf")]
		private var shoes_z002a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z003a_p51.swf")]
		private var shoes_z003a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z003a_p62.swf")]
		private var shoes_z003a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z005a_p51.swf")]
		private var shoes_z005a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z005a_p62.swf")]
		private var shoes_z005a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z006a_p51.swf")]
		private var shoes_z006a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z006a_p62.swf")]
		private var shoes_z006a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z008a_p51.swf")]
		private var shoes_z008a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z008a_p62.swf")]
		private var shoes_z008a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z011a_p51.swf")]
		private var shoes_z011a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z011a_p62.swf")]
		private var shoes_z011a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z013a_p51.swf")]
		private var shoes_z013a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z013a_p62.swf")]
		private var shoes_z013a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z015a_p51.swf")]
		private var shoes_z015a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z015a_p62.swf")]
		private var shoes_z015a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z016a_p51.swf")]
		private var shoes_z016a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z016a_p62.swf")]
		private var shoes_z016a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z016b_p51.swf")]
		private var shoes_z016b_p51:Class;
		[Embed(source = "../../../../assets/shoes_z016b_p62.swf")]
		private var shoes_z016b_p62:Class;
		[Embed(source = "../../../../assets/shoes_z017a_p51.swf")]
		private var shoes_z017a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z017a_p62.swf")]
		private var shoes_z017a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z018a_p51.swf")]
		private var shoes_z018a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z018a_p62.swf")]
		private var shoes_z018a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z019a_p51.swf")]
		private var shoes_z019a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z019a_p62.swf")]
		private var shoes_z019a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z020a_p51.swf")]
		private var shoes_z020a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z020a_p62.swf")]
		private var shoes_z020a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z021a_p51.swf")]
		private var shoes_z021a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z021a_p62.swf")]
		private var shoes_z021a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z022a_p51.swf")]
		private var shoes_z022a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z022a_p62.swf")]
		private var shoes_z022a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z023a_p51.swf")]
		private var shoes_z023a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z023a_p62.swf")]
		private var shoes_z023a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z024a_p51.swf")]
		private var shoes_z024a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z024a_p62.swf")]
		private var shoes_z024a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z026a_p51.swf")]
		private var shoes_z026a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z026a_p62.swf")]
		private var shoes_z026a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z028a_p51.swf")]
		private var shoes_z028a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z028a_p62.swf")]
		private var shoes_z028a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z030a_p51.swf")]
		private var shoes_z030a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z030a_p62.swf")]
		private var shoes_z030a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z031a_p51.swf")]
		private var shoes_z031a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z031a_p62.swf")]
		private var shoes_z031a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z032a_p51.swf")]
		private var shoes_z032a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z032a_p62.swf")]
		private var shoes_z032a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z034a_p51.swf")]
		private var shoes_z034a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z034a_p62.swf")]
		private var shoes_z034a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z037a_p51.swf")]
		private var shoes_z037a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z037a_p62.swf")]
		private var shoes_z037a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z038a_p52.swf")]
		private var shoes_z038a_p52:Class;
		[Embed(source = "../../../../assets/shoes_z038a_p62.swf")]
		private var shoes_z038a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z041a_p51.swf")]
		private var shoes_z041a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z041a_p62.swf")]
		private var shoes_z041a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z046a_p51.swf")]
		private var shoes_z046a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z046a_p62.swf")]
		private var shoes_z046a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z047a_p51.swf")]
		private var shoes_z047a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z047a_p62.swf")]
		private var shoes_z047a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z048a_p51.swf")]
		private var shoes_z048a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z048a_p62.swf")]
		private var shoes_z048a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z051a_p51.swf")]
		private var shoes_z051a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z051a_p62.swf")]
		private var shoes_z051a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z057a_p51.swf")]
		private var shoes_z057a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z057a_p62.swf")]
		private var shoes_z057a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z058a_p51.swf")]
		private var shoes_z058a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z058a_p62.swf")]
		private var shoes_z058a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z059a_p51.swf")]
		private var shoes_z059a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z059a_p62.swf")]
		private var shoes_z059a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z061a_p51.swf")]
		private var shoes_z061a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z061a_p62.swf")]
		private var shoes_z061a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z062a_p42.swf")]
		private var shoes_z062a_p42:Class;
		[Embed(source = "../../../../assets/shoes_z062a_p51.swf")]
		private var shoes_z062a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z062a_p62.swf")]
		private var shoes_z062a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z064a_p51.swf")]
		private var shoes_z064a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z064a_p62.swf")]
		private var shoes_z064a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z069a_p51.swf")]
		private var shoes_z069a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z069a_p62.swf")]
		private var shoes_z069a_p62:Class;
		[Embed(source = "../../../../assets/shoes_z300a_p51.swf")]
		private var shoes_z300a_p51:Class;
		[Embed(source = "../../../../assets/shoes_z300a_p62.swf")]
		private var shoes_z300a_p62:Class;
		[Embed(source = "../../../../assets/skirt_a000a_p69.swf")]
		private var skirt_a000a_p69:Class;
		[Embed(source = "../../../../assets/skirt_x002a_p48.swf")]
		private var skirt_x002a_p48:Class;
		[Embed(source = "../../../../assets/skirt_x002a_p59.swf")]
		private var skirt_x002a_p59:Class;
		[Embed(source = "../../../../assets/skirt_z002a_p48.swf")]
		private var skirt_z002a_p48:Class;
		[Embed(source = "../../../../assets/skirt_z002a_p59.swf")]
		private var skirt_z002a_p59:Class;
		[Embed(source = "../../../../assets/skirt_z003a_p48.swf")]
		private var skirt_z003a_p48:Class;
		[Embed(source = "../../../../assets/skirt_z003a_p59.swf")]
		private var skirt_z003a_p59:Class;
		[Embed(source = "../../../../assets/skirt_z003a_p69.swf")]
		private var skirt_z003a_p69:Class;
		[Embed(source = "../../../../assets/skirt_z003b_p48.swf")]
		private var skirt_z003b_p48:Class;
		[Embed(source = "../../../../assets/skirt_z003b_p59.swf")]
		private var skirt_z003b_p59:Class;
		[Embed(source = "../../../../assets/skirt_z003b_p69.swf")]
		private var skirt_z003b_p69:Class;
		[Embed(source = "../../../../assets/skirt_z006a_p64.swf")]
		private var skirt_z006a_p64:Class;
		[Embed(source = "../../../../assets/skirt_z008a_p69.swf")]
		private var skirt_z008a_p69:Class;
		[Embed(source = "../../../../assets/skirt_z011a_p45.swf")]
		private var skirt_z011a_p45:Class;
		[Embed(source = "../../../../assets/skirt_z011a_p56.swf")]
		private var skirt_z011a_p56:Class;
		[Embed(source = "../../../../assets/skirt_z012a_p64.swf")]
		private var skirt_z012a_p64:Class;
		[Embed(source = "../../../../assets/skirt_z012a_p69.swf")]
		private var skirt_z012a_p69:Class;
		[Embed(source = "../../../../assets/skirt_z013a_p64.swf")]
		private var skirt_z013a_p64:Class;
		[Embed(source = "../../../../assets/skirt_z014a_p48.swf")]
		private var skirt_z014a_p48:Class;
		[Embed(source = "../../../../assets/skirt_z014a_p59.swf")]
		private var skirt_z014a_p59:Class;
		[Embed(source = "../../../../assets/skirt_z015a_p64.swf")]
		private var skirt_z015a_p64:Class;
		[Embed(source = "../../../../assets/skirt_z017a_p64.swf")]
		private var skirt_z017a_p64:Class;
		[Embed(source = "../../../../assets/skirt_z018a_p48.swf")]
		private var skirt_z018a_p48:Class;
		[Embed(source = "../../../../assets/skirt_z018a_p59.swf")]
		private var skirt_z018a_p59:Class;
		[Embed(source = "../../../../assets/skirt_z019a_p64.swf")]
		private var skirt_z019a_p64:Class;
		[Embed(source = "../../../../assets/skirt_z021a_p64.swf")]
		private var skirt_z021a_p64:Class;
		[Embed(source = "../../../../assets/skirt_z022a_p48.swf")]
		private var skirt_z022a_p48:Class;
		[Embed(source = "../../../../assets/skirt_z022a_p59.swf")]
		private var skirt_z022a_p59:Class;
		[Embed(source = "../../../../assets/skirt_z024a_p48.swf")]
		private var skirt_z024a_p48:Class;
		[Embed(source = "../../../../assets/skirt_z024a_p59.swf")]
		private var skirt_z024a_p59:Class;
		[Embed(source = "../../../../assets/skirt_z026a_p64.swf")]
		private var skirt_z026a_p64:Class;
		[Embed(source = "../../../../assets/skirt_z030a_p64.swf")]
		private var skirt_z030a_p64:Class;
		[Embed(source = "../../../../assets/skirt_z033a_p69.swf")]
		private var skirt_z033a_p69:Class;
		[Embed(source = "../../../../assets/skirt_z034a_p48.swf")]
		private var skirt_z034a_p48:Class;
		[Embed(source = "../../../../assets/skirt_z034a_p59.swf")]
		private var skirt_z034a_p59:Class;
		[Embed(source = "../../../../assets/skirt_z036a_p64.swf")]
		private var skirt_z036a_p64:Class;
		[Embed(source = "../../../../assets/skirt_z037a_p64.swf")]
		private var skirt_z037a_p64:Class;
		[Embed(source = "../../../../assets/skirt_z045a_p48.swf")]
		private var skirt_z045a_p48:Class;
		[Embed(source = "../../../../assets/skirt_z045a_p59.swf")]
		private var skirt_z045a_p59:Class;
		[Embed(source = "../../../../assets/skirt_z046a_p64.swf")]
		private var skirt_z046a_p64:Class;
		[Embed(source = "../../../../assets/skirt_z048a_p48.swf")]
		private var skirt_z048a_p48:Class;
		[Embed(source = "../../../../assets/skirt_z048a_p59.swf")]
		private var skirt_z048a_p59:Class;
		[Embed(source = "../../../../assets/skirt_z050a_p64.swf")]
		private var skirt_z050a_p64:Class;
		[Embed(source = "../../../../assets/skirt_z058a_p48.swf")]
		private var skirt_z058a_p48:Class;
		[Embed(source = "../../../../assets/skirt_z058a_p59.swf")]
		private var skirt_z058a_p59:Class;
		[Embed(source = "../../../../assets/skirt_z059a_p64.swf")]
		private var skirt_z059a_p64:Class;
		[Embed(source = "../../../../assets/skirt_z061a_p48.swf")]
		private var skirt_z061a_p48:Class;
		[Embed(source = "../../../../assets/skirt_z061a_p59.swf")]
		private var skirt_z061a_p59:Class;
		[Embed(source = "../../../../assets/skirt_z064a_p69.swf")]
		private var skirt_z064a_p69:Class;
		[Embed(source = "../../../../assets/skirt_z069a_p64.swf")]
		private var skirt_z069a_p64:Class;
		[Embed(source = "../../../../assets/skirt_z074a_p64.swf")]
		private var skirt_z074a_p64:Class;
		[Embed(source = "../../../../assets/swim_o_a000a_p67.swf")]
		private var swim_o_a000a_p67:Class;
		[Embed(source = "../../../../assets/swim_t_a000a_p67.swf")]
		private var swim_t_a000a_p67:Class;
		[Embed(source = "../../../../assets/swim_u_a000a_p64.swf")]
		private var swim_u_a000a_p64:Class;
		[Embed(source = "../../../../assets/swim_u_a001a_p64.swf")]
		private var swim_u_a001a_p64:Class;
		[Embed(source = "../../../../assets/tail_z029a_p10.swf")]
		private var tail_z029a_p10:Class;
		[Embed(source = "../../../../assets/tiara_a000b_p112.swf")]
		private var tiara_a000b_p112:Class;
		[Embed(source = "../../../../assets/tiara_a000c_p112.swf")]
		private var tiara_a000c_p112:Class;
		[Embed(source = "../../../../assets/tiara_m000c_p114.swf")]
		private var tiara_m000c_p114:Class;
		[Embed(source = "../../../../assets/wand_x000b_p78.swf")]
		private var wand_x000b_p78:Class;
		[Embed(source = "../../../../assets/wing_a000a_p12.swf")]
		private var wing_a000a_p12:Class;
		
		private var _map:Object = null;
		
		private var _grpMap:Object = null;
		
		public function AssetsManager()
		{
			this._map = {};
			
			this._map["bag_a041a_p77"] = new bag_a041a_p77();
			this._map["base_a000_p27"] = new base_a000_p27();
			this._map["base_a000_p31"] = new base_a000_p31();
			this._map["base_a000_p33"] = new base_a000_p33();
			this._map["base_a000_p44"] = new base_a000_p44();
			this._map["base_a000_p48"] = new base_a000_p48();
			this._map["base_a000_p51"] = new base_a000_p51();
			this._map["base_a000_p53"] = new base_a000_p53();
			this._map["base_a000_p55"] = new base_a000_p55();
			this._map["base_a000_p59"] = new base_a000_p59();
			this._map["base_a000_p62"] = new base_a000_p62();
			this._map["base_a000_p67"] = new base_a000_p67();
			this._map["base_a000_p81"] = new base_a000_p81();
			this._map["base_a000_p85"] = new base_a000_p85();
			this._map["base_a000_p87"] = new base_a000_p87();
			this._map["base_a000_p97"] = new base_a000_p97();
			this._map["basket_x002a_p78"] = new basket_x002a_p78();
			this._map["basket_z011a_p78"] = new basket_z011a_p78();
			this._map["basket_z030a_p78"] = new basket_z030a_p78();
			this._map["basket_z052a_p78"] = new basket_z052a_p78();
			this._map["basket_z101a_p78"] = new basket_z101a_p78();
			this._map["basket_z102a_p78"] = new basket_z102a_p78();
			this._map["basket_z103a_p78"] = new basket_z103a_p78();
			this._map["basket_z103b_p78"] = new basket_z103b_p78();
			this._map["basket_z104a_p78"] = new basket_z104a_p78();
			this._map["basket_z106a_p78"] = new basket_z106a_p78();
			this._map["basket_z107a_p78"] = new basket_z107a_p78();
			this._map["basket_z108a_p78"] = new basket_z108a_p78();
			this._map["basket_z109a_p78"] = new basket_z109a_p78();
			this._map["basket_z110a_p78"] = new basket_z110a_p78();
			this._map["basket_z111b_p78"] = new basket_z111b_p78();
			this._map["basket_z113a_p78"] = new basket_z113a_p78();
			this._map["basket_z114a_p78"] = new basket_z114a_p78();
			this._map["basket_z115a_p78"] = new basket_z115a_p78();
			this._map["basket_z116a_p78"] = new basket_z116a_p78();
			this._map["basket_z117a_p78"] = new basket_z117a_p78();
			this._map["basket_z118a_p78"] = new basket_z118a_p78();
			this._map["basket_z119a_p78"] = new basket_z119a_p78();
			this._map["basket_z121a_p78"] = new basket_z121a_p78();
			this._map["basket_z122a_p78"] = new basket_z122a_p78();
			this._map["basket_z122a_p85"] = new basket_z122a_p85();
			this._map["basket_z123a_p78"] = new basket_z123a_p78();
			this._map["basket_z124a_p78"] = new basket_z124a_p78();
			this._map["basket_z125a_p78"] = new basket_z125a_p78();
			this._map["basket_z126a_p78"] = new basket_z126a_p78();
			this._map["basket_z126a_p85"] = new basket_z126a_p85();
			this._map["basket_z127a_p78"] = new basket_z127a_p78();
			this._map["basket_z128a_p78"] = new basket_z128a_p78();
			this._map["basket_z129a_p78"] = new basket_z129a_p78();
			this._map["basket_z131a_p78"] = new basket_z131a_p78();
			this._map["basket_z132a_p78"] = new basket_z132a_p78();
			this._map["basket_z134a_p78"] = new basket_z134a_p78();
			this._map["basket_z135a_p78"] = new basket_z135a_p78();
			this._map["basket_z138a_p78"] = new basket_z138a_p78();
			this._map["basket_z139a_p78"] = new basket_z139a_p78();
			this._map["basket_z141a_p78"] = new basket_z141a_p78();
			this._map["basket_z146a_p78"] = new basket_z146a_p78();
			this._map["basket_z147a_p78"] = new basket_z147a_p78();
			this._map["basket_z153a_p78"] = new basket_z153a_p78();
			this._map["basket_z162a_p78"] = new basket_z162a_p78();
			this._map["basket_z163a_p78"] = new basket_z163a_p78();
			this._map["basket_z175a_p78"] = new basket_z175a_p78();
			this._map["blouse_a000a_p31"] = new blouse_a000a_p31();
			this._map["blouse_a000a_p33"] = new blouse_a000a_p33();
			this._map["blouse_a000a_p67"] = new blouse_a000a_p67();
			this._map["blouse_a000a_p85"] = new blouse_a000a_p85();
			this._map["blouse_a000a_p87"] = new blouse_a000a_p87();
			this._map["blouse_x000a_p33"] = new blouse_x000a_p33();
			this._map["blouse_x000a_p67"] = new blouse_x000a_p67();
			this._map["blouse_x000a_p87"] = new blouse_x000a_p87();
			this._map["blouse_z001a_p33"] = new blouse_z001a_p33();
			this._map["blouse_z001a_p40"] = new blouse_z001a_p40();
			this._map["blouse_z001a_p67"] = new blouse_z001a_p67();
			this._map["blouse_z001a_p87"] = new blouse_z001a_p87();
			this._map["blouse_z001b_p33"] = new blouse_z001b_p33();
			this._map["blouse_z001b_p67"] = new blouse_z001b_p67();
			this._map["blouse_z001b_p87"] = new blouse_z001b_p87();
			this._map["blouse_z002a_p33"] = new blouse_z002a_p33();
			this._map["blouse_z002a_p67"] = new blouse_z002a_p67();
			this._map["blouse_z002a_p87"] = new blouse_z002a_p87();
			this._map["blouse_z003a_p33"] = new blouse_z003a_p33();
			this._map["blouse_z003a_p67"] = new blouse_z003a_p67();
			this._map["blouse_z003a_p87"] = new blouse_z003a_p87();
			this._map["blouse_z003b_p33"] = new blouse_z003b_p33();
			this._map["blouse_z003b_p40"] = new blouse_z003b_p40();
			this._map["blouse_z003b_p67"] = new blouse_z003b_p67();
			this._map["blouse_z003b_p87"] = new blouse_z003b_p87();
			this._map["blouse_z006a_p33"] = new blouse_z006a_p33();
			this._map["blouse_z006a_p67"] = new blouse_z006a_p67();
			this._map["blouse_z006a_p87"] = new blouse_z006a_p87();
			this._map["blouse_z008b_p33"] = new blouse_z008b_p33();
			this._map["blouse_z008b_p40"] = new blouse_z008b_p40();
			this._map["blouse_z008b_p67"] = new blouse_z008b_p67();
			this._map["blouse_z008b_p75"] = new blouse_z008b_p75();
			this._map["blouse_z008b_p87"] = new blouse_z008b_p87();
			this._map["blouse_z013a_p33"] = new blouse_z013a_p33();
			this._map["blouse_z013a_p40"] = new blouse_z013a_p40();
			this._map["blouse_z013a_p67"] = new blouse_z013a_p67();
			this._map["blouse_z013a_p87"] = new blouse_z013a_p87();
			this._map["blouse_z017a_p33"] = new blouse_z017a_p33();
			this._map["blouse_z017a_p67"] = new blouse_z017a_p67();
			this._map["blouse_z017a_p87"] = new blouse_z017a_p87();
			this._map["blouse_z019a_p107"] = new blouse_z019a_p107();
			this._map["blouse_z019a_p33"] = new blouse_z019a_p33();
			this._map["blouse_z019a_p67"] = new blouse_z019a_p67();
			this._map["blouse_z019a_p87"] = new blouse_z019a_p87();
			this._map["blouse_z020a_p33"] = new blouse_z020a_p33();
			this._map["blouse_z020a_p67"] = new blouse_z020a_p67();
			this._map["blouse_z020a_p87"] = new blouse_z020a_p87();
			this._map["blouse_z021a_p33"] = new blouse_z021a_p33();
			this._map["blouse_z021a_p40"] = new blouse_z021a_p40();
			this._map["blouse_z021a_p67"] = new blouse_z021a_p67();
			this._map["blouse_z021a_p87"] = new blouse_z021a_p87();
			this._map["blouse_z024a_p33"] = new blouse_z024a_p33();
			this._map["blouse_z024a_p67"] = new blouse_z024a_p67();
			this._map["blouse_z024a_p87"] = new blouse_z024a_p87();
			this._map["blouse_z024b_p33"] = new blouse_z024b_p33();
			this._map["blouse_z024b_p40"] = new blouse_z024b_p40();
			this._map["blouse_z024b_p67"] = new blouse_z024b_p67();
			this._map["blouse_z024b_p87"] = new blouse_z024b_p87();
			this._map["blouse_z026a_p33"] = new blouse_z026a_p33();
			this._map["blouse_z026a_p40"] = new blouse_z026a_p40();
			this._map["blouse_z026a_p67"] = new blouse_z026a_p67();
			this._map["blouse_z026a_p87"] = new blouse_z026a_p87();
			this._map["blouse_z030a_p33"] = new blouse_z030a_p33();
			this._map["blouse_z030a_p67"] = new blouse_z030a_p67();
			this._map["blouse_z030a_p87"] = new blouse_z030a_p87();
			this._map["blouse_z030b_p33"] = new blouse_z030b_p33();
			this._map["blouse_z030b_p67"] = new blouse_z030b_p67();
			this._map["blouse_z030b_p87"] = new blouse_z030b_p87();
			this._map["blouse_z032a_p33"] = new blouse_z032a_p33();
			this._map["blouse_z032a_p40"] = new blouse_z032a_p40();
			this._map["blouse_z032a_p67"] = new blouse_z032a_p67();
			this._map["blouse_z032a_p87"] = new blouse_z032a_p87();
			this._map["blouse_z034a_p33"] = new blouse_z034a_p33();
			this._map["blouse_z034a_p67"] = new blouse_z034a_p67();
			this._map["blouse_z034a_p87"] = new blouse_z034a_p87();
			this._map["blouse_z037a_p33"] = new blouse_z037a_p33();
			this._map["blouse_z037a_p67"] = new blouse_z037a_p67();
			this._map["blouse_z037a_p87"] = new blouse_z037a_p87();
			this._map["blouse_z042a_p33"] = new blouse_z042a_p33();
			this._map["blouse_z042a_p40"] = new blouse_z042a_p40();
			this._map["blouse_z042a_p67"] = new blouse_z042a_p67();
			this._map["blouse_z042a_p87"] = new blouse_z042a_p87();
			this._map["blouse_z048a_p33"] = new blouse_z048a_p33();
			this._map["blouse_z048a_p40"] = new blouse_z048a_p40();
			this._map["blouse_z048a_p67"] = new blouse_z048a_p67();
			this._map["blouse_z048a_p87"] = new blouse_z048a_p87();
			this._map["blouse_z054a_p33"] = new blouse_z054a_p33();
			this._map["blouse_z054a_p67"] = new blouse_z054a_p67();
			this._map["blouse_z054a_p87"] = new blouse_z054a_p87();
			this._map["blouse_z058a_p111"] = new blouse_z058a_p111();
			this._map["blouse_z058a_p33"] = new blouse_z058a_p33();
			this._map["blouse_z058a_p40"] = new blouse_z058a_p40();
			this._map["blouse_z058a_p67"] = new blouse_z058a_p67();
			this._map["blouse_z058a_p87"] = new blouse_z058a_p87();
			this._map["blouse_z064a_p33"] = new blouse_z064a_p33();
			this._map["blouse_z064a_p67"] = new blouse_z064a_p67();
			this._map["blouse_z064a_p74"] = new blouse_z064a_p74();
			this._map["blouse_z064a_p87"] = new blouse_z064a_p87();
			this._map["blouse_z068a_p33"] = new blouse_z068a_p33();
			this._map["blouse_z068a_p67"] = new blouse_z068a_p67();
			this._map["blouse_z068a_p87"] = new blouse_z068a_p87();
			this._map["blouse_z069a_p33"] = new blouse_z069a_p33();
			this._map["blouse_z069a_p40"] = new blouse_z069a_p40();
			this._map["blouse_z069a_p67"] = new blouse_z069a_p67();
			this._map["blouse_z069a_p87"] = new blouse_z069a_p87();
			this._map["blouse_z074a_p33"] = new blouse_z074a_p33();
			this._map["blouse_z074a_p67"] = new blouse_z074a_p67();
			this._map["blouse_z074a_p87"] = new blouse_z074a_p87();
			this._map["dress_a004a_p31"] = new dress_a004a_p31();
			this._map["dress_a004a_p33"] = new dress_a004a_p33();
			this._map["dress_a004a_p64"] = new dress_a004a_p64();
			this._map["dress_a004a_p67"] = new dress_a004a_p67();
			this._map["dress_a004a_p85"] = new dress_a004a_p85();
			this._map["dress_a004a_p87"] = new dress_a004a_p87();
			this._map["dress_a004b_p31"] = new dress_a004b_p31();
			this._map["dress_a004b_p33"] = new dress_a004b_p33();
			this._map["dress_a004b_p64"] = new dress_a004b_p64();
			this._map["dress_a004b_p67"] = new dress_a004b_p67();
			this._map["dress_a004b_p85"] = new dress_a004b_p85();
			this._map["dress_a004b_p87"] = new dress_a004b_p87();
			this._map["dress_a004c_p31"] = new dress_a004c_p31();
			this._map["dress_a004c_p33"] = new dress_a004c_p33();
			this._map["dress_a004c_p64"] = new dress_a004c_p64();
			this._map["dress_a004c_p67"] = new dress_a004c_p67();
			this._map["dress_a004c_p85"] = new dress_a004c_p85();
			this._map["dress_a004c_p87"] = new dress_a004c_p87();
			this._map["dress_a006a_p33"] = new dress_a006a_p33();
			this._map["dress_a006a_p67"] = new dress_a006a_p67();
			this._map["dress_a006a_p87"] = new dress_a006a_p87();
			this._map["dress_a007a_p33"] = new dress_a007a_p33();
			this._map["dress_a007a_p67"] = new dress_a007a_p67();
			this._map["dress_a007a_p87"] = new dress_a007a_p87();
			this._map["dress_a009a_p33"] = new dress_a009a_p33();
			this._map["dress_a009a_p43"] = new dress_a009a_p43();
			this._map["dress_a009a_p67"] = new dress_a009a_p67();
			this._map["dress_a009a_p87"] = new dress_a009a_p87();
			this._map["dress_a010c_p33"] = new dress_a010c_p33();
			this._map["dress_a010c_p67"] = new dress_a010c_p67();
			this._map["dress_a010c_p87"] = new dress_a010c_p87();
			this._map["dress_a011a_p33"] = new dress_a011a_p33();
			this._map["dress_a011a_p67"] = new dress_a011a_p67();
			this._map["dress_a011a_p87"] = new dress_a011a_p87();
			this._map["dress_b000a_p67"] = new dress_b000a_p67();
			this._map["dress_b000b_p67"] = new dress_b000b_p67();
			this._map["dress_b001a_p67"] = new dress_b001a_p67();
			this._map["dress_b002a_p67"] = new dress_b002a_p67();
			this._map["dress_b003a_p67"] = new dress_b003a_p67();
			this._map["dress_x003a_p33"] = new dress_x003a_p33();
			this._map["dress_x003a_p40"] = new dress_x003a_p40();
			this._map["dress_x003a_p67"] = new dress_x003a_p67();
			this._map["dress_x003a_p87"] = new dress_x003a_p87();
			this._map["dress_x004a_p33"] = new dress_x004a_p33();
			this._map["dress_x004a_p48"] = new dress_x004a_p48();
			this._map["dress_x004a_p59"] = new dress_x004a_p59();
			this._map["dress_x004a_p67"] = new dress_x004a_p67();
			this._map["dress_x004a_p87"] = new dress_x004a_p87();
			this._map["dress_x005a_p33"] = new dress_x005a_p33();
			this._map["dress_x005a_p67"] = new dress_x005a_p67();
			this._map["dress_x005a_p87"] = new dress_x005a_p87();
			this._map["dress_x007a_p33"] = new dress_x007a_p33();
			this._map["dress_x007a_p67"] = new dress_x007a_p67();
			this._map["dress_x007a_p87"] = new dress_x007a_p87();
			this._map["dress_x008a_p33"] = new dress_x008a_p33();
			this._map["dress_x008a_p67"] = new dress_x008a_p67();
			this._map["dress_x008a_p87"] = new dress_x008a_p87();
			this._map["dress_x014a_p33"] = new dress_x014a_p33();
			this._map["dress_x014a_p67"] = new dress_x014a_p67();
			this._map["dress_x014a_p87"] = new dress_x014a_p87();
			this._map["dress_x015a_p33"] = new dress_x015a_p33();
			this._map["dress_x015a_p67"] = new dress_x015a_p67();
			this._map["dress_x015a_p87"] = new dress_x015a_p87();
			this._map["dress_z011a_p33"] = new dress_z011a_p33();
			this._map["dress_z011a_p67"] = new dress_z011a_p67();
			this._map["dress_z011a_p87"] = new dress_z011a_p87();
			this._map["dress_z011c_p33"] = new dress_z011c_p33();
			this._map["dress_z011c_p67"] = new dress_z011c_p67();
			this._map["dress_z011c_p87"] = new dress_z011c_p87();
			this._map["dress_z016a_p33"] = new dress_z016a_p33();
			this._map["dress_z016a_p67"] = new dress_z016a_p67();
			this._map["dress_z016a_p87"] = new dress_z016a_p87();
			this._map["dress_z016b_p33"] = new dress_z016b_p33();
			this._map["dress_z016b_p67"] = new dress_z016b_p67();
			this._map["dress_z016b_p87"] = new dress_z016b_p87();
			this._map["dress_z038a_p33"] = new dress_z038a_p33();
			this._map["dress_z038a_p48"] = new dress_z038a_p48();
			this._map["dress_z038a_p59"] = new dress_z038a_p59();
			this._map["dress_z038a_p67"] = new dress_z038a_p67();
			this._map["dress_z038a_p87"] = new dress_z038a_p87();
			this._map["dress_z041a_p33"] = new dress_z041a_p33();
			this._map["dress_z041a_p48"] = new dress_z041a_p48();
			this._map["dress_z041a_p59"] = new dress_z041a_p59();
			this._map["dress_z041a_p67"] = new dress_z041a_p67();
			this._map["dress_z041a_p87"] = new dress_z041a_p87();
			this._map["dress_z047a_p33"] = new dress_z047a_p33();
			this._map["dress_z047a_p48"] = new dress_z047a_p48();
			this._map["dress_z047a_p59"] = new dress_z047a_p59();
			this._map["dress_z047a_p67"] = new dress_z047a_p67();
			this._map["dress_z047a_p87"] = new dress_z047a_p87();
			this._map["dress_z051a_p33"] = new dress_z051a_p33();
			this._map["dress_z051a_p48"] = new dress_z051a_p48();
			this._map["dress_z051a_p59"] = new dress_z051a_p59();
			this._map["dress_z051a_p67"] = new dress_z051a_p67();
			this._map["dress_z051a_p87"] = new dress_z051a_p87();
			this._map["dress_z055a_p33"] = new dress_z055a_p33();
			this._map["dress_z055a_p67"] = new dress_z055a_p67();
			this._map["dress_z055a_p87"] = new dress_z055a_p87();
			this._map["dress_z057a_p33"] = new dress_z057a_p33();
			this._map["dress_z057a_p40"] = new dress_z057a_p40();
			this._map["dress_z057a_p48"] = new dress_z057a_p48();
			this._map["dress_z057a_p59"] = new dress_z057a_p59();
			this._map["dress_z057a_p67"] = new dress_z057a_p67();
			this._map["dress_z057a_p87"] = new dress_z057a_p87();
			this._map["earring_m000c_p104"] = new earring_m000c_p104();
			this._map["eyemask_z030a_p105"] = new eyemask_z030a_p105();
			this._map["eyepatch_m000a_p105"] = new eyepatch_m000a_p105();
			this._map["eyepatch_m000b_p105"] = new eyepatch_m000b_p105();
			this._map["eyepatch_z002a_p105"] = new eyepatch_z002a_p105();
			this._map["eyewear_z001a_p105"] = new eyewear_z001a_p105();
			this._map["eyewear_z019a_p105"] = new eyewear_z019a_p105();
			this._map["eye_a000a_p102"] = new eye_a000a_p102();
			this._map["eye_a000b_p102"] = new eye_a000b_p102();
			this._map["eye_a000c_p102"] = new eye_a000c_p102();
			this._map["eye_a000d_p102"] = new eye_a000d_p102();
			this._map["eye_a000e_p102"] = new eye_a000e_p102();
			this._map["eye_a001a_p102"] = new eye_a001a_p102();
			this._map["eye_a001b_p102"] = new eye_a001b_p102();
			this._map["eye_a001c_p102"] = new eye_a001c_p102();
			this._map["eye_a001d_p102"] = new eye_a001d_p102();
			this._map["eye_a001e_p102"] = new eye_a001e_p102();
			this._map["eye_a002a_p102"] = new eye_a002a_p102();
			this._map["eye_a002b_p102"] = new eye_a002b_p102();
			this._map["eye_a002c_p102"] = new eye_a002c_p102();
			this._map["eye_a002d_p102"] = new eye_a002d_p102();
			this._map["eye_a002e_p102"] = new eye_a002e_p102();
			this._map["eye_x000a_p102"] = new eye_x000a_p102();
			this._map["eye_x001a_p102"] = new eye_x001a_p102();
			this._map["fairy_a001a_p4"] = new fairy_a001a_p4();
			this._map["fairy_m000b_p126"] = new fairy_m000b_p126();
			this._map["fairy_m000c_p126"] = new fairy_m000c_p126();
			this._map["fairy_x000a_p3"] = new fairy_x000a_p3();
			this._map["fairy_x001a_p2"] = new fairy_x001a_p2();
			this._map["fairy_x002a_p2"] = new fairy_x002a_p2();
			this._map["fairy_x002b_p2"] = new fairy_x002b_p2();
			this._map["fairy_x003a_p3"] = new fairy_x003a_p3();
			this._map["fairy_x003b_p3"] = new fairy_x003b_p3();
			this._map["fairy_z003a_p2"] = new fairy_z003a_p2();
			this._map["fairy_z006a_p120"] = new fairy_z006a_p120();
			this._map["fairy_z006a_p8"] = new fairy_z006a_p8();
			this._map["fairy_z006b_p120"] = new fairy_z006b_p120();
			this._map["fairy_z006b_p8"] = new fairy_z006b_p8();
			this._map["fairy_z011a_p124"] = new fairy_z011a_p124();
			this._map["fairy_z015a_p125"] = new fairy_z015a_p125();
			this._map["fairy_z026a_p2"] = new fairy_z026a_p2();
			this._map["fairy_z028a_p124"] = new fairy_z028a_p124();
			this._map["fairy_z037a_p120"] = new fairy_z037a_p120();
			this._map["fairy_z037a_p8"] = new fairy_z037a_p8();
			this._map["fairy_z046a_p125"] = new fairy_z046a_p125();
			this._map["fairy_z052a_p125"] = new fairy_z052a_p125();
			this._map["hairpin_a000a_p117"] = new hairpin_a000a_p117();
			this._map["hairpin_a000b_p117"] = new hairpin_a000b_p117();
			this._map["hairpin_a000d_p117"] = new hairpin_a000d_p117();
			this._map["hair_a000a_p108"] = new hair_a000a_p108();
			this._map["hair_a000a_p18"] = new hair_a000a_p18();
			this._map["hair_a000b_p108"] = new hair_a000b_p108();
			this._map["hair_a000b_p18"] = new hair_a000b_p18();
			this._map["hair_a000c_p108"] = new hair_a000c_p108();
			this._map["hair_a000c_p18"] = new hair_a000c_p18();
			this._map["hair_a000d_p108"] = new hair_a000d_p108();
			this._map["hair_a000d_p18"] = new hair_a000d_p18();
			this._map["hair_a001g_p108"] = new hair_a001g_p108();
			this._map["hair_a001g_p18"] = new hair_a001g_p18();
			this._map["hair_b000a_p108"] = new hair_b000a_p108();
			this._map["hair_b000a_p18"] = new hair_b000a_p18();
			this._map["hair_b000b_p108"] = new hair_b000b_p108();
			this._map["hair_b000b_p18"] = new hair_b000b_p18();
			this._map["hair_b000c_p108"] = new hair_b000c_p108();
			this._map["hair_b000c_p18"] = new hair_b000c_p18();
			this._map["hair_b001b_p108"] = new hair_b001b_p108();
			this._map["hair_b001d_p108"] = new hair_b001d_p108();
			this._map["hair_c000d_p108"] = new hair_c000d_p108();
			this._map["hair_c000d_p18"] = new hair_c000d_p18();
			this._map["hair_c002i_p108"] = new hair_c002i_p108();
			this._map["hair_c002i_p18"] = new hair_c002i_p18();
			this._map["hair_c002m_p108"] = new hair_c002m_p108();
			this._map["hair_c002m_p18"] = new hair_c002m_p18();
			this._map["hair_c003h_p108"] = new hair_c003h_p108();
			this._map["hair_c003h_p18"] = new hair_c003h_p18();
			this._map["hair_d000a_p108"] = new hair_d000a_p108();
			this._map["hair_d000a_p18"] = new hair_d000a_p18();
			this._map["hair_d000a_p94"] = new hair_d000a_p94();
			this._map["hair_d000b_p108"] = new hair_d000b_p108();
			this._map["hair_d000b_p18"] = new hair_d000b_p18();
			this._map["hair_d000b_p94"] = new hair_d000b_p94();
			this._map["hair_d000c_p108"] = new hair_d000c_p108();
			this._map["hair_d000c_p18"] = new hair_d000c_p18();
			this._map["hair_d000c_p94"] = new hair_d000c_p94();
			this._map["hair_d000d_p108"] = new hair_d000d_p108();
			this._map["hair_d000d_p18"] = new hair_d000d_p18();
			this._map["hair_d000d_p94"] = new hair_d000d_p94();
			this._map["hair_d000k_p108"] = new hair_d000k_p108();
			this._map["hair_d000k_p18"] = new hair_d000k_p18();
			this._map["hair_d000k_p94"] = new hair_d000k_p94();
			this._map["hair_d001h_p108"] = new hair_d001h_p108();
			this._map["hair_d001h_p18"] = new hair_d001h_p18();
			this._map["hair_d002c_p108"] = new hair_d002c_p108();
			this._map["hair_d002c_p18"] = new hair_d002c_p18();
			this._map["hair_d002d_p108"] = new hair_d002d_p108();
			this._map["hair_d002d_p18"] = new hair_d002d_p18();
			this._map["hair_d002h_p108"] = new hair_d002h_p108();
			this._map["hair_d002h_p18"] = new hair_d002h_p18();
			this._map["hair_d003i_p108"] = new hair_d003i_p108();
			this._map["hair_d003i_p18"] = new hair_d003i_p18();
			this._map["hair_d003i_p37"] = new hair_d003i_p37();
			this._map["hair_x003a_p108"] = new hair_x003a_p108();
			this._map["hair_x003a_p18"] = new hair_x003a_p18();
			this._map["hair_z001a_p108"] = new hair_z001a_p108();
			this._map["hair_z006a_p108"] = new hair_z006a_p108();
			this._map["hair_z006a_p18"] = new hair_z006a_p18();
			this._map["hair_z007a_p108"] = new hair_z007a_p108();
			this._map["hair_z007a_p18"] = new hair_z007a_p18();
			this._map["hair_z007a_p94"] = new hair_z007a_p94();
			this._map["hair_z011b_p108"] = new hair_z011b_p108();
			this._map["hair_z011b_p18"] = new hair_z011b_p18();
			this._map["hair_z011b_p94"] = new hair_z011b_p94();
			this._map["hair_z016a_p108"] = new hair_z016a_p108();
			this._map["hair_z016a_p18"] = new hair_z016a_p18();
			this._map["hair_z016b_p108"] = new hair_z016b_p108();
			this._map["hair_z016b_p18"] = new hair_z016b_p18();
			this._map["hair_z022a_p108"] = new hair_z022a_p108();
			this._map["hair_z022a_p18"] = new hair_z022a_p18();
			this._map["hair_z022a_p75"] = new hair_z022a_p75();
			this._map["hair_z030a_p108"] = new hair_z030a_p108();
			this._map["hair_z030a_p18"] = new hair_z030a_p18();
			this._map["hair_z031a_p108"] = new hair_z031a_p108();
			this._map["hair_z031a_p18"] = new hair_z031a_p18();
			this._map["hair_z031a_p94"] = new hair_z031a_p94();
			this._map["hair_z032a_p108"] = new hair_z032a_p108();
			this._map["hair_z032a_p18"] = new hair_z032a_p18();
			this._map["hair_z032a_p94"] = new hair_z032a_p94();
			this._map["hair_z034b_p108"] = new hair_z034b_p108();
			this._map["hair_z034b_p18"] = new hair_z034b_p18();
			this._map["hair_z034c_p108"] = new hair_z034c_p108();
			this._map["hair_z034c_p18"] = new hair_z034c_p18();
			this._map["hair_z036a_p108"] = new hair_z036a_p108();
			this._map["hair_z036a_p18"] = new hair_z036a_p18();
			this._map["hair_z036a_p94"] = new hair_z036a_p94();
			this._map["hair_z041a_p108"] = new hair_z041a_p108();
			this._map["hair_z041a_p18"] = new hair_z041a_p18();
			this._map["hair_z046a_p108"] = new hair_z046a_p108();
			this._map["hair_z047a_p108"] = new hair_z047a_p108();
			this._map["hair_z047a_p18"] = new hair_z047a_p18();
			this._map["hair_z048a_p108"] = new hair_z048a_p108();
			this._map["hair_z048a_p18"] = new hair_z048a_p18();
			this._map["hair_z055a_p108"] = new hair_z055a_p108();
			this._map["hair_z055a_p18"] = new hair_z055a_p18();
			this._map["hair_z064a_p108"] = new hair_z064a_p108();
			this._map["hair_z064a_p18"] = new hair_z064a_p18();
			this._map["hat_m000a_p112"] = new hat_m000a_p112();
			this._map["hat_x000a_p112"] = new hat_x000a_p112();
			this._map["hat_x000a_p17"] = new hat_x000a_p17();
			this._map["hat_x002a_p112"] = new hat_x002a_p112();
			this._map["hat_x002a_p17"] = new hat_x002a_p17();
			this._map["hat_x004a_p117"] = new hat_x004a_p117();
			this._map["hat_x005a_p114"] = new hat_x005a_p114();
			this._map["hat_x011a_p112"] = new hat_x011a_p112();
			this._map["hat_x011a_p17"] = new hat_x011a_p17();
			this._map["hat_x012a_p117"] = new hat_x012a_p117();
			this._map["hat_x014a_p117"] = new hat_x014a_p117();
			this._map["hat_x015a_p111"] = new hat_x015a_p111();
			this._map["hat_x015a_p17"] = new hat_x015a_p17();
			this._map["hat_z008a_p112"] = new hat_z008a_p112();
			this._map["hat_z011a_p111"] = new hat_z011a_p111();
			this._map["hat_z016a_p111"] = new hat_z016a_p111();
			this._map["hat_z021a_p112"] = new hat_z021a_p112();
			this._map["hat_z021a_p17"] = new hat_z021a_p17();
			this._map["hat_z030b_p112"] = new hat_z030b_p112();
			this._map["hat_z041a_p111"] = new hat_z041a_p111();
			this._map["hat_z051a_p111"] = new hat_z051a_p111();
			this._map["hat_z051a_p17"] = new hat_z051a_p17();
			this._map["hat_z057a_p112"] = new hat_z057a_p112();
			this._map["hat_z057a_p17"] = new hat_z057a_p17();
			this._map["hat_z101a_p112"] = new hat_z101a_p112();
			this._map["hat_z101b_p112"] = new hat_z101b_p112();
			this._map["hat_z102a_p112"] = new hat_z102a_p112();
			this._map["hat_z103a_p112"] = new hat_z103a_p112();
			this._map["hat_z106a_p112"] = new hat_z106a_p112();
			this._map["hat_z107a_p112"] = new hat_z107a_p112();
			this._map["hat_z108a_p112"] = new hat_z108a_p112();
			this._map["hat_z112a_p112"] = new hat_z112a_p112();
			this._map["hat_z113a_p112"] = new hat_z113a_p112();
			this._map["hat_z115a_p112"] = new hat_z115a_p112();
			this._map["hat_z116a_p112"] = new hat_z116a_p112();
			this._map["hat_z117a_p112"] = new hat_z117a_p112();
			this._map["hat_z119a_p112"] = new hat_z119a_p112();
			this._map["hat_z120a_p112"] = new hat_z120a_p112();
			this._map["hat_z122a_p112"] = new hat_z122a_p112();
			this._map["hat_z123a_p112"] = new hat_z123a_p112();
			this._map["hat_z129a_p112"] = new hat_z129a_p112();
			this._map["hat_z131a_p112"] = new hat_z131a_p112();
			this._map["hat_z134a_p112"] = new hat_z134a_p112();
			this._map["hat_z135a_p112"] = new hat_z135a_p112();
			this._map["hat_z141a_p112"] = new hat_z141a_p112();
			this._map["hat_z148a_p112"] = new hat_z148a_p112();
			this._map["hat_z151a_p112"] = new hat_z151a_p112();
			this._map["hat_z153a_p112"] = new hat_z153a_p112();
			this._map["hat_z155a_p112"] = new hat_z155a_p112();
			this._map["hat_z157a_p112"] = new hat_z157a_p112();
			this._map["hat_z159a_p112"] = new hat_z159a_p112();
			this._map["hat_z162a_p112"] = new hat_z162a_p112();
			this._map["lefthand_x002a_p34"] = new lefthand_x002a_p34();
			this._map["lefthand_z001a_p34"] = new lefthand_z001a_p34();
			this._map["lefthand_z003a_p34"] = new lefthand_z003a_p34();
			this._map["lefthand_z004a_p34"] = new lefthand_z004a_p34();
			this._map["lefthand_z068b_p34"] = new lefthand_z068b_p34();
			this._map["lefthand_z101b_p34"] = new lefthand_z101b_p34();
			this._map["lefthand_z101p_p34"] = new lefthand_z101p_p34();
			this._map["lefthand_z103p_p34"] = new lefthand_z103p_p34();
			this._map["lefthand_z111p_p34"] = new lefthand_z111p_p34();
			this._map["lefthand_z115p_p34"] = new lefthand_z115p_p34();
			this._map["lefthand_z119b_p34"] = new lefthand_z119b_p34();
			this._map["mant_x000a_p21"] = new mant_x000a_p21();
			this._map["mant_x000a_p91"] = new mant_x000a_p91();
			this._map["mant_x001a_p108"] = new mant_x001a_p108();
			this._map["mant_x001a_p21"] = new mant_x001a_p21();
			this._map["mant_x001a_p91"] = new mant_x001a_p91();
			this._map["mant_z001a_p21"] = new mant_z001a_p21();
			this._map["mant_z001a_p91"] = new mant_z001a_p91();
			this._map["mant_z010a_p21"] = new mant_z010a_p21();
			this._map["mant_z010a_p91"] = new mant_z010a_p91();
			this._map["mant_z012a_p21"] = new mant_z012a_p21();
			this._map["mant_z012a_p75"] = new mant_z012a_p75();
			this._map["mant_z012a_p91"] = new mant_z012a_p91();
			this._map["mant_z018a_p21"] = new mant_z018a_p21();
			this._map["mant_z018a_p91"] = new mant_z018a_p91();
			this._map["mant_z038a_p21"] = new mant_z038a_p21();
			this._map["mant_z038a_p91"] = new mant_z038a_p91();
			this._map["mant_z047a_p21"] = new mant_z047a_p21();
			this._map["mant_z047a_p91"] = new mant_z047a_p91();
			this._map["mask_x002a_p105"] = new mask_x002a_p105();
			this._map["mask_z005a_p105"] = new mask_z005a_p105();
			this._map["mask_z022a_p105"] = new mask_z022a_p105();
			this._map["mouth_a000a_p101"] = new mouth_a000a_p101();
			this._map["mouth_a001a_p101"] = new mouth_a001a_p101();
			this._map["mouth_b000a_p101"] = new mouth_b000a_p101();
			this._map["mouth_x000a_p101"] = new mouth_x000a_p101();
			this._map["mouth_x001a_p101"] = new mouth_x001a_p101();
			this._map["paint_z014a_p98"] = new paint_z014a_p98();
			this._map["paint_z021a_p98"] = new paint_z021a_p98();
			this._map["paint_z037a_p98"] = new paint_z037a_p98();
			this._map["paint_z050a_p98"] = new paint_z050a_p98();
			this._map["paint_z071a_p98"] = new paint_z071a_p98();
			this._map["ribbon_a000a_p112"] = new ribbon_a000a_p112();
			this._map["ribbon_a001a_p112"] = new ribbon_a001a_p112();
			this._map["ribbon_a001b_p112"] = new ribbon_a001b_p112();
			this._map["ribbon_a002a_p112"] = new ribbon_a002a_p112();
			this._map["ribbon_x000a_p114"] = new ribbon_x000a_p114();
			this._map["ribbon_x001a_p117"] = new ribbon_x001a_p117();
			this._map["ribbon_x001a_p16"] = new ribbon_x001a_p16();
			this._map["ribbon_x002a_p117"] = new ribbon_x002a_p117();
			this._map["ribbon_x002a_p16"] = new ribbon_x002a_p16();
			this._map["ring_m000a_p82"] = new ring_m000a_p82();
			this._map["shoes_a000a_p48"] = new shoes_a000a_p48();
			this._map["shoes_a000a_p51"] = new shoes_a000a_p51();
			this._map["shoes_a000a_p59"] = new shoes_a000a_p59();
			this._map["shoes_a000a_p62"] = new shoes_a000a_p62();
			this._map["shoes_b000a_p51"] = new shoes_b000a_p51();
			this._map["shoes_b000a_p62"] = new shoes_b000a_p62();
			this._map["shoes_c000a_p51"] = new shoes_c000a_p51();
			this._map["shoes_c000a_p62"] = new shoes_c000a_p62();
			this._map["shoes_c000b_p51"] = new shoes_c000b_p51();
			this._map["shoes_c000b_p62"] = new shoes_c000b_p62();
			this._map["shoes_x003a_p51"] = new shoes_x003a_p51();
			this._map["shoes_x003a_p62"] = new shoes_x003a_p62();
			this._map["shoes_x004a_p51"] = new shoes_x004a_p51();
			this._map["shoes_x004a_p62"] = new shoes_x004a_p62();
			this._map["shoes_x005a_p51"] = new shoes_x005a_p51();
			this._map["shoes_x005a_p62"] = new shoes_x005a_p62();
			this._map["shoes_x006a_p51"] = new shoes_x006a_p51();
			this._map["shoes_x006a_p62"] = new shoes_x006a_p62();
			this._map["shoes_x007a_p51"] = new shoes_x007a_p51();
			this._map["shoes_x007a_p62"] = new shoes_x007a_p62();
			this._map["shoes_x008a_p51"] = new shoes_x008a_p51();
			this._map["shoes_x008a_p62"] = new shoes_x008a_p62();
			this._map["shoes_x010a_p51"] = new shoes_x010a_p51();
			this._map["shoes_x010a_p62"] = new shoes_x010a_p62();
			this._map["shoes_x011a_p51"] = new shoes_x011a_p51();
			this._map["shoes_x011a_p62"] = new shoes_x011a_p62();
			this._map["shoes_x014a_p51"] = new shoes_x014a_p51();
			this._map["shoes_x014a_p62"] = new shoes_x014a_p62();
			this._map["shoes_x015a_p51"] = new shoes_x015a_p51();
			this._map["shoes_x015a_p62"] = new shoes_x015a_p62();
			this._map["shoes_z002a_p51"] = new shoes_z002a_p51();
			this._map["shoes_z002a_p62"] = new shoes_z002a_p62();
			this._map["shoes_z003a_p51"] = new shoes_z003a_p51();
			this._map["shoes_z003a_p62"] = new shoes_z003a_p62();
			this._map["shoes_z005a_p51"] = new shoes_z005a_p51();
			this._map["shoes_z005a_p62"] = new shoes_z005a_p62();
			this._map["shoes_z006a_p51"] = new shoes_z006a_p51();
			this._map["shoes_z006a_p62"] = new shoes_z006a_p62();
			this._map["shoes_z008a_p51"] = new shoes_z008a_p51();
			this._map["shoes_z008a_p62"] = new shoes_z008a_p62();
			this._map["shoes_z011a_p51"] = new shoes_z011a_p51();
			this._map["shoes_z011a_p62"] = new shoes_z011a_p62();
			this._map["shoes_z013a_p51"] = new shoes_z013a_p51();
			this._map["shoes_z013a_p62"] = new shoes_z013a_p62();
			this._map["shoes_z015a_p51"] = new shoes_z015a_p51();
			this._map["shoes_z015a_p62"] = new shoes_z015a_p62();
			this._map["shoes_z016a_p51"] = new shoes_z016a_p51();
			this._map["shoes_z016a_p62"] = new shoes_z016a_p62();
			this._map["shoes_z016b_p51"] = new shoes_z016b_p51();
			this._map["shoes_z016b_p62"] = new shoes_z016b_p62();
			this._map["shoes_z017a_p51"] = new shoes_z017a_p51();
			this._map["shoes_z017a_p62"] = new shoes_z017a_p62();
			this._map["shoes_z018a_p51"] = new shoes_z018a_p51();
			this._map["shoes_z018a_p62"] = new shoes_z018a_p62();
			this._map["shoes_z019a_p51"] = new shoes_z019a_p51();
			this._map["shoes_z019a_p62"] = new shoes_z019a_p62();
			this._map["shoes_z020a_p51"] = new shoes_z020a_p51();
			this._map["shoes_z020a_p62"] = new shoes_z020a_p62();
			this._map["shoes_z021a_p51"] = new shoes_z021a_p51();
			this._map["shoes_z021a_p62"] = new shoes_z021a_p62();
			this._map["shoes_z022a_p51"] = new shoes_z022a_p51();
			this._map["shoes_z022a_p62"] = new shoes_z022a_p62();
			this._map["shoes_z023a_p51"] = new shoes_z023a_p51();
			this._map["shoes_z023a_p62"] = new shoes_z023a_p62();
			this._map["shoes_z024a_p51"] = new shoes_z024a_p51();
			this._map["shoes_z024a_p62"] = new shoes_z024a_p62();
			this._map["shoes_z026a_p51"] = new shoes_z026a_p51();
			this._map["shoes_z026a_p62"] = new shoes_z026a_p62();
			this._map["shoes_z028a_p51"] = new shoes_z028a_p51();
			this._map["shoes_z028a_p62"] = new shoes_z028a_p62();
			this._map["shoes_z030a_p51"] = new shoes_z030a_p51();
			this._map["shoes_z030a_p62"] = new shoes_z030a_p62();
			this._map["shoes_z031a_p51"] = new shoes_z031a_p51();
			this._map["shoes_z031a_p62"] = new shoes_z031a_p62();
			this._map["shoes_z032a_p51"] = new shoes_z032a_p51();
			this._map["shoes_z032a_p62"] = new shoes_z032a_p62();
			this._map["shoes_z034a_p51"] = new shoes_z034a_p51();
			this._map["shoes_z034a_p62"] = new shoes_z034a_p62();
			this._map["shoes_z037a_p51"] = new shoes_z037a_p51();
			this._map["shoes_z037a_p62"] = new shoes_z037a_p62();
			this._map["shoes_z038a_p52"] = new shoes_z038a_p52();
			this._map["shoes_z038a_p62"] = new shoes_z038a_p62();
			this._map["shoes_z041a_p51"] = new shoes_z041a_p51();
			this._map["shoes_z041a_p62"] = new shoes_z041a_p62();
			this._map["shoes_z046a_p51"] = new shoes_z046a_p51();
			this._map["shoes_z046a_p62"] = new shoes_z046a_p62();
			this._map["shoes_z047a_p51"] = new shoes_z047a_p51();
			this._map["shoes_z047a_p62"] = new shoes_z047a_p62();
			this._map["shoes_z048a_p51"] = new shoes_z048a_p51();
			this._map["shoes_z048a_p62"] = new shoes_z048a_p62();
			this._map["shoes_z051a_p51"] = new shoes_z051a_p51();
			this._map["shoes_z051a_p62"] = new shoes_z051a_p62();
			this._map["shoes_z057a_p51"] = new shoes_z057a_p51();
			this._map["shoes_z057a_p62"] = new shoes_z057a_p62();
			this._map["shoes_z058a_p51"] = new shoes_z058a_p51();
			this._map["shoes_z058a_p62"] = new shoes_z058a_p62();
			this._map["shoes_z059a_p51"] = new shoes_z059a_p51();
			this._map["shoes_z059a_p62"] = new shoes_z059a_p62();
			this._map["shoes_z061a_p51"] = new shoes_z061a_p51();
			this._map["shoes_z061a_p62"] = new shoes_z061a_p62();
			this._map["shoes_z062a_p42"] = new shoes_z062a_p42();
			this._map["shoes_z062a_p51"] = new shoes_z062a_p51();
			this._map["shoes_z062a_p62"] = new shoes_z062a_p62();
			this._map["shoes_z064a_p51"] = new shoes_z064a_p51();
			this._map["shoes_z064a_p62"] = new shoes_z064a_p62();
			this._map["shoes_z069a_p51"] = new shoes_z069a_p51();
			this._map["shoes_z069a_p62"] = new shoes_z069a_p62();
			this._map["shoes_z300a_p51"] = new shoes_z300a_p51();
			this._map["shoes_z300a_p62"] = new shoes_z300a_p62();
			this._map["skirt_a000a_p69"] = new skirt_a000a_p69();
			this._map["skirt_x002a_p48"] = new skirt_x002a_p48();
			this._map["skirt_x002a_p59"] = new skirt_x002a_p59();
			this._map["skirt_z002a_p48"] = new skirt_z002a_p48();
			this._map["skirt_z002a_p59"] = new skirt_z002a_p59();
			this._map["skirt_z003a_p48"] = new skirt_z003a_p48();
			this._map["skirt_z003a_p59"] = new skirt_z003a_p59();
			this._map["skirt_z003a_p69"] = new skirt_z003a_p69();
			this._map["skirt_z003b_p48"] = new skirt_z003b_p48();
			this._map["skirt_z003b_p59"] = new skirt_z003b_p59();
			this._map["skirt_z003b_p69"] = new skirt_z003b_p69();
			this._map["skirt_z006a_p64"] = new skirt_z006a_p64();
			this._map["skirt_z008a_p69"] = new skirt_z008a_p69();
			this._map["skirt_z011a_p45"] = new skirt_z011a_p45();
			this._map["skirt_z011a_p56"] = new skirt_z011a_p56();
			this._map["skirt_z012a_p64"] = new skirt_z012a_p64();
			this._map["skirt_z012a_p69"] = new skirt_z012a_p69();
			this._map["skirt_z013a_p64"] = new skirt_z013a_p64();
			this._map["skirt_z014a_p48"] = new skirt_z014a_p48();
			this._map["skirt_z014a_p59"] = new skirt_z014a_p59();
			this._map["skirt_z015a_p64"] = new skirt_z015a_p64();
			this._map["skirt_z017a_p64"] = new skirt_z017a_p64();
			this._map["skirt_z018a_p48"] = new skirt_z018a_p48();
			this._map["skirt_z018a_p59"] = new skirt_z018a_p59();
			this._map["skirt_z019a_p64"] = new skirt_z019a_p64();
			this._map["skirt_z021a_p64"] = new skirt_z021a_p64();
			this._map["skirt_z022a_p48"] = new skirt_z022a_p48();
			this._map["skirt_z022a_p59"] = new skirt_z022a_p59();
			this._map["skirt_z024a_p48"] = new skirt_z024a_p48();
			this._map["skirt_z024a_p59"] = new skirt_z024a_p59();
			this._map["skirt_z026a_p64"] = new skirt_z026a_p64();
			this._map["skirt_z030a_p64"] = new skirt_z030a_p64();
			this._map["skirt_z033a_p69"] = new skirt_z033a_p69();
			this._map["skirt_z034a_p48"] = new skirt_z034a_p48();
			this._map["skirt_z034a_p59"] = new skirt_z034a_p59();
			this._map["skirt_z036a_p64"] = new skirt_z036a_p64();
			this._map["skirt_z037a_p64"] = new skirt_z037a_p64();
			this._map["skirt_z045a_p48"] = new skirt_z045a_p48();
			this._map["skirt_z045a_p59"] = new skirt_z045a_p59();
			this._map["skirt_z046a_p64"] = new skirt_z046a_p64();
			this._map["skirt_z048a_p48"] = new skirt_z048a_p48();
			this._map["skirt_z048a_p59"] = new skirt_z048a_p59();
			this._map["skirt_z050a_p64"] = new skirt_z050a_p64();
			this._map["skirt_z058a_p48"] = new skirt_z058a_p48();
			this._map["skirt_z058a_p59"] = new skirt_z058a_p59();
			this._map["skirt_z059a_p64"] = new skirt_z059a_p64();
			this._map["skirt_z061a_p48"] = new skirt_z061a_p48();
			this._map["skirt_z061a_p59"] = new skirt_z061a_p59();
			this._map["skirt_z064a_p69"] = new skirt_z064a_p69();
			this._map["skirt_z069a_p64"] = new skirt_z069a_p64();
			this._map["skirt_z074a_p64"] = new skirt_z074a_p64();
			this._map["swim_o_a000a_p67"] = new swim_o_a000a_p67();
			this._map["swim_t_a000a_p67"] = new swim_t_a000a_p67();
			this._map["swim_u_a000a_p64"] = new swim_u_a000a_p64();
			this._map["swim_u_a001a_p64"] = new swim_u_a001a_p64();
			this._map["tail_z029a_p10"] = new tail_z029a_p10();
			this._map["tiara_a000b_p112"] = new tiara_a000b_p112();
			this._map["tiara_a000c_p112"] = new tiara_a000c_p112();
			this._map["tiara_m000c_p114"] = new tiara_m000c_p114();
			this._map["wand_x000b_p78"] = new wand_x000b_p78();
			this._map["wing_a000a_p12"] = new wing_a000a_p12();
			
			this.createGroup();
		}
		
		public function dispose():void
		{
			this._map = null;
		}
		
		private function createGroup():void
		{
			this._grpMap = {};
			
			for (var key:String in this._map)
			{
				var pos:int = key.lastIndexOf('_p');
				var name:String = key.substr(0, pos);
				var idx:int = parseInt(key.substr(pos + 2));
				var group:Object = null;
				if (!this._grpMap.hasOwnProperty(name))
				{
					group = {};
					group.list = [];
					this._grpMap[name] = group;
				}
				else
				{
					group = this._grpMap[name];
				}
				group.list.push(idx);
			}
		}
		
		public function getGroup():Object
		{
			return this._grpMap;
		}
		
		public function getSwf(name:String):MovieClip
		{
			if (!this._map[name])
			{
				return null;
			}
			
			return this._map[name];
		}
	
	}
}