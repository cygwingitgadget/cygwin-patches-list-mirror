Return-Path: <cygwin-patches-return-7447-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23153 invoked by alias); 21 Jul 2011 18:51:28 -0000
Received: (qmail 23143 invoked by uid 22791); 21 Jul 2011 18:51:28 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-yx0-f171.google.com (HELO mail-yx0-f171.google.com) (209.85.213.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 21 Jul 2011 18:51:15 +0000
Received: by yxk38 with SMTP id 38so923550yxk.2        for <cygwin-patches@cygwin.com>; Thu, 21 Jul 2011 11:51:14 -0700 (PDT)
Received: by 10.236.190.98 with SMTP id d62mr901745yhn.167.1311274274323;        Thu, 21 Jul 2011 11:51:14 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id a47sm1381500yhj.52.2011.07.21.11.51.11        (version=SSLv3 cipher=OTHER);        Thu, 21 Jul 2011 11:51:12 -0700 (PDT)
Subject: Re: [PATCH] clock_nanosleep(2)
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Thu, 21 Jul 2011 18:51:00 -0000
In-Reply-To: <20110721103735.GJ15150@calimero.vinschen.de>
References: <1311126880.7796.9.camel@YAAKOV04>	 <20110721103735.GJ15150@calimero.vinschen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Message-ID: <1311274281.6192.3.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00023.txt.bz2

On Thu, 2011-07-21 at 12:37 +0200, Corinna Vinschen wrote:
> Given our current discussion to change cancelable_wait, does it make
> sense to review this patch?  

No, the cancelable_wait changes need to go first.

> AFAICs the clock_nanosleep function will have to be changes quite a bit, right?

Definitely.

> Something else occured to me, but I think we should do this in an extra
> step, if at all.  IMO the family of sleep functions should be moved out
> of signal.cc into times.cc.  It just seems to belong there.

I'm not sure what the gain would be.


Yaakov

