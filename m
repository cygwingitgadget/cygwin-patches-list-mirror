Return-Path: <cygwin-patches-return-2550-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9424 invoked by alias); 30 Jun 2002 22:14:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9409 invoked from network); 30 Jun 2002 22:14:02 -0000
X-WM-Posted-At: avacado.atomice.net; Sun, 30 Jun 02 23:17:33 +0100
Message-ID: <01a801c22083$ee74c5b0$0100a8c0@advent02>
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
References: <00c501c22036$2cfd0f20$0100a8c0@advent02> <20020630171319.GC32201@redhat.com>
Subject: Re: Fw: dup tty error.
Date: Sun, 30 Jun 2002 15:21:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00533.txt.bz2

> >2002-06-30  Christopher January <chris@atomice.net>
> >
> > * tty.cc (tty_list::allocate_tty): retry FindWindow if it fails.
>
>        __small_sprintf (buf, "cygwin.find.console.%d", myself->pid);
>        SetConsoleTitle (buf);
> -      Sleep (40);
> -      console = FindWindow (NULL, buf);
> +      for (int times = 0; times < 25 && console == NULL; times++)
> +           {
> +                 Sleep (40);
> +          console = FindWindow (NULL, buf);
> +           }
>        SetConsoleTitle (oldtitle);
>        Sleep (40);
>        ReleaseMutex (title_mutex);
>
> Is the SetConsoleTitle really succeeding when the window doesn't exist
> yet?  That seems really broken to me but I guess that not too surprising.
>
> I'm just wondering if we should be looping on the SetConsoleTitle rather
> than the FindWindow.
I did some testing and it seemed like looping on SetConsoleTitle was
unnecessary. I believe the window is open at this point, but the title is
set asynchronously, hence the loop to wait for the title to change.

Chris

