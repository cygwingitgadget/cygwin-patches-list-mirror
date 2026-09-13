Return-Path: <SRS0=nquO=HF=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id B4E7F4BB58F9
	for <cygwin-patches@cygwin.com>; Sun, 13 Sep 2026 12:12:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B4E7F4BB58F9
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B4E7F4BB58F9
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789301540; cv=none;
	b=adeZdHLO50kC3EuVT3IGG/G+mds2TtMPKs4CypU5DsCL/KzIIV5esprlHPfwYtniuWez/6w5DYvkwG+hUpfQTM/7L+tOyhU9Wv16ehuiP0HJtMgUmSQauITTXNK8vcdkncGFxCiAid/gPpARc9Bkh5+WRHlFU87TtRsQ8zpCuys=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789301540; c=relaxed/simple;
	bh=9WnePDnuoDb9usR8QbelbAQyUON712UUZBPLQku06d0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=q2SJk4Q55bixb9tmmn0clI0llPEfEJsB6QFT4BS0L9yVvAb8V0T/I1B3SO3Xsd1V9/cgehbPrt98zZ70kiL5E7tNo09+v/LOFNlZyd+XuoCeViXAazdrl3gwEd5+0kSihgQJ1jesYtHDoVIVHOTfrn7E3dGJODlhERdePuExBMU=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=POOxFNQG
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B4E7F4BB58F9
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=POOxFNQG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789301538; x=1789906338;
	i=johannes.schindelin@gmx.de;
	bh=EKaThmFBxhb73H/5NkW2XgIbpMpUXxbu14vRiIX5G4E=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=POOxFNQG7P9b0QrT9N9U9jJEn7sKnlgYZVJo5A2p1PaHmlhX8N1xb4tUGTOG3KQI
	 XiXEnkAaRjhiq/zmPjq66TTZJuJk/DT4fcvMgManIoWWdzyElWelISwxXIfSSZZQP
	 ueWrjvneRZ7ar9g3JWgORKto5w4chT9FTgwi99sUMvPjnrUOJhtbGmN9VkH78ML8w
	 cgMf8ABIn1RhX//qdM9CZuNrm56xxNjas6mpzdTCvM3E54mrGa5i9CprY0pPg9qj0
	 vAskfGE1NANvx/B45PbnTsCRjxWAYhdfPVqbaK+I2rEGtwNkT0P4SEEogQkVbzy4i
	 Dd8Yq5SZaMXRz/7Jiw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MA7KU-1wycJs0llC-0011w1; Sun, 13
 Sep 2026 14:12:18 +0200
Date: Sun, 13 Sep 2026 14:12:16 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com, Jay Libove Alzina <libove@felines.org>
Subject: Re: [PATCH v2] Cygwin: console: Abort setting disable_master_thread
 when no con.owner
In-Reply-To: <20260912042757.1700-1-takashi.yano@nifty.ne.jp>
Message-ID: <5c21c922-d4db-a4b5-4a61-dc3cad3f0b76@gmx.de>
References: <20260912042757.1700-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:tBIIbr77wGzksiWMgtHoMoiwA6BXyWkt460j43olVXJucKldWf+
 3EZzCjHioBCuRc8LJZQCd6GuMurAZYCh+8GVGfOyHeOCpu7V4mzANgOp+Ag7+QaPSkBM9ub
 RjOY8W5oC2J4IjsNucBO2GAuqKOabv8HA9yMFH1MZAmywkOxFObaiX/9WGXGzh3bAklLsGB
 U5jVEGDQcrgolEv9i/49A==
