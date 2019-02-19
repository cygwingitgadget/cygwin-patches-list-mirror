Return-Path: <cygwin-patches-return-9200-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2294 invoked by alias); 19 Feb 2019 17:14:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 2266 invoked by uid 89); 19 Feb 2019 17:14:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_PASS autolearn=no version=3.3.2 spammy=principal, Hx-languages-length:2655, displaying, privileges
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 19 Feb 2019 17:14:47 +0000
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 273DE806A7	for <cygwin-patches@cygwin.com>; Tue, 19 Feb 2019 17:14:46 +0000 (UTC)
Received: from [10.3.116.222] (ovpn-116-222.phx2.redhat.com [10.3.116.222])	by smtp.corp.redhat.com (Postfix) with ESMTPS id E8E7319C68	for <cygwin-patches@cygwin.com>; Tue, 19 Feb 2019 17:14:45 +0000 (UTC)
Subject: Re: [PATCH] Cygwin: add secure_getenv
To: cygwin-patches@cygwin.com
References: <20190219050950.19116-1-yselkowi@redhat.com> <20190219114330.GK4256@calimero.vinschen.de> <20190219115910.GM4256@calimero.vinschen.de> <a31c3d43c9866900e7938015e2fed2c93712348e.camel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b434e09b-94a5-c7af-db2f-3a9d2dfe991f@redhat.com>
Date: Tue, 19 Feb 2019 17:14:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <a31c3d43c9866900e7938015e2fed2c93712348e.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00010.txt.bz2

On 2/19/19 10:58 AM, Yaakov Selkowitz wrote:

>>> "Secure execution is required if one of the following conditions was
>>>  true when the program run by the calling process was loaded: [...]"
>>>
>>> Do we ever have this situation?  We don't have any capability to make
>>> real and effective user ID different at process startup.  But from that
>>> description it seems secure_getenv does not trigger secure mode if the
>>> process calls seteuid() or setreuid() later in the process.

It says it may also be triggered by some Linux security modules (for
which I'll assume that can include states that were not present at
startup).  The main reason it was invented was to ensure that a setgid
application CANNOT be negatively impacted by LD_PRELOAD and friends
prior to main(), because all of the startup code in the dynamic loader
was switched to use secure_getenv() for any place where the loader can
normally be influenced by the environment.  But the wording sounds vague
enough about what other situations may be considered as security that it
is easy enough to just state that you should always be prepared for a
NULL return when using the function.

That said, while it is ideal to avoid squashing to NULL in situations
that are not security boundaries (as with your STC displaying HOME even
after seteuid() on Linux), I'm also okay if we filter too aggressively
(the way gnulib's fallback implementation does when neither
__secure_getenv() nor issetugid() available).


>> So I wonder if secure_getenv isn't just a synonym for getenv
>> in our case.
> 
> Or could it be the STC?  glibc's test is a bit more complicated:
> 
> https://sourceware.org/git/?p=glibc.git;a=blob;f=stdlib/tst-secure-getenv.c;hb=HEAD
> 
> And, looking now, FWIW gnulib's implementation is practically similar:
> 
> https://git.savannah.gnu.org/gitweb/?p=gnulib.git;a=blob;f=lib/secure_getenv.c;hb=HEAD

Gnulib argued that for native windows, being a synonym for getenv() is
okay because you have to opt in to running as administrator, and that
there is no native setuid/setgid binaries where you can otherwise gain
privileges by influencing the environment presented to a binary.  Of
course, if Cygwin is able to emulate setgid binaries where native
Windows can't, then we need secure_getenv() to reflect that emulation.

> 
> So if there is something wrong with the patch, then AFAIK gnulib is
> wrong too.  Eric?

The patch may be overly strict (returning NULL where it doesn't have
to), but that does not make it wrong in my eyes.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
