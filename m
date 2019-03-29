Return-Path: <cygwin-patches-return-9275-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 100634 invoked by alias); 29 Mar 2019 21:48:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 100543 invoked by uid 89); 29 Mar 2019 21:48:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.6 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.139) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 29 Mar 2019 21:48:48 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id 9zMjhydRmGusj9zMkhGP9F; Fri, 29 Mar 2019 15:48:46 -0600
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
To: cygwin-patches@cygwin.com
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com> <20190326182538.GA4096@calimero.vinschen.de> <20190326182824.GB4096@calimero.vinschen.de> <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com> <87y350ytpb.fsf@Rainer.invalid> <9c38ac1d-4dea-12d4-a63b-6e8ec59b3ae8@ssi-schaefer.com> <0f0d7cd6-e770-fc32-f28f-817b700e4d87@SystematicSw.ab.ca> <f5ab5a82-8d26-4898-7ea4-ecef5c377299@ssi-schaefer.com> <abf543bb-e8df-9eeb-5ae8-63e5d59cca9a@SystematicSw.ab.ca> <87sgv65eyc.fsf@Rainer.invalid> <5fa27e1c-a790-f03d-b4b3-1985f26df128@SystematicSw.ab.ca> <87pnq9jupk.fsf@Rainer.invalid>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <a83dedc6-ea5b-5fc9-4bbc-f06a9cf19472@SystematicSw.ab.ca>
Date: Fri, 29 Mar 2019 21:48:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87pnq9jupk.fsf@Rainer.invalid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00085.txt.bz2

On 2019-03-29 14:23, Achim Gratz wrote:
> Brian Inglis writes:
>>> If you are packaging your own exes and dlls with your own local Cygwin distro,
>>> you should point to your local utility directory with a path in a file under
>>> /var/lib/rebase/user.d/$USER for each Cygwin userid on each system, or perhaps
>>> you might also need to add your own production exes and dlls into
>>> /var/cache/rebase/rebase_user and /var/cache/rebase/rebase_user_exe: see
>>> /usr/share/doc/Cygwin/_autorebase.README.

>> Achim, thanks for the clarifications; could you please comment on the suggested
>> approach for handling local production dlls and exes, or explain the best
>> approach for migrating from test to prod and handling rebase on target systems?

> I'm not quite sure what you want to know.  As I said before oblivious
> rebase was invented for running tests that use freshly built DLL (I
> usually package them before running the tests, so the package will have
> the un-rebased DLL from before the test was run).  For this it suffices
> to simply feed in all new DLL names to rebase.  If you were to build in
> stages and/or combine different builds then you'd somehow have to
> remember the DLL from each stage or build, or just collect all the DLL
> names again each time you change something.  The important thing is that
> each oblivious rebase needs to get the list of _all_ DLL that need to
> get rebased, since the database only knows about the host system
> (i.e. you can't rebase incrementally with --oblivious).

I was wondering as my first para above stated, whether rebase_user{,_exe} would
be the proper place to add 3rd party Cygwin dlls and exes, that are distributed
with Cygwin (internally)?

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