UI-OutboundReport: notjunk:1;M01:P0:rmA/gT1LYeg=;+8XYKYYCWMX3YJvIX+H2ovnxDlx
 OMLDVMMFraoqmBVdxojjXI1WHuF5dE+XUSjy0r7I3HkRj04v8c+UYwPWGoMTVxH+SCOoHyuq9
 NLM/6fmQb2qAJXu97VLh1rlsuPrWwVV+4u1ZHKXXoa4l4TFXlaJUjJBkH4B551YTkXs74Gkll
 VfCLX1ydhKhZEKq5bJFUMHc0H0TU0l/kjK5ltWG3D3zGSEi93FA9IWq3DNkDPGehialXnLPfd
 9vSIVOCa26E/nPUcMHoVb1bl4bRQgA/8kSDTYxfv5qBM0zitHY/rmgUR2eyFA4gpmJNxh79rE
 bF2yFf1tDWAhVDaiVKWimQv7lDDx0OTnoZ3BzgVjJmiSLFhV3R/AIRSz7F9EaCoSJXN7QhpuL
 oRkWxwmBTRTazO22QOw1ySbmzOYLFiqT8tIiIVriZT288iO0X8fMZq/UjUgggXQz2l4B3U64a
 oKhm4dnosT0KQXUYzP6iuVLjXE3hgEBI8DQpshksL958EyM+aB03rOk5VuKFIHa6t9OGBVVj6
 v7wa5PRjypR/xhTzzsU7XRZMYyMpYc9B7UG2QP8g32GR33SnRV+I139m65gG+mvC3QgcRNI/+
 b+R8E0+qcNXnK0gp8IT7nnclAd+yS6xVPUbGiIJa/cwFLG55vMAps8BXyy6ZFT6NYxUSsCQPt
 2fbMZ5XGyOu/2Vjy00X8X9rcDOq4G+1TbNIDcb/3vETEbOrIs3UuoxybLB3bPrcmWNOOt3XwR
 TgeKlNDmJx8KbJlUOQoLC1Td9E0daLbw+usDmAK7DJeD8jfJ8zi+GgOLdXI4z9zf3tS9ZuPZI
 SsmR0fuvzQvgvySeTd34EXPuc1k+icd8wl2/yYiX1hOvtGjzIgQXsC6Q51cPjFqA8Rn8cW5N7
 DdtZs/sJPiDBsxCbjpvK7/UVCZFSmhTCKGCfWgbo3eSAT7Cloej1mBx6tOpcPNNl9nxYB4C87
 vM9tAId8dFeupugdhdU/h1TWRNTVUK2KVpmyoC9aCqOTR+hhuh1lpzmpRsJlNqn7lhBYxP0Hm
 J6MbKJTf2rWL4k0JXUgY1cTN12W7zZBKgCw3irlR2B7lqGlm7+kUQMfyaf2+Ug9TfmHc1bxwr
 SdVN7rjlGCn3Uu9/TGyHdQXiDchPtUAgXEEDoRQqFPPx/TMvKQTdSfUdgYtEnjWSvQeXwiNQU
 dQog8yDmV0AMausu5Aq8IY+dZFSxaN4mrXXgj224DjgECvai0ysJBM+KwbgKknuN8bnOdH7wN
 FlyvLN0qCl4mISh5ImbWsIolIE164PKqH/CM0+17N8ijVrTox513V1oN8WZ4PGgNHGUOhO+xl
 ZqCrXPh4jJOiV7XGEAKxizI4FoVdozOXyATAB12Onj4Dn1UiztRXtj6Yu1ZDC2If4miNfXaC6
 RSNkaD4uWdD1u/eyTFutQfv1LglYfdB+MgGPch6OZ+rHpVscsefQR8mZevTXdKj5rTj9R0/5d
 joxu1P90lDeOikcXBMfxKGJ91a0weu4vtVmxs5iSY6dk5wTwXmvk6K+05h+M63UUXT8+z5oTg
 cqzyLhYBFiUO8JiQl85gYn6Zs4aI7KKPGn8tgiX3pdFuD2l+jKVa8eU2IZqWusPXjvjoRnNch
 aHrA1aQYMxHawDZUbyfGo7/IsTnBcMWxVM2Hbxe4hFdRZmKjZglsE+gbsQv6Po5bUpaF4DY7G
 /scn9FBEPpqyrgDuvp0AEK6tFcU7O6XokUsIBXjfdDR3eIeHbn51JCo3fpCcESpTfEF7KmfhJ
 y3hdtiZDrdJ4ZvEIfz62cODvEPaI96pdzNQgr2H8OOgsb6kYjDMFtx73s26hvxn1Q7+Hc2asA
 X2TaltMCsx+l8ZgSOHgLH11GPFuN1BKfyMYxHXWJWN/msL9WeD7I3o9Qw7Sow1RAr8xpAIZ75
 agxD5WLrUp5sz60zXG7PjUfd5d4vR856o2A1KLUg9L4UbQL2Yok5LFhWb4TDC3iC4GOVIUand
 1LXLadjJn5BAX/ztTRRQXsVV70uByiC4JR96YOnriruzoid26ZVeQZ5Lkf+XuA9zPlap3zO3+
 P/TK1Yrj53CYNWcB32jQnutVqjTI2++GvXHUN8wuiXpGAiwtFPNdp82eOF8s+FyipKj3aJBmk
 kOvxvCzBjN7AqDAagninV5GgCqnBv5go7IOCwmsuz5R3P1WIFgOYIhVWuw+NqYOQlY05jcUPc
 Jh3LEYzJJFcywcEf3Ek25QNplcfZiueusuU7JTyVpm0XrYRJiJZAONP7haBtksQo9eZxY5+JY
 OtKPlxseJIeMJWhAV4K/idMP6YYKuXyw4F5DvZaNvPH//XuQkD5TRCWknIdjpDzp5yzYXlqJV
 qon3trfHmxqc2V1ei0sMSz9/ZEdNGFKSMZs868KLM2nfszcAdYXGrp4vT+rvfz1lmGgJJW8gZ
 qQt5i8hJ/EJoW27lfFZGWzfLIJrOIKeVtzbjI1aSp37BdeJ/tI+C8+Nt1pp5EjDhV3gxr5A5+
 RGWE+/2CkS8l+LYnmiNkLqbruT1xi7JPvOL9f5cm5AeBTHhtPxbHwAkSTdqcXtc+AZWWu5C4m
 +96JdrWSPv5Qec3Xd3rnFrQIAAR2JLsdqUzvxPIKdOB1QeIJkP47J7Xr2I4qz38DWkfgIGd1A
 3PVTH7FKiVIbWFQeiH93kaK+jAlkqNWl1kkXNFDaLwxrTwfUTmWZgZ4mjzbaaGHl10b7Ek5wm
 4TNNP7xOAY5wAqojckLqSFDf0xtjHrUskdZFkDVHZqyY48zekOlTg7k6mCrt2pdTnlIaQ80Tn
 7xrLMa0YdlCT80yaJjK4qoFhnri8EHRuiL8pZfUbA0h8zJPz+aDqRZQDMUFBYPI95vUQ5fhgO
 SNIs2QZ/9OGPeMTRuk/DUqPsdPVuS0jo77z6mm7BX7GkTEM9+FAruk5a+JtkeBTpdkPYVpxXt
 axgKak0EN3H4/IpXSOiutruFN0nKijmZlGYNnFgIFqxr2Z8X7fA2UEUm1CQ8DqkDw6si273Wo
 vdiH60WCZwNZTEBrqdlSyCY7Gktg89cNoDICKpa1DvtvKbvuwSsP1kW6INqVRF22wLUp4tscX
 GdgoviqNtL8vwd2InJwZZ8byBiGX/XxCgj3UwFWlx+bVuv0QWuKjuyJfcMZ5yfS3lXrizihz4
 ocXjn9eByuY4nema4vS851IRgWd/tK6JxdpI43bUH6qGZXu9wDhi1f8fcNV5NUld0x9ElkTon
 AiafhL26E8mu3yQubp87Jl/lm1R+mBrx91ohCrMqqdYT/yNUqYFL1bWj55yiEjmvYw2OjfigS
 dlmK2/zvA9+RBcYAQTIe2xa5vS3SxtbErMRjmny6Ck7FM397UtOw5SyVpEX8wzV0ZkC/I5dpC
 0Hp13mY8BZ6yd/5DXsJmakAHxx9z8XHyToNALEWcodvDLkf93jvSsxqYsrk2C+sEEqzlI0zAV
 zHPhgPWFsTBiBBONHOsCpvfNehkeR8+tJFDMeVLEQR5Ibf00vuMkaBDBV8ck42S4WvJVZhtOQ
 Dk1ti11ZHfizFqhmv3uo3qRssrR4bHcIBAHrTihvdR3aiCOtrya3HXfmANa2mWjw2mi2cXYKV
 qe8/X1xrSBAt5n3ESi25hIyjd0yJXsxC2sBqFVAvsHG86R6cwQhhYjWivRGX+mYixbfue3FJz
 r74cvgrPH4GKeF5XjyfM7ndFIET++40a5EXmI5dWA7xGDL4kd1lOWCA7NW9OYuPBUXpS/5zUz
 mbL4dd3w+aLDD6RfznaPAobfEz3vo0U1he0emU9i18S8fRPb0fSvVuhpoGe2l1h68yfduqAQD
 P1pRLF6AOfYdn40AhGCYvTMLG//5ulRlI3p/3n+XCL1s8gAndnZP1c79OzHjSF4hc1nCem3p4
 aJoooGddA9Xpt3V+0SUW4xkjgCw0sNoshFK4BHpbUupcXoCcI8fiMmoKWVo0qSLYkGDCY6kDB
 9s0Og6d3O359U1KDltnsrlWk733FhJqohCmI0R4rUdZ0Zd40Z/r2X+HMq4I1iZQIJS6GPVfqg
 PROZR79RbKkdjCYNzvuIwpe07FOsSzDPUysxTFxvilPTimZf+UDlx+SXDIDI/RVUiIjj4vUyU
 L4DV6r97BefH9QKsXZQc4HT00cNY4uOgN+1zkoxtkV3nPl+KGdemnNoQC2Lag/rdRfb0f3qMn
 biPApxVX5jCmeRxMuJPCQ8RsyYpBI1XQIkswT+UJEl4jSPxCv84NOwuDjneBLeNWF59hTJyin
 b6wUs2Cn1g8FWfecjEMvhS6rj0y6uMPo7tCLOyaQlyPs85dtVWigWCAsKf05leFgHky05ezg+
 MeVcxjtH/7oo6dgV0PvtCnKs2en2uFZGXXIZjtaDEXrHJEH/WR5d8EKl3ybSIDfnuFRwASsPi
 EnuwxIYR+fb3dXH6COqBtgv8zDeahT7FQoXkZAuhZcfrooD8TU/p1d2q0avG456iWcxkHPxgz
 Mduxh7k7E16/kEL3jonCwjPqkni7xDmtU3okMp0QwLacqfcwBBWIolagFfXlqzQ0fPt0UzTHo
 x/PtCjJj2s42Ye1DWpuuhLMehjhjhphlh0zanujf6eW9R1eLrmqfH0ezdS3yN0y3TF/YadsgE
 kmy5U7A2zCgkQ6Advws+2MUPnbsbeqfDhoNZowW4jNhzXjkSLPZZFj/o5mDKPxiAxdXxJN2bm
 ZMhFat+ZNhxbi8aIX7XQzQFgU93wh6ug2N7q9M4pnnZ5Y/fuRXqDdYSxNVkDOliEqZ9207T5f
 of6NtPbZrYCznMcMeoc85erguHsdi6p+BvuyGHN4oJrn394uZVsapLzMPuIn9JltZB+LDjlBf
 RhmDZcphq7oBOGiats82GkRwTGJ5tkBIKQxRBqe/unahBE+Agg3vr2CAoAb/PnRaWZSunoazq
 zFAdE37JLeJZ7GwerCQBFBt/hh/euQLCbHAr5m3EQX2cqOAUOSaWKKFSXuKJeozprVEbCgaLd
 We9+J4f40YBlLnMbsO9XlMfaj5DXCjnFWhC6qRtET4EvfHVVXA2z7nc2kaqw6vvVADQKX47m8
 l9nPYPNT2hUyAFKIsHdSa9Do9iNxLj7LW5MD1fO+co+NPyfLXYeDwMvAnnvXs1lqSCG6tbqsr
 3s5vM0Az/Rxob+4v4+cL0O4Rl9CK2+Z9L8UfgxapMivcIZ97ZtiXsldSaD7fCbLGBj35+2y0q
 0PXPC107wgxWrfVQODrE/DBAVxDJvdZJJqxBn6kTagyA2Sk9ZadfZ++MPDtETR2at3D/aoZTQ
 qFluh4Tj2qb0hHoSNIwZRgyT7QPPDigQrJbDY/y6LY06iLqds7U7uaPVcmJk4fm8z3tA/ahRr
 9DVJoCA+zBfA+pjyEXsRpHUX9AQlavLBU010xtbgduqPhfQHBNtmJywddYFeQj0UdN0RirDU2
 F8BAO4CIw/9+3o4x6OH3Z51w6ZBtgsrIRn22o+g9EOzaW0tjC0VMY9nnSwTgVNYwVfevToxwO
 5Lz0kplqpMCfJppS1k8xIyX7KbykNHNkGYlJwcnwyXW52XDSltbU49InkXayjKLA+/NAU3rMC
 FvFwsqv+XP1CG3LianhFlL30MYjy/fmCd+4CA4waFXTDSrcRoKx6Awuf/aB6Z8yAcEOjDNGsX
 oXyoV0UvozZV/9nDbOoHmm6CDMvn/igux/H82WCPIHWuy7lAm3VSzFDT0JeCi+JyCJczlcnrh
 StlOTBI4S/5vd4bCvb5fcf07Lhk7zJEoGJjveUUVqkvnUl8T3z9C7HowmpOtebfAbTXgByH3f
 2dqFAx+1vbV2HHvhrVWYiYzd2wtPeSI8v3itCCOzJf9p80n3LJjuLwnXWUAJNQreglVtK0tnk
 hHm/IQrWZ9wmrjr2JRVC+pWZgBJHMUj7eWB0owzFiNqfpj9/jLJhIPOub8xpuimApGdbEE3ea
 z4PdLXDcydiohjDfC5nl3cDmtmzP+RzWETnYlcW/sX3Z35UHnvTowVXt/ycqQ0qWp3bLAlyss
 3JRnVnLoP3V//QPcMYbKCe56s0tQ4Xh1cEbGELTujIAFdqMIYygE4iHe/CKO+hQoiBbNLgp31
 q4E+9Sz0uLMmivCYKztFoqUCmm+hTbxwpIKj8Avurs/7KE+UNAvxq2UceQFiB85A0mE0+YyvE
 XSByGTiq6HFhylHgmjuFuVX6xN1t+O7xRsfWs8TXQR4sC6e++/nQIyaJUoEjY3xXv6tIxLDtu
 yNj6CG7CRPMdFHAjc1/itD6D9v5rPqxBYY6ENOQOSEjxP+US057xPdx9vtz7heN60K8E/HuCe
 7m9vAKMAmdp+Mki9deDMqvb3M/ohxSGq2Kt/bh8q8VO85Q56HYpW+QiWob53ja3EKF1SzOLIt
 fIJXSTcc3YrsozLnlJeAMF8eX2OuDNBux8L+dMOPWzJqGf2romlxlT0Xjs0uHDcTl/ZXz4ALa
 InpJec5vqRAmn
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Sat, 12 Sep 2026, Takashi Yano wrote:

