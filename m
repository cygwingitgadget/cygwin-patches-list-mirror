Return-Path: <cygwin-patches-return-5191-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28871 invoked by alias); 6 Dec 2004 15:15:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28844 invoked from network); 6 Dec 2004 15:15:45 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 6 Dec 2004 15:15:45 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 468701B491; Mon,  6 Dec 2004 10:16:19 -0500 (EST)
Date: Mon, 06 Dec 2004 15:15:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Subject: Re: [Patch] fhandler.cc (pust_readahead): end-condition off.
Message-ID: <20041206151619.GA11120@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
References: <n2m-g.cp0gle.3vsh6i5.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.cp0gle.3vsh6i5.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00192.txt.bz2

On Mon, Dec 06, 2004 at 02:45:10AM +0100, Bas van Gompel wrote:
>Hi,
>
>A real bugfix this time.
>
>When fhandler_base::puts_readahead is given a (non -1) len-parameter,
>in the current implementation, not len characters are stowed, but len
>z-strings. This affects at least fhandler_pty_master::accept_input in
>fhandler_tty.cc.
>
>Following (trivial, I'd say) patch ought to fix it.
>
>
>ChangeLog-entry:
>
>2004-12-06 Bas van Gompel  <cygwin-patch@bavag.tmfweb.nl>
>
>	* fhandler.cc (fhandler_base::puts_readahead): Fix end-condition.

This patch changes things so that len characters are always output if
len is != -1.  It has been a while since I worked on this code but it's
not clear that that is correct.

cgf

>--- src/winsup/cygwin-mmod/fhandler.cc	5 Dec 2004 07:28:27 -0000	1.209
>+++ src/winsup/cygwin-mmod/fhandler.cc	6 Dec 2004 01:14:14 -0000
>@@ -54,7 +54,7 @@ int
> fhandler_base::puts_readahead (const char *s, size_t len)
> {
>   int success = 1;
>-  while ((*s || (len != (size_t) -1 && len--))
>+  while ((len == (size_t) -1 ? *s : len--)
> 	 && (success = put_readahead (*s++) > 0))
>     continue;
>   return success;
