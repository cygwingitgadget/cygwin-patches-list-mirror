Return-Path: <cygwin-patches-return-7482-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20096 invoked by alias); 18 Aug 2011 20:28:00 -0000
Received: (qmail 20085 invoked by uid 22791); 18 Aug 2011 20:27:59 -0000
X-SWARE-Spam-Status: No, hits=-1.5 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm17-vm1.bullet.mail.ne1.yahoo.com (HELO nm17-vm1.bullet.mail.ne1.yahoo.com) (98.138.91.34)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Thu, 18 Aug 2011 20:27:45 +0000
Received: from [98.138.90.57] by nm17.bullet.mail.ne1.yahoo.com with NNFMP; 18 Aug 2011 20:27:44 -0000
Received: from [98.138.226.62] by tm10.bullet.mail.ne1.yahoo.com with NNFMP; 18 Aug 2011 20:27:44 -0000
Received: from [127.0.0.1] by smtp213.mail.ne1.yahoo.com with NNFMP; 18 Aug 2011 20:27:44 -0000
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from cgf.cx (cgf@108.49.32.9 with login)        by smtp213.mail.ne1.yahoo.com with SMTP; 18 Aug 2011 13:27:44 -0700 PDT
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 8B9344A803D	for <cygwin-patches@cygwin.com>; Thu, 18 Aug 2011 16:27:43 -0400 (EDT)
Date: Thu, 18 Aug 2011 20:28:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add /proc/devices
Message-ID: <20110818202743.GB29396@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAGvSfexmqdO=i-Bpk_3T8h1knC17J9VHNa5geG33-fQujnwQ0Q@mail.gmail.com> <1313693438.4916.2.camel@YAAKOV04> <20110818195537.GD4955@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110818195537.GD4955@calimero.vinschen.de>
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
X-SW-Source: 2011-q3/txt/msg00058.txt.bz2

On Thu, Aug 18, 2011 at 09:55:37PM +0200, Corinna Vinschen wrote:
>On Aug 18 13:50, Yaakov (Cygwin/X) wrote:
>> On Thu, 2011-08-04 at 00:20 -0500, Yaakov (Cygwin/X) wrote:
>> > This patchset implements /proc/devices[1]:
>> > 
>> > The question is how to handle /dev/tty and /dev/console as the
>> > apparently vary now, per cgf's remarks on the main list.
>
>/dev/tty, /dev/console and /dev/ptmx have fixed major and minor numbers.
>But I see what you mean.  While `ls -l /dev/tty' on Linux always returns
>with 5, 0 as major, minor, on Cygwin it returns with the major and minor
>numbers of the actual tty it refers to:
>
>  $ tty
>  /dev/tty2
>  $ ls -l /dev/tty
>  crw--w---- 1 corinna vinschen 136, 2 Aug 18 21:51 /dev/tty
>
>Same for /dev/console.  Chris, is it tricky to return always the
>real major, minor pairs 5, 0 and 5, 1 for /dev/tty and /dev/console?

I think I mentioned this when /proc/devices was first proposed.  I
changed this when I merged the console and tty handling more closely a
couple of months ago.

It's not impossible to fix.  I'll get around to it eventually.

cgf
