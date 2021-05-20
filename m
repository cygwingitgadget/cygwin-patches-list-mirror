Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 9321C3973004
 for <cygwin-patches@cygwin.com>; Thu, 20 May 2021 18:05:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9321C3973004
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1McYP5-1lBpkW0BtF-00d06C for <cygwin-patches@cygwin.com>; Thu, 20 May 2021
 20:05:57 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id A322CA82BFD; Thu, 20 May 2021 20:05:56 +0200 (CEST)
Date: Thu, 20 May 2021 20:05:56 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Ensure PSAPI_VERSION is 1 when building ldd
Message-ID: <YKalBKpjhBx6mZBg@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210520174635.24163-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210520174635.24163-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:x25GYgJadiODUjwfcOIcvBQ+62Gy9vySW1vjGXyTL6V1qR28sfb
 FW6fxVvbn15WbM1A5OXImPnMXA7vOX+7eZ9Wdx+GIK6SbX91oe5pJbpxfzd7tcib+bRL+p8
 FNM2I4Xe65CW3j36lCvih2FVi1iMIe0Yv5fyKuO49ATK/VnEm9GSJpWsScnWV+gXBVzCt6q
 WAj05A/dxYtrL4OgaciEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bgoe7lh02XM=:1Rpx6R+aHpK1ISjLRpuvA5
 7w4Wi1TCliYJOwnisbShNGhv/6CpEXBp2d5qIiw7AgXVDexgili97qwarcs90pnQlVr3pPbpX
 yhKTKiH9kft69EnuXTljd9tGHhdlvwabqULWJ2rqn7ErnNh0TKOw3BJ259tI/TGRQeRe1DRQ0
 iq0uruCiL4LPlJz9l3/4PPesTBmFd7f+JA263fgKZRrl0fuTABNSyKZiU2j7gA9EKGjZEXw5v
 0jUbPVUZ3M1p1b6be30S1tMtpt8jn6+nTEKug0eWVOo9lOu/12G3EoKoEodbm9P9BSB9AHpHX
 1ryYyytmEh7gU4P18e+ddnVoS4UoC9vVKWN/rSdmYSdZE9WAXqExxAhZbC9PbcZUoasPiMG/0
 RpWbPcMzV76AghPhHxufl2QyN3SnFCHO62mPFb5zwhRWPZeU49TCCg11lOfGfSHjEW2mDRSwH
 oQn06UOed5quhybLaP7Ps1SJ3EWPYNcproK4mYcqPmrdUIoMsLgzzmK/ZTO4g5cLR0aYcph3i
 tSdNRxiiFpJBAyFaGZJDtg=
X-Spam-Status: No, score=-100.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 20 May 2021 18:05:59 -0000

Hi Jon,

On May 20 18:46, Jon Turney wrote:
> The default PSAPI_VERSION is controlled by WIN32_WINNT, which we set to
> 0x0a00 when building ldd, which gets PSAPI_VERSION=2.
> 
> This causes K32GetModuleFileNameEx to be used for GetFileNameFromHandle,
> which isn't available on Windows Vista.

Patch is ok, but the description needs a tweak.  GetModuleFileNameEx is
called from load_dll and print_dll, not from GetFileNameFromHandle.

In terms of GetFileNameFromHandle, given the GetFinalPathNameByHandle
function is availabe since Vista, we should probably go ahead and use
it in ldd.cc, too.


Thanks,
Corinna
