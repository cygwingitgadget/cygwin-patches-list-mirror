Return-Path: <cygwin-patches-return-4261-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14680 invoked by alias); 27 Sep 2003 03:45:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14645 invoked from network); 27 Sep 2003 03:45:00 -0000
Date: Sat, 27 Sep 2003 03:45:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Implementation of sched_rr_get_interval for NT systems.
Message-ID: <20030927034455.GB18807@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030206022912.GC14293@redhat.com> <20030206114758.I78867-100000@logout.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030206114758.I78867-100000@logout.sh.cvut.cz>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00277.txt.bz2

[cleaning out my cygwin-patches backlog]
On Thu, Feb 06, 2003 at 01:16:17PM +0100, Vaclav Haisman wrote:
>2003-02-06  Vaclav Haisman  <V.Haisman@sh.cvut.cz>
>        * Makefile.in: Add libusr32.a to DLL_IMPORTS.
>        * wincap.h (wincaps::is_server): New flag.
>        (wincapc::version): Change type to OSVERSIONINFOEX.
>        (wincapc::is_server): New function.
>        * wincap.cc (wincap_unknown::is_server): New initializer.
>        (wincap_95): Ditto.
>        (wincap_95osr2): Ditto.
>        (wincap_98): Ditto.
>        (wincap_me): Ditto.
>        (wincap_nt3): Ditto.
>        (wincap_nt4): Ditto.
>        (wincap_nt4sp4): Ditto.
>        (wincap_2000): Ditto.
>        (wincap_xp): Ditto.
>        (wincapc::init): Adapt to OSVERSIONINFOEX. Add detection of NT
>        server systems.
>        * sched.cc: Include windows.h and registry.h.
>        (sched_rr_get_interval): Re-implement for NT systems.

Applied, many months later.

Sincere apologies for the delay.

Corinna, could you take a look at the wincap stuff and make sure it
makes sense?

cgf
