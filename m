Return-Path: <cygwin-patches-return-7727-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4274 invoked by alias); 17 Oct 2012 19:33:03 -0000
Received: (qmail 4263 invoked by uid 22791); 17 Oct 2012 19:33:03 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-04-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.74)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 17 Oct 2012 19:32:59 +0000
Received: from pool-173-76-44-35.bstnma.fios.verizon.net ([173.76.44.35] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1TOZMQ-000P56-Te	for cygwin-patches@cygwin.com; Wed, 17 Oct 2012 19:32:58 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 47D7413C005	for <cygwin-patches@cygwin.com>; Wed, 17 Oct 2012 15:32:58 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19osuTJ0XfjIlecGL5xf+QE
Date: Wed, 17 Oct 2012 19:33:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
Message-ID: <20121017193258.GA15271@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAEwic4ZBrjVPDV1Y3tc6r7baGzxNbrjgj1MUgse6zYSMHiCUhQ@mail.gmail.com> <20121017164440.GA12989@ednor.casa.cgf.cx> <20121017170514.GD10578@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121017170514.GD10578@calimero.vinschen.de>
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
X-SW-Source: 2012-q4/txt/msg00004.txt.bz2

On Wed, Oct 17, 2012 at 07:05:14PM +0200, Corinna Vinschen wrote:
>On Oct 17 12:44, Christopher Faylor wrote:
>> >Index: winsup/Makefile.common
>> >===================================================================
>> >RCS file: /cvs/src/src/winsup/Makefile.common,v
>> >retrieving revision 1.59
>> >diff -p -u -3 -r1.59 Makefile.common
>> >--- winsup/Makefile.common	30 Jul 2012 04:43:21 -0000	1.59
>> >+++ winsup/Makefile.common	17 Oct 2012 15:21:32 -0000
>> 
>> Can we just get rid of this as well?  That's what I did in my now-unneeded
>> revamp of the configury in the cygwin git repository.
>> 
>> I think I'd rather just move everything into winsup, cygserver, utils and
>> not bother with this "common" stuff.
>
>But it's still a nice way to have certain definitions only once.
>The BSD build systems use something similar.

The BSD build system has multiple common include makefiles.  I use it
every day.  You have to look in multiple different places to find
makefile settings.  Although it obviously works, and I've gotten used to
it in the last several years, I find it mildly frustrating to work with
when you need to control how something is built because it isn't always
clear where settings are coming from.

When I created Makefile.common I thought I was doing a good thing just
so that you could have certain definitions more than once however, these
days, I think it makes more sense to use a common configure
infrastructure which produces similar Makefiles.  I've been bitten more
than once by making changes to winsup/Makefile and finding that it
doesn't do what I expected thanks to Makefile.common.

But, anyway, nevermind.  This shouldn't be a requirement for getting
these changes checked in.  I'm more concerned with just nuking the
now-unneeded mingw script.

cgf
