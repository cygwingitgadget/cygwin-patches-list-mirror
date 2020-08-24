Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id 2B7833860C3A
 for <cygwin-patches@cygwin.com>; Mon, 24 Aug 2020 09:07:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2B7833860C3A
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N5W0q-1kgZZu3HFi-016w4I for <cygwin-patches@cygwin.com>; Mon, 24 Aug 2020
 11:07:32 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 1CD5FA81007; Mon, 24 Aug 2020 11:07:31 +0200 (CEST)
Date: Mon, 24 Aug 2020 11:07:31 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: cwdstuff::get: clean up debug_printf output
Message-ID: <20200824090731.GY3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200823225103.22835-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200823225103.22835-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:m4U/1Vv9Zyek70XQzsT6487lZH/ye1Z9d0VltxJN9y3r1iBsV/S
 zPWk38olGtJdnnFJNIXKl8oeVd3MxClCCJyiw8TGWxVGAefJddBjYZwyornPLYaHyQJBaIx
 joogwwS0gXYyub6nIk9/onpWLXkVlp9zuLcFJ9zJNQne78gpU/esVP0xgU9la/wtHWAKA8v
 Ooz82Vt184PQWIEjaWAGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pizdJ/V3WfQ=:Bl5l4FxC5pZv1qAQre6//8
 Q0yHN/fkdoNqSA+xDtE7j80IR5OdzrlkJ7WcIskiJ4iF5LvftKept/aLuD/9L/j9J5v0FHaND
 argBT5mm30S8/hcvrWeChi/0VTGDHhukV3kfTKDf1aCw6/glfF/fDmnWbsBwhTR1o0xxxyzZR
 xKjwiyLp4QFA+NL0OE8ivRJPxtq58P6aoSKzJyhgLesdmwLoHBqyYLbUpan1wUqDQCa6Q84te
 TQgT0BmSabHUSzbUlXY8pdQmNYEZnnxhVTMrhXgHk/aN8uoi8qRmzZMljMPbC8wmqJf4kkNJ6
 DY7pCfHVqAU4RE0AKGd/87gu1X/u2nQKBLo9CLmqWKw2eiEIpnntjFhDjBorYXJNikIqajs88
 S3i/n1D4ItbfCV7IuXcTKrdGt2XsG+Cr06pX1itPHD1ptkQihWW0Z6qRmZ0kNu5oaaAu/igYJ
 p/5zC7qkBOOLGm465zuWxoOdJTQqhf6hz+QubKUBIq/AuWtoPyI8rvuk93DhKcTF8Dh8AoMuE
 ycjhPwXNWUoWJKACn4cazjrcJyBvrdY2W8lPjCQ6hlqG1z4eLcq9dRVzSgGMsW9MC5IRaG0zI
 +Bvpq2+g/EJeCrnqtnB5mZCAcuNFhzXbsAMAXo9eEtc3QKycEx8l40WG/TwNDlx/h9p9wn5vJ
 ed4n47euTHTsMwm0xLnKkLMqjaUo29ZC0JgS6VYcowK1qz8k6Css38dbQPsUdQl4fzYYc/pcQ
 6cMk7Q+7zy4MMIds7ddpYvcZgvopNjNyttbZZTh/Fw8KBcOLcoXoCNkPucbBg5dzFLjIlgDLt
 ZcaA8+OuOcHum99Lo++AgEtH9f+du4ghzYR/isQR3CUSRrEANiU8ITBzVPY81CNmKVc9oY033
 mS/ucFzXCd+PkJwsA+FQ==
X-Spam-Status: No, score=-104.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 24 Aug 2020 09:07:37 -0000

On Aug 23 18:51, Ken Brown via Cygwin-patches wrote:
> Set errno = 0 at the beginning so that the debug_printf call at the
> end doesn't report a nonzero errno left over from some other function
> call.
> ---
>  winsup/cygwin/path.cc | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> index f3b9913bd..95faf8ca7 100644
> --- a/winsup/cygwin/path.cc
> +++ b/winsup/cygwin/path.cc
> @@ -5022,6 +5022,8 @@ char *
>  cwdstuff::get (char *buf, int need_posix, int with_chroot, unsigned ulen)
>  {
>    tmp_pathbuf tp;
> +
> +  errno = 0;
>    if (ulen)
>      /* nothing */;
>    else if (buf == NULL)
> -- 
> 2.28.0

Please push.


Thanks,
Corinna
