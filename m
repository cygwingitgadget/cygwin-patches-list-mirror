Return-Path: <cygwin-patches-return-7011-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8887 invoked by alias); 30 Mar 2010 15:46:19 -0000
Received: (qmail 8871 invoked by uid 22791); 30 Mar 2010 15:46:17 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0 	tests=BAYES_00
X-Spam-Check-By: sourceware.org
Received: from ns2.sietec.de (HELO mail.sietec.de) (213.61.69.205)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 30 Mar 2010 15:46:12 +0000
Received: from mail.bln1.bf.nsn-intra.net (ns2.bln1.bf.nsn-intra.net [10.149.159.159]) 	by mail.sietec.de (8.13.5/8.13.5/MTA) with ESMTP id o2UFk76f026954 	for <cygwin-patches@cygwin.com>; Tue, 30 Mar 2010 17:46:07 +0200 (MEST)
Received: from [10.149.155.84] (stbm8186.bln1.bf.nsn-intra.net [10.149.155.84]) 	by mail.bln1.bf.nsn-intra.net (8.13.5/8.13.5/MTA) with ESMTP id o2UFk6nA028189 	for <cygwin-patches@cygwin.com>; Tue, 30 Mar 2010 17:46:07 +0200 (CEST)
Message-ID: <4BB21CBF.7030701@towo.net>
Date: Tue, 30 Mar 2010 15:46:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.8) Gecko/20100227 Lightning/1.0b1 Thunderbird/3.0.3
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events etc
References: <20091215130036.GA19394@calimero.vinschen.de>  <4B28ACE8.1050305@towo.net>  <20091216145627.GM8059@calimero.vinschen.de>  <4B29934A.80902@towo.net>  <4B2C0715.8090108@towo.net>  <20091221101216.GA5632@calimero.vinschen.de>  <20100125190806.GA9166@calimero.vinschen.de>  <4B5F0585.9070903@towo.net>  <20100330095912.GZ18364@calimero.vinschen.de>  <4BB1D83A.8010406@towo.net> <20100330142200.GA12926@calimero.vinschen.de>
In-Reply-To: <20100330142200.GA12926@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------090702060904000701030806"
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
X-SW-Source: 2010-q1/txt/msg00127.txt.bz2

This is a multi-part message in MIME format.
--------------090702060904000701030806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1067

Corinna Vinschen wrote:
>>> Since you were looking into the Cygwin console code lately, maybe you
>>> could find out why `stty sane' doesn't reset the character set?
>> The tool to use would be 'reset'. So I'll try to find out why
>> 'reset' doesn't reset the character set :-\ .
>>      
>> There are two methods to switch to the alternate character set. One
>> is by just sending a Control-N. Most terminals "guard" this method
>> by requiring an enable sequence before this works. I guess this
>> would considerably reduce the risk that this happens, that's
>> probably why they do it.
>> I didn't implement the guarding mechanism in fhandler_console
>> (although I prepared it somewhat) so I think I should fully
>> implement that.
>>      
The attached patch should make 'reset' work, and it should make the 
'VT100 graphics garbage effect' less likely. Miraculously, even 'pstree 
-G' works now...

2010-03-30  Thomas Wolff <towo@towo.net>

         * fhandler.h, fhandler_console.cc: Tune VT100 graphics mode
           switching to follow ISO 2022 strictly.


--------------090702060904000701030806
Content-Type: text/plain;
 name="cygwin-1.7.2-iso-2022.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cygwin-1.7.2-iso-2022.patch"
Content-length: 2929

diff -rup orig/fhandler.h ./fhandler.h
--- orig/fhandler.h	2010-03-23 10:34:05.001000000 +0100
+++ ./fhandler.h	2010-03-30 17:22:15.427713900 +0200
@@ -906,7 +906,9 @@ class dev_console
   unsigned rarg;
   bool saw_question_mark;
   bool saw_greater_than_sign;
-  bool vt100_graphics_mode_active;
+  bool vt100_graphics_mode_G0;
+  bool vt100_graphics_mode_G1;
+  bool iso_2022_G1;
   bool alternate_charset_active;
   bool metabit;
 
diff -rup orig/fhandler_console.cc ./fhandler_console.cc
--- orig/fhandler_console.cc	2010-03-18 15:57:09.001000000 +0100
+++ ./fhandler_console.cc	2010-03-30 17:26:59.418904900 +0200
@@ -1161,7 +1161,9 @@ static wchar_t __vt100_conv [31] = {
 inline
 bool fhandler_console::write_console (PWCHAR buf, DWORD len, DWORD& done)
 {
-  if (dev_state->vt100_graphics_mode_active)
+  if (dev_state->iso_2022_G1
+	? dev_state->vt100_graphics_mode_G1
+	: dev_state->vt100_graphics_mode_G0)
     for (DWORD i = 0; i < len; i ++)
       if (buf[i] >= (unsigned char) '`' && buf[i] <= (unsigned char) '~')
         buf[i] = __vt100_conv[buf[i] - (unsigned char) '`'];
@@ -1734,11 +1736,11 @@ fhandler_console::write_normal (const un
       int x, y;
       switch (base_chars[*found])
 	{
-	case SO:
-	  dev_state->vt100_graphics_mode_active = true;
+	case SO:	/* Shift Out: Invoke G1 character set (ISO 2022) */
+	  dev_state->iso_2022_G1 = true;
 	  break;
-	case SI:
-	  dev_state->vt100_graphics_mode_active = false;
+	case SI:	/* Shift In: Invoke G0 character set (ISO 2022) */
+	  dev_state->iso_2022_G1 = false;
 	  break;
 	case BEL:
 	  beep ();
@@ -1862,6 +1864,9 @@ fhandler_console::write (const void *vsr
 	  else if (*src == 'c')		/* RIS Full Reset */
 	    {
 	      dev_state->set_default_attr ();
+	      dev_state->vt100_graphics_mode_G0 = false;
+	      dev_state->vt100_graphics_mode_G1 = false;
+	      dev_state->iso_2022_G1 = false;
 	      clear_screen (0, 0, -1, -1);
 	      cursor_set (true, 0, 0);
 	      dev_state->state_ = normal;
@@ -1959,20 +1964,19 @@ fhandler_console::write (const void *vsr
 	  else
 	    dev_state->state_ = gotarg1;
 	  break;
-	case gotparen:
+	case gotparen:	/* Designate G0 Character Set (ISO 2022) */
 	  if (*src == '0')
-	    dev_state->vt100_graphics_mode_active = true;
+	    dev_state->vt100_graphics_mode_G0 = true;
 	  else
-	    dev_state->vt100_graphics_mode_active = false;
+	    dev_state->vt100_graphics_mode_G0 = false;
 	  dev_state->state_ = normal;
 	  src++;
 	  break;
-	case gotrparen:
-	  /* This is not strictly needed, ^N/^O can just always be enabled */
+	case gotrparen:	/* Designate G1 Character Set (ISO 2022) */
 	  if (*src == '0')
-	    /*dev_state->vt100_graphics_mode_SOSI_enabled = true*/;
+	    dev_state->vt100_graphics_mode_G1 = true;
 	  else
-	    /*dev_state->vt100_graphics_mode_SOSI_enabled = false*/;
+	    dev_state->vt100_graphics_mode_G1 = false;
 	  dev_state->state_ = normal;
 	  src++;
 	  break;

--------------090702060904000701030806--
