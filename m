Return-Path: <cygwin-patches-return-5057-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5858 invoked by alias); 14 Oct 2004 15:55:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5849 invoked from network); 14 Oct 2004 15:55:30 -0000
Date: Thu, 14 Oct 2004 15:55:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] testsuite and newlib's signal.h.
Message-ID: <20041014155559.GD22814@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.ckmcqg.3vvbujf.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.ckmcqg.3vvbujf.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00058.txt.bz2

On Thu, Oct 14, 2004 at 05:31:31PM +0200, Bas van Gompel wrote:
>Another trivial patch, a bit kludgy...
>
>ATM the testsuite does not build, because
>newlib/libc/include/sys/signal.h includes newlib/libc/include/signal.h.

This is a recent change to sys/signal.h and it is supposed to "just
work".  If it isn't working then please report the problem to the newlib
mailing list.

cgf
