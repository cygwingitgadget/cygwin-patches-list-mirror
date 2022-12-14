Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	by sourceware.org (Postfix) with ESMTPS id A4B2C3886A00
	for <cygwin-patches@cygwin.com>; Wed, 14 Dec 2022 18:48:05 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MSKq0-1pTowF1qNE-00SecZ for <cygwin-patches@cygwin.com>; Wed, 14 Dec 2022
 19:48:03 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 53C7DA80B94; Wed, 14 Dec 2022 19:48:02 +0100 (CET)
Date: Wed, 14 Dec 2022 19:48:02 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Improvements in configure options for reducing
 dependencies
Message-ID: <Y5oaYrKStcPPtTaX@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20221214173040.8431-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221214173040.8431-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:fNMvSyedsNw61H6coYS86BZ0li2x2OBBrSCe76i8tsAiuHXxTRz
 jzuFqEPqx+rVS6ftZvY5Kc1lD+5i5OnTQ7QsjLrAd0xtAXQ/SvL4VripKLVmk9xFdaOnmC3
 azA4CN92RRrYmMFmtiBxG7I0RCIeSIgld/bumdqe5XVd6kSAMofOwasJ4Osd5q3SLVO6D+7
 2azJ2BIEWzFEM5t1W1Bew==
UI-OutboundReport: notjunk:1;M01:P0:uBUDrVWk2Pg=;LFZWLfeg+xuy8j4OSgtVbeGXfp+
 8mNixleAqHDNtjRtnQuROeOAe7Ib9iKP62cNrIwetWTnhqThaG8qvBMgjeXGD9d/PyiklwKHs
 4hlmB9A0KJfFW9NjgFBqNlH7izih/JSc55ZLJq9GzBirza9IzRll+C7CbeWL7jaItysA4Bcpu
 H+YGEoA3L+CWVoNc0EPpGBJA2J1l+73nTZ3XW+lCjBiv7PNLqSyCkIp02Rw/7YZnb9hGFYm9o
 llkt2YD0XdeoYmfMla8lDU5e89aW+scxHCp4Xqu1S9oJoVkS7gDsvfKIu2TUYz33vFADJgSJK
 7Ts7kTzRvkXiMfvdotFEPswImIWDVkM6QSPCtY82wZ5o8NH3XWAGwSCwEkwiUQdlFO1NUaFnj
 5yyexkase9QdEXrFnIqpAX42FKUdbHGVZe113M3uJ0EtoV0MacmoSq8FCyEFfht3laQNOik2c
 CQPk26VkUfntdHR+jBN0EN9jnmRD+m+iFO+5mCtcn0pYEC1nGIlDYEvb4Vxeh7NokpHZ+Xerl
 NNsboWzOnBScxcoEZSedEwQ529PdTlz3KewlWayhmDPB5rKRHvgpyIkt2CFWSqu8NBSlNHXrk
 iiKfENEYMHl4dFvyD0R9sF8NAiGsIz/osoueKnoHRnC6xf0yNPmgwpaMOo/r996WVQ4nIqxf6
 SUIRwlPNBw0TSOH1YaGv6NEMpWpeQcmp5R2P3l4DAQ==
X-Spam-Status: No, score=-94.3 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,KAM_LINKBAIT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Dec 14 17:30, Jon Turney wrote:
> Jon Turney (2):
>   Cygwin: FAQ: Mention configure options to build with reduced
>     dependencies
>   Cygwin: configure: Add option to disable building 'dumper'
> 
>  winsup/configure.ac            |  8 +++++---
>  winsup/doc/faq-programming.xml | 16 ++++++++++++----
>  2 files changed, 17 insertions(+), 7 deletions(-)

LGTM.

Thanks,
Corinna
