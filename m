Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id C83DA3894E59
 for <cygwin-patches@cygwin.com>; Tue, 19 May 2020 09:51:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C83DA3894E59
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MBDrM-1jmUAF31ws-00CeMe for <cygwin-patches@cygwin.com>; Tue, 19 May 2020
 11:51:09 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 2DBDEA80F7E; Tue, 19 May 2020 11:51:07 +0200 (CEST)
Date: Tue, 19 May 2020 11:51:07 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] libc: Replace i386/sys/fenv.h symlink with an #include
 shim
Message-ID: <20200519095107.GR3947@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200516144257.00003284@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200516144257.00003284@gmail.com>
X-Provags-ID: V03:K1:bN65q+HlN34lGsSphKoEvo/4vsjbtFJ2f458OSBWaKmaCV4b8lh
 OXP4oa3glPuuiLszY79Yn8v0/WTDxo8f4YO6QUoHU+WetkZul5MhJVKpkUVD3+2lCDatzBu
 fsNoyYHrPnAB6N7s0aBzoVeBm252kvNg3Ei0Zy/pWcR2xqpAhxNyDu3NNJ8p2zhxdtMSCBo
 jLVY8gdfQFmTWlzDLPjqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LRwb7Qmyz/c=:AqwkdkLUQJQ38v6U59Wesm
 YH1rY9UysweseOkmh91h0QLkJMflDTJn+9tKnBNQORpVdMD2nIIyeY29FCgcpheM3OoCkjrmE
 L+VWl98qXFpby0ya2gir6ojurxbwPhgWRQHn6UyQvQPMAbqjhSNVWRFr28QJw2tUL8aREjF7g
 V4IDKuR70zihBFMToyqkfDjDh/N1QaAoJcyH5/r8hzVBrzr2AzrqXQ2lg5bVwVZCOIQUNy/Px
 ti3QVOkwFjaLZlldvXKfJeZY6lrxuupzOUHTmu7tW7NP/iBNNSnzZ4EQEC/FTjZs/t54kkdKk
 S7A8UAE56jd+HP+Wnb1wfhmKQJYrRTuIZ8DluHkgnI8RHeYyiiV/x6ggdqahKv485djWYXMZE
 7nt4fX8FCYa1xZ40i4JpymcjW/qKHQ2r+17f50cyRHw3YSwsCqg7aHj5pVnra2FJzqSezXdmg
 hBctSKAigt+Ji3z7/PB0PtFZpzaNjwFov6n9kx0lC6fohNip+Ll2B5uGuly1bI5YlNN9/C8K1
 nohaOlELLCEVMEqPaLG+EE6/8qEb31BhAqOaGp5grfKmMSyel/OvTWxLxWfH1GwKkcx0fw7uZ
 rdTx1cJLwQqwmVfXK3L9A5QZPd2CCnVpiPTfn14GTTe5Gn2+A8KI8ep1VN7V6R2ACqNiHZFu6
 EX96CFYNzr0xNj90fRX9si2fh3RB98AosXsw/J99slFYR91xizdRfZ5mjjAgUMVYwu7RAUGIr
 q0nc3n/HLUL/RHJt8tdV6H92RG1j0QPhSMvAr6dEtFwHkwmc1YMw0f+oJZRGG+UN0GoFrec4z
 PMH/NxEcxVosAYn/Bh5315VAJifmO++NEb2vZyQ71mjMXp0oQkOGgxQEa8hyUG8lmfu7mSO
X-Spam-Status: No, score=-98.0 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Tue, 19 May 2020 09:51:12 -0000

On May 16 14:43, David Macek via Cygwin-patches wrote:
> Same reasoning as fbaa0967.

This patch should go to the newlib mailing list, not here.  Please add a
bit more context than just the SHA-1 in the commit message and ideally
plewase CC Joel Sherrill, the author of the original patch.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
