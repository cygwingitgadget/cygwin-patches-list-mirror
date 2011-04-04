Return-Path: <cygwin-patches-return-7256-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12901 invoked by alias); 4 Apr 2011 07:13:52 -0000
Received: (qmail 12883 invoked by uid 22791); 4 Apr 2011 07:13:50 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-iw0-f171.google.com (HELO mail-iw0-f171.google.com) (209.85.214.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 04 Apr 2011 07:13:34 +0000
Received: by iwn8 with SMTP id 8so7070524iwn.2        for <cygwin-patches@cygwin.com>; Mon, 04 Apr 2011 00:13:33 -0700 (PDT)
Received: by 10.43.47.72 with SMTP id ur8mr8952366icb.9.1301901213573;        Mon, 04 Apr 2011 00:13:33 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id g16sm3558000ibb.20.2011.04.04.00.13.32        (version=SSLv3 cipher=OTHER);        Mon, 04 Apr 2011 00:13:33 -0700 (PDT)
Subject: Re: [PATCH] fix make after clean
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
In-Reply-To: <1301896591.3104.49.camel@YAAKOV04>
References: <1301870258.3104.11.camel@YAAKOV04>	 <20110403230350.GA16226@ednor.casa.cgf.cx>	 <1301876562.3104.45.camel@YAAKOV04>	 <20110404050727.GA23230@ednor.casa.cgf.cx>	 <1301896591.3104.49.camel@YAAKOV04>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 04 Apr 2011 07:13:00 -0000
Message-ID: <1301901216.3104.73.camel@YAAKOV04>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00022.txt.bz2

On Mon, 2011-04-04 at 00:56 -0500, Yaakov (Cygwin/X) wrote:
> No, I duplicated this on Linux as well (after I tracked down a cocom
> RPM), but that did make me think of other possibilities.  The difference
> seems to be if you pass an absolute or relative path to the top-level
> configure script; only in the latter does it fail as I described.  I
> presume you've been using an absolute path?

This is definitely the problem.  If configure is called with a relative
path (e.g. mkdir build; cd build; ../configure ...), then srcdir is also
defined relative, which is then used in VPATH.  But when Makefile.common
is include()d, it overrides srcdir to an absolute path, the value of
which is used later in the $(srcdir)/devices.cc: rule.  Since the new
value of srcdir isn't identical to the old (although functionally the
same), make doesn't find the dependency automatically.

I see two solutions:

1) move the VPATH definition to after the Makefile.common inclusion, OR
2) change the $(srcdir)/devices.cc: rule to @srcdir@/devices.cc.

Your preference?


Yaakov

