Return-Path: <cygwin-patches-return-7448-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25640 invoked by alias); 21 Jul 2011 18:59:44 -0000
Received: (qmail 25628 invoked by uid 22791); 21 Jul 2011 18:59:44 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-gx0-f171.google.com (HELO mail-gx0-f171.google.com) (209.85.161.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 21 Jul 2011 18:59:18 +0000
Received: by gxk22 with SMTP id 22so921210gxk.2        for <cygwin-patches@cygwin.com>; Thu, 21 Jul 2011 11:59:18 -0700 (PDT)
Received: by 10.150.238.8 with SMTP id l8mr1153988ybh.29.1311274758008;        Thu, 21 Jul 2011 11:59:18 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id p50sm1385749yhj.70.2011.07.21.11.59.16        (version=SSLv3 cipher=OTHER);        Thu, 21 Jul 2011 11:59:17 -0700 (PDT)
Subject: Re: [PATCH] clock_nanosleep(2), pthread_condattr_[gs]etclock(3)
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Thu, 21 Jul 2011 18:59:00 -0000
In-Reply-To: <20110721093554.GH15150@calimero.vinschen.de>
References: <1311126880.7796.9.camel@YAAKOV04>	 <20110720075654.GA3667@calimero.vinschen.de>	 <1311153377.7796.66.camel@YAAKOV04> <1311155453.7796.70.camel@YAAKOV04>	 <20110720141125.GA15232@calimero.vinschen.de>	 <1311199441.6248.9.camel@YAAKOV04> <1311214958.7552.24.camel@YAAKOV04>	 <20110721092105.GG15150@calimero.vinschen.de>	 <20110721093554.GH15150@calimero.vinschen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Message-ID: <1311274765.6192.10.camel@YAAKOV04>
Mime-Version: 1.0
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q3/txt/msg00024.txt.bz2

On Thu, 2011-07-21 at 11:35 +0200, Corinna Vinschen wrote:
> On Jul 21 11:21, Corinna Vinschen wrote:
> > No, you're not at all off-base.  Personally I'd prefer to use the native
> > NT timer functions, but that's not important.

No problem, that's something I keep forgetting about.

> > What I'm missing is a way to specify relative vs. absolute timeouts in
> > your above sketch.  I guess we need a flag argument as well.

Working on this last night, I decided to make the timeout a LONGLONG of
100ns units instead, positive for absolute and negative for relative.

> > Other than that, I think we should make sure to create the waitable
> > timer only once on a per-thread base.  Object creation and deletion is
> > usually a time consuming process.  So what we could do is to add a
> > HANDLE "cw_timer" to struct _local_storage in cygtls.h, which gets
> > inited to NULL in _cygtls::init_thread as well as in
> > _cygtls::fixup_after_fork.
> > 
> > Then cancelable_wait with a non-NULL timespec would check for the handle
> > being NULL and create a non-inheritable timer, if so.  All subsequent
> > calls only set (and cancel) the timer.
> > 
> > Does that sound reasonable?
> 
> Btw., if you call NtQueryTimer right before NtCancelTimer, then you get
> the remaining time for free to return to clock_nanosleep.  It would
> be nice if NtQueryTimer would return the remaining time after calling
> NtCancelTimer, but my experiments show that some weird value gets
> returned.  See my attached testcase.  Build with -lntdll.

Thanks, that was the piece I was missing last night.


Yaakov

