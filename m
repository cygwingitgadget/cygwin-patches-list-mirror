Return-Path: <cygwin-patches-return-2831-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24732 invoked by alias); 15 Aug 2002 20:34:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24716 invoked from network); 15 Aug 2002 20:34:53 -0000
Date: Thu, 15 Aug 2002 13:34:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fixed cygwin_GUARD
Message-ID: <20020815203506.GC21949@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0208152141330.-376009@thomas.kefrig-pfaff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0208152141330.-376009@thomas.kefrig-pfaff.de>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00279.txt.bz2

On Thu, Aug 15, 2002 at 09:51:45PM +0200, Thomas Pfaff wrote:
>2002-08-15  Thomas Pfaff  <tpfaff@gmx.net>
>
>	* dcrt0.cc: Modified define for CYGWIN_GUARD
>	(alloc_stack_hard_way): Fixed arguments for VirtualAlloc call.

Applied with a modified ChangeLog:

2002-08-15  Thomas Pfaff  <tpfaff@gmx.net>

	* dcrt0.cc: Modify define for CYGWIN_GUARD.
	(alloc_stack_hard_way): Just use CYGWIN_GUARD in VirtualAlloc call.


Thanks.
cgf
