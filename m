Return-Path: <cygwin-patches-return-2257-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7366 invoked by alias); 29 May 2002 12:50:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7311 invoked from network); 29 May 2002 12:50:10 -0000
Message-ID: <039d01c2070f$8da91ed0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <024701c2051d$e13cbdc0$6132bc3e@BABEL> <20020527022339.GA15585@redhat.com> <20020527142437.A26046@cygbert.vinschen.de> <20020527174354.GB21314@redhat.com> <20020527203832.A27852@cygbert.vinschen.de> <20020527184452.GA21106@redhat.com> <20020528021816.GA2066@redhat.com> <003f01c20693$14cbb990$6132bc3e@BABEL> <20020528224031.GA17266@redhat.com> <00bb01c20699$af643c60$6132bc3e@BABEL> <20020529051934.GA10833@redhat.com>
Subject: Re: New stat stuff (was [PATCH] improve performance of stat() operations (e.g. ls -lR ))
Date: Wed, 29 May 2002 05:50:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00240.txt.bz2

"Christopher Faylor" <cgf@redhat.com> wrote:
> I think you're running run.exe from Chuck Wilson's site.

Umm . . . (quick check). No: it's the copy from the current version of
XFree-startup-scripts (4.2.0-2). I was using it in this case without an X
server running (it's always happily worked either way, with or without).

> I managed to
> duplicate this behavior.  Apparently it happens because valid looking
> handles exist for stdin/stdout/stderr even when a program is linked with
> -mwindows.
> My new code attempted to do something with the handles and NT did
> something nonsensical.  I've worked around the behavior.  It's checked in
> and in the next snapshot.

Thanks: I've picked that up and it works fine now.

// Conrad

