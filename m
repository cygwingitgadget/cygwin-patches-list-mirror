Return-Path: <cygwin-patches-return-6878-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13810 invoked by alias); 18 Dec 2009 22:50:11 -0000
Received: (qmail 13797 invoked by uid 22791); 18 Dec 2009 22:50:10 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_HELO_PASS
X-Spam-Check-By: sourceware.org
Received: from moutng.kundenserver.de (HELO moutng.kundenserver.de) (212.227.17.9)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 18 Dec 2009 22:50:05 +0000
Received: from [127.0.0.1] (dslb-088-073-128-215.pools.arcor-ip.net [88.73.128.215]) 	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis) 	id 0Lqn9W-1O04Gw3QY6-00dpuv; Fri, 18 Dec 2009 23:50:02 +0100
Message-ID: <4B2C0715.8090108@towo.net>
Date: Fri, 18 Dec 2009 22:50:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events etc
References: <20091119160054.GB8185@ednor.casa.cgf.cx>  <20091119160948.GA1883@calimero.vinschen.de>  <4B1C04D1.8010707@towo.net>  <20091214114715.GG8059@calimero.vinschen.de>  <4B266528.7090006@towo.net>  <20091214162953.GO8059@calimero.vinschen.de>  <4B266F9B.6070204@towo.net>  <20091214171323.GS8059@calimero.vinschen.de>  <20091215130036.GA19394@calimero.vinschen.de>  <4B28ACE8.1050305@towo.net> <20091216145627.GM8059@calimero.vinschen.de> <4B29934A.80902@towo.net>
In-Reply-To: <4B29934A.80902@towo.net>
Content-Type: multipart/mixed;  boundary="------------040209020900000303010206"
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
X-SW-Source: 2009-q4/txt/msg00209.txt.bz2

This is a multi-part message in MIME format.
--------------040209020900000303010206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1122

