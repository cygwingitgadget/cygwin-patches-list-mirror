Return-Path: <cygwin-patches-return-6880-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30729 invoked by alias); 19 Dec 2009 15:42:23 -0000
Received: (qmail 30717 invoked by uid 22791); 19 Dec 2009 15:42:22 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 19 Dec 2009 15:42:18 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 9F0E36D417D; Sat, 19 Dec 2009 16:42:06 +0100 (CET)
Date: Sat, 19 Dec 2009 15:42:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events etc
Message-ID: <20091219154206.GA20349@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B1C04D1.8010707@towo.net>  <20091214114715.GG8059@calimero.vinschen.de>  <4B266528.7090006@towo.net>  <20091214162953.GO8059@calimero.vinschen.de>  <4B266F9B.6070204@towo.net>  <20091214171323.GS8059@calimero.vinschen.de>  <20091215130036.GA19394@calimero.vinschen.de>  <4B28ACE8.1050305@towo.net>  <20091216145627.GM8059@calimero.vinschen.de>  <4B29934A.80902@towo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B29934A.80902@towo.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00211.txt.bz2

On Dec 17 03:11, Thomas Wolff wrote:
> Hi,
> here is my VT100 graphics mode patch, plus the one-liner I forgot to
> mention in the change log last time, I hope that's OK.
> Thomas

> 	* fhandler_console.cc (write_console): Check for VT100 
> 	graphics mode and transform wide characters in ASCII small 
> 	letter range to corresponding graphics.
> 	(__vt100_conv): Table to transform small ASCII letters to line 
> 	drawing graphics for use in VT100 graphics mode.
> 	(write_normal): Check for SO/SI control characters to 
> 	enable/disable VT100 graphics mode.
> 	(base_chars): Enable SO/SI control characters for detection.
> 	(write): Check for ESC ( 0 / ESC ( B escape sequences to 
> 	enable/disable VT100 graphics mode. Also detect ">" while 
> 	parsing ESC [ sequences to distinguish specific requests.
> 	(char_command): Distinguish Secondary from Primary Device Attribute 
> 	request to report more details about cygwin console terminal version.
> 	* fhandler.h (vt100_graphics_mode_active): New flag to indicate mode.
> 	(saw_greater_than_sign): New parse flag for ESC [ > sequences.
> 	(gotparen, gotrparen): New state values to parse ESC ( / ) sequences.
> 
> 	* fhandler_console.cc (read): Allow combined Alt-AltGr modifiers 
> 	to also produce an ESC prefix like a plain Alt modifier, e.g. to make 
> 	Alt-@ work on a keyboard where @ is AltGr-q.

Thanks, applied with a change.  I removed the whole lot of question
marks which were apparently meant to be the UTF-8 representation of the
vt100 graphical chars, and replaced them with the textual description
from the Unicode character table, like this:

  /* VT100 line drawing graphics mode maps `abcdefghijklmnopqrstuvwxyz{|}~ to
     graphical characters */
  static wchar_t __vt100_conv [31] = {
	  0x25C6, /* Black Diamond */
	  0x2592, /* Medium Shade */
	  0x2409, /* Symbol for Horizontal Tabulation */
	  0x240C, /* Symbol for Form Feed */
	  0x240D, /* Symbol for Carriage Return */
	  0x240A, /* Symbol for Line Feed */
	  0x00B0, /* Degree Sign */
	  0x00B1, /* Plus-Minus Sign */
	  0x2424, /* Symbol for Newline */
	  0x240B, /* Symbol for Vertical Tabulation */
	  0x2518, /* Box Drawings Light Up And Left */
	  0x2510, /* Box Drawings Light Down And Left */
	  0x250C, /* Box Drawings Light Down And Right */
	  0x2514, /* Box Drawings Light Up And Right */
	  0x253C, /* Box Drawings Light Vertical And Horizontal */
	  0x23BA, /* Horizontal Scan Line-1 */
	  0x23BB, /* Horizontal Scan Line-3 */
	  0x2500, /* Box Drawings Light Horizontal */
	  0x23BC, /* Horizontal Scan Line-7 */
	  0x23BD, /* Horizontal Scan Line-9 */
	  0x251C, /* Box Drawings Light Vertical And Right */
	  0x2524, /* Box Drawings Light Vertical And Left */
	  0x2534, /* Box Drawings Light Up And Horizontal */
	  0x252C, /* Box Drawings Light Down And Horizontal */
	  0x2502, /* Box Drawings Light Vertical */
	  0x2264, /* Less-Than Or Equal To */
	  0x2265, /* Greater-Than Or Equal To */
	  0x03C0, /* Greek Small Letter Pi */
	  0x2260, /* Not Equal To */
	  0x00A3, /* Pound Sign */
	  0x00B7, /* Middle Dot */
  };

This avoids usage of any non-ASCII characters in the sources.  While
UTF-8 is a good idea in general, we should avoid to use it in the
source code.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
