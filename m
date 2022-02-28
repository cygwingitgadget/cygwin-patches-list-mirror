Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 8EF933858414
 for <cygwin-patches@cygwin.com>; Mon, 28 Feb 2022 09:39:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 8EF933858414
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MTOZQ-1nlojL0xIa-00TiV1 for <cygwin-patches@cygwin.com>; Mon, 28 Feb 2022
 10:39:35 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id D00B8A80CE4; Mon, 28 Feb 2022 10:39:34 +0100 (CET)
Date: Mon, 28 Feb 2022 10:39:34 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Drop pointless loadlib.h use in utilities
Message-ID: <YhyYVvO7bV0sGZbX@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220226164054.26698-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220226164054.26698-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:hCgYDsAFuzG69+doy/RY/kMcHxm9V32xZ0MTSaAJWk4mDBImYq3
 ueR1+sZgnfkjeyK1Hh97YS6ME/llr8EDE0BPFS7Mq76fuK5j0XDNiBKxvdJpeVqnL1LPU6B
 si6H2lbeL0nLIaYZwvog3Au+0vU/+KJYQxTvF6hmQXtCo9Go/AhXuv0Jk1rGHorqRITo562
 /2wqh4tqpYkqvsC1F7kEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CAhb8UqEy7Q=:vloFMtZoqrO74dF+iwDXNr
 65sVGx3MInPvZ71kLxN2uzEh7gSL+srVFGxBgks7iqkZs6blDDeENPTXEf48c4a/xZJjy7DaF
 lxd5oP0CmHbbnlkBnITdaDSmdZm/KUeJis8w9IOp+W6GY8H2wKD9tlDBrRY4JCJIfCe+7UyrY
 gENXfTZRFNMHAawNj6EqCruVq5hZDmJGHswTqiRs6q7/dv3EzAX2JBWBIHQ4u4qvEx8oN312C
 9/ccKeWYPxxqexGJe77ablrX34qN2K08MQPPXgTJkVEMjGJFO3XgPgF8fo0ika4HiSz6Tcf1X
 HpfvBliASTBeIu2HK46JYAe4tk9sIQimtoCDKFOVacdIjWT/LKezIlcjg/l8JICTvPY4iSzg/
 HRXyi7z6KXmWLqi72BreufJ9E8nRq1uKaXmAxPydog5T18d05N+RVk3cdwNYqpULf+241MPPY
 g/5IkuqAuTbSymtK1noEUuPfJfNTRr5MhMyhuubc8c9DeD4fyhL9UzCTGrl9w1ScLth2p6iPW
 mzg2bXZ7VvhJscAAiJk34guDmQ88FYSBRj3pc1/YhbyjBI47Yy/qlCSDAZwrUxBJeEUiGWKRP
 UF5nAb+F27iDkd46qoz6EZ2U/nvF7ys1Pyu1gSbmhxbaZf5RFz+JptV2O4eCjEdQbrNODVzyb
 DTErv34fzzZoHCd47oeHe4dz7XZVjHjUkr8j1UBDeXSBy4lZ7Q1WMP69XGk4gEfqv6Vd5XmGk
 LbABlKtGxM6wAkS9
X-Spam-Status: No, score=-96.4 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H5, RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Mon, 28 Feb 2022 09:39:38 -0000

On Feb 26 16:40, Jon Turney wrote:
> The only remaining uses of loadlib.h are in cygcheck and strace, where it's
> used to load cygwin1.dll in both.
> 
> Things could be further simplified, but it's probably worth keeping it
> around in it's present form since it's quite likely that
> LoadLibrary()/GetProcAddress() might be used again in future.
> 
> Jon Turney (2):
>   Cygwin: Drop pointless loadlib.h includes in utilities
>   Cygwin: Drop use of loadlib.h in regtool
> 
>  winsup/utils/cygpath.cc     |  1 -
>  winsup/utils/module_info.cc |  1 -
>  winsup/utils/path.cc        |  1 -
>  winsup/utils/ps.cc          |  1 -
>  winsup/utils/regtool.cc     | 13 +------------
>  5 files changed, 1 insertion(+), 16 deletions(-)
> 
> -- 
> 2.35.1

Good idea!

Shouldn't we actually remove loadlib.h as well?  What this code does is
to provide a safety measure to make sure the files are not stealthy
loaded from another dir.  This should not be necessary anymore, because
Windows itself provides matching functionality.

First of all, the system has an internal list of DLLs it always
loads from the system32 dir.  In Cygwin, see the content of
/proc/sys/KnownDlls/ and /proc/sys/KnownDlls32/

And for all other cases we can use LoadLibraryEx flags introduced a
couple of years ago, e. g.  LOAD_LIBRARY_SEARCH_SYSTEM32.  See
https://docs.microsoft.com/en-us/windows/win32/api/libloaderapi/nf-libloaderapi-loadlibraryexa


Thanks,
Corinna
