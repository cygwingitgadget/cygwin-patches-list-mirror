Return-Path: <cygwin-patches-return-9269-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20163 invoked by alias); 29 Mar 2019 07:16:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 19996 invoked by uid 89); 29 Mar 2019 07:15:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: vsmx012.vodafonemail.xion.oxcs.net
Received: from vsmx012.vodafonemail.xion.oxcs.net (HELO vsmx012.vodafonemail.xion.oxcs.net) (153.92.174.90) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 29 Mar 2019 07:15:38 +0000
Received: from vsmx004.vodafonemail.xion.oxcs.net (unknown [192.168.75.198])	by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTP id DA774F34C5F	for <cygwin-patches@cygwin.com>; Fri, 29 Mar 2019 07:15:31 +0000 (UTC)
Received: from Rainer.invalid (unknown [87.185.211.111])	by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTPA id A6F3319AD95	for <cygwin-patches@cygwin.com>; Fri, 29 Mar 2019 07:15:29 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com>	<20190326182538.GA4096@calimero.vinschen.de>	<20190326182824.GB4096@calimero.vinschen.de>	<c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com>	<87y350ytpb.fsf@Rainer.invalid>	<9c38ac1d-4dea-12d4-a63b-6e8ec59b3ae8@ssi-schaefer.com>	<0f0d7cd6-e770-fc32-f28f-817b700e4d87@SystematicSw.ab.ca>	<f5ab5a82-8d26-4898-7ea4-ecef5c377299@ssi-schaefer.com>	<abf543bb-e8df-9eeb-5ae8-63e5d59cca9a@SystematicSw.ab.ca>
Date: Fri, 29 Mar 2019 07:16:00 -0000
In-Reply-To: <abf543bb-e8df-9eeb-5ae8-63e5d59cca9a@SystematicSw.ab.ca> (Brian	Inglis's message of "Thu, 28 Mar 2019 16:56:25 -0600")
Message-ID: <87sgv65eyc.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q1/txt/msg00079.txt.bz2

Brian Inglis writes:
> File list my-dlls.txt is your local test rebase db listing all your
> test dlls.

I think Michael got confused by your usage of "db" here.  This is in
fact just a listing of all the DLL to operate on, not the rebase
database (which won't be changed at all by an oblivious rebase, only
read in order to not collide the new rebase with the already existing
ones).

> If you are packaging your own exes and dlls with your own local Cygwin distro,
> you should point to your local utility directory with a path in a file under
> /var/lib/rebase/user.d/$USER for each Cygwin userid on each system, or perhaps
> you might also need to add your own production exes and dlls into
> /var/cache/rebase/rebase_user and /var/cache/rebase/rebase_user_exe: see
> /usr/share/doc/Cygwin/_autorebase.README.

What Michael is using is a fairly complex build system that would indeed
benefit from a layered rebase database, i.e. the one for the base system
providing the substrate for the build system and then at leat on other
one that collects the information from inside the build system (maybe
even a third layer for tests).  How to deal with the complexities of
when you want to push information down to a previous layer would likely
be a main point of contention, so you'd probably best skip it in the
beginning.

SHTDI, PTC, etc.pp.

With the current rebase, you'll have to use "--oblivious" (which, again,
doesn't remember any data for the newly rebased objects) and those
non-existing upper layers will have to be provided by side-channel
information that the build system has to collect and maintain itself,
then feed to the rebase command.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Factory and User Sound Singles for Waldorf rackAttack:
http://Synth.Stromeko.net/Downloads.html#WaldorfSounds
