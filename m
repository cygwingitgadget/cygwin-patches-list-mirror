Return-Path: <cygwin-patches-return-5365-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16382 invoked by alias); 4 Mar 2005 05:13:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16338 invoked from network); 4 Mar 2005 05:13:22 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 4 Mar 2005 05:13:22 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 005741B55F; Fri,  4 Mar 2005 00:13:45 -0500 (EST)
Date: Fri, 04 Mar 2005 05:13:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Timer functions
Message-ID: <20050304051345.GB11743@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20050303234545.00b42bc0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20050303234545.00b42bc0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2005-q1/txt/msg00068.txt.bz2

On Thu, Mar 03, 2005 at 11:45:45PM -0500, Pierre A. Humblet wrote:
>- the mu_to was not reinitialized on forks (non-inheritable event).

I just spent at least ten minutes looking for a "mu_to" in cygwin,
trying to figure out what you were referring to.  I'm not sure why
you're putting an underscore in the middle there.  Maybe you're thinking
that the "mu" and "to" have separate meanings but they really don't.

Did you actually see mutos not getting created?  Looking at the code
now, it seems like there would be a new muto created every time
there is a new instance of timer_tracker, which was certainly wrong but
it is different from mutos not being created after a fork.

cgf
