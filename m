Return-Path: <cygwin-patches-return-8638-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 37915 invoked by alias); 9 Sep 2016 08:19:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 37900 invoked by uid 89); 9 Sep 2016 08:19:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=H*r:4.77, HX-Envelope-From:sk:michael, HTo:U*cygwin-patches
X-HELO: smtp.salomon.at
Received: from smtp.salomon.at (HELO smtp.salomon.at) (193.186.16.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 09 Sep 2016 08:19:17 +0000
Received: from samail03.wamas.com ([172.28.33.235] helo=mailhost.salomon.at)	by smtp.salomon.at with esmtps (UNKNOWN:DHE-RSA-AES256-SHA:256)	(Exim 4.80.1)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1biH1l-0008Vo-HM	for cygwin-patches@cygwin.com; Fri, 09 Sep 2016 10:19:13 +0200
Received: from s01en24.wamas.com ([172.28.41.34])	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1biH1l-0004Jp-C9	for cygwin-patches@cygwin.com; Fri, 09 Sep 2016 10:19:13 +0200
Subject: Re: [PATCH 1/4] dlopen: switch to new pathfinder class
To: cygwin-patches@cygwin.com
References: <1472666829-32223-1-git-send-email-michael.haubenwallner@ssi-schaefer.com> <1472666829-32223-2-git-send-email-michael.haubenwallner@ssi-schaefer.com> <20160831191231.GA649@calimero.vinschen.de> <09d08bc9-d430-f6e8-8076-e9f9ad992fd9@ssi-schaefer.com> <20160901140327.GD1128@calimero.vinschen.de> <3cd7bff6-2e56-addd-d9ca-88e203dfb337@ssi-schaefer.com> <20160902085213.GA7709@calimero.vinschen.de> <bd3e33f0-de36-a65c-2e28-ff8bfdbf2d22@ssi-schaefer.com> <20160908115857.GA8359@calimero.vinschen.de>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Message-ID: <904e027a-f657-29c7-18bf-4695543798c8@ssi-schaefer.com>
Date: Fri, 09 Sep 2016 08:19:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20160908115857.GA8359@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2016-q3/txt/msg00046.txt.bz2

On 09/08/2016 01:58 PM, Corinna Vinschen wrote:
> On Sep  2 13:36, Michael Haubenwallner wrote:
>> On 09/02/2016 10:52 AM, Corinna Vinschen wrote:
>>> On Sep  2 10:05, Michael Haubenwallner wrote:
>>>> Moving the allocator into pathfinder would work then, but still the
>>>> tmp_pathbuf instance to use has to be provided as reference.
>>>
>>> Hmm, considering that a function calling your pathfinder *might*
>>> need a tmp_pathbuf for its own dubious purposes, this makes sense.
>>> That could be easily handled via the constructor I think:
>>>
>>>   tmp_pathbuf tp;
>>>   pathfinder finder (tp);
>>>
>>> Still, since I said I'm willing to take this code as is, do you want me
>>> to apply it this way for now or do you want to come up with the proposed
>>> changes first?
>>
>> As I do prefer both pathfinder and vstrlist to not know about tmp_pathbuf
>> in particular but a generic memory provider only: Yes, please apply as is.
> 
> Done, minus patch 4.

Then my original problem with dlopen isn't fixed yet, where some application
code within /opt/app/bin/app.exe does dlopen(libAPP.dll), currently finding
/usr/bin/libAPP.dll although app.exe linked against /opt/app/bin/libAPP.dll.

However, thank you anyway!

> I still think that there should be only a single
> pathfinder object and the rest encapsulated within and called via some
> pathfinder member function.  I'll look into it later this year.

A thought to avoid the extra tmp_pathbuf_allocator class:
Have cygmalloc.h (or similar) declare the allocator interface,
to allow for tmp_pathbuf to implement it by itself.

The complete idea is to have another allocator implementation using
cmalloc+cfree, as well as one more using malloc+free. Probably there
is use for another one using VirtualAlloc+VirtualFree as well.

Then even path_conv might utilize the allocator interface, using the
cmalloc+cfree implementation (provided by cygmalloc.h) by default...

/haubi/
