Return-Path: <cygwin-patches-return-7486-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32647 invoked by alias); 19 Aug 2011 19:50:55 -0000
Received: (qmail 32635 invoked by uid 22791); 19 Aug 2011 19:50:54 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-vw0-f43.google.com (HELO mail-vw0-f43.google.com) (209.85.212.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 19 Aug 2011 19:50:40 +0000
Received: by vws10 with SMTP id 10so3302942vws.2        for <cygwin-patches@cygwin.com>; Fri, 19 Aug 2011 12:50:39 -0700 (PDT)
Received: by 10.52.21.211 with SMTP id x19mr119175vde.457.1313783438993;        Fri, 19 Aug 2011 12:50:38 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id eq10sm1491686vdb.28.2011.08.19.12.50.36        (version=SSLv3 cipher=OTHER);        Fri, 19 Aug 2011 12:50:37 -0700 (PDT)
Subject: Re: [PATCH] Add /proc/devices
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Fri, 19 Aug 2011 19:50:00 -0000
In-Reply-To: <20110819144402.GC10953@ednor.casa.cgf.cx>
References: <CAGvSfexmqdO=i-Bpk_3T8h1knC17J9VHNa5geG33-fQujnwQ0Q@mail.gmail.com>	 <1313693438.4916.2.camel@YAAKOV04>	 <20110818195537.GD4955@calimero.vinschen.de>	 <1313718853.10964.0.camel@YAAKOV04>	 <20110819115253.GA13364@calimero.vinschen.de>	 <20110819144402.GC10953@ednor.casa.cgf.cx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Message-ID: <1313783438.2220.12.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00062.txt.bz2

On Fri, 2011-08-19 at 10:44 -0400, Christopher Faylor wrote:
> On Fri, Aug 19, 2011 at 01:52:53PM +0200, Corinna Vinschen wrote:
> >On Aug 18 20:54, Yaakov (Cygwin/X) wrote:
> >> 2011-08-18  Yaakov Selkowitz  <yselkowitz@...>
> >> 
> >> 	* devices.h (fh_devices): Define DEV_MISC_MAJOR, DEV_MEM_MAJOR,
> >> 	DEV_SOUND_MAJOR.  Use throughout.
> >> 	* fhandler_proc.cc (proc_tab): Add /proc/devices and /proc/misc
> >> 	virtual files.
> >> 	(format_proc_devices): New function.
> >> 	(format_proc_misc): New function.
> >
> >Yes, I think that's ok.
> 
> Isn't it somehow possible to just iterate over dev_storage and generate
> this automatically rather than hard-coding the names of devices?

I don't think so.  For the most part, /proc/devices doesn't list
individual devices but only groups thereof, and there is the "misc"
major device which is only descriptive and not an actual device name.
There is also the matter of distinguishing between block and character
devices.

As for /proc/misc, technically it could be done as you describe, but is
it worth the price of iterating over a 2581-member array to find the two
matching cases?  If the misc devices would vary based on configuration
as on Linux, I would see your point, but as we only and always have
these two, I'm not so sure.

Let me know how you want to proceed.


Yaakov

