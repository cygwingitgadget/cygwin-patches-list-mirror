Return-Path: <cygwin-patches-return-5383-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7431 invoked by alias); 27 Mar 2005 02:01:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7315 invoked from network); 27 Mar 2005 02:01:04 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 27 Mar 2005 02:01:04 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id A88AA13C1F8; Sat, 26 Mar 2005 21:01:04 -0500 (EST)
Date: Sun, 27 Mar 2005 02:01:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Timer functions
Message-ID: <20050327020104.GA15060@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20050303234545.00b42bc0@incoming.verizon.net> <3.0.5.32.20050303234545.00b42bc0@incoming.verizon.net> <3.0.5.32.20050306234015.00b5a598@incoming.verizon.net> <003401c52331$a412c3b0$ac05a8c0@wirelessworld.airvananet.com> <20050307162807.GC4591@trixie.casa.cgf.cx> <005b01c52337$f8993210$ac05a8c0@wirelessworld.airvananet.com> <20050322190130.GB25678@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322190130.GB25678@trixie.casa.cgf.cx>
User-Agent: Mutt/1.5.6i
X-SW-Source: 2005-q1/txt/msg00086.txt.bz2

On Tue, Mar 22, 2005 at 02:01:30PM -0500, Christopher Faylor wrote:
>I just wanted to say that I haven't forgotten about this patch and I plan
>on adding it + some modifications soon.

I've just checked in a superset of this patch.  I deleted a lot more
stuff from window.cc (and wininfo.h) and added a method to cygthread
which allows passing an event which will be signalled when an auto
release thread exits.  This allows waiting for a thread to exit without
resorting to a busy loop.  I also cleaned up the locking a little.

This passes all of the apppropriate timer_* tests from the
posixtestsuite (http://posixtest.sourceforge.net/) but there are still a
couple of problems with nanosleep.  I'll get to those in the next couple
of days.

Thanks for the patch.

cgf
