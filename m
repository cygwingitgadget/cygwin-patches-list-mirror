Return-Path: <cygwin-patches-return-3362-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14269 invoked by alias); 9 Jan 2003 21:45:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14246 invoked from network); 9 Jan 2003 21:45:17 -0000
Date: Thu, 09 Jan 2003 21:45:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] 230.4Kbps support for serial port
Message-ID: <20030109214549.GA7399@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4.3.2.7.2.20030107154846.00b30128@smtphost-cod.intra.kyocera-wireless.com> <4.3.2.7.2.20030107154846.00b30128@smtphost-cod.intra.kyocera-wireless.com> <4.3.2.7.2.20030109111457.00b323a0@smtphost-cod.intra.kyocera-wireless.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4.3.2.7.2.20030109111457.00b323a0@smtphost-cod.intra.kyocera-wireless.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00011.txt.bz2

On Thu, Jan 09, 2003 at 11:18:31AM -0700, Troy Curtiss wrote:
>Christopher,
>  I see in the latest fhandler_serial::tcsetattr(), the following part of 
>my patch wasn't applied.  This piece is necessary in the event the serial 
>device doesn't actually support 230.4Kbps (so tcsetattr() will return an 
>error instead of simply not working.)

This piece short circuits lots of subsequent code, however.  It's a departure
from the way this function used to work.  And it does need to set an errno,
as you'd indicated.  I don't know what the errno would be, though.

cgf

>@@ -723,8 +726,12 @@ fhandler_serial::tcsetattr (int action,
>   state.fAbortOnError = TRUE;
>
>   /* -------------- Set state and exit ------------------ */
>-  if (memcmp (&ostate, &state, sizeof (state)) != 0)
>-    SetCommState (get_handle (), &state);
>+  if ((memcmp (&ostate, &state, sizeof (state)) != 0) &&
>+      !SetCommState (get_handle (), &state))
>+    {
>+      /* Return now if any of the parameters in the DCB didn't take */
>+      return -1;
>+    }
>
>  Thanks,
>
>-Troy
>
>
>
>At 03:21 AM 1/9/2003 -0500, you wrote:
>>On Tue, Jan 07, 2003 at 03:48:51PM -0700, Troy Curtiss wrote:
>>>Hi,
>>>  Attached is a patch that enables cygwin to talk at 230400 bps on serial
>>>ports that support the higher rate.  It also does the necessary
>>>error-checking to confirm whether or not a given port is capable of
>>>extended bitrates.  I added B230400 (for Posix) and CBR_230400 (for Win32)
>>>definitions to the appropriate header files (termios.h and winbase.h,
>>>respectively).  I've been testing for a couple days now and it appears to
>>>work as designed.  (We use a lot of extended bitrate devices at work,
>>>mostly with Win32 code - so this simply brings the paradigm across to the
>>>posix side of the house.)
>>>
>>>Question:  Upon failure (ie. trying to configure a non-230.4K capable port
>>>to talk 230.4K), I simply return -1...  I'm not sure whether POSIX would
>>>set errno = EINVAL or not... either way is fine.
>>>
>>>  Let me know if you have any questions, otherwise it sure would be nice
>>>to roll this in if possible :)  Thanks,
>>
>>I'll apply this patch (with a reformatted changelog) to cygwin but not
>>to winbase.h.  I couldn't find any reference to a CBR_230400 anywhere so
>>it wouldn't be technically correct to a windows header file.
>>
>>Thanks,
>>cgf
>>
>>>2003-01-06  Troy Curtiss <troyc@usa.net>
>>>
>>>       * fhandler_serial.cc (fhandler_serial::tcsetattr): Add support and
>>>       capability checking for B230400 bitrate.
>>>       * fhandler_serial.cc (fhandler_serial::tcgetattr): Add support for
>>>       B230400 bitrate.
>>>       * /cvs/src/src/winsup/w32api/include/winbase.h: Add CBR_230400
>>>       definition for Win32 support of 230.4Kbps.
>>>       * /cvs/src/src/winsup/cygwin/include/sys/termios.h: Add B230400
>>>       definition for Posix support of 230.4Kbps.
