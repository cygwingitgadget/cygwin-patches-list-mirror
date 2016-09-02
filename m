Return-Path: <cygwin-patches-return-8635-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 128041 invoked by alias); 2 Sep 2016 11:36:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 128021 invoked by uid 89); 2 Sep 2016 11:36:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=201609, HTo:U*cygwin-patches
X-HELO: smtp.salomon.at
Received: from smtp.salomon.at (HELO smtp.salomon.at) (193.186.16.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 02 Sep 2016 11:36:22 +0000
Received: from samail03.wamas.com ([172.28.33.235] helo=mailhost.salomon.at)	by smtp.salomon.at with esmtps (UNKNOWN:DHE-RSA-AES256-SHA:256)	(Exim 4.80.1)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1bfmlc-0002xd-BM	for cygwin-patches@cygwin.com; Fri, 02 Sep 2016 13:36:18 +0200
Received: from s01en24.wamas.com ([172.28.41.34])	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1bfmlc-00054L-3H	for cygwin-patches@cygwin.com; Fri, 02 Sep 2016 13:36:16 +0200
Subject: Re: [PATCH 1/4] dlopen: switch to new pathfinder class
To: cygwin-patches@cygwin.com
References: <1472666829-32223-1-git-send-email-michael.haubenwallner@ssi-schaefer.com> <1472666829-32223-2-git-send-email-michael.haubenwallner@ssi-schaefer.com> <20160831191231.GA649@calimero.vinschen.de> <09d08bc9-d430-f6e8-8076-e9f9ad992fd9@ssi-schaefer.com> <20160901140327.GD1128@calimero.vinschen.de> <3cd7bff6-2e56-addd-d9ca-88e203dfb337@ssi-schaefer.com> <20160902085213.GA7709@calimero.vinschen.de>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Message-ID: <bd3e33f0-de36-a65c-2e28-ff8bfdbf2d22@ssi-schaefer.com>
Date: Fri, 02 Sep 2016 11:36:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20160902085213.GA7709@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2016-q3/txt/msg00043.txt.bz2

On 09/02/2016 10:52 AM, Corinna Vinschen wrote:
> On Sep  2 10:05, Michael Haubenwallner wrote:
>> On 09/01/2016 04:03 PM, Corinna Vinschen wrote:
>>> On Sep  1 13:05, Michael Haubenwallner wrote:
>>>> On 08/31/2016 09:12 PM, Corinna Vinschen wrote:
>>>>> On Aug 31 20:07, Michael Haubenwallner wrote:
>>>>>> Instead of find_exec, without changing behaviour use new pathfinder
>>>>>> class with new allocator_interface around tmp_pathbuf and new vstrlist
>>>>>> class.
>>>>>> * pathfinder.h (pathfinder): New file.
>>>>>> * vstrlist.h (allocator_interface, allocated_type, vstrlist): New file.
>>>>>> * dlfcn.cc (dlopen): Avoid redundant GetModuleHandleExW with RTLD_NOLOAD
>>>>>> and RTLD_NODELETE.  Switch to new pathfinder class, using
>>>>>> (tmp_pathbuf_allocator): New class.
>>>>>> (get_full_path_of_dll): Drop.
>>>>>> [...]
>>>>>
>>>>> Just one nit here:
>>>>>
>>>>>> +/* Dumb allocator using memory from tmp_pathbuf.w_get ().
>>>>>> +
>>>>>> +   Does not reuse free'd memory areas.  Instead, memory
>>>>>> +   is released when the tmp_pathbuf goes out of scope.
>>>>>> +
>>>>>> +   ATTENTION: Requesting memory from an instance of tmp_pathbuf breaks
>>>>>> +   when another instance on a newer stack frame has provided memory. */
>>>>>> +class tmp_pathbuf_allocator
>>>>>> +  : public allocator_interface
>>>>>
>>>>> You didn't reply to
>>>>> https://cygwin.com/ml/cygwin-developers/2016-08/msg00013.html
>>>>> So, again, why didn't you simply integrate a tmp_pathbuf member into the
>>>>> pathfinder class, rather than having to create some additional allocator
>>>>> class?  I'm probably not the most diligent C++ hacker, but to me this
>>>>> additional allocator is a bit confusing.
>>>>
>>>> Sorry, seems I've failed to fully grasp your concerns firsthand in
>>>> https://cygwin.com/ml/cygwin-developers/2016-08/msg00016.html
>>>> Second try to answer:
>>>> https://cygwin.com/ml/cygwin-developers/2016-09/msg00000.html
>>>
>>> Ok, I see what you mean, but it doesn't make me really happy.
>>>
>>> I'm willing to take it for now but I'd rather see basenames being a
>>> member of pathfinder right from the start, so you just instantiate
>>> finder and call methods on it.
>>
>> The idea to build the basenames list before constructing pathfinder
>> is that members of the searchdirs list reserve space for the maxlen
>> of basenames:  This implies that the basenames list must not change
>> after the first searchdir was registered.
>>
>> To make sure this doesn't happen I prefer to not provide such an API
>> at all, rather than to check within some pathfinder::add_basename ()
>> method and abort if there is some searchdir registered already.
> 
> Yes, that sounds good.
> 
>>> Given that basenames is a member,
>>> you can do the allocator stuff completely inside the pathfinder class.
>>
>> Moving the allocator into pathfinder would work then, but still the
>> tmp_pathbuf instance to use has to be provided as reference.
> 
> Hmm, considering that a function calling your pathfinder *might*
> need a tmp_pathbuf for its own dubious purposes, this makes sense.
> That could be easily handled via the constructor I think:
> 
>   tmp_pathbuf tp;
>   pathfinder finder (tp);
> 
> Still, since I said I'm willing to take this code as is, do you want me
> to apply it this way for now or do you want to come up with the proposed
> changes first?

As I do prefer both pathfinder and vstrlist to not know about tmp_pathbuf
in particular but a generic memory provider only: Yes, please apply as is.

Thanks a lot!
/haubi/
