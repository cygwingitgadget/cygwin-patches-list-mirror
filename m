Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	by sourceware.org (Postfix) with ESMTPS id 55CA63858D33
	for <cygwin-patches@cygwin.com>; Wed,  1 Feb 2023 17:33:11 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MO9vD-1ozRdM0DwP-00OY5O; Wed, 01 Feb 2023 18:33:09 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2A8CDA809C8; Wed,  1 Feb 2023 18:33:08 +0100 (CET)
Date: Wed, 1 Feb 2023 18:33:08 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH] dumper: avoid linker problem when `libbfd` depends on
 `libsframe`
Message-ID: <Y9qiVIHEaUFPrztO@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
	Jon TURNEY <jon.turney@dronecode.org.uk>
References: <50ed771a961112edb5c4b69421d9ad8cecf7a7cb.1675260460.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50ed771a961112edb5c4b69421d9ad8cecf7a7cb.1675260460.git.johannes.schindelin@gmx.de>
X-Provags-ID: V03:K1:EuLGo7KKEipN/Rs36COofEep3qktCq+t1lrh90RtSCtV6z1IlkB
 sz6lQXr8SGm6SffJljAvpBimuPtXUhMrqaK/ugP7BhGVkZMuxILdL8+oYUnv/v0qoJwEfbX
 /5PeoPqNQuWoeSL7AsmPXvHFVxgqaFl6zGYNVJdCE15oxQAr+hljxBuZYN16oq7RRcEc3xX
 VyevwJ74VsqOqISGF+PsQ==
UI-OutboundReport: notjunk:1;M01:P0:7IsAmBaO3Sg=;yrlu2rn0DFcepxG0+zRk8hCpt8k
 c38Fbp5Ppik7hJrnvu/1fbmKDYkHEpYYh5/s/TjSjMdEV1r4GaWc/2lXx+I8gLa+qXfWuRuUk
 Le20cS9g3pRTGvVdu+Fqy+aefEdWRLL7lIZvI2QWM3nZ6O10yeBPjXTuN77lcLcViesOSedDB
 Lihn4D52zmCSyC0AQDa5hXKdsWOzZYGDgQ0Gur8kcM6m5RnAgQQe8zQpJP+KKdW0PBMt67BpQ
 vF93TVqCYhQmVNJ7wb+VS+S8323gLUid+aEDVYzwanDWjayWyyjVFHbrhCKf/P34szxhobfkD
 stx+XVXS0GgHpXAMBDf0Z86o9IsV7a1SA+Sd+ewQT02avtBf2SM7Os8cuYhMJVr8miMC6TI4j
 ceOUrno4egTpxT2dVXCEOakzNH4P1B5vmkz1X280tcR8fNQmkGXhGofOiwm8SpPOq2uozmAWx
 MHu4+2+MAgGT9QmKzpS3zemzIPwpRb39dFQgUTqIlViUql8OQbrFD7SpKhSNiLu/CrBPLlR2O
 NHdJ9neimR3KVurpdSqXKUzqaltHPM5YPPlHrryUkTiWbC8IWyYZQEXQL/HhtlvYEXY1VRrKE
 h86A3EPmn/sPF+YMgN6zXhCtguvscUb6RjCrhBrUbIRAltcF+oUu6+DEN424N7BEafOqSpb/z
 MtfdJAqMYAg9Sv3C1c7LkHX3Qgkq13p/M+gLPs54OQ==
X-Spam-Status: No, score=-97.1 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Feb  1 15:08, Johannes Schindelin wrote:
> A recent binutils version introduced `libsframe` and made it a
> dependency of `libbfd`. This caused a linker problem in the MSYS2
> project, and once Cygwin upgrades to that binutils version it would
> cause the same problems there.
> 
> Let's preemptively detect the presence of `libsframe` and if detected,
> link to it in addition to `libbfd`.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/msys2-runtime/releases/tag/do-link-libsframe-if-available-v1
> Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime do-link-libsframe-if-available-v1
> 
>  winsup/configure.ac      | 5 +++++
>  winsup/utils/Makefile.am | 4 ++++
>  2 files changed, 9 insertions(+)

LGTM.  Jon, what do you think?


Thanks,
Corinna
