Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id 08CB73858D28
 for <cygwin-patches@cygwin.com>; Tue,  7 Dec 2021 14:23:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 08CB73858D28
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MwxNF-1meSER2VpL-00yQLP for <cygwin-patches@cygwin.com>; Tue, 07 Dec 2021
 15:23:16 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C300CA80920; Tue,  7 Dec 2021 15:23:15 +0100 (CET)
Date: Tue, 7 Dec 2021 15:23:15 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: clipboard: Fix a bug in read().
Message-ID: <Ya9uU1JP8stQOB/l@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20211207140006.912-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211207140006.912-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:INLoceiXY+5IVbO4pVXHDu9L1312fSajq3DMLrmzI51dTaDEKCy
 4xYx+mzmJl/9gu4L90aQAp6hpEvdZJsQQzu830c8tC2vti/4ppdehAWgRCxs8fxZNinPGSO
 g+fFMz6gn55RPkSB7Id/6hilOH64sHDbdh3kbC0X2vtxzGj1kZGM1rHN1d4+ghe+zi8kbhZ
 meCBwkOkuMkupc8j94YvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EeGvL0BOvCc=:cSc19GuDE1wGEvmSZ193Cr
 KG2Sz0JOmsLkMmJXPYugt2yD47hmG19ofANuq4wWRWMh9qE+ixrRcKkqog7rb8ljmMn4P9whP
 gzb1R/XJ44azISZX+/RwV6+vtgmx2x4fHwyL8CrOvAQskqKpa5ae+jAUdP9jzaz+li6bv/I2X
 xpewD2V8+kgM3B6SHHA3HTyLD56c0qN6ck0aXcPenFMC3pPwodCBi4h8ZugDgEIrEvFOGe2Jo
 6Kipu89PqxQNKPCTA4GYRYHsMn6xKPpmagq4Dq4cmW9p1aBLmK71kBTTaj70Hp/QWgTH25EK+
 NeWTtNpD7OjTE0Sce5TFlmNBlLg7EywPyFNcytFDK3JQoux6wtpSAA6vjHm7Z8eI3/RHh81ub
 gwtVR3A2Qz2RhagU+CLn5iTfc14qBtexaKtj7OxcYrH6DNyyQdAX32wC2HC3vDEAsOt1gX+7L
 1PZIIh1nmGVdA+pyRMtHyvAeFd4mX/NltFzeroNiISrukeW6gjj42EQlK0hYqCXEZgpCF4GaR
 UpbZL3BJGtk06DR/2gIMJPMzM8vkS8MwvMI8y3r0531GYFFlrsLgl5AxP20hj8Eiu6T65BSws
 DhFPkjjC3gZWVTmOgenZ42vXVKEMpCMKenwBxhDNPRAi9JxR+0YV7HMlcNIHurxyUm9uNDecC
 sWSYkvyBlg45q0JHUfcJQCJJLza+ftEaKtrP2s7Gwc0t7LYzmRo9stVKayHQLgBRrZBfyHmlw
 Wa5JywK8kNL6IcJr
X-Spam-Status: No, score=-105.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Tue, 07 Dec 2021 14:23:20 -0000

On Dec  7 23:00, Takashi Yano wrote:
> - Fix a bug in fhandler_dev_clipboard::read() that the second read
>   fails with 'Bad address'.
> 
> Addresses:
>   https://cygwin.com/pipermail/cygwin/2021-December/250141.html
> ---
>  winsup/cygwin/fhandler_clipboard.cc | 2 +-
>  winsup/cygwin/release/3.3.4         | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>  create mode 100644 winsup/cygwin/release/3.3.4
> 
> diff --git a/winsup/cygwin/fhandler_clipboard.cc b/winsup/cygwin/fhandler_clipboard.cc
> index 0b87dd352..ae10228a7 100644
> --- a/winsup/cygwin/fhandler_clipboard.cc
> +++ b/winsup/cygwin/fhandler_clipboard.cc
> @@ -229,7 +229,7 @@ fhandler_dev_clipboard::read (void *ptr, size_t& len)
>        if (pos < (off_t) clipbuf->cb_size)
>  	{
>  	  ret = (len > (clipbuf->cb_size - pos)) ? clipbuf->cb_size - pos : len;
> -	  memcpy (ptr, &clipbuf[1] + pos , ret);
> +	  memcpy (ptr, (char *) &clipbuf[1] + pos, ret);

I'm always cringing a bit when I see this kind of expression. Personally
I think (ptr + offset) is easier to read than &ptr[offset], but of course
that's just me.  If you agree, would it be ok to change the above to

  (char *) (clipbuf + 1)

while you're at it?  If you like the ampersand expression more, it's ok,
too, of course.  Please push.


Thanks,
Corinna
