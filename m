Return-Path: <cygwin-patches-return-2606-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18634 invoked by alias); 5 Jul 2002 11:26:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18608 invoked from network); 5 Jul 2002 11:26:34 -0000
Message-ID: <00fa01c22417$1a0be4b0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <20020705030630.GA24255@redhat.com> <008301c22411$7cfc7900$6132bc3e@BABEL>
Subject: Re: printfs in cygserver?
Date: Fri, 05 Jul 2002 04:26:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00054.txt.bz2

"Conrad Scott" <Conrad.Scott@dsl.pipex.com> wrote:
> In case it's
> something you'd like fixed immediately, attached is a (slightly
> updated) copy of a patch I previously submitted to Rob that,
> among other things, changes the cygserver code to use the
> xxx_printf calls from "strace.h".  I'd be happy for this to
> go into HEAD; it's not a functionality patch, more of a brisk
> clean-up and rub-down patch :-)

Just to clarify, I'm also happy for it *not* to go into HEAD, i.e.
I've got no strong desire to merge anything from the cygwin_daemon
branch as yet.  The changes might just as well sit on the branch
until the cygserver reaches a "releasable" state (e.g. a
reasonably full SysV IPC implementation?) and then all of it be
merged in one go.

// Conrad


