Return-Path: <cygwin-patches-return-5095-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14419 invoked by alias); 28 Oct 2004 17:41:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14406 invoked from network); 28 Oct 2004 17:41:33 -0000
Received: from unknown (HELO esds.vss.fsi.com) (66.136.174.213)
  by sourceware.org with SMTP; 28 Oct 2004 17:41:33 -0000
Received: from fordpc.vss.fsi.com (fordpc [198.51.27.93])
	by esds.vss.fsi.com (8.11.6+Sun/8.9.1) with ESMTP id i9SHfTn06748
	for <cygwin-patches@cygwin.com>; Thu, 28 Oct 2004 12:41:29 -0500 (CDT)
Date: Thu, 28 Oct 2004 17:41:00 -0000
From: Brian Ford <ford@vss.fsi.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Deimpersonate while accessing HKLM
In-Reply-To: <Pine.CYG.4.58.0410281157530.2216@fordpc.vss.fsi.com>
Message-ID: <Pine.CYG.4.58.0410281240530.1248@fordpc.vss.fsi.com>
References: <3.0.5.32.20041027203301.0081e7d0@incoming.verizon.net>
 <Pine.CYG.4.58.0410281157530.2216@fordpc.vss.fsi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2004-q4/txt/msg00096.txt.bz2

On Thu, 28 Oct 2004, Brian Ford wrote:

> This may very well be user error, but I thought it important to report.
> After compiling current CVS I get a slew of:
>
> 53 [main] sh 3064 cygheap_user::reimpersonate: ImpersonateLoggedOnUser:
> Win32 error 6

Yup, user error.  After a clean build, this problem went away.  Sorry for
the noise.

> So, I thought I'd do a clean build.  Then I get:

Building under a working DLL instead of the broken one above fixes these
as well.

> ../../cygwin/libiberty/fibheap.c: In function `fibheap_union':
> ../../cygwin/libiberty/fibheap.c:166: warning: implicit declaration of
> function `free'
> ../../cygwin/libiberty/fibheap.c: In function `fibheap_delete_node':
> ../../cygwin/libiberty/fibheap.c:285: error: `LONG_MIN' undeclared (first
> use in this function)
> ../../cygwin/libiberty/fibheap.c:285: error: (Each undeclared identifier
> is reported only once
> ../../cygwin/libiberty/fibheap.c:285: error: for each function it appears
> in.)
> ../../cygwin/libiberty/fibheap.c: In function `fibheap_consolidate':
> ../../cygwin/libiberty/fibheap.c:395: warning: implicit declaration of
> function `memset'

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained pilot...
