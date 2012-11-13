Return-Path: <cygwin-patches-return-7772-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11085 invoked by alias); 13 Nov 2012 00:03:06 -0000
Received: (qmail 11071 invoked by uid 22791); 13 Nov 2012 00:03:06 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 13 Nov 2012 00:02:58 +0000
Received: from pool-98-110-183-145.bstnma.fios.verizon.net ([98.110.183.145] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1TY3xx-000JWx-N1	for cygwin-patches@cygwin.com; Tue, 13 Nov 2012 00:02:57 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 0FA2313C0C7	for <cygwin-patches@cygwin.com>; Mon, 12 Nov 2012 19:02:57 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+bXVehB73hzF4Kv+G7xoZn
Date: Tue, 13 Nov 2012 00:03:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [WIP] mingw64 related changes to Cygwin configure and other assorted files with departed w32api/mingw
Message-ID: <20121113000257.GA13261@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20121112200223.GA16672@ednor.casa.cgf.cx> <20121112215023.GA1436@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121112215023.GA1436@calimero.vinschen.de>
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
X-SW-Source: 2012-q4/txt/msg00049.txt.bz2

On Mon, Nov 12, 2012 at 10:50:23PM +0100, Corinna Vinschen wrote:
>On Nov 12 15:02, Christopher Faylor wrote:
>> I decided over the weekend to port over configury changes that I made to
>> Cygwin's now-out-of-date GIT repository.
>> 
>> These changes basically just cleaned up some of the configure scripts
>> and made it easier to pinpoint where windows headers and libraries come
>> from by adding a --with-windows-headers and --with-windows-libs options.
>> However, some of the assumptions made for the git repository weren't
>> really valid for the CVS repository so there was a fair amount of work
>> involved.
>> 
>> I thought that I'd do this so I could easily get up-and-running with the
>> MinGW64 stuff but I ran into some problems building things with gentoo's
>> MinGW64 implementation.  So, I switched to using the files from the
>> Cygwin release.
>> 
>> As I mentioned in cygwin-developers, getting the most recent version of
>> mingw64 stuff working required making some changes to some Cygwin source
>> files.  Most of the changes just involved #undef'ing constants defined
>> in Windows headers.  Still, I was surprised that these hadn't already
>> been handled since I thought I was behind the times by still using the
>> Mingw32 stuff.
>> 
>> Anyway, is a summary of the changes I've made to files is below.  I'll
>> be doing appropriate ChangeLogs too, of course.  I've also attached the
>> patch.
>> 
>> This is a heads up in case this conflicted materially with any of the
>> w64 development.
>
>Looks good at first sight.  I see only one place which won't work for 64
>bit, the ccwrap script.  It uses i686-pc-cygwin-gcc/g++ hardcoded, but
>it should use something like ${target_cpu}-pc-cygwin-gcc/g++ to make it
>platform independent.  With a matching change, I can give it a try on
>64 bit tomorrow.

That was really only for my own personal use.  It isn't meant to be used
with CC not in the environment.  That's only for when I was experimenting
with running the script outside of the build.

>I'm a bit puzzled about the necessity of some of the changes to source
>files.  Yaakov's Fedora 17 version of the headers is supposedly cut from
>the mingw64 trunk on 2012-10-16, while JonY's official headers have an
>upload date of 2012-10-18.  They should be practically identical.  Why
>do I not see any problems to build CVS HEAD?!?

You can keep asking me this question but I don't really have an answer.
Since I don't run Fedora, I'm not going to install it to figure it out.

cgf
