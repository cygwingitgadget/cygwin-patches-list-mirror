Return-Path: <cygwin-patches-return-6932-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17713 invoked by alias); 26 Jan 2010 15:09:02 -0000
Received: (qmail 17702 invoked by uid 22791); 26 Jan 2010 15:09:01 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00
X-Spam-Check-By: sourceware.org
Received: from demumfd002.nsn-inter.net (HELO demumfd002.nsn-inter.net) (93.183.12.31)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 26 Jan 2010 15:08:57 +0000
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56]) 	by demumfd002.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id o0QF8rwJ028949 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL) 	for <cygwin-patches@cygwin.com>; Tue, 26 Jan 2010 16:08:54 +0100
Received: from [10.149.155.84] ([10.149.155.84]) 	by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id o0QF8rb0031302 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO) 	for <cygwin-patches@cygwin.com>; Tue, 26 Jan 2010 16:08:53 +0100
Message-ID: <4B5F0585.9070903@towo.net>
Date: Tue, 26 Jan 2010 15:09:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.5) Gecko/20091204 Lightning/1.0b1 Thunderbird/3.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events etc
References: <4B266528.7090006@towo.net> <20091214162953.GO8059@calimero.vinschen.de> <4B266F9B.6070204@towo.net> <20091214171323.GS8059@calimero.vinschen.de> <20091215130036.GA19394@calimero.vinschen.de> <4B28ACE8.1050305@towo.net> <20091216145627.GM8059@calimero.vinschen.de> <4B29934A.80902@towo.net> <4B2C0715.8090108@towo.net> <20091221101216.GA5632@calimero.vinschen.de> <20100125190806.GA9166@calimero.vinschen.de>
In-Reply-To: <20100125190806.GA9166@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------060204040901050109010300"
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
X-SW-Source: 2010-q1/txt/msg00048.txt.bz2

This is a multi-part message in MIME format.
--------------060204040901050109010300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 437

On 25.01.2010 20:08, Corinna Vinschen wrote:
> Hi Thomas,
> ...
> can you please create a patch to add some words to the "What's new and
> what changed from 1.7.1 to 1.7.2" section in the User's Guide
> (winsup/doc/new-features.sgml), in terms of your console enhancements?
>    
Hi, changelog and patch attached. I had already looked for a web or man 
page describing console features to amend that but apparently there is none.
Thomas

--------------060204040901050109010300
Content-Type: text/plain;
 name="new-features-console-enhancements.changelog"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="new-features-console-enhancements.changelog"
Content-length: 286

2010-01-26  Thomas Wolff  <towo@towo.net>

	* new-features.sgml (Device related changes): List console enhancements:
	Modified function and keypad keys, VT100 line drawing graphics mode, 
	Alt-AltGr combinations, enhanced mouse and focus event reporting, 
	attribute escape sequences.


--------------060204040901050109010300
Content-Type: text/plain;
 name="new-features-console-enhancements.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="new-features-console-enhancements.patch"
Content-length: 2173

--- new-features.sgml	2010-01-26 14:42:17.583032000 +0100
+++ patch/new-features.sgml	2010-01-26 15:58:11.067930000 +0100
@@ -382,6 +382,50 @@ Support UTF-8 in console window.
 </para></listitem>
 
 <listitem><para>
+Enhanced support of modified function and keypad keys in console window:
+Function keys together with combinations of Shift, Control, Alt send 
+distinguished escape sequences (compatible with rxvt).
+Keypad keys together with Shift, Control, Shift-Control send 
+distinguished escape sequences (xterm-style); with Alt, an additional 
+ESC prefix is sent.
+</para></listitem>
+
+<listitem><para>
+Support VT100 line drawing graphics mode in console window (compatible 
+with xterm and mintty).
+</para></listitem>
+
+<listitem><para>
+Support of combining Alt and AltGr modifiers in console window 
+(compatible with xterm and mintty), so that e.g. Alt-@ sends ESC @ 
+also on keyboards where @ is mapped to an AltGr combination.
+</para></listitem>
+
+<listitem><para>
+Support enhanced mouse event reporting in console window (compatible 
+with xterm and mintty):
+Report mouse wheel scroll events in mouse reporting mode 1000 (note: 
+this doesn't seem to work on all systems, assumedly due to driver 
+interworking issues).
+Add mouse reporting mode 1002 to report mouse drag movement.
+Add mouse reporting mode 1003 to report any mouse movement.
+Ensure consistence of read() and select() system calls as to whether 
+a reporting escape sequence is available for input.
+</para></listitem>
+
+<listitem><para>
+Support focus event reporting (mode 1004) in console window 
+(compatible with xterm and mintty).
+</para></listitem>
+
+<listitem><para>
+Fix escape sequence to select dim attribute in console window 
+(2 instead of 9 for compatibility with ANSI and other terminals).
+Add escape sequences for not bold (22), not invisible (28), not 
+blinking (25) (compatible with xterm and mintty).
+</para></listitem>
+
+<listitem><para>
 In the console window the backspace key now emits DEL (0x7f) instead of
 BS (0x08), Alt-Backspace emits ESC-DEL (0x1b,0x7f) instead of DEL
 (0x7f), same as the Linux console and xterm.  Control-Space now emits an

--------------060204040901050109010300--
