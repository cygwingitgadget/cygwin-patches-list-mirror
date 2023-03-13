Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	by sourceware.org (Postfix) with ESMTPS id 9987D3858D32
	for <cygwin-patches@cygwin.com>; Mon, 13 Mar 2023 09:31:35 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mgvj3-1qC5jn1xJV-00hQdc for <cygwin-patches@cygwin.com>; Mon, 13 Mar 2023
 10:31:34 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 262CBA80C87; Mon, 13 Mar 2023 10:31:34 +0100 (CET)
Date: Mon, 13 Mar 2023 10:31:34 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Fix type mismatch on sys/cpuset.h
Message-ID: <ZA7tdk/1w56zRzLF@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230310101821.18319-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230310101821.18319-1-mark@maxrnd.com>
X-Provags-ID: V03:K1:C/LQIlTgI6+zRpzKrO292ypWVLQ6QTQS0PpAqPC4+7ZeNck1tq8
 wFaD3odmVxlbNO9z2dCmTBwITsk//EEqE5Sg0m5bgFkyfecF1z9Bjtdw+7pDNN1raqHnbgS
 AFHgI8+HZbaN09UZQPsBUIQMQvfMCpbgwtqizQU8zl3BEUmxEffeqHZ0BwkW8cyu+RQcHWk
 hPMXz4VZJNTermnGLgAsw==
UI-OutboundReport: notjunk:1;M01:P0:k+TKJ874DHk=;rUWWUke1d93pc+LuPitfbi3N7si
 LfLqr+ZaAU+2mQfJCGKPAoS/QDTJRCyx8XsiGFlhn8Wkyvwn4qH3u7VD53mm9RQn2nCvB6sOx
 f9UlVlu/M9t6ZB2qTzoNVgk+ck1FPY38CdKypKyGt5Or3ljJZu+rcsAlmHkcCysqmV3Ow1pD3
 KVSOIrB57+23Fd/+wUkcMJhgrBh9qOmsN8nw6aroIs4BWqBdNn8xAh5XY8zyqHTDzqd1h9gEE
 GN/rrOdHlBZ96SnzyMXU76TSk5jrUntTQUL2twBFxaMkYAMv+4LVn+tzCDdt2zv16G9F1Soro
 zIKGy9qNeiD+PuQmJtB4wFU3/YhLKVmo11eEFbh9O5/hogsYTWtpSdT2dmkdMirOoPjnGBmlK
 x40Wwnh3kcihlMuH3hp0r729c0qK9zhvQGiKVSniA2Hg68bxmHqjJi0rz6wr3zk+5g/R/1X9t
 /IhJ6argJJtZJuIzLDmGtk4g02rMZxlmH9J2CQqvIvAbP/EBSU9mgAt+NkwKmG4h2vHcEVCak
 cPVQPvdmb/jW6sg2zHpRZqZygJdS8e9L+dl/c+1ufV2JMFFLVpojAotN8Tm5g86rF3GsRjPDu
 gV9c62+CE0ctjOGVnUq9bvsL8d7Uu+XlDZBKR0fo6nW/bTIHdW15+h68xoAXyQZqkn2dsPnnA
 ejNe6/KLjRb/kVrqOWf1fdZ3cGn4fOSJTi+4ymsU4g==
X-Spam-Status: No, score=-97.5 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

looks good to me, codewise.  An additional "Fixes:" in the 
commit message would be great, i. e.

On Mar 10 02:18, Mark Geisert wrote:
> Addresses https://cygwin.com/pipermail/cygwin/2023-March/253220.html
> 
> Take the opportunity to follow FreeBSD's and Linux's lead in recasting
> macro inline code as calls to static inline functions.  This allows the
> macros to be type-safe.  In addition, added a lower bound check to the
> functions that use a cpu number to avoid a potential buffer underrun on
> a bad argument.  h/t to Corinna for the advice on recasting.

Fixes: 362b98b49af5 ("Cygwin: Implement CPU_SET(3) macros")


Thanks,
Corinna
