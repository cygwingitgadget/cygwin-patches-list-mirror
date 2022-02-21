Return-Path: <johannes.schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by sourceware.org (Postfix) with ESMTPS id 9E5043858D37
 for <cygwin-patches@cygwin.com>; Mon, 21 Feb 2022 13:36:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 9E5043858D37
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1645450579;
 bh=fEbbDd7CvGcWTiymGzaWkqrxnjOfuSugCTJmlUGrQ7o=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=ZfAJ6LkFvXmORBL1wz2LGTkxEMCdct8N7EXeF32Rh9+AbEM+Mo8aQ2f1wjj+wulFS
 ncw+9E0nip6WoWmIC1g6kLCc3VXBBdm99I5mvj9xrfT71a5ZT8sEYpZEbz2kGlV0il
 CKh7tggQtdJAAfFTfk3QTULhu2KPvWhhR1SdayKU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIMbO-1nRedy46DM-00EPeC for
 <cygwin-patches@cygwin.com>; Mon, 21 Feb 2022 14:36:19 +0100
Date: Mon, 21 Feb 2022 14:36:16 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/2] Provide virtual /dev/fd and /dev/{stdin,stdout,stderr}
 symlinks
Message-ID: <cover.1645450518.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iZb7WqAjZzVphXbLYLLiOtKFlWNEMkGZhEFBcOlonVDUzTVubF3
 G+ujiCyAMZ0QZJ3vxebxivrEAR8vwcXH5Lu6o5d/q34bgQfd5ubjKIaMsXv8S8gkm+cyDoQ
 VYcO7wOWEy9p5TBSDPOFTDlp9oWQc4mPSS+Z+S7AEBOuQrE1LdNqRJUWE/6ZNEM0xICmJTu
 Z1W6LJ89ObzsBjUyXY8+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HVPtNzwmpcw=:L4AKetPjyZbO1qGOE0HTQT
 cmrrjiguXpZKqtueelbxM0ZpL2JClDGieKW6EpGRi8nepxlBUoavL3b7zaa8Pr2Tqb58hQSzO
 2bhrutU/p+oYBh28DSXz+E3DuijPsflHYx/EcLRAb1z2r1AyO7T2eigGor7R1W/rsYWV9efkI
 p9RGeaSFv3qqQYwrzcVpHbVLLgHneZH9Zig3jXfs+2IejBsaMJNAU3QMFYC9UcZ/ND6GgPoJ3
 +8MXl88pANeHdjVuq87WPHMCwxIm4pSaVqmLLklTcSnlQO7hO3oBso/Ygxr/s1CtUkyVlI0oZ
 JywhI7iKsgUK+0FtoHFbdPC9ioAhaHxK3i90MIFsK1lw6mk8K+Vpo2a4iOZ3jd1jxNXA+V5So
 syyFdcnW+lrVlO6RxypJ0rBnyjnz6NQX/7kFcyF1lR3+bbTTEI/UtfC9woVNfRJ0NQ9t5IFpm
 YA9e7b64Na4r6JhB4caWdHxBfpv2ra/Z2bpLg0CxlrooGtBZvk2zpdQtKLunIZmRtnb69Cw8l
 F5hsHrvO4mrqcxXrMzrDVyezgytRArACFCLq3lJnu4iqWAuzEdwGQeGH/nKF0mn2xe2rIj9AE
 2e6TqsGVOdNO9IXO6hFvXGNDUmayxVWqYjCm8Wu+kf/2oEVEDyqG3emFbhSmIVG3jKeFRGikQ
 /Av/PKs5wJYRxngF6FcRbNJbcEO7Wkg6wc93iIfQW2JXfaCOKgQzubnTqLyHuuuIZ6hGc99z6
 Pnw/EGXMc5cxUhirBv/ZCGPI3Z+kIGJloqDUI2g6j/S7TzouZTEszIwJrRo59Jo1xxG9EpTZm
 gpMkw1Tj2ZjCz/IrZcyGP5dhNwf7zHyftinFP9/WLe0nfFJbl7EaQncvNZUU2VUuHfCZtYf4Q
 DDeeweVu20re4DcKKgycOn8mHioF1jOHA2wHJ5aTptIhBp8kAer3KmFFxHGsL21ZftjXbzJC2
 +jglDXkLrx7KBMk9yDWk/Qs2i97dKZUZE+fn+VnmFdy3CB4d6Zm0XvYULNcGMvqsQZkk+cauF
 7YDLGUi+A4IZ/SQ8B9NVq4oDuKO9Ptp4jaxOYKoyoOwdTU7kFwpJ6Q2YjBvd1mP5//jkN5vK/
 lGugWWK65TZeRw=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, FREEMAIL_FROM, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE,
 SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Mon, 21 Feb 2022 13:36:23 -0000

These symbolic links are crucial e.g. to support process substitution (Bas=
h's
very nice `<(SOME-COMMAND)` feature).

For various reasons, it is a bit cumbersome (or impossible) to generate th=
ese
symbolic links in all circumstances where Git for Windows wants to use its
close fork of the Cygwin runtime.

Therefore, let's just handle these symbolic links as implicit, virtual one=
s.

If there is appetite for it, I wonder whether we should do something simil=
ar
for `/dev/shm` and `/dev/mqueue`? Are these even still used in Cygwin?

Johannes Schindelin (2):
  Implicitly support the /dev/fd symlink and friends
  Regenerate devices.cc

 winsup/cygwin/Makefile.am        |    1 +
 winsup/cygwin/devices.cc         | 1494 ++++++++++++++++--------------
 winsup/cygwin/devices.h          |    3 +-
 winsup/cygwin/devices.in         |    4 +
 winsup/cygwin/dtable.cc          |    3 +
 winsup/cygwin/fhandler.h         |   28 +
 winsup/cygwin/fhandler_dev_fd.cc |   53 ++
 7 files changed, 879 insertions(+), 707 deletions(-)
 create mode 100644 winsup/cygwin/fhandler_dev_fd.cc


base-commit: ba7b912feba3178e530a484afea4cb127e7f2ae7
Published-As: https://github.com/dscho/msys2-runtime/releases/tag/virtual-=
dev-fd-cygwin-v1
Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime virtual-dev=
-fd-cygwin-v1

=2D-
2.35.1

