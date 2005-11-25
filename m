Return-Path: <cygwin-patches-return-5680-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2754 invoked by alias); 25 Nov 2005 07:50:35 -0000
Received: (qmail 2745 invoked by uid 22791); 25 Nov 2005 07:50:35 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout09.sul.t-online.com (HELO mailout09.sul.t-online.com) (194.25.134.84)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 25 Nov 2005 07:50:34 +0000
Received: from fwd29.aul.t-online.de  	by mailout09.sul.t-online.com with smtp  	id 1EfYLo-0003OX-01; Fri, 25 Nov 2005 08:50:32 +0100
Received: from localhost (GnzRHZZVwedNw6GJVgy20WLdVD2lHKSorPVGzWeFww90DKkKtoHQgB@[172.20.101.250]) by fwd29.aul.t-online.de 	with esmtp id 1EfYLi-05iS2a0; Fri, 25 Nov 2005 08:50:26 +0100
MIME-Version: 1.0
In-Reply-To: <20051125012622.GA12798@trixie.casa.cgf.cx>
References: <43863896.4080203@t-online.de> <20051125012622.GA12798@trixie.casa.cgf.cx>
Date: Fri, 25 Nov 2005 07:50:00 -0000
To: cygwin-patches@cygwin.com
X-UMS: email
Subject: Re: Allow to send SIGQUIT via Ctrl+BREAK (patch included)
From: "Christian Franke" <Christian.Franke@t-online.de>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <1EfYLi-05iS2a0@fwd29.aul.t-online.de>
X-ID: GnzRHZZVwedNw6GJVgy20WLdVD2lHKSorPVGzWeFww90DKkKtoHQgB@t-dialin.net
X-TOI-MSGID: 7dd6d334-9459-4154-b0c7-ab3e6002780d
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2005-q4/txt/msg00022.txt.bz2

Christopher Faylor wrote:
>>[...]
>>Suggest to add some option to send SIGQUIT via ^BREAK.
>>
>>A simple patch is attached.
>>
>>It sends SIGQUIT on ^BREAK if both VINTR and VQUIT are set to ^C.  As
a
>>positive side effect, this disables any other SIGQUIT key in termios.
>
>Sorry but the precedent of sending SIGINT when pressing CTRL-BREAK is
>long-standing behavior that I am not comfortable changing.

Agree.

But the patch won't change this long standing-behavior unless the user
opts-in via "stty quit ^C" (see testcase).

So the patch shouldn't BREAK anything ;-)

As an alternative, a new CYGWIN environment setting could be used.
But using some termios setting for such an option is IMO the right thing
to do.

I missed the SIGQUIT via keyboard during the first port of smartd to
Cygwin last year. In smartd's debug mode, SIGINT is used to reload
configuration file, SIGQUIT to exit. This worked on every supported
platform except Cygwin.
The Cygwin-specific workaround ("press ^C twice to quit") added to
smartd.c has more lines than this cygwin1.dll patch ;-)

Christian

