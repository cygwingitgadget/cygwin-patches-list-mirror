Return-Path: <cygwin-patches-return-2152-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1672 invoked by alias); 4 May 2002 15:48:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1658 invoked from network); 4 May 2002 15:48:43 -0000
X-WM-Posted-At: avacado.atomice.net; Sat, 4 May 02 16:51:34 +0100
Message-ID: <016001c1f383$90e0c700$0100a8c0@advent02>
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
References: <011901c1f2fb$1fbf5330$0100a8c0@advent02> <20020504042742.GI32261@redhat.com> <00c801c1f36d$73d55470$0100a8c0@advent02> <20020504153612.GC29229@redhat.com>
Subject: Re: Bug in ln / cygwin1.dll
Date: Sat, 04 May 2002 08:48:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00136.txt.bz2

> >> >When I run 'make -f Makefile.cvs' with QT3, I find that ln segfaults
> >trying
> >> >to create a symlink. I've included the output of strace showing the
> >problem,
> >> >output of cygcheck and also the stackdump ln produces. I can reproduce
> >this,
> >> >so if you need any more information, please ask. The problem occurs
with
> >the
> >> >latest Cygwin CVS.
> >> >ln is 'ln (fileutils) 4.1'.
> >> >cygwin is 'CYGWIN_NT-5.0 ADVENT02 1.3.11(0.52/3/2) 2002-05-03 15:18
i686
> >> >unknown'
> >>
> >> You're using a locally built version of cygwin.  Please run it under
gdb
> >> and pinpoint where the problem is occurring.  You may find the
techniques
> >> in how-to-debug-cygwin.txt useful.
> >
> >This patch fixes the problem.
>
> Why?
In the destructor, the code checks if normalized_path is non-NULL before
callin cfree on it. However, normalized_path is never initialised to NULL,
so it seems that sometimes cfree gets called on some memory that was never
allocated and that is what is causing the segfault.
My reasoning for this is as follows: I ran ln under gdb and found where the
segfault is (in cfree). I used the stack backtrace to find that cfree was
being called in path_conv::clear_normalized_path. gdb reported that the
normalized_path variable in this scope was an illegal non-NULL pointer. The
only time normalized_path is set is in path_conv::check, where it is
assigned to cstrdup (path_copy);
I guessed that only one of three things could have happened:
i) cstrdup() was returning an illegal pointer
ii) the pointer was getting corrupted somehow
iii) the pointer was never initialised to NULL in the first place
Looking at the constructor for path_conv I saw that indeed iii) was true.
Now one of the other points may have been true as well, but by initialising
normalized_path to NULL in the constructor of path_conv, the problem went
away.
I hope this explaination is satisfactory.

Regards
Chris


