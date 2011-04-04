Return-Path: <cygwin-patches-return-7249-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13658 invoked by alias); 4 Apr 2011 00:22:47 -0000
Received: (qmail 13648 invoked by uid 22791); 4 Apr 2011 00:22:47 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-gy0-f171.google.com (HELO mail-gy0-f171.google.com) (209.85.160.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 04 Apr 2011 00:22:40 +0000
Received: by gye5 with SMTP id 5so2490984gye.2        for <cygwin-patches@cygwin.com>; Sun, 03 Apr 2011 17:22:40 -0700 (PDT)
Received: by 10.90.8.36 with SMTP id 36mr6571252agh.12.1301876560088;        Sun, 03 Apr 2011 17:22:40 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id t23sm4794413ano.51.2011.04.03.17.22.38        (version=SSLv3 cipher=OTHER);        Sun, 03 Apr 2011 17:22:39 -0700 (PDT)
Subject: Re: [PATCH] fix make after clean
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
In-Reply-To: <20110403230350.GA16226@ednor.casa.cgf.cx>
References: <1301870258.3104.11.camel@YAAKOV04>	 <20110403230350.GA16226@ednor.casa.cgf.cx>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 04 Apr 2011 00:22:00 -0000
Message-ID: <1301876562.3104.45.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00015.txt.bz2

On Sun, 2011-04-03 at 19:03 -0400, Christopher Faylor wrote:
> This can't be right.  In all of the times that I've run a "make clean",
> I have never needed this.  A .o relying on .cc is a given.  You don't
> need an explicit rule.

Without it, after a successfully completed build:

$ make clean -C i686-pc-cygwin/winsup/cygwin
[...]
$ make
[...goes until winsup/cygwin...]
[...compiles all files until link stage...]
g++: devices.o: No such file or directory
make[3]: *** [cygwin0.dll] Error 1

So in this case, apparently it is.


Yaakov

