Return-Path: <cygwin-patches-return-2244-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31012 invoked by alias); 28 May 2002 21:59:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30997 invoked from network); 28 May 2002 21:59:13 -0000
Message-ID: <003f01c20693$14cbb990$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <FE045D4D9F7AED4CBFF1B3B813C85337676295@mail.sandvine.com> <20020527011013.GA15710@redhat.com> <024701c2051d$e13cbdc0$6132bc3e@BABEL> <20020527022339.GA15585@redhat.com> <20020527142437.A26046@cygbert.vinschen.de> <20020527174354.GB21314@redhat.com> <20020527203832.A27852@cygbert.vinschen.de> <20020527184452.GA21106@redhat.com> <20020528021816.GA2066@redhat.com>
Subject: Re: New stat stuff (was [PATCH] improve performance of stat() operations (e.g. ls -lR ))
Date: Tue, 28 May 2002 14:59:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00227.txt.bz2

Chris,

I've just picked up the latest changes from CVS and I'm having a problem
with run.exe from a .BAT file (i.e., from my current cygwin.bat mechanism).

After a bit of tracing, I've found that it comes down to NtQueryObject in
handle_to_fn() in dtable.cc. NtQueryObject succeeds but the Name.Buffer
pointer in the OBJECT_NAME_INFORMATION structure is NULL (and both the
Name.Length and Name.MaximumLength fields are 0 too).

Quite how that's meant to be a successful operation I'm very far from clear.
I've also not the foggiest exactly what's happening, as run.exe fails only
if not run from a cygwin process (i.e. only fails in BAT files or from the
command prompt).

I'm just changing my local copy to check for this problem and see if it
otherwise works. All else seems okay so far.

// Conrad

