Return-Path: <cygwin-patches-return-9299-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 130369 invoked by alias); 3 Apr 2019 10:38:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 130350 invoked by uid 89); 3 Apr 2019 10:38:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=setupexe, UD:setup.exe, setup.exe, dash
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 03 Apr 2019 10:38:41 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 12:38:39 +0200
Received: from [172.28.53.54]	by mailhost.salomon.at with esmtps (UNKNOWN:AES128-SHA:128)	(Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hBdHy-0004ce-IC; Wed, 03 Apr 2019 12:38:38 +0200
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com> <20190326182538.GA4096@calimero.vinschen.de> <20190326182824.GB4096@calimero.vinschen.de> <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com> <87y350ytpb.fsf@Rainer.invalid> <9c38ac1d-4dea-12d4-a63b-6e8ec59b3ae8@ssi-schaefer.com> <0f0d7cd6-e770-fc32-f28f-817b700e4d87@SystematicSw.ab.ca> <f5ab5a82-8d26-4898-7ea4-ecef5c377299@ssi-schaefer.com> <abf543bb-e8df-9eeb-5ae8-63e5d59cca9a@SystematicSw.ab.ca> <87sgv65eyc.fsf@Rainer.invalid> <5fa27e1c-a790-f03d-b4b3-1985f26df128@SystematicSw.ab.ca> <87pnq9jupk.fsf@Rainer.invalid> <a83dedc6-ea5b-5fc9-4bbc-f06a9cf19472@SystematicSw.ab.ca> <878sww93g9.fsf@Rainer.invalid> <97aec921-d9b1-3b0e-de7a-d492832ba481@SystematicSw.ab.ca>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Message-ID: <236d3269-1b0b-9da0-9816-ed84e489f73e@ssi-schaefer.com>
Date: Wed, 03 Apr 2019 10:38:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <97aec921-d9b1-3b0e-de7a-d492832ba481@SystematicSw.ab.ca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q2/txt/msg00006.txt.bz2

Hi Brian, hi Achim,

Thanks a lot for your input!

On 3/30/19 5:09 PM, Brian Inglis wrote:
> On 2019-03-30 02:22, Achim Gratz wrote:
>> Brian Inglis writes:
>>> On 2019-03-29 14:23, Achim Gratz wrote:
>>>> Brian Inglis writes:
>>>>>> If you are packaging your own exes and dlls with your own local Cygwin distro,
>>>>>> you should point to your local utility directory with a path in a file under
>>>>>> /var/lib/rebase/user.d/$USER for each Cygwin userid on each system, or perhaps
>>>>>> you might also need to add your own production exes and dlls into
>>>>>> /var/cache/rebase/rebase_user and /var/cache/rebase/rebase_user_exe: see
>>>>>> /usr/share/doc/Cygwin/_autorebase.README.
>>>
>>> I was wondering as my first para above stated, whether rebase_user{,_exe} would
>>> be the proper place to add 3rd party Cygwin dlls and exes, that are distributed
>>> with Cygwin (internally)?
>>
>> Well, if you are distributing something (even just locally), then
>> preferrably you make proper Cygwin packages and you will never have to
>> deal with rebase yourself.
>>
>> The options you allude to above are meant for cases where that just
>> isn't possible and so you install things without using setup and often
>> also outside the Cygwin install (permanently, not temporarily until it
>> gets packaged).  You still need to run setup after each change so
>> autorebase can pick up on it.
> 
> Thanks Achim,
> 
> I think that those are possibly the answers the OP Michael was looking for,
> depending on how they are using Gentoo Prefix: it did not seem like they were
> installing their dlls and exes using Cygwin setup, but they could still run
> autorebase under dash.

Beyond being portable across many operating systems (*nix, MacOS, Cygwin, ...),
one of the main goals for Gentoo Prefix is to provide it's packaging mechanism
without the need for any privilege elevation on the underlying operating system,
nor coping with the various underlying operating system's packaging mechanisms.

On a side note:
To get it working as intended on Cygwin, I had to extend Cygwin fork() to allow
for updating dlls and executables while the process is running, as the Gentoo
Prefix package manager is a Cygwin program by itself - unlike Cygwin setup.exe,
which is a non-Cygwin executable and requires Cygwin processes to be terminated.

Before I really can tell what I need regarding the rebase, I need to learn what
exactly is recorded into the rebase database, and probably how the recorded data
does influence the rebase procedure right now.

My thoughts so far for what I probably need:

* First, rebase new dlls before being installed into the target file system
directory with respect to currently installed dlls (the --oblivious option),
* Second, register new dlls just installed into the target file system
directory into the rebase database without performing a rebase, and
* Third, unregister dlls being removed from the rebase database.

Also, it may make sense to allow for reusing the base address of an installed
dll by it's update replacement - while the old version dll still is in use and
the new version dll is in some temporary staging directory.

As there may be multiple instances of Gentoo Prefix within one single operating
system instance, it does not make sense to record the dll's base addresses into
the rebase database of the underlying Cygwin instance in /etc, but still the
base addresses already recorded there should be respected when rebasing dlls
for within a particular Gentoo Prefix instance.

Furthermore, with so called "Stacked Prefix", it is possible to have a second
level of Gentoo Prefix, so what I'm after is some option to tell the rebase
utility which database to record dll base addresses into, and which multiple(!)
databases take into account while performing a rebase.

Thanks!
/haubi/
