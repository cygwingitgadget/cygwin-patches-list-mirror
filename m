Return-Path: <cygwin-patches-return-7828-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11802 invoked by alias); 22 Feb 2013 06:19:14 -0000
Received: (qmail 11785 invoked by uid 22791); 22 Feb 2013 06:19:10 -0000
X-SWARE-Spam-Status: No, hits=-5.3 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_SPAMHAUS_DROP,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE,TW_SF
X-Spam-Check-By: sourceware.org
Received: from mail-ie0-f173.google.com (HELO mail-ie0-f173.google.com) (209.85.223.173)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 22 Feb 2013 06:19:04 +0000
Received: by mail-ie0-f173.google.com with SMTP id 9so338155iec.18        for <cygwin-patches@cygwin.com>; Thu, 21 Feb 2013 22:19:04 -0800 (PST)
X-Received: by 10.50.190.138 with SMTP id gq10mr373754igc.38.1361513944039;        Thu, 21 Feb 2013 22:19:04 -0800 (PST)
Received: from YAAKOV04 (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id vb15sm979266igb.9.2013.02.21.22.19.02        (version=SSLv3 cipher=RC4-SHA bits=128/128);        Thu, 21 Feb 2013 22:19:03 -0800 (PST)
Date: Fri, 22 Feb 2013 06:19:00 -0000
From: Yaakov (Cygwin/X) <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Export <io.h> symbols with underscore
Message-ID: <20130222001848.7049805a@YAAKOV04>
In-Reply-To: <20130221194236.GA1163@ednor.casa.cgf.cx>
References: <20130220151600.5983c15a@YAAKOV04>	<20130221011432.GA2786@ednor.casa.cgf.cx>	<20130221111545.GA24054@calimero.vinschen.de>	<20130221194236.GA1163@ednor.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
X-SW-Source: 2013-q1/txt/msg00039.txt.bz2

On Thu, 21 Feb 2013 14:42:36 -0500, Christopher Faylor wrote:
> I wasn't fulling grokking the fact that Cygwin explicitly defined the
> get_osfhandle without an underscore in io.h.  Sigh.  That's probably my
> fault too.
> 
> But we definitely shouldn't be going back to adding "_" decorations.  I
> have deleted a few of these and no one has complained.  I know that
> isn't a scientific sampling but it's hard to believe that someone has
> written code which actually goes out of its way to prepend an underscore
> in front of a standard UNIX function name, especially since we do not,
> AFAIK, define these functions in any header file.
> 
> So, I guess I don't understand why we need to add an underscore now
> when we have gotten by with the incorrect declaration for get_osfhandle
> all of these years.

Because even if it caused a warning in C, the link still succeeded with
the underscored symbol.


Yaakov
