Return-Path: <cygwin-patches-return-7740-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10197 invoked by alias); 21 Oct 2012 18:32:46 -0000
Received: (qmail 10185 invoked by uid 22791); 21 Oct 2012 18:32:45 -0000
X-SWARE-Spam-Status: No, hits=-5.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mail-ia0-f171.google.com (HELO mail-ia0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 21 Oct 2012 18:32:42 +0000
Received: by mail-ia0-f171.google.com with SMTP id u21so1645573ial.2        for <cygwin-patches@cygwin.com>; Sun, 21 Oct 2012 11:32:41 -0700 (PDT)
Received: by 10.50.217.167 with SMTP id oz7mr14062752igc.3.1350844361602;        Sun, 21 Oct 2012 11:32:41 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id uj6sm6790270igb.4.2012.10.21.11.32.40        (version=TLSv1/SSLv3 cipher=OTHER);        Sun, 21 Oct 2012 11:32:41 -0700 (PDT)
Message-ID: <1350844361.1244.54.camel@YAAKOV04>
Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Sun, 21 Oct 2012 18:32:00 -0000
In-Reply-To: <20121021171053.GA24725@ednor.casa.cgf.cx>
References: <20121017164440.GA12989@ednor.casa.cgf.cx>	 <20121017170514.GD10578@calimero.vinschen.de>	 <20121017193258.GA15271@ednor.casa.cgf.cx>	 <1350545597.3492.59.camel@YAAKOV04>	 <20121018083419.GC6221@calimero.vinschen.de>	 <1350580828.3492.73.camel@YAAKOV04>	 <20121019092135.GA22432@calimero.vinschen.de>	 <1350664438.3492.114.camel@YAAKOV04>	 <20121019184636.GZ25877@calimero.vinschen.de>	 <20121021113320.GA2469@calimero.vinschen.de>	 <20121021171053.GA24725@ednor.casa.cgf.cx>
Content-Type: text/plain; charset="UTF-8"
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
X-SW-Source: 2012-q4/txt/msg00017.txt.bz2

On Sun, 2012-10-21 at 13:10 -0400, Christopher Faylor wrote:
> That said, is it time to ask the mingw.org stuff to relocate their
> CVS repo?  I could tar up the affected CVS directories for them if
> so.

What about some CVSROOT/modules magic to exclude winsup/mingw and
winsup/w32api from a Cygwin checkout?  

1) change the existing cygwin module to naked-cygwin;
2) add a new cygwin module with "-a src-support naked-cygwin
naked-newlib naked-include";
3) change the directions on cvs.html to "cvs co cygwin" instead of "cvs
co winsup" for new checkouts;
4) devs with existing checkouts could just rm -fr winsup/mingw
winsup/w32api if they so choose (but with the patch, they won't be used
anymore even if present).

As mingw.org already treats winsup/mingw and winsup/w32api as separate
repos[1], that should do the trick for us without forcing them to move.
Given our long-standing cooperation until now, I think it's the least we
could do.


Yaakov

[1] http://mingw.org/wiki/Official_CVS_Repository

