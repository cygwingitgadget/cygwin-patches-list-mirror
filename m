Return-Path: <cygwin-patches-return-3190-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1853 invoked by alias); 15 Nov 2002 18:16:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1834 invoked from network); 15 Nov 2002 18:16:31 -0000
Message-ID: <03eb01c28cd2$c5cb96f0$0201a8c0@sos>
From: "Sergey Okhapkin" <sos@prospect.com.ru>
To: "Cygwin-Patches" <cygwin-patches@cygwin.com>
Subject: Fw: siginterrupt() call implementation
Date: Fri, 15 Nov 2002 10:16:00 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Virus-Scanned: by amavisd-milter (http://amavis.org/)
X-SW-Source: 2002-q4/txt/msg00141.txt.bz2

I apologise for sending a patch to a wrong list.

Sergey Okhapkin
Somerset, NJ
----- Original Message -----
From: "Sergey Okhapkin" <sos@prospect.com.ru>
To: <cygwin-developers@cygwin.com>
Sent: Thursday, November 14, 2002 9:35 PM
Subject: siginterrupt() call implementation


> The patch implements siginterrupt(3) library function.
>
> 2002-11-14  Sergey Okhapkin  <sos@prospect.com.ru>
>
>         * cygwin.din (siginterrupt): New export.
>         * signal.cc (siginterrupt): New.
>
>
> Index: cygwin.din
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
> retrieving revision 1.67
> diff -u -p -r1.67 cygwin.din
> --- cygwin.din  7 Nov 2002 09:08:39 -0000       1.67
> +++ cygwin.din  15 Nov 2002 02:31:50 -0000
> @@ -740,6 +740,8 @@ sigemptyset
>  _sigemptyset = sigemptyset
>  sigfillset
>  _sigfillset = sigfillset
> +siginterrupt
> +_siginterrupt = siginterrupt
>  signal
>  _signal = signal
>  significand
> Index: signal.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/signal.cc,v
> retrieving revision 1.36
> diff -u -p -r1.36 signal.cc
> --- signal.cc   20 Oct 2002 04:15:50 -0000      1.36
> +++ signal.cc   15 Nov 2002 02:31:51 -0000
> @@ -407,3 +407,16 @@ pause (void)
>  {
>    return handle_sigsuspend (myself->getsigmask ());
>  }
> +
> +extern "C" int
> +siginterrupt (int sig, int flag)
> +{
> +  struct sigaction act;
> +  (void)sigaction(sig, NULL, &act);
> +  if (flag)
> +    act.sa_flags &= ~SA_RESTART;
> +  else
> +    act.sa_flags |= SA_RESTART;
> +  return sigaction(sig, &act, NULL);
> +}
> +
>
> Sergey Okhapkin
> Somerset, NJ
>
>

