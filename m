Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id BB9433860C3D
 for <cygwin-patches@cygwin.com>; Wed,  1 Jul 2020 07:27:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BB9433860C3D
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MkYkI-1j5snM0lGI-00m16s for <cygwin-patches@cygwin.com>; Wed, 01 Jul 2020
 09:27:54 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 1D271A80991; Wed,  1 Jul 2020 09:27:48 +0200 (CEST)
Date: Wed, 1 Jul 2020 09:27:48 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Discard CSI > Pm m sequence from native
 windows apps.
Message-ID: <20200701072748.GI3499@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200630111213.2678-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200630111213.2678-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:Eksqfl3Y2DuOV4LQZDKx+MEbCOTAQ173/EF2OYmmA8lkxC2kokY
 w9fqIvnHva5OlbT1rCnLgj29kor2H3tXRs/mcFClDvgxl4P1pGfuHnYdqwey7vxWjEkDNWH
 E7Wq3kLud5+gUBZNdDqu8fnXh5FeMPPXxf0gd04e0ewEU75sy1uN5PovcBZnzagX6Z3knLy
 nPPYuHsI0LH2yy4SHoJSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KJhbiWvYTD0=:FlCmyMepKjie6ADQjwH9Ra
 Wmray1pErR1qg2KfzVFOLBnn13DzikDIusb2T6vz1b4m+4MrjnkjBmW8iGgJHIlvoJf+TBYCA
 LW4+NyX4aje/LJl/Sak6400jWzXHEjwbxcIrFxS51JDcLNg+0wM0VqzLWBL3Bb8xQtGxJZtMC
 SpgKe8JwyoMRVvqBZ2giu3I4xKA1cIUIaDgsCH+I8Acl0B1W1IzoLOGfuy1lbGu55W4ioWtgR
 vj80LutGNSKYZMXfCz6qD7ZFy9OzjdUzWgF2he+2IQx2EXEKa6PWOpvtNS/3GuAsZL0jt0tRK
 kAIiwGkwkHWy9thVWv8bQ59C9rWEb5iYcVTEBaqs7ttdfxhGG4t+CMKV/4yzvu5Dz0QUW007S
 qjQWDCrMCCJUm3HGaHBiRhBk56OiHS7ursE/sJm5c1EsmCkpaR/kJrw2a25GlXQy2GSsTlsd5
 JcL4HHrQlbi7hPU0bOBrVhg6aqzs4AVLryuMupJh/jANXusJTmitSywQOseIB6RNjkqfN/cpU
 5QfY6neYXitoeFK5GCSmY8Y0jwXGhrkG5UFrLOHDos4cL+RSbXD4TLlDD/KXezoZptdCcu+/c
 16KV/KuVUk1XddaWp316sr948lr7Go6+SBWBvViFXeFs+CniCUvUrEok8POIRnFfCYu98IVsq
 4pUY4lK8GVJnxk4ETkwU4dD4I8snTLRQHSLk/XO+2ZqIYjly1PjDq0QMAmUWYdQgXV45qW+Lx
 RPlYjzDQrniP9V3benoEsbtX1ypa0BuCcKU3rVSpnd8LVzPiO/SLBKU9mTahvf3oh1bU+XGLh
 2cS7jqE3A3FDwulnFOUPxVrbqpWsCSKHxkoNWlv8P6iSz1CEZ7q1zyuR3lEfXTnqCl5Xj1OXS
 PKAsC165Y4cV984U+q2w==
X-Spam-Status: No, score=-99.6 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 01 Jul 2020 07:27:57 -0000

On Jun 30 20:12, Takashi Yano via Cygwin-patches wrote:
> - If vim is started from WSL (Ubuntu) which is executed in pseudo
>   console in mintty, shift key and ctrl key do not work. Though
>   this issue is similar to the issue resolved by commit
>   4527541ec66af8d82bb9dba5d25afdf489d71271, that commit is not
>   effective for this issue. This patch fixes the issue by discarding
>   "CSI > Pm m" in fhandler_pty_master::pty_master_fwd_thread().
> ---
>  winsup/cygwin/fhandler_tty.cc | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Pushed.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
