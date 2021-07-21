Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id DD55B383603E
 for <cygwin-patches@cygwin.com>; Wed, 21 Jul 2021 08:39:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org DD55B383603E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MqsGv-1lJKd327NJ-00mwWE for <cygwin-patches@cygwin.com>; Wed, 21 Jul 2021
 10:39:40 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 02CDBA831C7; Wed, 21 Jul 2021 10:39:39 +0200 (CEST)
Date: Wed, 21 Jul 2021 10:39:39 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix nanosleep returning negative rem
Message-ID: <YPfdSyPTCdSWhRv/@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <000201d77d7a$2faae510$8f00af30$@cl.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000201d77d7a$2faae510$8f00af30$@cl.cam.ac.uk>
X-Provags-ID: V03:K1:ut1PNptIP+9j5hBs+toAnwSOB+WmhaD41RONlSxVT8wBpyLJCVQ
 01tpaSxMv7zli1tDdjg7slyVipYWzxKCZQLRS6BYD29Y40i1e69roVoBrm/WLPuENkRYbrB
 FsUJ65bAjV797Wh6380sXlR1yNGiLzj+uI1jEtkaW/uE93rD+kJmimJYKzCOSgX0fsR0uGJ
 n5lWUloU/CEtAXz+fLkJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SYV1wnlAWUk=:2nKZ18Up9gDdXSSzOMh4oC
 0TSA1lUkUP3dpz7KS/GSJF4i4scg0BMK+RW80rmvwlHiWwlorAZvNN0FY2Y96cKzSrxBABCgp
 F3+smbeEqiOByQ4jMTW9m7lSy7xFNcehUyykCQw02ghBBLUinV3UT6/xcwDZvpU++Ha2zHhxh
 48rL2CJ7yHzRipqWrffJ04ITHeCm66OH9mi8am/zVatgsgR+wBWBtz3iC/rFEOxTam6Wiw3x/
 2lEp4rtQ6SRee+eSBOlv79/DV7sg+j7pHYTn4QtyAhTdnIY+85ys5AwQJY1vkCy2IXW5IJofh
 mbxO0u33aV8TPdSeCZN/6HpssrhKmfWFZBGTYdIbzlLdqoDvMDjwhqMt9+3naxXFo8SN61nYf
 aDaTWTVrHqMCAcWut3Nj2BL1AjHY6kyQUt8SNwKlTcnvefFAc7OymXFzfzcJlaLDI0Y+3odlN
 Beyp6CYiWQlfGkH9sTb2gE+6eo6ctDQuhvpORiRwxBkBfBC0Hq+KBCSqmzcqLBPeZEvzOOgTq
 6NcyuvH9L/RkFSTMLJs9bNWYFl2sEeSUzmvsSFTOgVElQmM8cKxoltb0JWebjC9/KOveFF2C7
 9wvAOKwQu215UNfm4MWm4JYK1Wlk+mKOucVP+TR/PMVyjGgF+wwwR5YNH4DzDtnBfLLGYFAkI
 cPoDJVRz3YAY+FxdqSmqg2ovAmNL859IzYb1jk/t3aTfvIJkyHFFOo6ZzeIDoJmhMYs/VG77B
 366naRm4hREfGycXUZRB4VaSQJDETDTlQC6mr1z0pKY2Mbnug8Qrb3qEUpxeqVBbLDhFlu2/G
 4BTb5VNIZ3nnpYQu501++uvRgsrgKcvCTP4LcKvtwRZ1i5vaFRybFeJWEM0aFvswl+CsVgvJT
 SMip3onv/gzPgxivO0iQ==
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Wed, 21 Jul 2021 08:39:43 -0000

Hi David,

On Jul 20 16:16, David Allsopp wrote:
> I've pushed a repro case for this to
> https://github.com/dra27/cygwin-nanosleep-bug.git
> 
> Originally noticed as the main CI system for OCaml has been failing
> sporadically for the signal.ml test mentioned in that repo. This morning I
> tried hammering that test on my dev machine and discovered that it fails
> very frequently. No idea if that's drivers, Windows 10 updates, number of
> cores or what, but it was definitely happening, and easily.
> 
> Drilling further, it appears that NtQueryTimer is able to return a negative
> value in the TimeRemaining field even when SignalState is false. The values
> I've seen have always been < 15ms - i.e. less than the timer resolution, so
> I wonder if there is a point at which the timer has elapsed but has not been
> signalled, but WaitForMultipleObjects returns because of the EINTR signal.
> Mildly surprising that it seems to be so reproducible.
> 
> Anyway, a patch is attached which simply guards a negative return value. The
> test on tbi.SignalState is in theory unnecessary.

Thanks for the patch, I think your patch is fine.  However, I'd like
to dig a bit into this to see what exactly happens.  Do you have a
very simple testcase in plain C, by any chance?


Thanks,
Corinna
