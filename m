Return-Path: <cygwin-patches-return-2615-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21528 invoked by alias); 7 Jul 2002 19:01:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21506 invoked from network); 7 Jul 2002 19:01:23 -0000
Message-ID: <007801c225e8$f94d0550$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <015501c225c3$d8ddcc20$6132bc3e@BABEL> <20020707180435.GA1213@redhat.com>
Subject: Re: mark_closed messages
Date: Sun, 07 Jul 2002 12:01:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00063.txt.bz2

"Christopher Faylor" <cgf@redhat.com> wrote:
> Of course, maybe we should just nuke the whole concept, too.
> I think the vast majority of "problems" that the
> ProtectHandle stuff has unearthed have been "false
> positives", lately.

Thanks for the response, Chris.  It was a slew of false positives
that set me off looking at this, thinking that something was wrong
with the cygserver client code.  Of course, I didn't know they
were false when I started :-)

FWIW, all the problems I saw came from calls to setclexec_pid
after a fork, and I couldn't see any easy way to fix that code.  I
tried removing NO_COPY from the relevant data structures but then,
as I mentioned, you have to handle calls to ProtectHandle before
the parent's data is copied down (and there are quite a few such
calls).  I didn't consider using the cygheap mechanism, for no
other reason than I haven't looked at that bit yet.  Anyhow, you
understand the issues better than me.

Right now, I'm happy to know that it's nothing to do with the
cygserver code, which is what I was worried about.  And I'm glad
my fiddling around was of some use.  I'll get back to the
cygserver code now.

Cheers,

// Conrad


