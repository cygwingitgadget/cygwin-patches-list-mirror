Return-Path: <cygwin-patches-return-7266-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15686 invoked by alias); 4 Apr 2011 14:52:41 -0000
Received: (qmail 15676 invoked by uid 22791); 4 Apr 2011 14:52:40 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm28.bullet.mail.bf1.yahoo.com (HELO nm28.bullet.mail.bf1.yahoo.com) (98.139.212.187)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Mon, 04 Apr 2011 14:52:09 +0000
Received: from [98.139.212.144] by nm28.bullet.mail.bf1.yahoo.com with NNFMP; 04 Apr 2011 14:52:08 -0000
Received: from [98.139.213.10] by tm1.bullet.mail.bf1.yahoo.com with NNFMP; 04 Apr 2011 14:52:08 -0000
Received: from [127.0.0.1] by smtp110.mail.bf1.yahoo.com with NNFMP; 04 Apr 2011 14:52:08 -0000
Received: from cgf.cx (cgf@96.252.118.15 with login)        by smtp110.mail.bf1.yahoo.com with SMTP; 04 Apr 2011 07:52:08 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id C0638428013	for <cygwin-patches@cygwin.com>; Mon,  4 Apr 2011 10:52:07 -0400 (EDT)
Date: Mon, 04 Apr 2011 14:52:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix make after clean
Message-ID: <20110404145207.GB1140@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1301870258.3104.11.camel@YAAKOV04> <20110403230350.GA16226@ednor.casa.cgf.cx> <1301876562.3104.45.camel@YAAKOV04> <20110404050727.GA23230@ednor.casa.cgf.cx> <1301896591.3104.49.camel@YAAKOV04> <1301901216.3104.73.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1301901216.3104.73.camel@YAAKOV04>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00032.txt.bz2

On Mon, Apr 04, 2011 at 02:13:36AM -0500, Yaakov (Cygwin/X) wrote:
>On Mon, 2011-04-04 at 00:56 -0500, Yaakov (Cygwin/X) wrote:
>> No, I duplicated this on Linux as well (after I tracked down a cocom
>> RPM), but that did make me think of other possibilities.  The difference
>> seems to be if you pass an absolute or relative path to the top-level
>> configure script; only in the latter does it fail as I described.  I
>> presume you've been using an absolute path?
>
>This is definitely the problem.  If configure is called with a relative
>path (e.g. mkdir build; cd build; ../configure ...), then srcdir is also
>defined relative, which is then used in VPATH.  But when Makefile.common
>is include()d, it overrides srcdir to an absolute path, the value of
>which is used later in the $(srcdir)/devices.cc: rule.  Since the new
>value of srcdir isn't identical to the old (although functionally the
>same), make doesn't find the dependency automatically.
>
>I see two solutions:
>
>1) move the VPATH definition to after the Makefile.common inclusion, OR
>2) change the $(srcdir)/devices.cc: rule to @srcdir@/devices.cc.
>
>Your preference?

The last time I reported that I was using relative paths in the
gcc/binutils/winsup directory I was told "Don't do that.  It isn't
supported."  However, I'll move the call to Makefile.common earlier
in Makefile.in.

Thanks for the analysis.

cgf
