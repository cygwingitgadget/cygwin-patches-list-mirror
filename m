Return-Path: <cygwin-patches-return-7452-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10416 invoked by alias); 22 Jul 2011 06:34:10 -0000
Received: (qmail 10266 invoked by uid 22791); 22 Jul 2011 06:34:10 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-yi0-f43.google.com (HELO mail-yi0-f43.google.com) (209.85.218.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 22 Jul 2011 06:33:56 +0000
Received: by yib12 with SMTP id 12so1217887yib.2        for <cygwin-patches@cygwin.com>; Thu, 21 Jul 2011 23:33:55 -0700 (PDT)
Received: by 10.150.63.10 with SMTP id l10mr1443727yba.378.1311316435592;        Thu, 21 Jul 2011 23:33:55 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id y18sm1550424ybn.21.2011.07.21.23.33.53        (version=SSLv3 cipher=OTHER);        Thu, 21 Jul 2011 23:33:54 -0700 (PDT)
Subject: Re: [PATCH] clock_nanosleep(2), pthread_condattr_[gs]etclock(3)
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Fri, 22 Jul 2011 06:34:00 -0000
In-Reply-To: <20110721191521.GW15150@calimero.vinschen.de>
References: <20110720075654.GA3667@calimero.vinschen.de>	 <1311153377.7796.66.camel@YAAKOV04> <1311155453.7796.70.camel@YAAKOV04>	 <20110720141125.GA15232@calimero.vinschen.de>	 <1311199441.6248.9.camel@YAAKOV04> <1311214958.7552.24.camel@YAAKOV04>	 <20110721092105.GG15150@calimero.vinschen.de>	 <20110721093554.GH15150@calimero.vinschen.de>	 <1311274765.6192.10.camel@YAAKOV04>	 <20110721190910.GU15150@calimero.vinschen.de>	 <20110721191521.GW15150@calimero.vinschen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Message-ID: <1311316444.6192.46.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00028.txt.bz2

On Thu, 2011-07-21 at 21:15 +0200, Corinna Vinschen wrote:
> On Jul 21 21:09, Corinna Vinschen wrote:
> > On Jul 21 13:59, Yaakov (Cygwin/X) wrote:
> > Good idea.  The value can be immediately used in NtSetTimer and it
> > can be used for testing.
> 
> Erm... maybe PLARGE_INTEGER would be the right type for this?

You're right, that would also allow it to be used as an in/out variable
to get the remaining time back in nanosleep().

I'm most of the way there now, but I've got a busy weekend ahead, so I
probably won't be finished with this until at least Monday.


Yaakov

