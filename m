Return-Path: <cygwin-patches-return-8181-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 121736 invoked by alias); 17 Jun 2015 05:39:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 121723 invoked by uid 89); 17 Jun 2015 05:39:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.4 required=5.0 tests=AWL,BAYES_20,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD autolearn=no version=3.3.2
X-HELO: mailout01.t-online.de
Received: from mailout01.t-online.de (HELO mailout01.t-online.de) (194.25.134.80) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Wed, 17 Jun 2015 05:39:18 +0000
Received: from fwd06.aul.t-online.de (fwd06.aul.t-online.de [172.20.26.150])	by mailout01.t-online.de (Postfix) with SMTP id A4F9B2BB18E	for <cygwin-patches@cygwin.com>; Wed, 17 Jun 2015 07:39:14 +0200 (CEST)
Received: from [192.168.2.103] (rx6MngZfohcl8YP62ZNrgBKkZUxSjhBjFBsNiP88hx5kxjTBSALLjagoRtTT-zFgE+@[84.180.90.102]) by fwd06.t-online.de	with (TLSv1.2:ECDHE-RSA-AES256-SHA encrypted)	esmtp id 1Z563z-3z7k4O0; Wed, 17 Jun 2015 07:39:03 +0200
Message-ID: <558107F2.3030809@t-online.de>
Date: Wed, 17 Jun 2015 05:39:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:36.0) Gecko/20100101 Firefox/36.0 SeaMonkey/2.33.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Hide sethostname() in unistd.h
References: <55804E7D.3060504@t-online.de> <20150616174551.GF31537@calimero.vinschen.de>
In-Reply-To: <20150616174551.GF31537@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2015-q2/txt/msg00082.txt.bz2

Corinna Vinschen wrote:
> On Jun 16 18:27, Christian Franke wrote:
>> Found during an experimental build of busybox:
>>
>> The sethostname() prototype in /usr/include/sys/unistd.h is enabled also on
>> Cygwin.
>> It should be disabled because Cygwin does not provide this function.
>>
>> Christian
>>
>
> What about implementing sethostname instead?
>
>    extern "C" int
>    sethostname (const char *name, size_t len)
> ...

I didn't consider this as an alternative because I guessed that it is 
intentional that sethostname is missing.
(it is not a typical that someone wants to use Cygwin to change the name 
of a Windows machine)

Christian
