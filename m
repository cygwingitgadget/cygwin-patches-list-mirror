Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id BD0083858416
 for <cygwin-patches@cygwin.com>; Wed, 12 Jan 2022 10:18:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org BD0083858416
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MpD39-1mZ3dS0gXP-00qiIc for <cygwin-patches@cygwin.com>; Wed, 12 Jan 2022
 11:18:05 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 14B0DA80ED6; Wed, 12 Jan 2022 11:18:00 +0100 (CET)
Date: Wed, 12 Jan 2022 11:18:00 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): add Linux 5.16
 Gobble Gobble flags
Message-ID: <Yd6q2CARZ3qNyo8H@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220112060431.7956-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220112060431.7956-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:SL7owVKUHR78cfxduzdoIJtv3ciL1U3tDBQEnsbYvuQKIfo+kGg
 twhOcjGfl2coI7X8jOkcKYBNZxIq6qb/8bm6qr/PXvlVJ2CPormn1licJgJo8aLhNK/9t8U
 4PXBrwHNkFbyrQJgpVs34oEUfMOPyOzq/r+Tromi1g15RzFK0ZBGZTEo0FyrgX2XBeq5E60
 uhH3vD25vS4HFfpOhsH1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VYQo3oZRODw=:VTus4TgkFdZYPgphvZG7Nq
 rWLEdZ0ncpRZvSoA2MRV9tBfYUA+dRSAbct68WE11ohJiiHNzsLVSrggd6ROWOWco3Z2HkNTY
 Eoyf6jNtQRMHPy/5axoToTNapdzBMJakmREfWd+7aEobUZPKypKgJq8GwzPj1xC4+rkaikV48
 eR9qC+tbcEB73uQqGMl4SjSJUEXnYIQEIv6H4z26pGM2T9Ote48PeSN+JErNlpCF1EID1gcRM
 QMWW7mIoMSx+z60Lx/AJKr8SJ9ItHXNvjUAZB/G8nxOWQMMTfbNuWdCioN67a9/G0SOG+JICT
 LG0zpGJ7j0W8LaiR5NEbrF5WosYJ84CczLSXSFHRYSK6oAFrs/Y0g14TGM8u1DJHFOsMh7XRM
 z8o+cX1r287UfhxUuYIdXBW3g26qSeIl7s0XJcdrL8lzEVYcsAd8jwL7ILxQWnFI/s0dMRkIQ
 jCfnNiK6gTBIO3MMBe+Cave4RKrN2UKvc1ucdIDwdu3/DZHe46N8UeKvN5v9aDfgATwr5Tpn/
 CbykfFEgWzwO71J56lUm26qMSco/WYANMXSlKDWW9vTdsIsnMDkbh2odXBdGLeDcXKYmKiSFo
 1JtAodmKO5K5cik6WXXfWrcmykHD7xh/kbIC7Oy/6KkqYdYZBm67ukOk4wuurDzaGW4Hmb2/W
 tYzuDqCX6qMRlQ6L6COTmlhaYxVaU4K0e4bUCUyVLpz5fD5oSc0bSzGbpY64By80VeOwza50g
 hjjXGX7ndJJt2rgxp2v66D88HZ6PC/1l4Ay5Er5r3ojau6CrVIizzhG5IdvawVo6n45zshdOa
 ET6DiJsw9ZT/eeMFyvFt4b1GuEUT/Dg3vNV+g4Q3783LYLvIuTQK1ooWlQI7GA3gLwb4F57TK
 NXQWZzONtNpP0usQtNjc5uAxBPDflkG9kfoCD+nXba0H/p3jGqI9JpFOmmVS9HPRO/dDo4nKz
 g4X8bp7jfuTiEELAFtocGlNsJsyfAbdTmAA13vsKxtD9Hv41qrH4HsuqGUbuIbA4cKV7vjyst
 +zKxATpsNIsmd80FeEBFY5U=
X-Spam-Status: No, score=-93.5 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Wed, 12 Jan 2022 10:18:08 -0000

On Jan 11 23:04, Brian Inglis wrote:
> Subject: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): add Linux 5.16 Gobble   Gobble flags

Gobble Gobble?

Did I miss something or is that a preliminary subject line? :)


Corinna
