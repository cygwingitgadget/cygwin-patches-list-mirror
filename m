Return-Path: <cygwin-patches-return-7484-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23860 invoked by alias); 19 Aug 2011 11:53:29 -0000
Received: (qmail 23836 invoked by uid 22791); 19 Aug 2011 11:53:10 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 19 Aug 2011 11:52:56 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6F35F2C00F3; Fri, 19 Aug 2011 13:52:53 +0200 (CEST)
Date: Fri, 19 Aug 2011 11:53:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add /proc/devices
Message-ID: <20110819115253.GA13364@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAGvSfexmqdO=i-Bpk_3T8h1knC17J9VHNa5geG33-fQujnwQ0Q@mail.gmail.com> <1313693438.4916.2.camel@YAAKOV04> <20110818195537.GD4955@calimero.vinschen.de> <1313718853.10964.0.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1313718853.10964.0.camel@YAAKOV04>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q3/txt/msg00060.txt.bz2

On Aug 18 20:54, Yaakov (Cygwin/X) wrote:
> On Thu, 2011-08-18 at 21:55 +0200, Corinna Vinschen wrote:
> > > 2011-08-18  Yaakov Selkowitz  <yselkowitz@...>
> > > 
> > > 	* devices.h (fh_devices): Define DEV_MISC_MAJOR, DEV_MEM_MAJOR,
> > > 	DEV_SOUND_MAJOR.  Use throughout.
> > > 	* fhandler_proc.cc (proc_tab): Add /proc/devices and /proc/misc
> > > 	virtual files.
> > > 	(format_proc_devices): New function.
> > > 	(format_proc_misc): New function.
> > 
> > I think the patch is basically ok, but it's missing the "cons" entry
> > for consoles, equivalent to the "tty" entry.
> 
> Revised patch attached.  OK to commit?
> 
> 
> Yaakov
> 

> 2011-08-18  Yaakov Selkowitz  <yselkowitz@...>
> 
> 	* devices.h (fh_devices): Define DEV_MISC_MAJOR, DEV_MEM_MAJOR,
> 	DEV_SOUND_MAJOR.  Use throughout.
> 	* fhandler_proc.cc (proc_tab): Add /proc/devices and /proc/misc
> 	virtual files.
> 	(format_proc_devices): New function.
> 	(format_proc_misc): New function.

Yes, I think that's ok.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
