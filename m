Return-Path: <towo@towo.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id 02F993857025
 for <cygwin-patches@cygwin.com>; Sat,  3 Jul 2021 16:19:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 02F993857025
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=towo.net
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=towo.net
Received: from [192.168.178.74] ([91.65.247.112]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mdv2u-1lS1VM1Ng6-00b5BM for <cygwin-patches@cygwin.com>; Sat, 03 Jul 2021
 18:19:22 +0200
To: cygwin-patches@cygwin.com
From: Thomas Wolff <towo@towo.net>
Subject: propagate font zoom via SIGWINCH
Message-ID: <9191991e-4c52-43f1-cd9e-6eaac9013f24@towo.net>
Date: Sat, 3 Jul 2021 18:19:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------7C914EB8CB85F0E9E618BE0D"
X-Provags-ID: V03:K1:hOqxDrOPAHoV1QEBljjA9F/AnYz/zzDoKANk2xL4UaPrLIQEMyV
 g9dwBZgvNDd4HcrdbavUrSSm2zRGB/fe1qOaknsLHdSIq53bYOVFm2Lx925NE+W2yCoerth
 zbGTi4JSB9TMh028WhLhRsvyMGb/DQ5+w6yTu+kx3gVEEVItpo6Al1PSeKllakERT9g3OdM
 KdFJfHDduYkI5QTCSViUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DVvnrEaEGao=:mpcgf7sF8/KtNqoW3n9o2s
 9lGTYY8FuCQs5qaKFflzFxJEOEsxRlN8NWG7aJuc0Ynpy02J1nukNAp7BtgbzU1RL24BSlxR4
 pTCv99eGTwAo7yrU4s3t4r+i1TrH6LysHQrzkYttFq9XeGB5jKwHSIBMBBgLUKnMmW6HqqgH/
 pmMSf7IGmPqBDxFVLxqVA8H/EwLsLKf7zaXITsspmRgRujClGRqv3mVBCSo8JSgFBVRvgg+gy
 4B7JUaqqUmWvtEXxugUv36n367EEIP6bARt3twePBAQQF904vPEtSLl78P1e+KMoX1j2fglyA
 ocZiJ8DPRiG0XMkDc71gGzd0885AO8GMaXMdKM7X3jfHYuhHDR3UTIu3bpTSHTS8PKiWLK6hP
 VjSsUHFvgHWvEx+1RrTNFAKpWUzXZFjMGntkCHdVUxEW43n+hSxg8RZ+RaN4/cdqx+ieNq7hD
 wNmCuyPyy4wOS10NNVG7Y9rmvkrtmPqMeDz/MFTtAE45p6Fv/1EbP74SDEQEPbr4kSRtL5TLE
 VZAgZ3fTuFwxL8YP7j7DL3axRee+fyY4hGZb3l/Jy9YfL5qFXjUAnfvL2l8NcwekgsxBlmbM/
 CkyeOSbK7eG+B7SbwYLJ1hMblREA9FFeUAmbaeDXQEmB5aamA0Pwi8BT+0XuvjHI0KBVmkHn3
 t6t7OwwdtMHVeDNRBnn27SB1HZS7z5uyPicZ6wZuuFR2k4mPW3MqTR4DEvVh1TZQx4889Xhnv
 BLUPseBMrPlREfs2ld0Gz3bYjQMPzBIpM508OypjRA/gloJbwkCEFzE7dBUr/YDAybrWA4rib
 Wnhit4XOj3apgM24Mzud11KdemPzWaRGBUjs+Gtdjav5jLukL7f1BlA3LaZcyVel0UieCNn
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Sat, 03 Jul 2021 16:19:25 -0000

This is a multi-part message in MIME format.
--------------7C914EB8CB85F0E9E618BE0D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

xterm 368 and mintty 3.5.1 implement a new feature to support 
notification of terminal scaling via font zooming also if the terminal 
text dimensions (rows/columns) stay unchanged, using ioctl(TIOCSWINSZ), 
raising SIGWINCH.
This does not work in cygwin currently. The attached patch fixes that.
Thomas

--------------7C914EB8CB85F0E9E618BE0D
Content-Type: text/plain; charset=UTF-8;
 name="0001-tty-pty-support-TIOCSWINSZ-pixel-size-only-change-no.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-tty-pty-support-TIOCSWINSZ-pixel-size-only-change-no.pa";
 filename*1="tch"

RnJvbSBiOTc5NWVkNmVjMzk3OWY2ODE3M2U1NGQwMWU2ODEyNzFlZWE0YTlhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaG9tYXMgV29sZmYgPG1pbmVkQHVzZXJzLm5vcmVw
bHkuZ2l0aHViLmNvbT4KRGF0ZTogU2F0LCAzIEp1bCAyMDIxIDAwOjAwOjAwICswMjAwClN1
YmplY3Q6IFtQQVRDSF0gdHR5L3B0eTogc3VwcG9ydCBUSU9DU1dJTlNaIHBpeGVsLXNpemUt
b25seSBjaGFuZ2UKIG5vdGlmaWNhdGlvbgoKLS0tCiB3aW5zdXAvY3lnd2luL2ZoYW5kbGVy
X3R0eS5jYyB8IDEwICsrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9maGFuZGxl
cl90dHkuY2MgYi93aW5zdXAvY3lnd2luL2ZoYW5kbGVyX3R0eS5jYwppbmRleCAxZWQ0MWQz
YjIuLmYyYWMyNjg5MiAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl90dHku
Y2MKKysrIGIvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl90dHkuY2MKQEAgLTE2ODcsNyArMTY4
NywxMCBAQCBmaGFuZGxlcl9wdHlfc2xhdmU6OmlvY3RsICh1bnNpZ25lZCBpbnQgY21kLCB2
b2lkICphcmcpCiAgICAgICBicmVhazsKICAgICBjYXNlIFRJT0NTV0lOU1o6CiAgICAgICBp
ZiAoZ2V0X3R0eXAgKCktPndpbnNpemUud3Nfcm93ICE9ICgoc3RydWN0IHdpbnNpemUgKikg
YXJnKS0+d3Nfcm93Ci0JICB8fCBnZXRfdHR5cCAoKS0+d2luc2l6ZS53c19jb2wgIT0gKChz
dHJ1Y3Qgd2luc2l6ZSAqKSBhcmcpLT53c19jb2wpCisJICB8fCBnZXRfdHR5cCAoKS0+d2lu
c2l6ZS53c19jb2wgIT0gKChzdHJ1Y3Qgd2luc2l6ZSAqKSBhcmcpLT53c19jb2wKKwkgIHx8
IGdldF90dHlwICgpLT53aW5zaXplLndzX3lwaXhlbCAhPSAoKHN0cnVjdCB3aW5zaXplICop
IGFyZyktPndzX3lwaXhlbAorCSAgfHwgZ2V0X3R0eXAgKCktPndpbnNpemUud3NfeHBpeGVs
ICE9ICgoc3RydWN0IHdpbnNpemUgKikgYXJnKS0+d3NfeHBpeGVsCisJICkKIAl7CiAJICBp
ZiAoZ2V0X3R0eXAgKCktPnBjb25fYWN0aXZhdGVkICYmIGdldF90dHlwICgpLT5wY29uX3Bp
ZCkKIAkgICAgcmVzaXplX3BzZXVkb19jb25zb2xlICgoc3RydWN0IHdpbnNpemUgKikgYXJn
KTsKQEAgLTIyNzksNyArMjI4MiwxMCBAQCBmaGFuZGxlcl9wdHlfbWFzdGVyOjppb2N0bCAo
dW5zaWduZWQgaW50IGNtZCwgdm9pZCAqYXJnKQogICAgICAgYnJlYWs7CiAgICAgY2FzZSBU
SU9DU1dJTlNaOgogICAgICAgaWYgKGdldF90dHlwICgpLT53aW5zaXplLndzX3JvdyAhPSAo
KHN0cnVjdCB3aW5zaXplICopIGFyZyktPndzX3JvdwotCSAgfHwgZ2V0X3R0eXAgKCktPndp
bnNpemUud3NfY29sICE9ICgoc3RydWN0IHdpbnNpemUgKikgYXJnKS0+d3NfY29sKQorCSAg
fHwgZ2V0X3R0eXAgKCktPndpbnNpemUud3NfY29sICE9ICgoc3RydWN0IHdpbnNpemUgKikg
YXJnKS0+d3NfY29sCisJICB8fCBnZXRfdHR5cCAoKS0+d2luc2l6ZS53c195cGl4ZWwgIT0g
KChzdHJ1Y3Qgd2luc2l6ZSAqKSBhcmcpLT53c195cGl4ZWwKKwkgIHx8IGdldF90dHlwICgp
LT53aW5zaXplLndzX3hwaXhlbCAhPSAoKHN0cnVjdCB3aW5zaXplICopIGFyZyktPndzX3hw
aXhlbAorCSApCiAJewogCSAgaWYgKGdldF90dHlwICgpLT5wY29uX2FjdGl2YXRlZCAmJiBn
ZXRfdHR5cCAoKS0+cGNvbl9waWQpCiAJICAgIHJlc2l6ZV9wc2V1ZG9fY29uc29sZSAoKHN0
cnVjdCB3aW5zaXplICopIGFyZyk7Ci0tIAoyLjMyLjAKCg==
--------------7C914EB8CB85F0E9E618BE0D--
