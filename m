Return-Path: <cygwin-patches-return-5360-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27838 invoked by alias); 27 Feb 2005 03:03:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27642 invoked from network); 27 Feb 2005 03:03:17 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 27 Feb 2005 03:03:17 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 3DC161B55F; Sat, 26 Feb 2005 22:03:23 -0500 (EST)
Date: Sun, 27 Feb 2005 03:03:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fix buffer overflow in kill utility
Message-ID: <20050227030322.GA2853@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <422133BC.62A176E1@dessent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422133BC.62A176E1@dessent.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2005-q1/txt/msg00063.txt.bz2

On Sat, Feb 26, 2005 at 06:43:08PM -0800, Brian Dessent wrote:
>
>In kill.cc there exists the possibility to overflow the "char buf[80]"
>array by supplying malformed command line arguments.
>
>An attacker could use this to overwrite the return value on the stack
>and execute arbitrary code, but the amount of space available on the
>stack for shellcode is approx 108 bytes so you'd have to be mighty
>creative to do anything significant with it.  A far-fetched scenario
>might be some kind of perl or other CGI script running under Apache that
>somehow allows a user-specified signal name to reach the command line of
>/bin/kill.  Emphasis on the "far-fetched" part though.
>
>Example:
>
>$ /bin/kill -s `perl -e 'print "A"x200'`       
>Segmentation fault (core dumped)
>
>As far as I can tell from CVS history this has existed in kill.cc since
>its first version (~5 years.)  Trivial patch below.
>
>2005-02-26  Brian Dessent  <brian@dessent.net>
>
>	* kill.cc (getsig): Use snprintf to prevent overflowing `buf'.

Thanks for the patch.

Call me old-fashioned, but my first inclination in a case like this would be
to just limit the format spec to avoid overflow.  So, I've checked in a patch
which does this.

cgf
