Return-Path: <cygwin-patches-return-9311-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13350 invoked by alias); 8 Apr 2019 13:03:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 13340 invoked by uid 89); 8 Apr 2019 13:03:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=accessible, cope, newly
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 08 Apr 2019 13:03:55 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 15:03:51 +0200
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hDTwF-0007ip-0F; Mon, 08 Apr 2019 15:03:51 +0200
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com> <20190326182538.GA4096@calimero.vinschen.de> <20190326182824.GB4096@calimero.vinschen.de> <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com> <87y350ytpb.fsf@Rainer.invalid> <9c38ac1d-4dea-12d4-a63b-6e8ec59b3ae8@ssi-schaefer.com> <0f0d7cd6-e770-fc32-f28f-817b700e4d87@SystematicSw.ab.ca> <f5ab5a82-8d26-4898-7ea4-ecef5c377299@ssi-schaefer.com> <abf543bb-e8df-9eeb-5ae8-63e5d59cca9a@SystematicSw.ab.ca> <87sgv65eyc.fsf@Rainer.invalid> <5fa27e1c-a790-f03d-b4b3-1985f26df128@SystematicSw.ab.ca> <87pnq9jupk.fsf@Rainer.invalid> <a83dedc6-ea5b-5fc9-4bbc-f06a9cf19472@SystematicSw.ab.ca> <878sww93g9.fsf@Rainer.invalid> <97aec921-d9b1-3b0e-de7a-d492832ba481@SystematicSw.ab.ca> <236d3269-1b0b-9da0-9816-ed84e489f73e@ssi-schaefer.com> <87ef6jmfwv.fsf@Rainer.invalid>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Openpgp: preference=signencrypt
Message-ID: <437a6a24-4428-ad14-f6bb-16ff23679c30@ssi-schaefer.com>
Date: Mon, 08 Apr 2019 13:03:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87ef6jmfwv.fsf@Rainer.invalid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q2/txt/msg00018.txt.bz2

On 4/3/19 2:28 PM, Achim Gratz wrote:
> Michael Haubenwallner writes:
>> Before I really can tell what I need regarding the rebase, I need to learn what
>> exactly is recorded into the rebase database, and probably how the recorded data
>> does influence the rebase procedure right now.
> 
> Just where the DLL resides in the filesystem, what address it has been
> rebased to and what size it occupies.  If you rebase a new DLL with the
> database, it will give you the first gap in the address space that this
> new DLL fits into for doing the rebase and record that into the
> database.  With the --oblivious option, it keeps the database file
> untouched, so the information about the newly rebased DLL gets lost
> whenh the program exits.  That's why you need to do all oblivious
> rebasing in a single invocation.

Ok, this does fit what I guessed, thanks!

> 
>> My thoughts so far for what I probably need:
>>
>> * First, rebase new dlls before being installed into the target file system
>> directory with respect to currently installed dlls (the --oblivious
>> option),
> 
> You always rebase after the install so that the path information is
> correct.  Pre-rebasing is useless.
> 
>> * Second, register new dlls just installed into the target file system
>> directory into the rebase database without performing a rebase, and
> 
> No, rebasing the installed DLL already does that.

Well... once installed, a dll may get in use quickly, because I can not require
to shut down all Cygwin processes.  So I need to rebase and register the dll in
some staging directory before it is installed into it's final directory, hence
 I'm about to add some new '--destdir' option.

>> * Third, unregister dlls being removed from the rebase database.
> 
> Rebase already removes any entries that are no longer accessible from
> the database.

Ah, nice.  So I don't need to care about rebased but then not installed ones.

>> Also, it may make sense to allow for reusing the base address of an installed
>> dll by it's update replacement - while the old version dll still is in use and
>> the new version dll is in some temporary staging directory.
> 
> Rebase already re-uses the base-address if the path for the new DLL is
> the same and it still fits into the gap.

Ok.

> In general, however, that
> won't work when the size of any DLL changes.  You can ask for more
> guardband around each entry, but that doesn't actually solve the problem
> as it's only useful for the initial (full) rebase.
> 
>> As there may be multiple instances of Gentoo Prefix within one single operating
>> system instance, it does not make sense to record the dll's base addresses into
>> the rebase database of the underlying Cygwin instance in /etc, but still the
>> base addresses already recorded there should be respected when rebasing dlls
>> for within a particular Gentoo Prefix instance.
> 
> If you can limit the address space that's used by the Cygwin base
> system, I'd just give your Gentoo prefix installation its own address
> space and rebase it independently from the base system.  That probably
> requires some fooling around with the (currently hardcoded) rebase
> database files, but should otherwise just work.

When I install rebase right within Gentoo Prefix, the rebase db is stored there
as well, to not cope with host Cygwin's rebase db.  Other than cygwin1.dll, no
dll should be used by Gentoo Prefix binaries anyway (except during bootstrap).

>> Furthermore, with so called "Stacked Prefix", it is possible to have a second
>> level of Gentoo Prefix, so what I'm after is some option to tell the rebase
>> utility which database to record dll base addresses into, and which multiple(!)
>> databases take into account while performing a rebase.
> 
> I don't think you'll want to do that.

Indeed - at least not for the moment.

Thanks!
/haubi/