Thomas Wolff schrieb:
> Hi,
> here is my VT100 graphics mode patch, plus the one-liner I forgot to 
> mention in the change log last time, I hope that's OK.
> Thomas
Now this is my patch # 3, enhancing / distinguishing escape sequences 
for function keys and keypad keys with modifiers Ctrl, Shift, Alt and 
their various combinations.
It's proper to say that this patch has a details which is not strictly 
upwards compatible; it does two things:

    * Extend modified function keys beyond Shift-F10, upwards compatible
      and compatible with (u)rxvt.
    * Distinguish and extend modified keypad keys; Ctrl- and
      Shift-keypad keys used to send identical escape sequences as
      unmodified keys (which isn't very useful); now they indicate the
      modifier combination using the same ANSI parameter method as xterm
      and mintty for Ctrl and Shift, and the ESC prefixing method used
      by (u)rxvt for Alt (to stay compatible with previous Alt-keypad
      sequences).


The patch diff is based on my previous patch (VT100 line drawing 
graphics mode) which I supplied on Thursday.
Kind regards,
Thomas

--------------040209020900000303010206
Content-Type: text/plain;
 name="ChangeLog.add3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ChangeLog.add3"
Content-length: 595

2009-12-18  Thomas Wolff  <towo@towo.net>

	* fhandler_console.cc (get_nonascii_key): Generate ESC prefix 
	for Alt modifier generically for function keys and keypad keys.
	Distinguish Normal, Ctrl, Shift, Ctrl-Shift rather 
	than Normal, Ctrl, Shift, Alt, so that in combination with generic 
	Alt handling all 8 combinations of these modifiers are distinguished.
	(keytable): Add escape sequences for remaining modified 
	function keys as a compatible extension using rxvt escape codes.
	Also distinguish keypad keys modified with Ctrl, Shift, Ctrl-Shift 
	using xterm-style modifier coding.


--------------040209020900000303010206
Content-Type: text/plain;
 name="cygwin-console-modified-fkeys-keypad.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-console-modified-fkeys-keypad.patch"
Content-length: 5012

--- patch2/fhandler_console.cc	2009-12-17 02:43:32.000000000 +0100
+++ ./fhandler_console.cc	2009-12-18 23:26:52.000000000 +0100
@@ -1985,33 +1985,39 @@ static struct {
   int vk;
   const char *val[4];
 } keytable[] NO_COPY = {
-	       /* NORMAL */    /* SHIFT */     /* CTRL */     /* ALT */
-  {VK_LEFT,	{"\033[D",	"\033[D",	"\033[D",	"\033\033[D"}},
-  {VK_RIGHT,	{"\033[C",	"\033[C",	"\033[C",	"\033\033[C"}},
-  {VK_UP,	{"\033[A",	"\033[A",	"\033[A",	"\033\033[A"}},
-  {VK_DOWN,	{"\033[B",	"\033[B",	"\033[B",	"\033\033[B"}},
-  {VK_PRIOR,	{"\033[5~",	"\033[5~",	"\033[5~",	"\033\033[5~"}},
-  {VK_NEXT,	{"\033[6~",	"\033[6~",	"\033[6~",	"\033\033[6~"}},
-  {VK_HOME,	{"\033[1~",	"\033[1~",	"\033[1~",	"\033\033[1~"}},
-  {VK_END,	{"\033[4~",	"\033[4~",	"\033[4~",	"\033\033[4~"}},
-  {VK_INSERT,	{"\033[2~",	"\033[2~",	"\033[2~",	"\033\033[2~"}},
-  {VK_DELETE,	{"\033[3~",	"\033[3~",	"\033[3~",	"\033\033[3~"}},
-  {VK_F1,	{"\033[[A",	"\033[23~",	NULL,		NULL}},
-  {VK_F2,	{"\033[[B",	"\033[24~",	NULL,		NULL}},
-  {VK_F3,	{"\033[[C",	"\033[25~",	NULL,		NULL}},
-  {VK_F4,	{"\033[[D",	"\033[26~",	NULL,		NULL}},
-  {VK_F5,	{"\033[[E",	"\033[28~",	NULL,		NULL}},
-  {VK_F6,	{"\033[17~",	"\033[29~",	"\036",		NULL}},
-  {VK_F7,	{"\033[18~",	"\033[31~",	NULL,		NULL}},
-  {VK_F8,	{"\033[19~",	"\033[32~",	NULL,		NULL}},
-  {VK_F9,	{"\033[20~",	"\033[33~",	NULL,		NULL}},
-  {VK_F10,	{"\033[21~",	"\033[34~",	NULL,		NULL}},
-  {VK_F11,	{"\033[23~",	NULL,		NULL,		NULL}},
-  {VK_F12,	{"\033[24~",	NULL,		NULL,		NULL}},
-  {VK_NUMPAD5,	{"\033[G",	NULL,		NULL,		NULL}},
-  {VK_CLEAR,	{"\033[G",	NULL,		NULL,		NULL}},
+	       /* NORMAL */    /* SHIFT */     /* CTRL */     /* CTRL-SHIFT */
+  /* Unmodified and Alt-modified keypad keys comply with linux console
+     SHIFT, CTRL, CTRL-SHIFT modifiers comply with xterm modifier usage */
+  {VK_NUMPAD5,	{"\033[G",	"\033[1;2G",	"\033[1;5G",	"\033[1;6G"}},
+  {VK_CLEAR,	{"\033[G",	"\033[1;2G",	"\033[1;5G",	"\033[1;6G"}},
+  {VK_LEFT,	{"\033[D",	"\033[1;2D",	"\033[1;5D",	"\033[1;6D"}},
+  {VK_RIGHT,	{"\033[C",	"\033[1;2C",	"\033[1;5C",	"\033[1;6C"}},
+  {VK_UP,	{"\033[A",	"\033[1;2A",	"\033[1;5A",	"\033[1;6A"}},
+  {VK_DOWN,	{"\033[B",	"\033[1;2B",	"\033[1;5B",	"\033[1;6B"}},
+  {VK_PRIOR,	{"\033[5~",	"\033[5;2~",	"\033[5;5~",	"\033[5;6~"}},
+  {VK_NEXT,	{"\033[6~",	"\033[6;2~",	"\033[6;5~",	"\033[6;6~"}},
+  {VK_HOME,	{"\033[1~",	"\033[1;2~",	"\033[1;5~",	"\033[1;6~"}},
+  {VK_END,	{"\033[4~",	"\033[4;2~",	"\033[4;5~",	"\033[4;6~"}},
+  {VK_INSERT,	{"\033[2~",	"\033[2;2~",	"\033[2;5~",	"\033[2;6~"}},
+  {VK_DELETE,	{"\033[3~",	"\033[3;2~",	"\033[3;5~",	"\033[3;6~"}},
+  /* F1...F12, SHIFT-F1...SHIFT-F10 comply with linux console
+     F6...F12, and all modified F-keys comply with rxvt (compatible extension) */
+  {VK_F1,	{"\033[[A",	"\033[23~",	"\033[11^",	"\033[23^"}},
+  {VK_F2,	{"\033[[B",	"\033[24~",	"\033[12^",	"\033[24^"}},
+  {VK_F3,	{"\033[[C",	"\033[25~",	"\033[13^",	"\033[25^"}},
+  {VK_F4,	{"\033[[D",	"\033[26~",	"\033[14^",	"\033[26^"}},
+  {VK_F5,	{"\033[[E",	"\033[28~",	"\033[15^",	"\033[28^"}},
+  {VK_F6,	{"\033[17~",	"\033[29~",	"\033[17^",	"\033[29^"}},
+  {VK_F7,	{"\033[18~",	"\033[31~",	"\033[18^",	"\033[31^"}},
+  {VK_F8,	{"\033[19~",	"\033[32~",	"\033[19^",	"\033[32^"}},
+  {VK_F9,	{"\033[20~",	"\033[33~",	"\033[20^",	"\033[33^"}},
+  {VK_F10,	{"\033[21~",	"\033[34~",	"\033[21^",	"\033[34^"}},
+  {VK_F11,	{"\033[23~",	"\033[23$",	"\033[23^",	"\033[23@"}},
+  {VK_F12,	{"\033[24~",	"\033[24$",	"\033[24^",	"\033[24@"}},
+  /* CTRL-6 complies with Windows cmd console but should be fixed */
   {'6',		{NULL,		NULL,		"\036",		NULL}},
-  {0,		{"",		NULL,		NULL,		NULL}}
+  /* Table end marker */
+  {0}
 };
 
 const char *
@@ -2020,21 +2026,29 @@ get_nonascii_key (INPUT_RECORD& input_re
 #define NORMAL  0
 #define SHIFT	1
 #define CONTROL	2
-#define ALT	3
-  int modifier_index = NORMAL;
+/*#define CONTROLSHIFT	3*/
 
+  int modifier_index = NORMAL;
   if (input_rec.Event.KeyEvent.dwControlKeyState & SHIFT_PRESSED)
     modifier_index = SHIFT;
-  else if (input_rec.Event.KeyEvent.dwControlKeyState &
+  if (input_rec.Event.KeyEvent.dwControlKeyState &
 		(LEFT_CTRL_PRESSED | RIGHT_CTRL_PRESSED))
-    modifier_index = CONTROL;
-  else if (input_rec.Event.KeyEvent.dwControlKeyState &
-		(LEFT_ALT_PRESSED | RIGHT_ALT_PRESSED))
-    modifier_index = ALT;
+    modifier_index += CONTROL;
 
   for (int i = 0; keytable[i].vk; i++)
     if (input_rec.Event.KeyEvent.wVirtualKeyCode == keytable[i].vk)
-      return keytable[i].val[modifier_index];
+      {
+        if ((input_rec.Event.KeyEvent.dwControlKeyState &
+		(LEFT_ALT_PRESSED | RIGHT_ALT_PRESSED))
+	    && keytable[i].val[modifier_index] != NULL)
+          { /* Generic ESC prefixing if Alt is pressed */
+	    tmp[0] = '\033';
+	    strcpy (tmp + 1, keytable[i].val[modifier_index]);
+	    return tmp;
+          }
+        else
+          return keytable[i].val[modifier_index];
+      }
 
   if (input_rec.Event.KeyEvent.uChar.AsciiChar)
     {

--------------040209020900000303010206--
