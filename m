Return-Path: <cygwin-patches-return-5015-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3480 invoked by alias); 5 Oct 2004 14:40:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3447 invoked from network); 5 Oct 2004 14:40:04 -0000
Date: Tue, 05 Oct 2004 14:40:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] pinfo.cc: second CreatePipe, not first.
Message-ID: <20041005144025.GC13719@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.cjt3mt.3vvcq0n.1@buzzy-box.bavag> <20041005021043.GA7897@trixie.casa.cgf.cx> <n2m-g.cjtq1h.3vvba3b.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.cjtq1h.3vvba3b.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00016.txt.bz2

On Tue, Oct 05, 2004 at 09:45:53AM +0200, Bas van Gompel wrote:
>Op Mon, 4 Oct 2004 22:10:43 -0400 schreef Christopher Faylor
>in <20041005021043.GA7897@trixie.casa.cgf.cx>:
>:  On Tue, Oct 05, 2004 at 03:49:20AM +0200, Bas van Gompel wrote:
>
>[...]
>
>: > 	* pinfo.cc (_pinfo::commune_send): Make debugging output less ambiguous.
>:
>:   I've applied this patch.  Thanks.
>:
>:  I used a slightly less ambiguous ChangeLog, though. :-)
>
>``Correct debugging output.'' is less ambiguous? If you say so... :]

Yes, it is.  Having two debugging messages say "first" is obviously a
mistake that should be corrected.  It wasn't ambiguous.  It was wrong.

>BTW: What was your change to fhandler_termios.cc about? I see no
>ChangeLog-entry/cvs message for that.

That was a mistaken checkin.  I've reverted it.  Thanks for the heads up.

>BTW2: Did you see the question at the bottom of my other mail?

No, I didn't but the answer to your question is "I don't know it would
take some research to figure out."

cgf
