Return-Path: <cygwin-patches-return-9271-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 35657 invoked by alias); 29 Mar 2019 14:42:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 35646 invoked by uid 89); 29 Mar 2019 14:42:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.6 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.138) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 29 Mar 2019 14:42:35 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id 9siGhu2kSGusj9siHhEY5P; Fri, 29 Mar 2019 08:42:33 -0600
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
To: cygwin-patches@cygwin.com
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com> <20190326182538.GA4096@calimero.vinschen.de> <20190326182824.GB4096@calimero.vinschen.de> <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com> <87y350ytpb.fsf@Rainer.invalid> <9c38ac1d-4dea-12d4-a63b-6e8ec59b3ae8@ssi-schaefer.com> <0f0d7cd6-e770-fc32-f28f-817b700e4d87@SystematicSw.ab.ca> <f5ab5a82-8d26-4898-7ea4-ecef5c377299@ssi-schaefer.com> <abf543bb-e8df-9eeb-5ae8-63e5d59cca9a@SystematicSw.ab.ca> <87sgv65eyc.fsf@Rainer.invalid>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <5fa27e1c-a790-f03d-b4b3-1985f26df128@SystematicSw.ab.ca>
Date: Fri, 29 Mar 2019 14:42:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87sgv65eyc.fsf@Rainer.invalid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00081.txt.bz2

On 2019-03-29 01:15, Achim Gratz wrote:
> Brian Inglis writes:
>> File list my-dlls.txt is your local test rebase db listing all your
>> test dlls.
> 
> I think Michael got confused by your usage of "db" here.  This is in
> fact just a listing of all the DLL to operate on, not the rebase
> database (which won't be changed at all by an oblivious rebase, only
> read in order to not collide the new rebase with the already existing
> ones).
> 
>> If you are packaging your own exes and dlls with your own local Cygwin distro,
>> you should point to your local utility directory with a path in a file under
>> /var/lib/rebase/user.d/$USER for each Cygwin userid on each system, or perhaps
>> you might also need to add your own production exes and dlls into
>> /var/cache/rebase/rebase_user and /var/cache/rebase/rebase_user_exe: see
>> /usr/share/doc/Cygwin/_autorebase.README.
> 
> What Michael is using is a fairly complex build system that would indeed
> benefit from a layered rebase database, i.e. the one for the base system
> providing the substrate for the build system and then at leat on other
> one that collects the information from inside the build system (maybe
> even a third layer for tests).  How to deal with the complexities of
> when you want to push information down to a previous layer would likely
> be a main point of contention, so you'd probably best skip it in the
> beginning.
> 
> SHTDI, PTC, etc.pp.
> 
> With the current rebase, you'll have to use "--oblivious" (which, again,
> doesn't remember any data for the newly rebased objects) and those
> non-existing upper layers will have to be provided by side-channel
> information that the build system has to collect and maintain itself,
> then feed to the rebase command.

Achim, thanks for the clarifications; could you please comment on the suggested
approach for handling local production dlls and exes, or explain the best
approach for migrating from test to prod and handling rebase on target systems?

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
