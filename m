Return-Path: <cygwin-patches-return-7224-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4572 invoked by alias); 30 Mar 2011 08:56:33 -0000
Received: (qmail 4562 invoked by uid 22791); 30 Mar 2011 08:56:32 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0	tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-iy0-f171.google.com (HELO mail-iy0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 30 Mar 2011 08:56:28 +0000
Received: by iyi20 with SMTP id 20so1351151iyi.2        for <cygwin-patches@cygwin.com>; Wed, 30 Mar 2011 01:56:27 -0700 (PDT)
Received: by 10.231.42.199 with SMTP id t7mr939959ibe.144.1301475240445;        Wed, 30 Mar 2011 01:54:00 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id hc41sm2683510ibb.64.2011.03.30.01.53.59        (version=SSLv3 cipher=OTHER);        Wed, 30 Mar 2011 01:54:00 -0700 (PDT)
Subject: Re: [PATCH] /proc/loadavg: add running/total processes
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
In-Reply-To: <20110330081341.GA28987@calimero.vinschen.de>
References: <1301445133.756.11.camel@YAAKOV04>	 <20110330081341.GA28987@calimero.vinschen.de>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 30 Mar 2011 08:56:00 -0000
Message-ID: <1301475242.5552.28.camel@YAAKOV04>
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
X-SW-Source: 2011-q1/txt/msg00079.txt.bz2

On Wed, 2011-03-30 at 10:13 +0200, Corinna Vinschen wrote:
> On Mar 29 19:32, Yaakov (Cygwin/X) wrote:
> > This patch adds the fourth component of Linux's /proc/loadavg[1], the
> > current running/total processes count.  My only question is if states
> > other than 'O' and 'R' should be considered "running" for this purpose.
> 
> That looks right.  But I don't see that get_process_state will ever
> generate an 'O'.

Good point.  get_process_state() returns only R/S/Z, but
format_process_status() has a case for a few other states.  Why?

> What about the last column in /proc/loadavg, the last pid?  Shouldn't
> this be added and set to 0 as well?

I don't think using a 0 is a good idea, in case some software scanf()s
this file and tries to do something with the information (division by
zero comes to mind).

As for actually implementing the fifth column, I wasn't sure as to the
true significance of this number: is it really just the pid of the last
process or the number of processes launched since startup?  On Linux,
AFAICS these are one and the same, as pids are allocated sequentially,
but not on Cygwin.  I know the wording implies the former but the
purpose of this file makes me suspect the latter.  Insight, anyone?


Yaakov

