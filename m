Return-Path: <cygwin-patches-return-8198-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23290 invoked by alias); 19 Jun 2015 05:28:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 23274 invoked by uid 89); 19 Jun 2015 05:28:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.2 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD autolearn=no version=3.3.2
X-HELO: mailout09.t-online.de
Received: from mailout09.t-online.de (HELO mailout09.t-online.de) (194.25.134.84) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 19 Jun 2015 05:28:06 +0000
Received: from fwd09.aul.t-online.de (fwd09.aul.t-online.de [172.20.27.151])	by mailout09.t-online.de (Postfix) with SMTP id 0B30955D725	for <cygwin-patches@cygwin.com>; Fri, 19 Jun 2015 07:28:03 +0200 (CEST)
Received: from [192.168.2.103] (GW9wpMZdYh4-mkQK0ilCRN6HdJ6bl7KyhvGObw6J9HNCSRdXGns8Go3Quo53dI3woR@[84.180.90.102]) by fwd09.t-online.de	with (TLSv1.2:ECDHE-RSA-AES256-SHA encrypted)	esmtp id 1Z5oqP-3lElwO0; Fri, 19 Jun 2015 07:28:01 +0200
Message-ID: <5583A85E.5010907@t-online.de>
Date: Fri, 19 Jun 2015 05:28:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:36.0) Gecko/20100101 Firefox/36.0 SeaMonkey/2.33.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Hide sethostname() in unistd.h
References: <55804E7D.3060504@t-online.de> <20150616174551.GF31537@calimero.vinschen.de> <558107F2.3030809@t-online.de> <20150617084626.GI31537@calimero.vinschen.de> <5581D7C4.1000207@t-online.de> <1434574654.11212.4.camel@cygwin.com> <5581E384.9030608@redhat.com> <20150618082638.GQ31537@calimero.vinschen.de>
In-Reply-To: <20150618082638.GQ31537@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2015-q2/txt/msg00099.txt.bz2

Corinna Vinschen wrote:
> On Jun 17 15:15, Eric Blake wrote:
>> On 06/17/2015 02:57 PM, Yaakov Selkowitz wrote:
>>> On Wed, 2015-06-17 at 22:25 +0200, Christian Franke wrote:
>>>> Busybox does not use autoconf or similar. It requires manual platform
>>>> specific configuration which does not yet support a missing
>>>> sethostname(). After adding HAVE_SETHOSTNAME manually and some other
>>>> minor additions, busybox (which many commands enabled) compiles and
>>>> works reasonably.
>>>> Would ITP make sense ?
>>> TBH I'm not sure.  Presuming you're discussing the single-executable
>>> build (so as not to clobber coreutils etc.), there is still the question
>>> of (not) matching the heavily-patched coreutils wrt .exe handling etc.
>>> What do you think the use case would be?
>> Portability testing is one thing - I often compare how
>> bash/dash/zsh/mksh handle a shell construct, and adding busybox sh into
>> the mix adds another perspective.  But yeah, I don't see busybox
>> becoming the default source of these apps, so much as an alternative
>> implementation.
> If it's called "busybox" and the package doesn't try to create shortcuts
> /bin/sh -> /bin/busybox, etc, I don't see a problem to ITP it.

Symlinks in standard places should not be created, of course.
The shell and other commands could still be started by: busybox COMMAND ..."

> If those symlinks are required for busybox to work, they should be
> encapsulated in their own subdir, something like /usr/libexec/busybox
> or so.  Users just need to set $PATH correctly then.  Or maybe that
> could be done by busybox as well.
Yes: busybox --install -s /some/where

Busybox may occasionally be useful because it provides lightweight 
versions of various commands (including daemons) not part of the Cygwin 
base installation and a few commands not available in any package.

It could also be used to build a minimalistic Cygwin (busybox.exe, 
mintty.exe, cygwin1.dll). If build with standalone option enabled, 
symlinks are not needed then.

Christian
