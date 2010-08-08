Return-Path: <cygwin-patches-return-7055-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14558 invoked by alias); 8 Aug 2010 05:06:33 -0000
Received: (qmail 14548 invoked by uid 22791); 8 Aug 2010 05:06:32 -0000
X-SWARE-Spam-Status: No, hits=-50.9 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from mail-pw0-f43.google.com (HELO mail-pw0-f43.google.com) (209.85.160.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 08 Aug 2010 05:06:24 +0000
Received: by pwi5 with SMTP id 5so2069957pwi.2        for <cygwin-patches@cygwin.com>; Sat, 07 Aug 2010 22:06:22 -0700 (PDT)
Received: by 10.142.156.14 with SMTP id d14mr12030986wfe.248.1281243982595;        Sat, 07 Aug 2010 22:06:22 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [24.76.240.202])        by mx.google.com with ESMTPS id 23sm4323798wfa.10.2010.08.07.22.06.20        (version=SSLv3 cipher=RC4-MD5);        Sat, 07 Aug 2010 22:06:21 -0700 (PDT)
Subject: Re: [PATCH] POSIX monotonic clock
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
In-Reply-To: <20100803140420.GA21733@ednor.casa.cgf.cx>
References: <1280782148.6756.81.camel@YAAKOV04>	 <e9a284aade1fca8f1132eb866f4f7224@shell.sh.cvut.cz>	 <20100803140420.GA21733@ednor.casa.cgf.cx>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 08 Aug 2010 05:06:00 -0000
Message-ID: <1281243978.1344.0.camel@YAAKOV04>
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
X-SW-Source: 2010-q3/txt/msg00015.txt.bz2

On Tue, 2010-08-03 at 10:04 -0400, Christopher Faylor wrote:
> On Tue, Aug 03, 2010 at 09:32:47AM +0200, V??clav Haisman wrote:
> >This looks like you could get monotonic clock going backwards.
> 
> That's a good point.  We have that very problem here where I work.
> However, Yaakov isn't adding anything new here so, if this is a problem,
> it would be a long-standing one.
> 
> It sounds like it would be trivially solvable by setting the processor
> affinity mask but I'm not sure what that would mean for performance.

So should I hold off on my patch until this can be fixed?


Yaakov

