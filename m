Return-Path: <cygwin-patches-return-6871-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3490 invoked by alias); 16 Dec 2009 15:14:07 -0000
Received: (qmail 3478 invoked by uid 22791); 16 Dec 2009 15:14:07 -0000
X-SWARE-Spam-Status: No, hits=-2.3 required=5.0 	tests=AWL,BAYES_00
X-Spam-Check-By: sourceware.org
Received: from demumfd001.nsn-inter.net (HELO demumfd001.nsn-inter.net) (93.183.12.32)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 16 Dec 2009 15:14:02 +0000
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55]) 	by demumfd001.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id nBGFDxES025920 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL) 	for <cygwin-patches@cygwin.com>; Wed, 16 Dec 2009 16:13:59 +0100
Received: from [10.149.155.84] ([10.149.155.84]) 	by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id nBGFDwgK001408 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO) 	for <cygwin-patches@cygwin.com>; Wed, 16 Dec 2009 16:13:59 +0100
Message-ID: <4B28F936.1040105@towo.net>
Date: Wed, 16 Dec 2009 15:14:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events etc
References: <20091119160054.GB8185@ednor.casa.cgf.cx>  <20091119160948.GA1883@calimero.vinschen.de>  <4B1C04D1.8010707@towo.net>  <20091214114715.GG8059@calimero.vinschen.de>  <4B266528.7090006@towo.net>  <20091214162953.GO8059@calimero.vinschen.de>  <4B266F9B.6070204@towo.net>  <20091214171323.GS8059@calimero.vinschen.de>  <20091215130036.GA19394@calimero.vinschen.de>  <4B28ACE8.1050305@towo.net> <20091216145627.GM8059@calimero.vinschen.de>
In-Reply-To: <20091216145627.GM8059@calimero.vinschen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00202.txt.bz2

Corinna Vinschen wrote:
> On Dec 16 10:48, Thomas Wolff wrote:
>   
>> 	* fhandler_console.cc (read): Detect and handle mouse wheel scrolling 
>> 	...
>>     
> Thank you.  Applied with two changes:
>
>   
>> @@ -362,9 +405,12 @@ fhandler_console::read (void *pv, size_t
>>  	      /* Determine if the keystroke is modified by META.  The tricky
>>  		 part is to distinguish whether the right Alt key should be
>>  		 recognized as Alt, or as AltGr. */
>> -	      bool meta;
>> -	      meta = (control_key_state & ALT_PRESSED) != 0
>> +	      bool meta =
>> +		     /* Alt but not AltGr (= left ctrl + right alt)? */
>> +		     (control_key_state & ALT_PRESSED) != 0
>>  		     && ((control_key_state & CTRL_PRESSED) == 0
>> +			    /* but also allow Alt-AltGr: */
>> +			 || (control_key_state & ALT_PRESSED) == ALT_PRESSED
>>  			 || (wch <= 0x1f || wch == 0x7f));
>>  	      if (!meta)
>>  		{
>>     
> This hunk apparently belongs to another part of the patch and isn't
> mentioned in the ChangeLog.  I removed it for now.
>   
Yes, sorry, I forgot to add it to the ChangeLog.

>> @@ -400,10 +446,18 @@ fhandler_console::read (void *pv, size_t
>>  	  break;
>>  
>>  	case MOUSE_EVENT:
>> -	  send_winch_maybe ();
>> -	  if (dev_state->use_mouse)
>> +	 send_winch_maybe ();
>> +	 {
>> [...]
>>     
> The above and the followup hunks within the MOUSE_EVENT case were not
> correctly indented.  I fixed that.
>   
That's fine. I just didn't want to change the indentation of all lines, 
but sure it's better to do it.

>> +	case 1000: /* Mouse tracking */
>> +	  dev_state->use_mouse = (c == 'h') ? 1 : 0;
>> +	  syscall_printf ("mouse support set to mode %d", dev_state->use_mouse);
>> +	  break;
>> +
>> +	case 1002: /* Mouse button event tracking */
>>     
> Just curious:  Is there a 1001 control sequence as well?
>   
Yes, with xterm. It's "Highlight mouse tracking mode" with implicit text 
highlighting while moving the mouse, and it's interacting with the 
application. So it's quite tricky to implement for the terminal and 
error-prone for the application because if it does not cooperate 
properly the terminal will hang. I'm currently using it for mined (in 
xterm) but I'll drop it for the next release in favour of my own 
highlighting. The mode provides more trouble than benefit and I also 
discouraged Andy from doing it for mintty.

Thomas
