Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	by sourceware.org (Postfix) with ESMTPS id 8487E3858D39
	for <cygwin-patches@cygwin.com>; Tue, 28 Mar 2023 13:31:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8487E3858D39
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N6LMN-1qVnCP33CT-016iND; Tue, 28 Mar 2023 15:31:00 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 26D27A80BFF; Tue, 28 Mar 2023 15:31:00 +0200 (CEST)
Date: Tue, 28 Mar 2023 15:31:00 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 1/3] Allow deriving the current user's home directory
 via the HOME variable
Message-ID: <ZCLsFCguNjGi5Ga9@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Jon Turney <jon.turney@dronecode.org.uk>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	cygwin-patches@cygwin.com
References: <cover.1663761086.git.johannes.schindelin@gmx.de>
 <cover.1679991274.git.johannes.schindelin@gmx.de>
 <7a074997ea64d9f9d6dab766d1c49627e762cbed.1679991274.git.johannes.schindelin@gmx.de>
 <ZCLC1kvfb5Gdk+Cd@calimero.vinschen.de>
 <2ef9176e-9282-d0d1-b047-d8555d4434da@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ef9176e-9282-d0d1-b047-d8555d4434da@dronecode.org.uk>
X-Provags-ID: V03:K1:4C49SjqP4NIbsfjTN6ckpgvr/9Y0m8emybGVZTKmQO4fcjo99c4
 hx81kp0Hhw3CgdUiV9kVWPKK4gpgOMG3Ybtdsd45QXXTPecfsbYSE5dQHPhEkoRMby+Cmbu
 qZ58YJw1pnIv8ycsRnlPhqf2pmSredYRY+LyvCWLSA86ih1vAxIP6fOJqpmiRKGL0X93/H4
 TkmjVjRuAxVYTO+UdVntg==
UI-OutboundReport: notjunk:1;M01:P0:qWbi464i8DU=;YuBwGG5e/tDwjM52bRH/KlSaCYK
 AOExGlHWpQYwRuGitqMuXNjia3QiZcW/kSZbo0XLuXooZp/G+lQpwf3spPsud/Bv7rDVzAWUt
 Wjjefumg/1YA7ksT7blYtQ07Ofk1PR5T85FAZlGSALcEWqBWf03VMfhucgZMk0YoOA2wjU+IJ
 kcl1YbtHhSLhskr7wFHlEoDW0wI1zjLoOVA8QSzMoLR3c5d1ujIY0jrE06G0nUgU+xOz2AdDg
 /gDeLki0tfbveYpN+9rI1oGYKx44hTavbAH4S7Nhj/nj5CBS1RCJY9XanLWaXLKavTdQEl4X9
 zMQX9A8YDzsrnIWAL0ywBcbuplE8t9gvuUc9waE8O1U9TkQJshzi5YFx0EAZlnLhVa7aZhJyq
 4LxWN3MJb4dZgTuwEWixogZILX8Q/KRPD5wrcy2KtukJI0Z/JwKAJls5pGQC+Mc7HXRSdEjO/
 s47fTOztjx4xu5Oi9J/F+2eyAyD4R0voFoxkrxBlt3iay6Q+YJDg4KIHgOUHehHvJJmTEideR
 19OMCkdCXgDIHW0Es7Byyw66h8ULfnCGyTByKIDjx4r1Sj/BG/GZVKf03IA2Mh1wcaKowyMao
 hXU5tonHBoA6yfhgla6TxOK35rSYQHAejEL0vj+1psmTRQquct/SsgLkYbVeamiUaNEvglQjI
 QloRCaUjo/+iaGG8EiC5vvN6ed+z47NKAtS8tcTx5Q==
X-Spam-Status: No, score=-97.7 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mar 28 13:34, Jon Turney wrote:
> On 28/03/2023 11:35, Corinna Vinschen wrote:
> > Apart from the doc change, the patch is ok now.
> 
> The preceding text says "Four schema are predefined, two schemata are
> variable", then we add "env" to both lists? That doesn't make much sense to
> me.  Surely it's just a "predefined schema"?  In any case that text should
> be updated.

Ouch, yeah, I missed that.  Thanks for catching!


Corinna
