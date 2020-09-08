Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id 3DE62385783A
 for <cygwin-patches@cygwin.com>; Tue,  8 Sep 2020 18:42:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3DE62385783A
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M1ZQT-1kH6YW3T2p-0038Dd for <cygwin-patches@cygwin.com>; Tue, 08 Sep 2020
 20:42:47 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 57093A83A8D; Tue,  8 Sep 2020 20:42:47 +0200 (CEST)
Date: Tue, 8 Sep 2020 20:42:47 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix input charset for non-cygwin apps with
 disable_pcon.
Message-ID: <20200908184247.GQ4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200908095757.2042-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908095757.2042-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:hbszBDeO3g3vg3R8i7R++0Hswi1pZlvVywaSPsRk3UjiyOZDhsl
 4MYa7yynpU4ZA5AiOw/sS5jrhC+bEoSrOTgEs9ZqPz2vooLWZNFnaOweRehheBOxIgbTp94
 ARBPf+lE3i/caRIXZd0A/twK9dCJQfVS4p7SqFl1kui1yPC7GlewND0uNhtWn+T7+SuI398
 anEMQbxZV3J8GOXWJnGvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3gEnURn6Siw=:2Y0JruHa/ifvVXOWlY4pse
 5lfVfRCIzmIkWMFD4KEnuUp86A4mwIe68H1H/ye4AD53Qrc0c+pcRyos+iW3VADBGHQEHLjny
 YXFrSSLXfXcMbVArDgORpuDpaAhbvSMp3V+wP2hs+xPXDwibdC3rTWR2mF8mSt5xlEHL/sauB
 tQNv+otCr5ajmUSL06o8KfBZeuFMTyP2+hwrXTLCI4n6Q4Q6z/ypLsuD8LwbFH2Gbio2Q/irI
 m4xfc60if3HVWyu1K/SkF/k6ftkt5iwauQ34EhzB0bBDvyIYqPxilzJoLiCSO3RKCU7Xr7DbI
 QnvGY+lnW/p238NfarwYC34UM04uYiiGcCnVppYrO3sktsyT7QRbSKCVi0GR00fNuTqSLH9Iy
 t23eCuIbX6yBdD/reHOg/MXO6fExs4AkpC+LkyaRptsoDXbiMrwEVr3QwIisf2YzdB8O5N3WT
 KQaEWbre4ypE3UEIUvDg4ExkTSjxM+voHn8NAzf/5GNdALe1M4IUzLZCrJnEAfyInsm7cmkL1
 0DoQob0Br4jRw+icnexiALvfNGX9fdMBL5b+OpB7POdPDwWjIT250kBV7JqzlG2syPRgQeUlv
 xmO2hbdtR4rWP79lLJmr1QMhfvNjE6c1suKUaLQi7bsjfvlQncJjkoOj9iYzuS8YOUkLbJQwE
 L0aydWKu69uVbgg9yrvaqOUcENlpPFL7JxK5K8zJDD4iW/+OYCwwX1CtWEb1yT6Vqr/6lPHNx
 1xjTGNqTt0wjlgP1umdCDSIRUIPttSlNK3TlR2gBOfWZ29yaaFxZ9pmNE0BxSVq/9y7XeydsK
 nHpzoKXMAnPaSWLnkg/zXyCkZmO6UMz/bW9sigstyu68cAlrfp0lcjhHAerU4HFRfhQHFiEwb
 Q0ncMqR8hWfAmHmBD3hA==
X-Spam-Status: No, score=-105.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 08 Sep 2020 18:42:50 -0000

Hi Takashi,

On Sep  8 18:57, Takashi Yano via Cygwin-patches wrote:
> - If the non-cygwin apps is executed under pseudo console disabled,
>   multibyte input for the apps are garbled. This patch fixes the
>   issue.
> ---
>  winsup/cygwin/fhandler_tty.cc | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 6de591d9b..afaa4546e 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -271,8 +271,17 @@ fhandler_pty_master::accept_input ()
>    bytes_left = eat_readahead (-1);
>  
>    HANDLE write_to = get_output_handle ();
> +  char *buf = NULL;
>    if (to_be_read_from_pcon ())
> -    write_to = to_slave;
> +    {
> +      write_to = to_slave;
> +      size_t nlen;
> +      buf = convert_mb_str (GetConsoleCP (), &nlen,
> +			    get_ttyp ()->term_code_page,
> +			    (const char *) p, bytes_left);
> +      p = buf;
> +      bytes_left = nlen;
> +    }

How big are chances that the string in p is larger than 32767 chars?

I'd like to see convert_mb_str use a tmp_pathbuf buffer instead of
calling HeapAlloc/HeapFree every time.  That also drops the mb_str_free
entirely.

Isn't there a problem anyway with calling convert_mb_str?  Consider
a write call which stops in the middle of a multibyte char, the
second half only sent with the next write call.  convert_mb_str
only allows to convert complete multibyte chars, and the caller does
not keep something like an mbstate_t around, which would allow
continuation of split multibyte chars.


Corinna
