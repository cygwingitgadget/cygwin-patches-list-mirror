Return-Path: <cygwin-patches-return-7485-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31522 invoked by alias); 19 Aug 2011 14:44:19 -0000
Received: (qmail 31511 invoked by uid 22791); 19 Aug 2011 14:44:18 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm39-vm5.bullet.mail.bf1.yahoo.com (HELO nm39-vm5.bullet.mail.bf1.yahoo.com) (72.30.239.149)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Fri, 19 Aug 2011 14:44:04 +0000
Received: from [98.139.212.149] by nm39.bullet.mail.bf1.yahoo.com with NNFMP; 19 Aug 2011 14:44:03 -0000
Received: from [98.139.212.205] by tm6.bullet.mail.bf1.yahoo.com with NNFMP; 19 Aug 2011 14:44:03 -0000
Received: from [127.0.0.1] by omp1014.mail.bf1.yahoo.com with NNFMP; 19 Aug 2011 14:44:03 -0000
Received: (qmail 75166 invoked from network); 19 Aug 2011 14:44:03 -0000
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from cgf.cx (cgf@108.49.32.9 with login)        by smtp108.mail.bf1.yahoo.com with SMTP; 19 Aug 2011 07:44:03 -0700 PDT
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 4CABF1D00BF	for <cygwin-patches@cygwin.com>; Fri, 19 Aug 2011 10:44:03 -0400 (EDT)
Date: Fri, 19 Aug 2011 14:44:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add /proc/devices
Message-ID: <20110819144402.GC10953@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAGvSfexmqdO=i-Bpk_3T8h1knC17J9VHNa5geG33-fQujnwQ0Q@mail.gmail.com> <1313693438.4916.2.camel@YAAKOV04> <20110818195537.GD4955@calimero.vinschen.de> <1313718853.10964.0.camel@YAAKOV04> <20110819115253.GA13364@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110819115253.GA13364@calimero.vinschen.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q3/txt/msg00061.txt.bz2

On Fri, Aug 19, 2011 at 01:52:53PM +0200, Corinna Vinschen wrote:
>On Aug 18 20:54, Yaakov (Cygwin/X) wrote:
>> On Thu, 2011-08-18 at 21:55 +0200, Corinna Vinschen wrote:
>> > > 2011-08-18  Yaakov Selkowitz  <yselkowitz@...>
>> > > 
>> > > 	* devices.h (fh_devices): Define DEV_MISC_MAJOR, DEV_MEM_MAJOR,
>> > > 	DEV_SOUND_MAJOR.  Use throughout.
>> > > 	* fhandler_proc.cc (proc_tab): Add /proc/devices and /proc/misc
>> > > 	virtual files.
>> > > 	(format_proc_devices): New function.
>> > > 	(format_proc_misc): New function.
>> > 
>> > I think the patch is basically ok, but it's missing the "cons" entry
>> > for consoles, equivalent to the "tty" entry.
>> 
>> Revised patch attached.  OK to commit?
>> 
>> 
>> Yaakov
>> 
>
>> 2011-08-18  Yaakov Selkowitz  <yselkowitz@...>
>> 
>> 	* devices.h (fh_devices): Define DEV_MISC_MAJOR, DEV_MEM_MAJOR,
>> 	DEV_SOUND_MAJOR.  Use throughout.
>> 	* fhandler_proc.cc (proc_tab): Add /proc/devices and /proc/misc
>> 	virtual files.
>> 	(format_proc_devices): New function.
>> 	(format_proc_misc): New function.
>
>Yes, I think that's ok.

Isn't it somehow possible to just iterate over dev_storage and generate
this automatically rather than hard-coding the names of devices?

cgf
