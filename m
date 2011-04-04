Return-Path: <cygwin-patches-return-7254-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31934 invoked by alias); 4 Apr 2011 05:56:36 -0000
Received: (qmail 31924 invoked by uid 22791); 4 Apr 2011 05:56:35 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-iw0-f171.google.com (HELO mail-iw0-f171.google.com) (209.85.214.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 04 Apr 2011 05:56:30 +0000
Received: by iwn8 with SMTP id 8so7019661iwn.2        for <cygwin-patches@cygwin.com>; Sun, 03 Apr 2011 22:56:30 -0700 (PDT)
Received: by 10.42.157.199 with SMTP id e7mr1167748icx.278.1301896590148;        Sun, 03 Apr 2011 22:56:30 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id mv26sm3510308ibb.45.2011.04.03.22.56.27        (version=SSLv3 cipher=OTHER);        Sun, 03 Apr 2011 22:56:29 -0700 (PDT)
Subject: Re: [PATCH] fix make after clean
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
In-Reply-To: <20110404050727.GA23230@ednor.casa.cgf.cx>
References: <1301870258.3104.11.camel@YAAKOV04>	 <20110403230350.GA16226@ednor.casa.cgf.cx>	 <1301876562.3104.45.camel@YAAKOV04>	 <20110404050727.GA23230@ednor.casa.cgf.cx>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 04 Apr 2011 05:56:00 -0000
Message-ID: <1301896591.3104.49.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00020.txt.bz2

On Mon, 2011-04-04 at 01:07 -0400, Christopher Faylor wrote:
> On Sun, Apr 03, 2011 at 07:22:42PM -0500, Yaakov (Cygwin/X) wrote:
> >Without it, after a successfully completed build:
> >
> >$ make clean -C i686-pc-cygwin/winsup/cygwin
> >[...]
> >$ make
> >[...goes until winsup/cygwin...]
> >[...compiles all files until link stage...]
> >g++: devices.o: No such file or directory
> >make[3]: *** [cygwin0.dll] Error 1
> >
> >So in this case, apparently it is.
> 
> And, without it, I continue to build without problem.  I *am* building
> on Linux, though, so maybe that's the difference.

No, I duplicated this on Linux as well (after I tracked down a cocom
RPM), but that did make me think of other possibilities.  The difference
seems to be if you pass an absolute or relative path to the top-level
configure script; only in the latter does it fail as I described.  I
presume you've been using an absolute path?


Yaakov

