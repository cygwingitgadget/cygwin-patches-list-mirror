Return-Path: <cygwin-patches-return-3361-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4059 invoked by alias); 9 Jan 2003 18:18:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4030 invoked from network); 9 Jan 2003 18:18:57 -0000
Message-Id: <4.3.2.7.2.20030109111457.00b323a0@smtphost-cod.intra.kyocera-wireless.com>
X-Sender: tcurtiss@smtphost-cod.intra.kyocera-wireless.com
Date: Thu, 09 Jan 2003 18:18:00 -0000
To: cygwin-patches@cygwin.com
From: Troy Curtiss <tcurtiss@qcpi.com>
Subject: Re: [PATCH] 230.4Kbps support for serial port
In-Reply-To: <20030109082133.GA21768@redhat.com>
References: <4.3.2.7.2.20030107154846.00b30128@smtphost-cod.intra.kyocera-wireless.com>
 <4.3.2.7.2.20030107154846.00b30128@smtphost-cod.intra.kyocera-wireless.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====================_760357326==_.ALT"
X-SW-Source: 2003-q1/txt/msg00010.txt.bz2

--=====================_760357326==_.ALT
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-length: 2586

Christopher,
   I see in the latest fhandler_serial::tcsetattr(), the following part of 
my patch wasn't applied.  This piece is necessary in the event the serial 
device doesn't actually support 230.4Kbps (so tcsetattr() will return an 
error instead of simply not working.)

@@ -723,8 +726,12 @@ fhandler_serial::tcsetattr (int action,
    state.fAbortOnError = TRUE;

    /* -------------- Set state and exit ------------------ */
-  if (memcmp (&ostate, &state, sizeof (state)) != 0)
-    SetCommState (get_handle (), &state);
+  if ((memcmp (&ostate, &state, sizeof (state)) != 0) &&
+      !SetCommState (get_handle (), &state))
+    {
+      /* Return now if any of the parameters in the DCB didn't take */
+      return -1;
+    }

   Thanks,

-Troy



At 03:21 AM 1/9/2003 -0500, you wrote:
>On Tue, Jan 07, 2003 at 03:48:51PM -0700, Troy Curtiss wrote:
> >Hi,
> >  Attached is a patch that enables cygwin to talk at 230400 bps on serial
> >ports that support the higher rate.  It also does the necessary
> >error-checking to confirm whether or not a given port is capable of
> >extended bitrates.  I added B230400 (for Posix) and CBR_230400 (for Win32)
> >definitions to the appropriate header files (termios.h and winbase.h,
> >respectively).  I've been testing for a couple days now and it appears to
> >work as designed.  (We use a lot of extended bitrate devices at work,
> >mostly with Win32 code - so this simply brings the paradigm across to the
> >posix side of the house.)
> >
> >Question:  Upon failure (ie. trying to configure a non-230.4K capable port
> >to talk 230.4K), I simply return -1...  I'm not sure whether POSIX would
> >set errno = EINVAL or not... either way is fine.
> >
> >  Let me know if you have any questions, otherwise it sure would be nice
> >to roll this in if possible :)  Thanks,
>
>I'll apply this patch (with a reformatted changelog) to cygwin but not
>to winbase.h.  I couldn't find any reference to a CBR_230400 anywhere so
>it wouldn't be technically correct to a windows header file.
>
>Thanks,
>cgf
>
> >2003-01-06  Troy Curtiss <troyc@usa.net>
> >
> >       * fhandler_serial.cc (fhandler_serial::tcsetattr): Add support and
> >       capability checking for B230400 bitrate.
> >       * fhandler_serial.cc (fhandler_serial::tcgetattr): Add support for
> >       B230400 bitrate.
> >       * /cvs/src/src/winsup/w32api/include/winbase.h: Add CBR_230400
> >       definition for Win32 support of 230.4Kbps.
> >       * /cvs/src/src/winsup/cygwin/include/sys/termios.h: Add B230400
> >       definition for Posix support of 230.4Kbps.

