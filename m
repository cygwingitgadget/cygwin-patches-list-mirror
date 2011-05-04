Return-Path: <cygwin-patches-return-7295-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10412 invoked by alias); 4 May 2011 10:17:43 -0000
Received: (qmail 10395 invoked by uid 22791); 4 May 2011 10:17:42 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RFC_ABUSE_POST
X-Spam-Check-By: sourceware.org
Received: from mail-iy0-f171.google.com (HELO mail-iy0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 04 May 2011 10:17:28 +0000
Received: by iyi20 with SMTP id 20so1135532iyi.2        for <cygwin-patches@cygwin.com>; Wed, 04 May 2011 03:17:27 -0700 (PDT)
Received: by 10.42.82.81 with SMTP id c17mr1631796icl.34.1304504247035;        Wed, 04 May 2011 03:17:27 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id y10sm418483iba.46.2011.05.04.03.17.25        (version=SSLv3 cipher=OTHER);        Wed, 04 May 2011 03:17:25 -0700 (PDT)
Subject: Re: initialize local variable wait_return
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
In-Reply-To: <20110504060321.GC30194@ednor.casa.cgf.cx>
References: <BANLkTikUJ+opazYOga0URTKj6-6Nw_D+pw@mail.gmail.com>	 <BANLkTinhei4VRcfFLeFAJfqwOD08W1Df+w@mail.gmail.com>	 <20110504060321.GC30194@ednor.casa.cgf.cx>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 May 2011 10:17:00 -0000
Message-ID: <1304504251.820.1.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00061.txt.bz2

On Wed, 2011-05-04 at 02:03 -0400, Christopher Faylor wrote:
> On Wed, May 04, 2011 at 11:11:52AM +0800, Chiheng Xu wrote:
> >2011-05-04  Chiheng Xu  <chiheng.xu@gmail.com>
> >
> >       * fhandler.cc (fhandler_base_overlapped::wait_overlapped): initialize
> >local variable wait_return , otherwise, gcc-4.3.4 will not compile it.
> 
> Sorry but this is the wrong solution to this problem.  I rewrote the
> code recently to carefully set error conditions at each decision point.
> Globally setting it at the beginning is a step backwards and it actually
> masks the real problem.

FWIW, I regularly build CVS with gcc-4.5, and there is currently no
compilation problem.


Yaakov

