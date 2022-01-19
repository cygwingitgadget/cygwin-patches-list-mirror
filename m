Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 960EB3857817
 for <cygwin-patches@cygwin.com>; Wed, 19 Jan 2022 07:56:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 960EB3857817
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MtO4E-1mJeC30gsI-00urOg for <cygwin-patches@cygwin.com>; Wed, 19 Jan 2022
 08:56:13 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 8A0F3A80D5F; Wed, 19 Jan 2022 08:56:12 +0100 (CET)
Date: Wed, 19 Jan 2022 08:56:12 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Fix configure help for --{en, dis}able-doc option.
Message-ID: <YefEHMSMkvUcLR5q@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220118195705.34031-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220118195705.34031-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:9EMMpfpoWGuv045ruz5Cb01aDOY7rCMMlhikWER8vnuR71KIBEK
 NqxeukR1yrSazmOu6tO/hIr2o7zYyBogrW2KwVcrT2raYdkArMkEQw4rKUuboYN+SN9LIGt
 2vig9HlmtnYzEEa34e90XY+44tF0yNlqbtqibRdUqcF6J8SgJ2bs2gLrUhGrrn+2wP1bOlk
 4Rf6iE6exJa9i/N1LhHIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VnH7eAvPavQ=:lsRZwCrKmmm2B4mMIYtyTQ
 QrjXSv4sllv/GiDbKEyDn/j/Fk/T/hXXax+uSp81NxfOQt3OOYQ+nidsbR10IG3NtlSUGNHzD
 raaTO6uCOTdkkzKD9fhE2g7w7WnbBKZXlosJJSZIV4KTgk9umjKXp3+qQkaRTTMOR8HitKaFx
 RK2goOBhF3qrGQdg3mtKw6OmZi2R7kXjFlNqfgjiGZ5rWBZevijGWi8T7EUzWO1o3TTiPC+F4
 +YTMlR4Mjm2aZSThpfsgzMgjQrrSLY8een6Qr94RAK+WUyr3J1pTZMOm1rP3CwysRzCb+yhGJ
 snf4trh9taUVv7sTHWJrsbRlKzERwMmrLwXFS1bdx0pPblAW/xkimnsfHAlVF5c79wzkHRZLm
 ucZ3Fjdg/9p8CeRvAleMVwETDieio++Q/3WdFgRsDqTnlt0lvbePNvb+NSP6YCJmOM7qK4Q98
 IMVEbf5MTbqA52qvYguDz14mjGhrIgKwJgJcorw109orRCJqSQzzo+ksR2GG5rigvoQgB08XF
 uZx96Q4QRXFqoqC4LXt9NkV/JCOyDFzg+onBWkjmKPax/NrJdZ1W0d3mSBXDo6Wbmd4gooEvW
 Q4SVqUusNQavSn5UNYdMg0KzP8cjnCmH/zxcwVpl/AWenNfjYkdBhsXwh1wu3nfv6xo6SnQbQ
 oj2KiWkvoH9fRth7yfQ59MUMsvNw85aMS5PhTW6H6CinlwuzgKCm6EqLb6rYiqhBcqq8RS6bs
 90Iepb1pg/ynAxeQ
X-Spam-Status: No, score=-96.9 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE,
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
X-List-Received-Date: Wed, 19 Jan 2022 07:56:19 -0000

On Jan 18 19:57, Jon Turney wrote:
> Report '--disable-doc' in 'configure --help', as enable is the default.
> ---
>  winsup/configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Sure.


Thanks,
Corinna
