Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	by sourceware.org (Postfix) with ESMTPS id 0AD323858D38
	for <cygwin-patches@cygwin.com>; Sat, 29 Oct 2022 08:34:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 0AD323858D38
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MxEcg-1ozW4H46em-00xaIr; Sat, 29 Oct 2022 10:34:02 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E8380A80A3C; Sat, 29 Oct 2022 10:34:00 +0200 (CEST)
Date: Sat, 29 Oct 2022 10:34:00 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] Stackdump improvements
Message-ID: <Y1zleJNr1nz65QoE@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Jon Turney <jon.turney@dronecode.org.uk>,
	cygwin-patches@cygwin.com
References: <20221028150558.2300-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221028150558.2300-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:1YQ6VM4SReK213eypRPCORNwuiu4+7ETgdpKe1IGWkDtOylDUj3
 Cus6shOZPaBtRpDUJhQsZqNY8bEPGucj2H+EmwKdg43Zc92HL76Gx6k3bS9Vakr4jFnuBfR
 0qkaCdME34oLldQ6jnqOIKE0af0x/6caci/dfZzR1GkvSADGXfOhFaXBXex/lmW1Ee3rG1b
 FbCjiHycL0Ge4n/E6JgaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:acq8Ci0stX0=:Uf3t4cmHqqv4yfz7DE5qKM
 4dGGFwFJjZu7LQIKSLgAPAgNOYKl/MkVPVII5mLa33e4XnOE8KlKNz9rstvbhsG4T8pSw2Z1p
 QgvKcC2swvILH6POqRcamlaU/zk5NYn/BJtkvEbzjcdrTPR/YdHToWdJaaAs8Ev49Jc1jNQS/
 WPD6bofBUKkR+HONl37QLeGRG/2GYlr37V6W8+oJhfuRTdiEk6oKIeR30H2OZT1pHiDjvKZ6c
 XXzxK8ry5/4dtqwP0fmKbGXskxcIHQa3oLZ6zrxsbxlKgsN9AYHPo0TMBe/Cqt3XHOgRwEIbd
 w3dqDU1wUnmPGAfw1PX0X9NvHLk+PSo54oDGD/R6FfcyTX/+YjVhFHQ3GpKyX/Rke1p5a6OnK
 tyNF6tQB+mKzo9VkQtU+XWoXJbm8sFkiPdXS8YN0yWAz7mnNHV7umECLxx+MbJ/IJDR2OIRqo
 AeL39k6hAiacJOrqoCFnqeDnb+nz6Kw5nQYs4g7eaaUrTOHsdN6cnrckJP5Eol51fV7W3BMV1
 QU2RJiT8wX/S5/x5R8jInbUbI+iHmvn4U/g5OJ9Fe8yd+a0VyasuDmjosNAMpCzTM9x+gwE0V
 HgtTL82h6h8FNXTaudHIugBObzmhuOyh2P7nSxau4Bs1tnr5KG4Sp8iwck5lZrq0uA8yu8hWg
 Eupf4dfjXRPs49P+ihbtgLsIZcy4CkDdKc2PvXmIkmo0q+39P7/LkY+NLdtvLszUiuLTj1XQt
 Yvq6g7rqmlpyFzU21xv8jY/1BOd5L+qXjaAZ65DWMcD5gJp5Isn49qk0lq5cQWmwnXKuGM/2Z
 8sPL0Hfae27PVQAhVi197TJ7u3t7Q==
X-Spam-Status: No, score=-95.7 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Oct 28 16:05, Jon Turney wrote:
> Jon Turney (3):
>   Cygwin: Tidy up formatting of stackdump
>   Cygwin: Add addresses as module offsets in .stackdump file
>   Cygwin: Add loaded module base address list to stackdump
> 
>  winsup/cygwin/exceptions.cc | 46 +++++++++++++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 4 deletions(-)

Looks really good to me and will be quite helpful as soon as
ASLR is used.  Please push.


Thanks,
Corinna
