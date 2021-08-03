Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id B21A6385AC30
 for <cygwin-patches@cygwin.com>; Tue,  3 Aug 2021 08:07:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B21A6385AC30
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MpD39-1mwl7B0gCl-00qmVD for <cygwin-patches@cygwin.com>; Tue, 03 Aug 2021
 10:07:18 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C2429A80D90; Tue,  3 Aug 2021 10:07:17 +0200 (CEST)
Date: Tue, 3 Aug 2021 10:07:17 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: More profiler format + small issue fixes
Message-ID: <YQj5Na4vtJ8xVNcR@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210802065231.1011-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210802065231.1011-1-mark@maxrnd.com>
X-Provags-ID: V03:K1:xOJiW6CWfg5/kUO0VFg+N50uiOwxtiYzMYMCghRvCPQH36FizlW
 Pu6hjpUf8pfQgUgUsn20T87jQEnAbUgILCp0nE24FtvTYgoCtHJlozxE4tw8TNduBYZtH+s
 PJUF0msZqNHcW54A0ffAtec6pgVcE5h53AdhpvwhGtTxkQXE3dELsY9+41Dav02Pa88pO8j
 7Gs+L245siCSdm8VLtFpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X+BZL9fwJlU=:mmIF+etQu9VQEPUmaP/lq2
 zmREXhP2wVzM1v4yN7jdO2JpZp0nUufn9RkyGS/+Aqk1zwF49dFoE0uedcZeHqtpX+juMf4KQ
 TadLgE/jZHWvZrenkreBTeqL5YUrentujQRy6GdZ4jXuWU44nCu5ZFzvWk2EeC86e25ihzxSr
 kqI5j7GLevqP6tV8njZuHXVlSFvQQUmUd3QV6F0pSfEMbToW+tWmMTwcosXTDMwDlarrFSlxd
 7amG99I2pwfxZSZTgDHB4ZxrNgkEQQJ9YX9Drk3lZZxKR6zNHMRKSl3pkBUeJcRFvQlnGOnNF
 4bUk6kyg61O3W+VLkJbF37igsIX9VfxIcNgBahJyfKnCfjsptGYeKH3IceSUhwS9IVzIPYJdA
 o7c50AV6garFzK9QUB7frtYhq2KOXKTT9IbOGd/aemyw41FREs1SbhpSGr4rS4BksScWV3YmQ
 tQbPa8nwUARGdI63sUPx0mmTzrjSuV911t5LpqMaMkZS4AFZxTU+NgyKL+FuxFrk3ghlQlQjq
 iLw9w25lcdSj63hQvzy9LQn9X4nJt7PnTeAHshl8pVrp+5qpScMYrqO/m9WCHk8Em6fmwNqg0
 4UbLrqnzRcmjcL2gjJPlaaXLgjx2vWcc7cTO4ASeMbkL2E+IEINh+uscXg3CXXQTOigd4cnFH
 Sl9SvGeTJhQCRyPemzjzFq/RWvWofMVeP1DCW4V6xvoyyEb7gjyE4ybBd3ABVZD6Ujn9RCWMR
 9tLam7jgo7ZvPHOOBMc5yzGEcQ1JEbtmGXuRorRd2lvTU4+afngLWA6TUHZlbRXG7JHshXT8+
 0zSdH4OsT6tb5FR0KN2zFVABMJOa00OFhOWbSuDQ8qysAwAsHc+ZoKRZsUS3TQx5zTg4G9pwi
 TOX+FB1wtfhImT4eTBAg==
X-Spam-Status: No, score=-100.0 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Tue, 03 Aug 2021 08:07:23 -0000

On Aug  1 23:52, Mark Geisert wrote:
> Make sure to cast to ulong all DWORD values displayed with format "%lu".
> More instances are fixed here than in either my earlier unused patch or
> Corinna's patch. I decided to use typedef..ulong for more compact code.
> 
> Address jturney's reported small issues:
> - Remove explicit external ref for cygwin_internal() as it is already
>   provided by <sys/cygwin.h>.
> - Leave intact ref for cygwin_dll_path[] as it is required by function(s)
>   in path.cc that profiler uses. Added comment to that effect.
> - Delete existing main() wrapper. Rename main2() to main(). This because
>   profiler is now a Cygwin program and doesn't need to dynamically load
>   cygwin1.dll.
> - Documentation issues will be addressed in a separate xml patch.
> 
> (I would have linked message-ids of Corinna's and Jon's messages for
> proper theading but I no longer have their original emails and the mail
> archives don't show msgids any more.)
> 
> ---
>  winsup/utils/profiler.cc | 60 ++++++++++++++--------------------------
>  1 file changed, 20 insertions(+), 40 deletions(-)

Pushed.


Thanks,
Corinna
