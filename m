Return-Path: <cygwin-patches-return-7603-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32408 invoked by alias); 24 Feb 2012 11:00:55 -0000
Received: (qmail 32398 invoked by uid 22791); 24 Feb 2012 11:00:54 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-iy0-f171.google.com (HELO mail-iy0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 24 Feb 2012 11:00:39 +0000
Received: by iaeh11 with SMTP id h11so3571500iae.2        for <cygwin-patches@cygwin.com>; Fri, 24 Feb 2012 03:00:38 -0800 (PST)
Received-SPF: pass (google.com: domain of yselkowitz@gmail.com designates 10.50.194.233 as permitted sender) client-ip=10.50.194.233;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of yselkowitz@gmail.com designates 10.50.194.233 as permitted sender) smtp.mail=yselkowitz@gmail.com; dkim=pass header.i=yselkowitz@gmail.com
Received: from mr.google.com ([10.50.194.233])        by 10.50.194.233 with SMTP id hz9mr2170582igc.11.1330081238737 (num_hops = 1);        Fri, 24 Feb 2012 03:00:38 -0800 (PST)
Received: by 10.50.194.233 with SMTP id hz9mr1785022igc.11.1330081238597;        Fri, 24 Feb 2012 03:00:38 -0800 (PST)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id mr24sm6052499ibb.1.2012.02.24.03.00.37        (version=SSLv3 cipher=OTHER);        Fri, 24 Feb 2012 03:00:37 -0800 (PST)
Message-ID: <1330081241.6260.3.camel@YAAKOV04>
Subject: Re: [PATCH] Add pthread_getname_np, pthread_setname_np
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Date: Fri, 24 Feb 2012 11:00:00 -0000
In-Reply-To: <20120224093809.GA20683@calimero.vinschen.de>
References: <1330054695.6828.15.camel@YAAKOV04>	 <20120224093809.GA20683@calimero.vinschen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
X-SW-Source: 2012-q1/txt/msg00026.txt.bz2

On Fri, 2012-02-24 at 10:38 +0100, Corinna Vinschen wrote:
> On Feb 23 21:38, Yaakov (Cygwin/X) wrote:
> > This patchset adds pthread_getname_np and pthread_setname_np.  These
> > were added to glibc in 2.12[1] and are also present in some form on
> > NetBSD and several UNIXes.  IIUC recent versions of GDB can benefit from
> > this support.
> 
> Thanks for your patch, but I don't think it's the whole thing.
> 
> Consider, if you implement pthread_[gs]etname_np as you did, then you
> have pthread names which are only available to the process in which
> the threads are running.

My implementation is based on NetBSD's[1].  So what purpose do these
functions serve then on that it and the UNIXes?  (Serious question.)


Yaakov

[1] http://cvsweb.netbsd.org/bsdweb.cgi/src/lib/libpthread/pthread.c?rev=1.125

