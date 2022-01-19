Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 8A07D385780E
 for <cygwin-patches@cygwin.com>; Wed, 19 Jan 2022 07:55:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 8A07D385780E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M8QNs-1nEVez1EG0-004XFv for <cygwin-patches@cygwin.com>; Wed, 19 Jan 2022
 08:55:37 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 7B241A80D5F; Wed, 19 Jan 2022 08:55:36 +0100 (CET)
Date: Wed, 19 Jan 2022 08:55:36 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: resolver: A few fixes for cygwin_query(), part 2
Message-ID: <YefD+DEki2DpBx2+@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220119000755.1324-1-lavr@ncbi.nlm.nih.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220119000755.1324-1-lavr@ncbi.nlm.nih.gov>
X-Provags-ID: V03:K1:6dtKnaacBJDc+rQiwG/OqXj/b1j7Wrgu/XmLpvB5sDS777b/e0j
 r9bW9nDCvr6Dd944toUoCtCYGSUezA1Mdwe9OFUd/3S7LX5BueO3RG4RyJHaEnbNq38GRYg
 OXe1T6qawxXQ/s596idBd3HLQ6Utg2Fy3dOH7fLHZp/0V0OvzNBNX0JIzoRj0Jb7s8yKw1o
 LjnsEfRnlYaDAVwbrqoXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CQUjrdHkI5o=:LQZFppdLZVfuR2PwIAxgPf
 K3Dym6FeUzVFQCMx5qGJ+He76hDzbA258NDLgPqxKFytxavEK46vVS9opRbyB+9WxH0jmB3DV
 OpYzGUr6g1l4xxh6rCgBu1z1S10e76xuR+hYsh5R4Yzv0ZYeTZnBLp6PHmT/1OSPT0M5d37yH
 Gjl6M5WHf69f2L3hKkicwqG9tuCqB+Fg118AIYZyYw23nRvVaXNnI01+qwcVNnxCZENdUAqWD
 rFEuPtr6bzzd9qfjC5ZOP5ucNBTfAtO3Eaquk7QFyd7oAhdzf8zDn53vvnlJjmcT1bH4LDYCx
 0auJMhgsMHa73dRL/aUxD3C2KPsKDC9zx0wVHX25A1Ob5zhzCQ2B/Abt9pWAlXEhSp5VS16iL
 vPU2Pd5Jb3TDQVdtr9U8KnETp7BKIPrqUE9xWbPbsb2Nl/NakeqaYm+7tkggGcsXctGd2F9A0
 7iEfaHBONXuy8b6d3zv4JzwFeaeRttKY/EYw7T33v8ooc00/cP35Qg8MbYe0XeZZzOK5R/QdF
 xVj2y2wa+boEHm5Q+710i711aCDHWfiz5CYvQJycG53AW4+gl47YkIez09hhDvDQD7m67YSTu
 GN4vET9U7Lv4gblK6qSTFHDOECMd8f94UoMOsHUrHsTH7zkjkxPR/yhTisjWrfq0DKQmFtncJ
 V1S2PVdvRkhR6BPddwTqwe2kaPUuuOrgh8R1k0UaYMu6m+3S9QafQ45VDhQ6QF6nxnXs64Ygs
 ijMjU2E0IDywp4ux
X-Spam-Status: No, score=-96.6 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, KAM_NUMSUBJECT,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H5, RCVD_IN_MSPIKE_WL, SPF_FAIL,
 SPF_HELO_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Wed, 19 Jan 2022 07:55:40 -0000

On Jan 18 19:07, Anton Lavrentiev via Cygwin-patches wrote:
> Make sure Windows ResultSet is free'd when dn_comp failed internally
> ---
>  winsup/cygwin/libc/minires-os-if.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Great, thanks!  I pushed all your resolver patches.


Corinna
