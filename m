Return-Path: <cygwin-patches-return-5697-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27212 invoked by alias); 5 Jan 2006 15:12:30 -0000
Received: (qmail 27203 invoked by uid 22791); 5 Jan 2006 15:12:30 -0000
X-Spam-Check-By: sourceware.org
Received: from cgf.cx (HELO cgf.cx) (24.61.23.223)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Thu, 05 Jan 2006 15:12:27 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 46B4613C49C; Thu,  5 Jan 2006 10:12:26 -0500 (EST)
Date: Thu, 05 Jan 2006 15:12:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Correctly compute whether the process is a non-Cygwin process in  spawn_guts
Message-ID: <20060105151226.GC32362@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.63.0601050944160.1754@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.63.0601050944160.1754@slinky.cs.nyu.edu>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00006.txt.bz2

On Thu, Jan 05, 2006 at 09:46:46AM -0500, Igor Peshansky wrote:
>The attached patch fixes the "no output from commands invoked through ssh"
>for me.  The ChangeLog is below.
>	Igor
>==============================================================================
>2006-01-05  Igor Peshansky  <pechtcha@cs.nyu.edu>
>
>	* spawn.cc (spawn_guts): Invert the argument to
>	set_console_state_for_spawn.

Did you happen to notice the name of the argument to
"set_console_state_for_spawn"?

Sorry, but this seems to be a "fix the symptom" patch.

Apparently iscygexec is getting set incorrectly.  That is probably the
problem.

cgf
