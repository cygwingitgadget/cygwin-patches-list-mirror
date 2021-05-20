Return-Path: <Christian.Franke@t-online.de>
Received: from mailout04.t-online.de (mailout04.t-online.de [194.25.134.18])
 by sourceware.org (Postfix) with ESMTPS id C49B0385740E
 for <cygwin-patches@cygwin.com>; Thu, 20 May 2021 19:48:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C49B0385740E
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=Christian.Franke@t-online.de
Received: from fwd04.aul.t-online.de (fwd04.aul.t-online.de [172.20.26.149])
 by mailout04.t-online.de (Postfix) with SMTP id 921EC5F662
 for <cygwin-patches@cygwin.com>; Thu, 20 May 2021 21:48:42 +0200 (CEST)
Received: from [192.168.2.105]
 (Tt2uWrZ1ohwwtH7aHsGLdvqRNl6-gAsGKgkBUPZiDywNhOI7GHN5cwQfYKvyZMNQGO@[79.230.169.184])
 by fwd04.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1ljoev-0SJDAu0; Thu, 20 May 2021 21:48:41 +0200
Subject: Re: [PATCH] Cygwin: utils: chattr: Improve option parsing.
To: cygwin-patches@cygwin.com
References: <d515bfba-ce77-40c0-0c3e-67895675f753@t-online.de>
 <YKVPOaBrb0a9lV54@calimero.vinschen.de>
 <e78257d8-bd2a-3ea0-0cea-48114ec017a0@t-online.de>
 <YKajIZm3F4OpX5sx@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <f4bff7ef-17c1-357e-0630-0d7d587e467f@t-online.de>
Date: Thu, 20 May 2021 21:48:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 SeaMonkey/2.53.6
MIME-Version: 1.0
In-Reply-To: <YKajIZm3F4OpX5sx@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ID: Tt2uWrZ1ohwwtH7aHsGLdvqRNl6-gAsGKgkBUPZiDywNhOI7GHN5cwQfYKvyZMNQGO
X-TOI-EXPURGATEID: 150726::1621540121-00007E51-0DB23F1B/0/0 CLEAN NORMAL
X-TOI-MSGID: 1027ae0f-013e-4e47-99cf-947dfc0d2433
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00, BODY_8BITS,
 FREEMAIL_FROM, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 20 May 2021 19:48:46 -0000

Hi Corinna,

Corinna Vinschen wrote:
> Hi Christian,
>
> On May 20 12:01, Christian Franke wrote:
>> Corinna Vinschen wrote:
>>> On May 19 17:46, Christian Franke wrote:
>>>> ...
>>>> $ egrep 'ACL|--r' chattr.c
>>>>             "Get POSIX ACL information\n"
>>>>         "  -R, --recursive     recursively list attributes of directories and
>>>> their \n"
>>> Oops.  Please patch while you're at it...
>>> ...
>>>>   From 865a5a50501f3fd0cf5ed28500d3e6e45a6456de Mon Sep 17 00:00:00 2001
>>>> From: Christian Franke<...>
>>>> Date: Wed, 19 May 2021 16:24:47 +0200
>>>> Subject: [PATCH] Cygwin: utils: chattr: Improve option parsing.
>>>>
>>>> Interpret '-h' as '--help' only if last argument.
>>> Who was the idiot using -h for help *and* the hidden flag? *blush*
>>>
>>> I'd vote for --help to be changed to -H for the single character
>>> option.  The help output is very unlikely to be used in scripts,
>>> so that shouldn't be a backward compat problem.
>> New patch attached.
>>
>> Note that there is now the possibly unexpected (& hidden) behavior that
>> 'chattr -h' without file argument clears the hidden attribute of cwd.
> Uhm... why?

Because chattr uses '.' as default if no FILE argument is specified. The 
same applies to all other '+-=MODE' arguments. The patch does not change 
this behavior but of course enables it for '-h'.


>    Isn't that easily avoidable?

Yes: make FILE argument mandatory - but this would break backward 
compatibility.

Another behavior (possibly inherited from lsattr) is also not very useful:
'chattr +-=MODE DIRECTORY' also changes the attributes of all elements 
in the directory (not recursively). It is not possible to solely change 
the attributes of a directory except if it is the current directory and 
no FILE argument is passed. Fixing this would again break backward 
compatibility.

Regards,
Christian

