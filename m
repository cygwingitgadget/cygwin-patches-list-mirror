Return-Path: <cygwin-patches-return-8625-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10190 invoked by alias); 1 Sep 2016 11:06:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 10180 invoked by uid 89); 1 Sep 2016 11:06:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=grasp, Hx-languages-length:1755, 201609, HTo:U*cygwin-patches
X-HELO: smtp.salomon.at
Received: from smtp.salomon.at (HELO smtp.salomon.at) (193.186.16.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 01 Sep 2016 11:05:57 +0000
Received: from samail03.wamas.com ([172.28.33.235] helo=mailhost.salomon.at)	by smtp.salomon.at with esmtps (UNKNOWN:DHE-RSA-AES256-SHA:256)	(Exim 4.80.1)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1bfPoc-0004Pl-4w	for cygwin-patches@cygwin.com; Thu, 01 Sep 2016 13:05:54 +0200
Received: from [172.28.41.34]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1bfPoa-0005uH-9m	for cygwin-patches@cygwin.com; Thu, 01 Sep 2016 13:05:49 +0200
Subject: Re: [PATCH 1/4] dlopen: switch to new pathfinder class
To: cygwin-patches@cygwin.com
References: <1472666829-32223-1-git-send-email-michael.haubenwallner@ssi-schaefer.com> <1472666829-32223-2-git-send-email-michael.haubenwallner@ssi-schaefer.com> <20160831191231.GA649@calimero.vinschen.de>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Message-ID: <09d08bc9-d430-f6e8-8076-e9f9ad992fd9@ssi-schaefer.com>
Date: Thu, 01 Sep 2016 11:06:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20160831191231.GA649@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2016-q3/txt/msg00033.txt.bz2

On 08/31/2016 09:12 PM, Corinna Vinschen wrote:
> Hi Michael,
> 
> On Aug 31 20:07, Michael Haubenwallner wrote:
>> Instead of find_exec, without changing behaviour use new pathfinder
>> class with new allocator_interface around tmp_pathbuf and new vstrlist
>> class.
>> * pathfinder.h (pathfinder): New file.
>> * vstrlist.h (allocator_interface, allocated_type, vstrlist): New file.
>> * dlfcn.cc (dlopen): Avoid redundant GetModuleHandleExW with RTLD_NOLOAD
>> and RTLD_NODELETE.  Switch to new pathfinder class, using
>> (tmp_pathbuf_allocator): New class.
>> (get_full_path_of_dll): Drop.
>> [...]
> 
> Just one nit here:
> 
>> +/* Dumb allocator using memory from tmp_pathbuf.w_get ().
>> +
>> +   Does not reuse free'd memory areas.  Instead, memory
>> +   is released when the tmp_pathbuf goes out of scope.
>> +
>> +   ATTENTION: Requesting memory from an instance of tmp_pathbuf breaks
>> +   when another instance on a newer stack frame has provided memory. */
>> +class tmp_pathbuf_allocator
>> +  : public allocator_interface
> 
> You didn't reply to
> https://cygwin.com/ml/cygwin-developers/2016-08/msg00013.html
> So, again, why didn't you simply integrate a tmp_pathbuf member into the
> pathfinder class, rather than having to create some additional allocator
> class?  I'm probably not the most diligent C++ hacker, but to me this
> additional allocator is a bit confusing.

Sorry, seems I've failed to fully grasp your concerns firsthand in
https://cygwin.com/ml/cygwin-developers/2016-08/msg00016.html
Second try to answer:
https://cygwin.com/ml/cygwin-developers/2016-09/msg00000.html

> The rest of the patch looks good.  I'll look further into the patchset
> later tomorrow.

Thanks!
/haubi/
