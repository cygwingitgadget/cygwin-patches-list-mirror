Return-Path: <cygwin-patches-return-2246-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15351 invoked by alias); 28 May 2002 22:46:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15320 invoked from network); 28 May 2002 22:46:26 -0000
Message-ID: <00bb01c20699$af643c60$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <FE045D4D9F7AED4CBFF1B3B813C85337676295@mail.sandvine.com> <20020527011013.GA15710@redhat.com> <024701c2051d$e13cbdc0$6132bc3e@BABEL> <20020527022339.GA15585@redhat.com> <20020527142437.A26046@cygbert.vinschen.de> <20020527174354.GB21314@redhat.com> <20020527203832.A27852@cygbert.vinschen.de> <20020527184452.GA21106@redhat.com> <20020528021816.GA2066@redhat.com> <003f01c20693$14cbb990$6132bc3e@BABEL> <20020528224031.GA17266@redhat.com>
Subject: Re: New stat stuff (was [PATCH] improve performance of stat() operations (e.g. ls -lR ))
Date: Tue, 28 May 2002 15:46:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00229.txt.bz2

"Christopher Faylor" <cgf@redhat.com> wrote:
> On Tue, May 28, 2002 at 11:00:28PM +0100, Conrad Scott wrote:
> >I've just picked up the latest changes from CVS and I'm having a problem
> >with run.exe from a .BAT file (i.e., from my current cygwin.bat
mechanism).
>
> What's run.exe?
>
> cgf

Sorry: it's /usr/X11R6/bin/run.exe, which was recommended by some as the
best way to launch rxvt from the cygwin.bat file. AFAIK it's meant to avoid
having the (irritating) command window pop-up before the rxvt window
appears. However, it fails to achieve that and I'd never (until just now)
taken it out of my cygwin.bat file.

I've also just had find fall over in the do_exit handling, something to do
with stack error checking? Anyhow, I junked the core file accidently so I've
lost that one.

// Conrad

