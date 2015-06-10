Return-Path: <cygwin-patches-return-8151-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 121414 invoked by alias); 10 Jun 2015 18:47:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 121401 invoked by uid 89); 10 Jun 2015 18:47:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.4 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2
X-HELO: out4-smtp.messagingengine.com
Received: from out4-smtp.messagingengine.com (HELO out4-smtp.messagingengine.com) (66.111.4.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Wed, 10 Jun 2015 18:47:13 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])	by mailout.nyi.internal (Postfix) with ESMTP id 376BA21002	for <cygwin-patches@cygwin.com>; Wed, 10 Jun 2015 14:47:11 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])  by compute5.internal (MEProxy); Wed, 10 Jun 2015 14:47:11 -0400
Received: from [192.168.1.102] (unknown [86.141.128.210])	by mail.messagingengine.com (Postfix) with ESMTPA id CCD5A6800EF	for <cygwin-patches@cygwin.com>; Wed, 10 Jun 2015 14:47:10 -0400 (EDT)
Message-ID: <5578862D.3060403@dronecode.org.uk>
Date: Wed, 10 Jun 2015 18:47:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Improve strace to log most Windows debug events
References: <1433937922-16492-1-git-send-email-jon.turney@dronecode.org.uk> <20150610141120.GG31537@calimero.vinschen.de> <20150610141827.GH31537@calimero.vinschen.de> <20150610154400.GI31537@calimero.vinschen.de> <20150610172329.GJ31537@calimero.vinschen.de>
In-Reply-To: <20150610172329.GJ31537@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2015-q2/txt/msg00052.txt.bz2

On 10/06/2015 18:23, Corinna Vinschen wrote:
> On Jun 10 17:44, Corinna Vinschen wrote:
>> On Jun 10 16:18, Corinna Vinschen wrote:
>>> On Jun 10 16:11, Corinna Vinschen wrote:
>>>> Hi Jon,
>>>>
>>>> On Jun 10 13:05, Jon TURNEY wrote:
>>>>> Not sure if this is wanted, but on a couple of occasions recently I have been
>>>>> presented with strace output which contains an exception at an address in an
>>>>> unknown module (i.e. not in the cygwin DLL or the main executable), so here is a
>>>>> patch which adds some more information, including DLL load addresses, to help
>>>>> interpret such straces.
>>>>
>>>> That's a nice addition.  Two points, though:
>>>>
>>>> - Do we *always* want that output or do we want a way to switch it on
>>>>    and off?  If the latter, we can simply add another _STRACE_foo option
>>>>    for it.

I'm not sure it makes much sense to use a _STRACE_foo flag, since those 
form a mask applied to a set of flags emitted by the cygwin DLL.

I added a command line option to turn this additional logging off.

>>>>
>>>> - The GetFileNameFromHandle function could be much simpler.  Rather than
>>>>    opening a mapping object for ev.u.LoadDll.hFile, just use the existing
>>>>    mapping object from ev.u.LoadDll.lpBaseOfDll.
>>>
>>>      ...with the process handle taken from get_child(ev.dwProcessId).
>>
>> And since I'm generally fuzzy and unclear in my first reply:
>>
>> Of course, ev.u.LoadDll.lpBaseOfDll is not the mapping *object*, but the
>> mapping *address*.  So you neither have to call CreateFileMapping nor
>> MapViewOfFile.  Just call GetMappedFileNameW (get_child (ev.dwProcessId),
>> ev.u.LoadDll.lpBaseOfDll, ...)
>
> This works for me resulting in Win32 pathnames.  These are only the
> affected diff hunks, I omited the rest.  Does that work for you?
>
> Btw., I don't like using MAX_PATH as maximum path length, but I think
> DLL paths can't be longer anyway, so that should be ok...
>
>
> diff --git a/winsup/utils/strace.cc b/winsup/utils/strace.cc
> index 73096ab..0661e17 100644
> --- a/winsup/utils/strace.cc
> +++ b/winsup/utils/strace.cc

Yes, that seems to work.
