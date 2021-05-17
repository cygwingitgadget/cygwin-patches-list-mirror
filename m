Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id 51F003835822
 for <cygwin-patches@cygwin.com>; Mon, 17 May 2021 10:54:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 51F003835822
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MXXZf-1lynE11Ujf-00Z304; Mon, 17 May 2021 12:54:30 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 97D75A80EF3; Mon, 17 May 2021 12:54:28 +0200 (CEST)
Date: Mon, 17 May 2021 12:54:28 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Jeremy Drake <cygwin@jdrake.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add support for high-entropy-va flag to peflags.
Message-ID: <YKJLZE/QFQotdkQw@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Jeremy Drake <cygwin@jdrake.com>, cygwin-patches@cygwin.com
References: <alpine.WNT.2.22.394.2105151214260.7536@persephone>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.WNT.2.22.394.2105151214260.7536@persephone>
X-Provags-ID: V03:K1:bXbjSezUqG3zKSmQ6JcQSqR9IyHDPyvPrTqKutx6S0te7kwW0zH
 PzsBDGXIxh0pHrtbhdQmqfBOwRy4OyW2eoVGwwj6CYF9cL6shOG+U5ral8dg3RWD6+NfqcU
 gVWke8qaMRikiPE1a7TmsXXcJA2Lh6ZxPDQsSqbLEVbm2dDJZx4HXYwNMVYb5nK/qY4Ycsj
 iz+CtTZk3q6AcGRdiMQfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LnjXRfmovOI=:SD3QSyW24IE7g8paW7p5IA
 QxUWwpwGOYOJMPvRokaix6dXA9f+7zDiRcElwAwHZtjcNbuK5tUdL5jE2uPkw6oiWjijya7pr
 /93USfaqaz1eHj0/RUzcwpujTngghmTWsr2xxklOUdtFLRpx6gh3JMNQHbl0LfFSWFWAkGdA0
 pAeP/CrdheA5AI15SXIugoFRkVQLTUxVBnYDtJa9kLCDrDU03J1AQ773fmlO+j9n6gg9fYjFS
 MIYGh+0C/6KgsTB7EUt28G82X21cBxMaIs9sN1QBy6JpsHe8Ax31hMQSo8lGVj4s/bLy9rIQ/
 r1zdazYLN/1+f21+WBcwWYwC+bdGZG0UKbz2r4Sxj8IwiBF/M0vz/+VhmapBeE3TPi0/c8+TV
 pnQbY2MIHZEgcvo7Wexrybz2VjfnChqH8ydBHzNrSyTDMUAd44EWjpXspnFbYF21WxvT8A0Kc
 qBBTsy+4mVN/ujzH/AoBp+CZLJF9hMQdeG2BdoMmDSlIRBhOzxHfzN1SjSWhvvXzRhXPjlg+x
 v5eha3QqkNnKU7FACFldWQ=
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 17 May 2021 10:54:35 -0000

Hi Jeremy,

On May 15 12:17, Jeremy Drake via Cygwin-patches wrote:
> This allows for setting, clearing, and displaying the value of the "high
> entropy va" dll characteristics flag.
> 
> Signed-off-by: Jeremy Drake <github@jdrake.com>
> ---
> I'm not sure this is the right list for this...

It's not, but given the low traffic, never mind that for this patch.

Thanks for the patch, but I have two nits:

- The patch doesn't apply cleanly with `git am'.  Please check again.

- I would prefer a massively reduced patch size, by *not* changing
  indentation on otherwise unaffected lines.

  I.e., ignore the problem here:

       {"dynamicbase",  optional_argument, NULL, 'd'},
    +  {"high-entropy-va", optional_argument, NULL, 'e'},

  ...and just add 

     "  -d, --dynamicbase  [BOOL]   Image base address may be relocated using\n"
    +"  -e,
    +   --high-entropy-va  [BOOL]   Image is compatible with 64-bit address space\n"
    +"                              layout randomization (ASLR).\n"

With that change I'll apply it and release a new version of rebase soon.

Oh and, btw., there's some problem with DMARC munging with your email
address.  Would you mind to attach the git patch instead of inlining
it?  I won't accidentally forget to fix your email address in the log
message then :-P


Thanks,
Corinna
