Return-Path: <cygwin-patches-return-5314-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13372 invoked by alias); 24 Jan 2005 11:11:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13270 invoked from network); 24 Jan 2005 11:11:31 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.112.130)
  by sourceware.org with SMTP; 24 Jan 2005 11:11:31 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id F1D2E57D61; Mon, 24 Jan 2005 12:11:29 +0100 (CET)
Date: Mon, 24 Jan 2005 11:11:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Fwd: RE: ssh problem on Windows XP]
Message-ID: <20050124111129.GB14945@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20050121173426.GA16347@cygbert.vinschen.de> <20050122205845.A3967E54A@carnage.curl.com> <20050122210303.GC32005@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050122210303.GC32005@trixie.casa.cgf.cx>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q1/txt/msg00017.txt.bz2

On Jan 22 16:03, Christopher Faylor wrote:
> On Sat, Jan 22, 2005 at 03:58:45PM -0500, Bob Byrnes wrote:
> >Our patches have been extensively tested, but we missed the problem
> >that occurs for pending, nonblocking reads, because our automated
> >builds don't use commands like sftp, unison, etc.  Most of the other
> >commands seem to use nonblocking I/O on pipes (often with select), and
> >that works with my patches.
> 
> Interesting stuff.  I'm looking forward to seeing all of your patches
> eventually.
> 
> In the meantime, do yo have time to submit the short-circuiting patch that
> you mentioned?  I agree that it makes sense to do things that way.

Yes, that makes sense.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
