Return-Path: <cygwin-patches-return-5224-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16279 invoked by alias); 17 Dec 2004 02:01:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15106 invoked from network); 17 Dec 2004 02:00:56 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 17 Dec 2004 02:00:56 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id A565B1B401; Thu, 16 Dec 2004 21:02:05 -0500 (EST)
Date: Fri, 17 Dec 2004 02:01:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Subject: Re: [Patch] cygcheck: eprintf + display_error: Do /something/.
Message-ID: <20041217020205.GA26712@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
References: <n2m-g.cpt7kf.3vvb68n.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.cpt7kf.3vvb68n.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00225.txt.bz2

On Fri, Dec 17, 2004 at 02:04:40AM +0100, Buzz wrote:
>Here is another attempt at making eprintf a usable/used function in
>cygcheck. It this time just flushes stdout and stderr before/after
>output on stderr, when both (stdout and stderr) are ttys.
>
>2004-12-16  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>
>
>	* cygcheck.cc (eprintf): Flush stdout before, and stderr after output,
>	when stdout and stderr both refer to tty's.
>	(display_error): Use eprintf.

I'm still not sure what you're hoping to accomplish with this.  I haven't
seen any problems with flushing in cygcheck and I wouldn't expect any
since the flushing should be automatic if stdout is a "tty".

cgf
