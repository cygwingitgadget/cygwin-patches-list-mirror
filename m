Return-Path: <cygwin-patches-return-5537-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18934 invoked by alias); 9 Jun 2005 21:54:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18908 invoked by uid 22791); 9 Jun 2005 21:54:43 -0000
Received: from nat.electric-cloud.com (HELO main.electric-cloud.com) (63.82.0.114)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Thu, 09 Jun 2005 21:54:43 +0000
Received: from fulgurite.electric-cloud.com (fulgurite.electric-cloud.com [192.168.1.58])
	(authenticated bits=0)
	by main.electric-cloud.com (8.12.9/8.12.9) with ESMTP id j59LseM2012667
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <cygwin-patches@cygwin.com>; Thu, 9 Jun 2005 14:54:40 -0700
Subject: Re: [Patch] Testing loads of cygwin1.dll from MinGW and MSVC, take
	3
From: Max Kaehn <slothman@electric-cloud.com>
To: cygwin-patches@cygwin.com
In-Reply-To: <20050609085300.GG11065@calimero.vinschen.de>
References: <1118084587.5031.128.camel@fulgurite>
	 <20050606200639.GC13442@trixie.casa.cgf.cx>
	 <1118091704.5031.144.camel@fulgurite>
	 <20050606213339.GC16960@trixie.casa.cgf.cx>
	 <1118098448.5031.157.camel@fulgurite>
	 <Pine.GSO.4.61.0506061907220.15703@slinky.cs.nyu.edu>
	 <1118099492.5031.160.camel@fulgurite>
	 <20050606235137.GE16960@trixie.casa.cgf.cx>
	 <1118256244.5031.2661.camel@fulgurite>
	 <20050609085300.GG11065@calimero.vinschen.de>
Content-Type: text/plain
Message-Id: <1118354080.5031.2692.camel@fulgurite>
Mime-Version: 1.0
Date: Thu, 09 Jun 2005 21:54:00 -0000
Content-Transfer-Encoding: 7bit
X-Spam-Not-Checked:  Messages over 100K or from internal Electric Cloud machines are not checked
X-SW-Source: 2005-q2/txt/msg00133.txt.bz2

On Thu, 2005-06-09 at 01:53, Corinna Vinschen wrote:
> On Jun  8 11:44, Max Kaehn wrote:
> > I wound up using "eval", and was thoroughly perplexed at the way
> > that the first "eval" seems to get thrown away.
> 
> -v, please.
> 
>   tcsh> sh
>   $ eval date
>   Thu Jun  9 10:52:23 WEDT 2005
>   $
> 
> Corinna

"make -v" gives "GNU Make 3.80".  "sh -v" doesn't seem to do anything--
the ash man page doesn't mention a verbose or debugging mode.  
"cygcheck -f /bin/sh" reports ash-20040127-1.  "cygcheck -f /bin/make"
reports ash-20040127-1.  "make --debug" doesn't tell anything
interesting.  I'm using cygwin1.dll from the cygwin1-20050609.dll.bz2
snapshot.  (I wasn't sure if you meant -v for version numbers
or verbose output; I hope what you wanted is somewhere in there.)

I've tried testing this with a pure shell script and I can't reproduce
the problem there.  If the cause lies with GNU make, it's pretty
subtle, since the Electric Cloud make program gets the same results.

I'm badly out of practice with the classic Bourne shell, and I
haven't worked with ash before, so I may be missing something basic.

Using this makefile:
---
TESTS = foo bar baz

all:
	@i=0; \
	eval ""; \
	for tool in $(TESTS); do \
	    echo "results_$${tool}=$$i"; \
	    eval "results_$${tool}=$$i"; \
	    i=`expr $$i + 1`; \
	done; \
	echo "results_foo = $$results_foo"; \
	echo "results_bar = $$results_bar"; \
	echo "results_baz = $$results_baz"; \
	for tool in $(TESTS); do \
	    eval "result=\$$results_$$tool"; \
	    echo "results_$$tool = $$result";\
	    if [ $${result} -ne 0 ] ; then \
		exit $$result; \
	    fi; \
	done;
---
with the 'eval ""' line present I get:


fulgurite-xpdbg% make -f /u/cygwin/src/winsup/testsuite/iterate.mak
results_foo=0
results_bar=1
results_baz=2
results_foo = 0
results_bar = 1
results_baz = 2
results_foo = 0
results_bar = 1
make: *** [all] Error 1

Delete the line with 'eval ""' and:

fulgurite-xpdbg% make -f /u/cygwin/src/winsup/testsuite/iterate.mak
results_foo=0
results_bar=1
results_baz=2
results_foo = 
results_bar = 1
results_baz = 2
results_foo = 
[: 0: unknown operand
results_bar = 1
make: *** [all] Error 1

This shell script, on the other hand, works just fine:
---
	i=0; \
	for tool in foo bar baz; do \
	    echo "results_${tool}=$i"; \
	    eval "results_${tool}=$i"; \
	    i=`expr $i + 1`; \
	done; \
	echo "results_foo = $results_foo"; \
	echo "results_bar = $results_bar"; \
	echo "results_baz = $results_baz"; \
	for tool in foo bar baz; do \
	    eval "result=\$results_$tool"; \
	    echo "results_$tool = $result"; \
	    if [ ${result} -ne 0 ] ; then \
		exit $result; \
	    fi; \
	done;
---

