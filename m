Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 6CD92385E83D
 for <cygwin-patches@cygwin.com>; Tue,  6 Jul 2021 14:06:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 6CD92385E83D
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MFbBO-1ly0pe09Co-00HBO3 for <cygwin-patches@cygwin.com>; Tue, 06 Jul 2021
 16:06:04 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 0B9AAA80D68; Tue,  6 Jul 2021 16:06:03 +0200 (CEST)
Date: Tue, 6 Jul 2021 16:06:03 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: console: Fix garbled input for non-ASCII chars.
Message-ID: <YORjSxjvw7ZlW12d@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210624034058.663-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210624034058.663-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:hF24/l/SX8Rp+dLd8/sdmGjQslheCBrU0BgA38d+Kkb5+KkDKVs
 k+xhQgc3V3gT/VzpIApCyIpgAEFBY7dOEhCTErWVr6VKNfkTuh9+9krXpYAAt+aH3/2vQo7
 /THmFQ9wMxExW2QRnr+JPZb+nO09lu6VKFk73OSK4YjmLcgMukNVPqdeVSwTwPNEqqQ9TzF
 Oz9BR01g/M8+mwbZUIjtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/GBAv/rbd4s=:WEbrKP9UccoWMdTWLsu1MT
 uKxPyim6q63+Al8omTN6JtK+Zqwd5S67zn6yoSzaaVqW97mtHvAWXVp6SOV4pr79ABcYW4y7b
 eOkoEA/LWCvw/W1PevN7ko2K/Aty39dh2xt8AJfi3SwxC+UKnYQdx5gv/kcn6jE2LvzAe0m2g
 biguZJ1A1+MK0tTwKeatcbmTRx0AbEtm9HIhDy0t0j4FKgnEtmD+3rEpeJBxPlXnygHI/zN0Q
 FdK0n9x2Eajb3peCKbIor0mxU9RXdXedqhOAGpe66cgYSV/ZL05ifAza3dK+++2XS5Jpu7IeB
 DmdAltI8XbU3fBJ7Q8zPsPSpaS/oUem8sbF/mbzz0pIp+Un815DLUSiL5WOa/qOsXk+SMgKDu
 52a0FgTukIDEtczTJXmEzDyWuTbHjkSU5OJYapuFwk1GcBkWt2SWIwul79CfYdCxzeeqS+Hlv
 ATHPk2tHnW2XN1XES77KmAMqx7dBEk9dZ2f4KrCj2hXs/QmwSmpcxtFt+IsKrUpXr4m0H14in
 MWNDEUI6jwsRmFgk8Pm64Pa7cFXzYqu0Ej9fh/Cqcs8UPnaETI+X48f+G7kCtL+6CvQQAfsU/
 +52JFlXNXqzzmvc+ME+Gs8EXwX3/bucEiaTPib7ONteusr6JnJNCu7YtYFLTRBsESDN/69zCA
 WJR0TZz2xdi7FuscNuLig2yssUAFwZdYADs6NSf8nQWkUzqMMflbmhVUKTsU8cLjFYKh0fQpu
 W5wnxxanI+vbf6UWKn2OzHhTCc4jK4nQr2dsfT8/P7NJPlLoxx2L8l76W7W3uXZmeDiuZ/QYL
 6GLBMIrTq4aEv3civB2OocLmDrdN+9p7JiH/kKKZiyjkq7joWZ0J1CvdZTuhj8lW7xC29mWJL
 Kbzqp54xJZeH1n5BLvfQ==
X-Spam-Status: No, score=-100.1 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Tue, 06 Jul 2021 14:06:07 -0000

On Jun 24 12:40, Takashi Yano wrote:
> - After the commit ff4440fc, non-ASCII input may sometimes be garbled.
>   This patch fixes the issue.
> 
>   Addresses: https://cygwin.com/pipermail/cygwin/2021-June/248775.html
> ---
>  winsup/cygwin/fhandler_console.cc | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Pushed.  Apologies for applying the v1 first, accidentally!


Thanks,
Corinna
