Return-Path: <cygwin-patches-return-7425-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 797 invoked by alias); 9 Jul 2011 19:31:45 -0000
Received: (qmail 785 invoked by uid 22791); 9 Jul 2011 19:31:45 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm8.bullet.mail.bf1.yahoo.com (HELO nm8.bullet.mail.bf1.yahoo.com) (98.139.212.167)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Sat, 09 Jul 2011 19:31:31 +0000
Received: from [98.139.212.149] by nm8.bullet.mail.bf1.yahoo.com with NNFMP; 09 Jul 2011 19:31:30 -0000
Received: from [98.139.213.7] by tm6.bullet.mail.bf1.yahoo.com with NNFMP; 09 Jul 2011 19:31:30 -0000
Received: from [127.0.0.1] by smtp107.mail.bf1.yahoo.com with NNFMP; 09 Jul 2011 19:31:30 -0000
Received: from cgf.cx (cgf@108.49.32.184 with login)        by smtp107.mail.bf1.yahoo.com with SMTP; 09 Jul 2011 12:31:30 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 4B1E942804C	for <cygwin-patches@cygwin.com>; Sat,  9 Jul 2011 15:31:30 -0400 (EDT)
Date: Sat, 09 Jul 2011 19:31:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: pthread_sigmask bug
Message-ID: <20110709193121.GB18833@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4E178FD6.5010101@redhat.com> <20110709065855.GB29867@calimero.vinschen.de> <4E185567.2090001@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E185567.2090001@redhat.com>
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
X-SW-Source: 2011-q3/txt/msg00001.txt.bz2

On Sat, Jul 09, 2011 at 07:19:35AM -0600, Eric Blake wrote:
>On 07/09/2011 12:58 AM, Corinna Vinschen wrote:
>> On Jul  8 17:16, Eric Blake wrote:
>>> The current implementation of pthread_sigmask violates POSIX:
>> 
>> PTC?
>
> winsup/cygwin/ChangeLog |    6 ++++++
> winsup/cygwin/signal.cc |   10 ++++++----
> 2 files changed, 12 insertions(+), 4 deletions(-)
>
>2011-07-09  Eric Blake  <eblake@redhat.com>
>
>	* signal.cc (handle_sigprocmask): Return error rather than
>	setting errno, for pthread_sigmask.
>	(sigprocmask): Adjust caller.

Looks good.  Please apply.  Thanks.

cgf
