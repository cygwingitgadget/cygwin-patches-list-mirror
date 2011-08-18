Return-Path: <cygwin-patches-return-7481-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8872 invoked by alias); 18 Aug 2011 19:56:14 -0000
Received: (qmail 8842 invoked by uid 22791); 18 Aug 2011 19:55:53 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 18 Aug 2011 19:55:40 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B1C7A2C00F4; Thu, 18 Aug 2011 21:55:37 +0200 (CEST)
Date: Thu, 18 Aug 2011 19:56:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add /proc/devices
Message-ID: <20110818195537.GD4955@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAGvSfexmqdO=i-Bpk_3T8h1knC17J9VHNa5geG33-fQujnwQ0Q@mail.gmail.com> <1313693438.4916.2.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1313693438.4916.2.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00057.txt.bz2

On Aug 18 13:50, Yaakov (Cygwin/X) wrote:
> On Thu, 2011-08-04 at 00:20 -0500, Yaakov (Cygwin/X) wrote:
> > This patchset implements /proc/devices[1]:
> > 
> > The question is how to handle /dev/tty and /dev/console as the
> > apparently vary now, per cgf's remarks on the main list.

/dev/tty, /dev/console and /dev/ptmx have fixed major and minor numbers.
But I see what you mean.  While `ls -l /dev/tty' on Linux always returns
with 5, 0 as major, minor, on Cygwin it returns with the major and minor
numbers of the actual tty it refers to:

  $ tty
  /dev/tty2
  $ ls -l /dev/tty
  crw--w---- 1 corinna vinschen 136, 2 Aug 18 21:51 /dev/tty

Same for /dev/console.  Chris, is it tricky to return always the
real major, minor pairs 5, 0 and 5, 1 for /dev/tty and /dev/console?

> Here is a second version which adds the closely related /proc/misc[1] as
> well.
> 
> 
> Yaakov
> 
> [1] http://docs.redhat.com/docs/en-US/Red_Hat_Enterprise_Linux/6/html/Deployment_Guide/s2-proc-misc.html
> 

> 2011-08-18  Yaakov Selkowitz  <yselkowitz@...>
> 
> 	* devices.h (fh_devices): Define DEV_MISC_MAJOR, DEV_MEM_MAJOR,
> 	DEV_SOUND_MAJOR.  Use throughout.
> 	* fhandler_proc.cc (proc_tab): Add /proc/devices and /proc/misc
> 	virtual files.
> 	(format_proc_devices): New function.
> 	(format_proc_misc): New function.

I think the patch is basically ok, but it's missing the "cons" entry
for consoles, equivalent to the "tty" entry.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
