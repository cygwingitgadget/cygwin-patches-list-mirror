Return-Path: <cygwin-patches-return-5313-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10233 invoked by alias); 22 Jan 2005 21:02:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10142 invoked from network); 22 Jan 2005 21:02:51 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 22 Jan 2005 21:02:51 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 4832C1B524; Sat, 22 Jan 2005 16:03:03 -0500 (EST)
Date: Sat, 22 Jan 2005 21:02:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Fwd: RE: ssh problem on Windows XP]
Message-ID: <20050122210303.GC32005@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20050121173426.GA16347@cygbert.vinschen.de> <20050122205845.A3967E54A@carnage.curl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050122205845.A3967E54A@carnage.curl.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2005-q1/txt/msg00016.txt.bz2

On Sat, Jan 22, 2005 at 03:58:45PM -0500, Bob Byrnes wrote:
>On Jan 21,  6:34pm, Corinna Vinschen wrote:
>Our patches have been extensively tested, but we missed the problem
>that occurs for pending, nonblocking reads, because our automated
>builds don't use commands like sftp, unison, etc.  Most of the other
>commands seem to use nonblocking I/O on pipes (often with select), and
>that works with my patches.

Interesting stuff.  I'm looking forward to seeing all of your patches
eventually.

In the meantime, do yo have time to submit the short-circuiting patch that
you mentioned?  I agree that it makes sense to do things that way.

cgf
