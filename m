Return-Path: <cygwin-patches-return-8192-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 110612 invoked by alias); 17 Jun 2015 20:25:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 110592 invoked by uid 89); 17 Jun 2015 20:25:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.4 required=5.0 tests=AWL,BAYES_20,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD autolearn=no version=3.3.2
X-HELO: mailout03.t-online.de
Received: from mailout03.t-online.de (HELO mailout03.t-online.de) (194.25.134.81) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Wed, 17 Jun 2015 20:25:54 +0000
Received: from fwd34.aul.t-online.de (fwd34.aul.t-online.de [172.20.26.145])	by mailout03.t-online.de (Postfix) with SMTP id 5A30936C51D	for <cygwin-patches@cygwin.com>; Wed, 17 Jun 2015 22:25:51 +0200 (CEST)
Received: from [192.168.2.103] (rAHTYrZEYhPatCB20pAbrtrIh-053epHwfj9AObP9gmPOtgGLnYuYF8MVV5Fa69grj@[84.180.90.102]) by fwd34.t-online.de	with (TLSv1.2:ECDHE-RSA-AES256-SHA encrypted)	esmtp id 1Z5Ju1-0MXBUu0; Wed, 17 Jun 2015 22:25:41 +0200
Message-ID: <5581D7C4.1000207@t-online.de>
Date: Wed, 17 Jun 2015 20:25:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:36.0) Gecko/20100101 Firefox/36.0 SeaMonkey/2.33.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Hide sethostname() in unistd.h
References: <55804E7D.3060504@t-online.de> <20150616174551.GF31537@calimero.vinschen.de> <558107F2.3030809@t-online.de> <20150617084626.GI31537@calimero.vinschen.de>
In-Reply-To: <20150617084626.GI31537@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2015-q2/txt/msg00093.txt.bz2

Corinna Vinschen wrote:
> On Jun 17 07:38, Christian Franke wrote:
>> Corinna Vinschen wrote:
>>> On Jun 16 18:27, Christian Franke wrote:
>>>> Found during an experimental build of busybox:
>>>>
>>>> The sethostname() prototype in /usr/include/sys/unistd.h is enabled also on
>>>> Cygwin.
>>>> It should be disabled because Cygwin does not provide this function.
>>>>
>>>> Christian
>>>>
>>> What about implementing sethostname instead?
>>>
>>>    extern "C" int
>>>    sethostname (const char *name, size_t len)
>>> ...
>> I didn't consider this as an alternative because I guessed that it is
>> intentional that sethostname is missing.
>> (it is not a typical that someone wants to use Cygwin to change the name of
>> a Windows machine)
> You're right there.  But, we have a lot of interfaces defined in newlib
> headers which are not available on all platforms, but we're not
> explicitely filtering them per platform.

I see. Then let's forget the patch.


> Afaics, the problem is the configuration of busybox, not unistd.h.
> Checking for prototypes in headers is not sufficient to check for the
> availablility of functions, only for the availability of the prototype.
> The configuration should also try a link check on the function with
> AC_CHECK_FUNC or something like that.

Busybox does not use autoconf or similar. It requires manual platform 
specific configuration which does not yet support a missing 
sethostname(). After adding HAVE_SETHOSTNAME manually and some other 
minor additions, busybox (which many commands enabled) compiles and 
works reasonably.
Would ITP make sense ?

Christian
