Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	by sourceware.org (Postfix) with ESMTPS id 25C5C3858D20
	for <cygwin-patches@cygwin.com>; Mon,  9 Jan 2023 11:12:55 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MvJo7-1owlAS2yrB-00rHC5 for <cygwin-patches@cygwin.com>; Mon, 09 Jan 2023
 12:12:53 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B63C6A809BE; Mon,  9 Jan 2023 12:12:52 +0100 (CET)
Date: Mon, 9 Jan 2023 12:12:52 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Run testsuite against the just-built DLL
Message-ID: <Y7v2tBwkd79plnBd@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20221221161834.45553-1-jon.turney@dronecode.org.uk>
 <20230106143823.53627-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230106143823.53627-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:HvKP49wGgE8+jq+wLbumkJ0FprIklIY7gKyJi3XIEKAA9XqqhsE
 plczLve0wsP14sHJQ+Tj/QyYfJMeZ71F28GVK449c8TdYGbr+VUvc7mwTtULkeDW7csJ3ZD
 J2q1don2X9V7CnxuVSD7AvYOubegIml5EDP0Yz4DtSbcIdjXi99POhj0jpSIoSXcxclJ50H
 Okq2CfHTzOJQWexPFtLvA==
UI-OutboundReport: notjunk:1;M01:P0:06SaCGCITDA=;w17WSD+CIDl5kvpA6InKY6oSGX3
 giPDHuJ9T3xV1pNFpaFCGWhyh9kAdYnkKoXoH9M0UUb/S8Zx2AgPeKskjoY4DnPa+R5tJwUJX
 QWb5OpbBo9PsmXpXsrLAF0kN85dZpFBB5+wXW6grRMrCiwZim8V+bYahYGqZgyz3/5O3t1xw5
 vtSqNuPivWcTcdGShayFb8TRoKDSCrKw9hnjjTO8ywvusqHele6J/9KAlMtCZYqJ4kF/rWCbA
 WIrl7eHory4oIHQj/73qR3vOJRI4JWVob06QW/J8KU9oN7BaMIcctzoeydKBw54UkvVj1Mh6z
 vXFweRRD+ghZOhCCSD2f+2R0PtTk9VlvaHlLwK47V8aiWVBTeLQ9Gj/MKtjSvSTrrK++F0clU
 MtXiDpn+YNRcq+ogKZdXdMuG+pyrwmKJFBy9EfSqaqyEqJsEE71bpfz1VCKxPNLIUkTTblPzm
 TB/CgchO6H5SipEezrMDrYJBZ9zR24wREkTV/uivGqdgNg2AWKMSUBBkn7oK/m+N2PAweo2OW
 4h0WFjef4hEdL5xiK+VJhAiwLZHhdv9RD8jDqVspozOMU6awZ8L2Ki9zcdhHx5tE8s8uYrWfJ
 5WeACCRTW4RqtyEVlX45JkJyRKhvvBPH6kXGIU5L21Q2AHM/7kgDFfrivNBG8HayO405/WUoq
 RH5LmHilD9fgXgd13cGbdBtiEeD1tdpTN+U+CSSiHw==
X-Spam-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Jan  6 14:38, Jon Turney wrote:
> Since 4e7817498efc, we're just running the tests against the installed
> DLL.  We're arranging to put the build directory on the path, but since
> it doesn't contain cygwin1.dll (since it's built with a different name
> and renamed on installation), that doesn't have any effect.
> 
> Arrange to place the just-built DLL into a directory which the testsuite
> can place on it's path (while running the test, but not while compiling
> it).
> 
> Also fix any remaining references to cygwin0.dll in testsuite,
> documentation and comments.
> 
> Fixes: 4e7817498efc ("Cygwin: Makefile: Drop all the "test dll" considerations")
> ---
> 
> Notes:
>     This flips a couple of tests from passing to failing, since they try to
>     use system(), which doesn't work, because there is no /usr/bin/bash in
>     the Cygwin 'installation' at testsuite/runtime/.
>     
>     I think perhaps the best solution long-term is to remove all these
>     fragile hacks to try to run the testsuite on top of an existing Cygwin,
>     and instead the CI should save the result of 'make install' in an
>     archive, and a job should unpack that and run the testsuite on it...
> 
>  winsup/cygwin/Makefile.am               | 8 +++++---
>  winsup/cygwin/scripts/analyze_sigfe     | 2 +-
>  winsup/testsuite/Makefile.am            | 3 ++-
>  winsup/testsuite/README                 | 9 +++------
>  winsup/testsuite/config/default.exp     | 2 +-
>  winsup/testsuite/winsup.api/cygload.exp | 2 +-
>  winsup/testsuite/winsup.api/winsup.exp  | 8 +++++---
>  7 files changed, 18 insertions(+), 16 deletions(-)

All your patches to the testsuite are auto-approved.

Just go ahead with whatever you deem right.  We can handle any question
on IRC.


Thanks,
Corinna
