Return-Path: <cygwin-patches-return-9336-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 113680 invoked by alias); 13 Apr 2019 07:46:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 113671 invoked by uid 89); 13 Apr 2019 07:46:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=plug, HX-Languages-Length:1891
X-HELO: vsmx009.vodafonemail.xion.oxcs.net
Received: from vsmx009.vodafonemail.xion.oxcs.net (HELO vsmx009.vodafonemail.xion.oxcs.net) (153.92.174.87) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 13 Apr 2019 07:46:26 +0000
Received: from vsmx001.vodafonemail.xion.oxcs.net (unknown [192.168.75.191])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id 89324C062F	for <cygwin-patches@cygwin.com>; Sat, 13 Apr 2019 07:46:24 +0000 (UTC)
Received: from Gertrud (unknown [87.185.221.231])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 602E830063A	for <cygwin-patches@cygwin.com>; Sat, 13 Apr 2019 07:46:22 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
References: <b22069db-a300-56f7-33dd-30a1adbc0c93@ssi-schaefer.com>	<678d8ec4-f6c2-1538-aafd-dbb9cfc5dea5@ssi-schaefer.com>	<20190328095818.GP4096@calimero.vinschen.de>	<fd7b9ab3-ca07-0c80-04da-4f6b2f20d49e@ssi-schaefer.com>	<20190328203056.GB4096@calimero.vinschen.de>	<fe627231-6717-c702-b97b-d66cdc9409a3@ssi-schaefer.com>	<20190401145658.GA6331@calimero.vinschen.de>	<20190401155636.GN3337@calimero.vinschen.de>	<837bc171-eb6f-681e-5167-103f5e9e8523@ssi-schaefer.com>	<20190403122216.GX3337@calimero.vinschen.de>	<20190412174031.GC4248@calimero.vinschen.de>
Date: Sat, 13 Apr 2019 07:46:00 -0000
In-Reply-To: <20190412174031.GC4248@calimero.vinschen.de> (Corinna Vinschen's	message of "Fri, 12 Apr 2019 19:40:31 +0200")
Message-ID: <877ebyxs8i.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q2/txt/msg00043.txt.bz2

Corinna Vinschen writes:
> Nick Clifton, one of the binutils maintainers, made the following
> suggestion in PM:
>
> Allow the ld flag --enable-auto-image-base to take a filename as
> argument.
>
> The idea: The file is used by ld to generate the start address
> for the next built DLL.  Mechanism:
>
> 1.1. If ld links a DLL and if the file given to --enable-auto-image-base
>      doesn't exist, ld will give the DLL the start address of the
>      auto image base range.
>
> 1.2: Next time, if ld links a DLL and if the file given to
>      --enable-auto-image-base exists, it will use the address in that
>      file as the start address for th just built DLL.
>
> 2. It will store that address, plus the size of the DLL, rounded up to
>    64K, in that file.
>
> 3. If the auto image base range is at an end, ld will wrap back to
>    the start address of the auto image base range.

Sounds OK if the goal is just to avoid collisions, but it would really
be nicer if there was some way to plug this together with the rebase
database from the start.

> TBD: A way to enable this feature without having to change all
>      packages' build systems.

:-)

> That way you could build hundreds of DLLs in a project and use them
> immediately without having to rebase.
>
> This is just in a discussion state, nothing has happend yet, but
> what do you think in general?

Looking at what triggered the discussion, on would probably want to have
the option of giving the linker the name of an existing DLL as the
argument and have it re-use that base address (and a warning if the size
gets larger than the original DLL plus some guardband).


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Waldorf MIDI Implementation & additional documentation:
http://Synth.Stromeko.net/Downloads.html#WaldorfDocs