> With the commit 733d5a953fa9 ("Cygwin: console: Ensure the master
> thread runs only when it is supposed to"), the process which calls
> set_disable_master_thread() hangs if the con.owner already exited,
> because set_disable_master_thread() waits for cons_master_thread
> accepting the status change and reflecting the current status to
> master_thread_suspended. With this patch, set_disable_master_thread()
> is aborted if the owner process no longer exists to avoid this
> hang.
>=20
> Addresses: https://cygwin.com/pipermail/cygwin/2026-September/260037.htm=
l
> Fixes: 733d5a953fa9 ("Cygwin: console: Ensure the master thread runs onl=
y when it is supposed to")
> Reported-by: Jay Libove Alzina <libove@felines.org>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
> v2:
>   Fix the race
>=20
>  winsup/cygwin/fhandler/console.cc | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index 5f78d0c62..4b1ba60ca 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -5009,11 +5009,24 @@ fhandler_console::set_disable_master_thread (boo=
l x, fhandler_console *cons)
>  	return;
>      }
>    const _minor_t unit =3D cons->get_minor ();
> +  if (con.owner =3D=3D 0)
> +    /* The process that runs cons_master_thread no longer exists. */
> +    return;

This discards a request that a replacement worker must inherit.

A reachable retired state is `con.owner=3D0`, `disable_master_thread=3Dfal=
se`,
`master_thread_suspended=3Dtrue`: the worker yielded to a reader, then its
hosting process closed a console descriptor that was not its controlling
terminal, without requesting suspension. A surviving foreground Cygwin
process subsequently requests suspension before starting a native
application, but the initial guard returns without recording the true
request. A later Cygwin process with redirected stdin and console stdout
can adopt that console and start a replacement worker without resetting
the false request. It therefore runs and can consume flow-control
characters intended for the native reader. V2's later normalization cannot
help: the initial return bypasses it.

Before this patch, the true request was recorded, and the already-true
acknowledgement let the call finish immediately. Thus this is a regression
in a previously completing case, not simply a different outcome for an
already-hanging case. The defect comes from v1's guard and remains in v2.

The basic idea is: a missing worker lets us stop waiting, but not discard
the request its replacement needs. We need to preserve or normalize the
shared request consistently under input-state synchronization on both
no-owner exits, without removing the dead-owner escape.

Thanks,
Johannes

>    cons->acquire_input_mutex (mutex_timeout);
>    con.disable_master_thread =3D x;
>    cons->release_input_mutex ();
>    while (con.master_thread_suspended !=3D x)
> -    Sleep (1);
> +    {
> +      Sleep (1);
> +      if (con.owner =3D=3D 0)
> +	{
> +	  cons->acquire_input_mutex (mutex_timeout);
> +	  con.disable_master_thread =3D true;
> +	  con.master_thread_suspended =3D true;
> +	  cons->release_input_mutex ();
> +	  return;
> +	}
> +    }
>  }
> =20
>  int
> --=20
> 2.51.0
>=20
>=20
