Return-Path: <cygwin-patches-return-9514-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 108962 invoked by alias); 23 Jul 2019 18:07:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 108952 invoked by uid 89); 23 Jul 2019 18:07:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: rgout0804.bt.lon5.cpcloud.co.uk
Received: from rgout0804.bt.lon5.cpcloud.co.uk (HELO rgout0804.bt.lon5.cpcloud.co.uk) (65.20.0.151) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 23 Jul 2019 18:07:08 +0000
X-OWM-Source-IP: 86.179.112.104 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
Received: from [192.168.1.102] (86.179.112.104) by rgout08.bt.lon5.cpcloud.co.uk (9.0.019.26-1) (authenticated as jonturney@btinternet.com)        id 5BC47A87199C3E2E for cygwin-patches@cygwin.com; Tue, 23 Jul 2019 19:07:06 +0100
Subject: Re: [PATCH 1/1] Cygwin: don't allow getpgrp() to fail
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20190723161100.1045-1-kbrown@cornell.edu> <20190723161100.1045-2-kbrown@cornell.edu> <20190723165458.GM21169@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <59c6529d-b411-fcf5-fa82-8a681d5b6378@dronecode.org.uk>
Date: Tue, 23 Jul 2019 18:07:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723165458.GM21169@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q3/txt/msg00034.txt.bz2

On 23/07/2019 17:54, Corinna Vinschen wrote:
> Hi Ken,
> 
> On Jul 23 16:12, Ken Brown wrote:
>> According to POSIX, "The getpgrp() function shall always be successful
>> and no return value is reserved to indicate an error."  Cygwin's
>> getpgrp() is defined in terms of getpgid(), which is allowed to fail.
> 
> But it shouldn't fail for the current process.  Why should pinfo::init
> fail for myself if it begins like this?
> 
>    if (myself && n == myself->pid)
>      {
>        procinfo = myself;
>        destroy = 0;
>        return;
>      }
> 
> I fear this patch would only cover up the problem still persisting
> under the hood.

I agree.

There is presumably a class of programs which require getpgrp() to 
return the correct value for correct operation, which cannot be 0 (since 
that cannot be a pid).
