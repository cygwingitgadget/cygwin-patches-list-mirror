Return-Path: <cygwin-patches-return-4502-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17236 invoked by alias); 12 Dec 2003 19:20:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17214 invoked from network); 12 Dec 2003 19:20:36 -0000
Date: Fri, 12 Dec 2003 19:20:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: termios.cc: Restore setting of EBADF appropriately throughout
Message-ID: <20031212192036.GA6287@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.58.0312121305400.23399@eos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0312121305400.23399@eos>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00221.txt.bz2

On Fri, Dec 12, 2003 at 01:14:32PM -0600, Brian Ford wrote:
>I noticed this while digging through other serial port problems.  It
>appears to have been lost in version 1.16, although there did not appear
>to be a reason for the loss in that change.  Please let me know if it was
>intentional for some reason that I do not understand.  Thanks.
>
>2003-12-12  Brian Ford  <ford@vss.fsi.com>
>
>	* termios.cc: Restore setting of EBADF appropriately throughout.
>	Lost in version 1.16.

I think you've missed the fact that cygheap_fdget sets errno.  That is part of
the reason for its existence.  If it is not doing that, then that's the bug
which needs to be fixed.

cgf
