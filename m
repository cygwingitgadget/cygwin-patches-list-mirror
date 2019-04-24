Return-Path: <cygwin-patches-return-9380-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 119795 invoked by alias); 24 Apr 2019 15:10:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 119786 invoked by uid 89); 24 Apr 2019 15:10:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=occupied
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 24 Apr 2019 15:09:59 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 17:09:57 +0200
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hJJX2-0002yi-PJ; Wed, 24 Apr 2019 17:09:56 +0200
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
References: <b22069db-a300-56f7-33dd-30a1adbc0c93@ssi-schaefer.com> <678d8ec4-f6c2-1538-aafd-dbb9cfc5dea5@ssi-schaefer.com> <20190328095818.GP4096@calimero.vinschen.de> <fd7b9ab3-ca07-0c80-04da-4f6b2f20d49e@ssi-schaefer.com> <20190328203056.GB4096@calimero.vinschen.de> <fe627231-6717-c702-b97b-d66cdc9409a3@ssi-schaefer.com> <20190401145658.GA6331@calimero.vinschen.de> <20190401155636.GN3337@calimero.vinschen.de> <837bc171-eb6f-681e-5167-103f5e9e8523@ssi-schaefer.com> <20190403122216.GX3337@calimero.vinschen.de> <20190412174031.GC4248@calimero.vinschen.de>
To: cygwin-patches@cygwin.com
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Openpgp: preference=signencrypt
Message-ID: <96a07e1e-8fe3-8264-7c26-ba09acf8bad3@ssi-schaefer.com>
Date: Wed, 24 Apr 2019 15:10:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412174031.GC4248@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q2/txt/msg00087.txt.bz2

On 4/12/19 7:40 PM, Corinna Vinschen wrote:
> Hi Michael,

> Nick Clifton, one of the binutils maintainers, made the following
> suggestion in PM:
> 
> Allow the ld flag --enable-auto-image-base to take a filename as
> argument.> 
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

The rounding up is fine to get some alignment for the base address itself,
but it feels irrelevant if it was for "finding the next base" only.

> 3. If the auto image base range is at an end, ld will wrap back to
>    the start address of the auto image base range.> 
> TBD: A way to enable this feature without having to change all
>      packages' build systems.

As the --enable-auto-image-base flag does not name any method for finding
the image base beyond "automatic", IMHO using some predefined control file
under the hoods should be fine.

Beyond holding the last image base and the range, such an auto image base
control file could control the actual behaviour as well, as in either
"use the -o argument" or "use next base within range".

Hence some versioning of that file's content might be resonable.  And
for parallel builds, "finding the next base" needs some synchronization.

What about hardcoding (the default of) such a filename into ld itself?  E.g.
"./configure --with-auto-image-base-control-file=/var/lib/ld/auto-image-base"

Also, I could think of binutils' configure options like this instead:
 --with-auto-image-base=control-file=/path/to/file
 --with-auto-image-base=dash-o-argument # current behaviour, no control file support

And to set the defaults of that control file:
 --with-auto-image-base-control-file-default-mode=[dash-o-argument|control-file]
 --with-auto-image-base-control-file-default-range=0x123456789abcdef:0xfedcba9876543210

> That way you could build hundreds of DLLs in a project and use them
> immediately without having to rebase.
> 
> This is just in a discussion state, nothing has happend yet, but
> what do you think in general?

This does make a lot of sense to me in general, although package managers
still need to use the Cygwin rebase database, as in the long run that range
will exceed.  But for Gentoo Prefix in particular, this would help during
bootstrap, before the Cygwin rebase database is set up inside the Prefix.

Thanks!
/haubi/