--=====================_760357326==_.ALT
Content-Type: text/html; charset="us-ascii"
Content-length: 3606

<html>
Christopher,<br>
&nbsp; I see in the latest fhandler_serial::tcsetattr(), the following
part of my patch wasn't applied.&nbsp; This piece is necessary in the
event the serial device doesn't actually support 230.4Kbps (so
tcsetattr() will return an error instead of simply not working.)<br>
<br>
<font face="Courier New, Courier">@@ -723,8 +726,12 @@
fhandler_serial::tcsetattr (int action, <br>
&nbsp;&nbsp; state.fAbortOnError = TRUE;<br>
&nbsp;<br>
&nbsp;&nbsp; /* -------------- Set state and exit ------------------
*/<br>
-&nbsp; if (memcmp (&amp;ostate, &amp;state, sizeof (state)) != 0)<br>
-&nbsp;&nbsp;&nbsp; SetCommState (get_handle (), &amp;state);<br>
+&nbsp; if ((memcmp (&amp;ostate, &amp;state, sizeof (state)) != 0)
&amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !SetCommState (get_handle (),
&amp;state))<br>
+&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Return now if any of the parameters in
the DCB didn't take */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1;<br>
+&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
</font>&nbsp; Thanks,<br>
<br>
-Troy<br>
<br>
<br>
<br>
At 03:21 AM 1/9/2003 -0500, you wrote:<br>
<blockquote type=cite cite>On Tue, Jan 07, 2003 at 03:48:51PM -0700, Troy
Curtiss wrote:<br>
&gt;Hi,<br>
&gt;&nbsp; Attached is a patch that enables cygwin to talk at 230400 bps
on serial <br>
&gt;ports that support the higher rate.&nbsp; It also does the necessary
<br>
&gt;error-checking to confirm whether or not a given port is capable of
<br>
&gt;extended bitrates.&nbsp; I added B230400 (for Posix) and CBR_230400
(for Win32) <br>
&gt;definitions to the appropriate header files (termios.h and winbase.h,
<br>
&gt;respectively).&nbsp; I've been testing for a couple days now and it
appears to <br>
&gt;work as designed.&nbsp; (We use a lot of extended bitrate devices at
work, <br>
&gt;mostly with Win32 code - so this simply brings the paradigm across to
the <br>
&gt;posix side of the house.)<br>
&gt;<br>
&gt;Question:&nbsp; Upon failure (ie. trying to configure a non-230.4K
capable port <br>
&gt;to talk 230.4K), I simply return -1...&nbsp; I'm not sure whether
POSIX would <br>
&gt;set errno = EINVAL or not... either way is fine.<br>
&gt;<br>
&gt;&nbsp; Let me know if you have any questions, otherwise it sure would
be nice <br>
&gt;to roll this in if possible :)&nbsp; Thanks,<br>
<br>
I'll apply this patch (with a reformatted changelog) to cygwin but
not<br>
to winbase.h.&nbsp; I couldn't find any reference to a CBR_230400
anywhere so<br>
it wouldn't be technically correct to a windows header file.<br>
<br>
Thanks,<br>
cgf<br>
<br>
&gt;2003-01-06&nbsp; Troy Curtiss &lt;troyc@usa.net&gt;<br>
&gt;<br>
&gt;<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>*
fhandler_serial.cc (fhandler_serial::tcsetattr): Add support and<br>
&gt;<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>capability
checking for B230400 bitrate.<br>
&gt;<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>*
fhandler_serial.cc (fhandler_serial::tcgetattr): Add support for<br>
&gt;<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>B230400
bitrate.<br>
&gt;<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>*
/cvs/src/src/winsup/w32api/include/winbase.h: Add CBR_230400<br>
&gt;<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>definition
for Win32 support of 230.4Kbps.<br>
&gt;<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>*
/cvs/src/src/winsup/cygwin/include/sys/termios.h: Add B230400<br>
&gt;<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>definition
for Posix support of 230.4Kbps.</blockquote></html>

--=====================_760357326==_.ALT--
