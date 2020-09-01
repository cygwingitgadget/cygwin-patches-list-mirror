Return-Path: <johannes.schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by sourceware.org (Postfix) with ESMTPS id C75A03892454
 for <cygwin-patches@cygwin.com>; Tue,  1 Sep 2020 19:49:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C75A03892454
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=johannes.schindelin@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598989765;
 bh=SmFQVgCNUf5Nbtm2UIys/sX6nw+Si/t5SOki1cTVQuc=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=gEt3EGdtylJZ0oWce9LKCR2XHa/tflc8pwJ+ilMesgjyXWD/CrJdM6B24qMj3lEWv
 76v/3rEuJ9f9FYwUAhZmUEk79hCBkzhQm5wEqYb6HBL1U/rrqvna1BFbELhpXuKZxB
 ohd1eu/rPpV8pXLez5WH1aBH4mGT6kV8MHrG0AE0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([89.1.214.118]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b6b-1kEanQ0HWP-0080Ya for
 <cygwin-patches@cygwin.com>; Tue, 01 Sep 2020 21:49:25 +0200
Date: Tue, 1 Sep 2020 18:18:15 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/3] pty: use the UTF-8 code page by default for non-Cygwin
 console applications
Message-ID: <nycvar.QRO.7.76.6.2009011813260.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DBgdIUlThdF34Z4QI3Bv2J5rouLlmRNwohqsp4Lo60wNvIgQ2uL
 i6yraW/UzEQqomICDJciKAjt7vCvyuk4xpoUZY7Ev9+kRhbKoloFiKtKAVF+gMu7kXkdyyh
 H2rsSb9W1dn/cQVtJtA9AkJd/Lyd67pshd4KKgiM4SrYTbTw8GUbJ0Lk5hKvzoe/dQ7YLyw
 ZZvZQuYNYB2f1xaDuRJow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lKtbr5S2Z8M=:/lE1XglNhzST7peEOzMXb7
 xrzZJhHX7OMuegw1elfvxtMDmbeSSB+KTSiVLzRI8PIYUV5kYz8nIivJdxdpxkGLvNBG2hmwr
 X/AcEvEH6ZrehggWgnV2LRQjIK5mZbeqFOoGSDWli3o/H+w/dg3uHBV/SsRP4IPUE7QD6ybHJ
 3TGYOAiBYnVJ1cInuUjYFPEe9UkOyoB9J8IDi1OAlkWuWdqFANq0r5eH6jrERG3ou3nz0GLkQ
 vXCg2Y0fHwwoVMkMQIk0gGpSG9DYi6rF/qY6035Vzvk6KAqbRzXgDjP7Tp0hJ5Pmyr8TuyegV
 4Jz9T8IZTdQVXhmEH8hu3uHjpKPChB86GBM2pS7SgE5+cnVSupUq8NhZiplZ/i/h2IYzVYuTS
 kmBxzs0YiRduQGlM8OLEbI5XE/LVsdhnUsLGWNyLJISSIWywUOO7G/Sd2OKrqE7F339oNtBGZ
 1l0fcuk0Hr0GI+g8jnlmZldDcAKYnRIPSMrT34DGpexTus++JlyEOc1HhpvP29BcXaCkSbQzO
 a/IdwaDqRRFTvuH6km7VQGhabwGA3LwGKvne47pXLzirN7IZdXd4XFLaNM6w5NgFX1aBWI8r5
 MF3RhChj9pAk+r4jM4jSdqzEKp5a1F/wtXuBDaVmfWGYSIYSpID+H1gVsmDC6SFd5L9QYUFdr
 OYrgJo5gfErIxnBldPxdqdeDivPNoHoiddQs/GKkTF84ulDoY7gy3lsDiNeG34KXPYqt2zqKM
 zA00WAB8HyyDcdBAqzgzFz+oiRTNSsSnN+sJt7VVhxwDFz0WqofPRGdFKfLPFwLPZafYepQV4
 WeTB8gNiqp98EeamietBYkLNhe4i6sff/Q8MzMg6Q4AwMU9hewtddOFgLPJGth+ittaDgPxpS
 LIjHRTEJmbQV8FqWrJZDzHm+YUkZVHJMsndsjYDeCMXwEI/WDu5k6mVXWPcxdvH5v1JjOOnwl
 q9Cspopp6rZ2swXPd0slFxImschdfHLpR4ubn3jUrQMw/2imv36e0TYXMPjoTXx/NdpeX+QPa
 6dsZ8fwJGh9bv2zHUG2e+4jOelgNxcVh6Gx4EtLFM2vqB23+/Zh7e08/mvjT+QxmcJNWbThj/
 /NeY9DAaRUVud8PtmIfZBQH4wAeV7dXnQf4SGeiKsDfUBJIZKZReRpwrMj26EXbhEezm2VTZM
 h50v5Et+rrJtQBaZW1wtMOvo+UcVhSuZsyCSfOEt+nsOWbX2xtukesKULqltSpOJJ/5/GD9oX
 nGq1BHTTAga8sO3Yi/P/kXdkNIF0zh5ux4X4u7A==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00, DATE_IN_PAST_03_06,
 DKIM_SIGNED, DKIM_VALID, FREEMAIL_FROM, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Tue, 01 Sep 2020 19:49:30 -0000

This patch series is the result of what was discussed in
https://cygwin.com/pipermail/cygwin-developers/2020-September/011962.html

While it is still not quite clear to me how the Console output code page
is used under `disable_pcon` (when it was not used at all prior to the
Pseudo Console patches, i.e. in v3.0.x), it is clear to me that using
ASCII by default is not desirable.

So here are patches to address this. Incidentally, this addresses quite a
few tickets in the MSYS2 and Git for Windows projects.

Johannes Schindelin (3):
  fhandler_pty_slave::setup_locale: fix typo
  fhandler_pty_slave::setup_locale: fall back to UTF-8, not ASCII
  fhandler_pty_slave::setup_locale: respect charset =3D=3D "UTF-8"

 winsup/cygwin/fhandler_tty.cc | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

=2D-
2.27.0

