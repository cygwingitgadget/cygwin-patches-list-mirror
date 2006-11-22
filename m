Return-Path: <cygwin-patches-return-5998-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14569 invoked by alias); 22 Nov 2006 17:21:06 -0000
Received: (qmail 14529 invoked by uid 22791); 22 Nov 2006 17:21:03 -0000
X-Spam-Check-By: sourceware.org
Received: from ns2.bln1.siemens.de (HELO ns2.bln1.siemens.de) (194.138.127.35)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 22 Nov 2006 17:20:56 +0000
Received: from ns-srv-2.bln1.siemens.de (stbf7654 [194.138.127.67]) 	by ns2.bln1.siemens.de (8.13.5/8.13.5/MTA) with ESMTP id kAMHKo9Q028720 	for <cygwin-patches@cygwin.com>; Wed, 22 Nov 2006 18:20:50 +0100 (MET)
Received: from scotty.bln1.siemens.de (stbd7124.bln1.siemens.de [192.168.120.17]) 	by ns-srv-2.bln1.siemens.de (8.13.5/8.13.5/MTA) with SMTP id kAMHKjP2020766 	for cygwin-patches@cygwin.com; Wed, 22 Nov 2006 18:20:45 +0100 (MET)
Date: Wed, 22 Nov 2006 17:21:00 -0000
Message-Id: <200611221720.kAMHKjP2020766@ns-srv-2.bln1.siemens.de>
From: Thomas Wolff <towo@computer.org>
To: cygwin-patches@cygwin.com
Subject: [Patch] bug # 514 deja vu (cygwin console color handling)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=%%message-boundary%%
References: <E1CeJAV-0007GT-00@mrelayng.kundenserver.de>
In-Reply-To: <E1CeJAV-0007GT-00@mrelayng.kundenserver.de>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q4/txt/msg00016.txt.bz2


--%%message-boundary%%
Content-Type: text/plain
Content-length: 2012

I noticed that the reverse color bug
 http://sourceware.org/bugzilla/show_bug.cgi?id=514
shows up again in recent cygwin1.dll updates. My previous patch 
is still in the source but additional code apparently has the same 
effect of rendering output unreadable; the effect is the following:
* foreground is set bright
* screen mode is set to reverse
* cygwin wrongly assumes that the reverse foreground colour (which 
  actually used to be the non-bright background color) should be 
  set to bright, which is obviously a wrong idea and often results 
  in a contrast that renders the output almost unreadable

The attached shell script test514 demonstrates the bug.
The attached patch is an attempt to fix the bug again.
Unfortunately, I could not compile it due to the following mysterious 
make error:

make[4]: Entering directory `/usr/src/cygwin-1.5.22-patch/i686-pc-cygwin/newlib'
rm -f libm.a
ln libm/libm.a libm.a >/dev/null 2>/dev/null || cp libm/libm.a libm.a
rm -rf libc.a libg.a tmp
mkdir tmp
cd tmp; \
         ar x ../libm.a lib_a-s_isinf.o lib_a-sf_isinf.o lib_a-s_isnan.o lib_a-sf_isnan.o lib_a-s_isinfd.o lib_a-sf_isinff.o lib_a-s_isnand.o lib_a-sf_isnanf.o lib_a-s_nan.o lib_a-sf_nan.o lib_a-s_ldexp.o lib_a-sf_ldexp.o lib_a-s_frexp.o lib_a-sf_frexp.o lib_a-s_modf.o lib_a-sf_modf.o lib_a-s_scalbn.o lib_a-sf_scalbn.o lib_a-s_finite.o lib_a-sf_finite.o lib_a-s_copysign.o lib_a-sf_copysign.o lib_a-s_infconst.o ; \
         ar x ../libc/libc.a ; \
         ar rc ../libc.a *.o
/bin/sh: line 3: /bin/ar: Argument list too long
make[4]: *** [libc.a] Error 126


I would appreciate if someone (who can successfully compile cygwin1.dll) 
could check the patch, please, and the result.

Thanks a lot.
Thomas


2006-11-22  Thomas Wolff  <towo@computer.org>

* fhandler_console.cc (set_color): Avoid (again) inappropriate intensity 
     interchanging that used to render reverse output unreadable 
     when (non-reversed) text is bright.
     See http://sourceware.org/bugzilla/show_bug.cgi?id=514



--%%message-boundary%%
Content-Type: text/plain
Content-length: 975

--- cygwin-1.5.22-1/winsup/cygwin/fhandler_console.cc	2006-07-03 17:29:10.001000000 +0200
+++ cygwin-1.5.22-patch/winsup/cygwin/fhandler_console.cc	2006-11-22 17:37:15.518677900 +0100
@@ -948,6 +948,8 @@ dev_console::set_color (HANDLE h)
 	       (save_fg & FOREGROUND_BLUE  ? BACKGROUND_BLUE  : 0) |
 	       (save_fg & FOREGROUND_INTENSITY ? BACKGROUND_INTENSITY : 0);
     }
+
+  /* apply attributes */
   if (underline)
     win_fg = underline_color;
   /* emulate blink with bright background */
@@ -956,7 +958,12 @@ dev_console::set_color (HANDLE h)
   if (intensity == INTENSITY_INVISIBLE)
     win_fg = win_bg;
   else if (intensity == INTENSITY_BOLD)
-    win_fg |= FOREGROUND_INTENSITY;
+    /* apply foreground intensity only in non-reverse mode! */
+    if (reverse) 
+      win_bg |= BACKGROUND_INTENSITY;
+    else
+      win_fg |= FOREGROUND_INTENSITY;
+
   current_win32_attr = win_fg | win_bg;
   if (h)
     SetConsoleTextAttribute (h, current_win32_attr);

--%%message-boundary%%
Content-Type: application/octet-stream; name="test514"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="test514"
Content-length: 305

IyEgL2Jpbi9zaAoKZWNobyAiG1szMjs0MDsxbSBicmlnaHQgZ3JlZW4gb24g
YmxhY2sgIgplY2hvICIbWzdtIHJldmVyc2UgIiAiG1swbTwtIHJldmVyc2U7
IgplY2hvICIgc2hvdWxkIGFjdHVhbGx5IGJlIGJsYWNrIG9uIGJyaWdodCBn
cmVlbiIKZWNobyAiIHdpdGggdGhlIGJ1ZywgaXQncyBncmF5IChicmlnaHQg
YmxhY2spIG9uIChkaW0pIGdyZWVuIHNvIGFsbW9zdCB1bnJlYWRhYmxlIgoK

--%%message-boundary%%--
