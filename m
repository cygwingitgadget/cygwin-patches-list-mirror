Return-Path: <cygwin-patches-return-3360-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30519 invoked by alias); 9 Jan 2003 15:32:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30488 invoked from network); 9 Jan 2003 15:32:13 -0000
Message-ID: <003201c2b7f4$415aad00$6501a8c0@tcurtiss2>
From: "Troy Curtiss" <tcurtiss@qcpi.com>
To: <cygwin-patches@cygwin.com>
References: <4.3.2.7.2.20030107154846.00b30128@smtphost-cod.intra.kyocera-wireless.com> <20030109082133.GA21768@redhat.com>
Subject: Re: [PATCH] 230.4Kbps support for serial port
Date: Thu, 09 Jan 2003 15:32:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2003-q1/txt/msg00009.txt.bz2

Christopher,
  You're right, there is no such thing as CBR_230400 in Win32-land as
documented/supported by MS.  Simply replace CBR_230400 with 230400 and you
won't need to touch winbase.h.  Thanks,

-Troy

----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Thursday, January 09, 2003 1:21 AM
Subject: Re: [PATCH] 230.4Kbps support for serial port


> On Tue, Jan 07, 2003 at 03:48:51PM -0700, Troy Curtiss wrote:
> >Hi,
> >  Attached is a patch that enables cygwin to talk at 230400 bps on serial
> >ports that support the higher rate.  It also does the necessary
> >error-checking to confirm whether or not a given port is capable of
> >extended bitrates.  I added B230400 (for Posix) and CBR_230400 (for
Win32)
> >definitions to the appropriate header files (termios.h and winbase.h,
> >respectively).  I've been testing for a couple days now and it appears to
> >work as designed.  (We use a lot of extended bitrate devices at work,
> >mostly with Win32 code - so this simply brings the paradigm across to the
> >posix side of the house.)
> >
> >Question:  Upon failure (ie. trying to configure a non-230.4K capable
port
> >to talk 230.4K), I simply return -1...  I'm not sure whether POSIX would
> >set errno = EINVAL or not... either way is fine.
> >
> >  Let me know if you have any questions, otherwise it sure would be nice
> >to roll this in if possible :)  Thanks,
>
> I'll apply this patch (with a reformatted changelog) to cygwin but not
> to winbase.h.  I couldn't find any reference to a CBR_230400 anywhere so
> it wouldn't be technically correct to a windows header file.
>
> Thanks,
> cgf
>
> >2003-01-06  Troy Curtiss <troyc@usa.net>
> >
> > * fhandler_serial.cc (fhandler_serial::tcsetattr): Add support and
> > capability checking for B230400 bitrate.
> > * fhandler_serial.cc (fhandler_serial::tcgetattr): Add support for
> > B230400 bitrate.
> > * /cvs/src/src/winsup/w32api/include/winbase.h: Add CBR_230400
> > definition for Win32 support of 230.4Kbps.
> > * /cvs/src/src/winsup/cygwin/include/sys/termios.h: Add B230400
> > definition for Posix support of 230.4Kbps.
>
>
