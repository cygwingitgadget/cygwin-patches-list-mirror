Return-Path: <johannes.schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by sourceware.org (Postfix) with ESMTPS id 4C95D3892454
 for <cygwin-patches@cygwin.com>; Tue,  1 Sep 2020 19:49:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4C95D3892454
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=johannes.schindelin@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598989779;
 bh=LK8FtSTe1tBcjTaXDsETQonFUtIh81FjU6VrzFSZa0Q=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=RhOw3t+UBRj9Twjs1RvGT+T6BELozFRQK+7cf76I+tRHJ3vRdEIslZfVi5KQmH7fh
 LYJvifLXKkdXqMPaCFRnEzcLYX+i1wt+PFGRfidcM4rQvLrqJ2bLpz8KSjcsGiHO0Z
 qwcIp3aKG1fnwMfNf0qJjdeHTTHMVuLKpJPpgQSE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([89.1.214.118]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wpt-1kbZfe2d5d-012IP7 for
 <cygwin-patches@cygwin.com>; Tue, 01 Sep 2020 21:49:39 +0200
Date: Tue, 1 Sep 2020 18:18:29 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/3] fhandler_pty_slave::setup_locale: fix typo
Message-ID: <nycvar.QRO.7.76.6.2009011818210.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Mcz2/+M5PVmbHrkqvbgNi2y7J88dqqq9UXlLgae1iMvqRgb7Tw3
 npxWnfZ3d0g9bs4i5l9r5v367OMpJhR2Qk+g0QjBGQPBe+yzjl7+OxKrrwU1rrF+P646qN+
 9RpFdrMdqk7vHHxzCsxYfdZftqixctvl8ozBCe9Abm1+2X1vOU/jwVGZcKCpe+ou2GT5bqJ
 a8mJGdOFgFmv0ic026wlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T34QuT26reM=:roFGWdXqLUFVa5tKFBHPCp
 V+WgecbAlGHA2sy3xqM+3kLorx9RcMWOC3175WmxNdOdq6P2mJ+mu5VsFE1RIj1MwDoma8yKz
 6Hoe4o+w9Rz3kE9PBlENFwqrG5KbHXO7oHEsORATzEg2JsjvX2JB6zCcUY6WUWgASc/H531YU
 rqg/ZSBMCj9uDMOxQiFa7/5pegrzpeVAbeqGONbCmiTr7OH2vRKgbjbGM25x49UBs8qgDHGS2
 QpjzA0rGqvY/o5S3YEESXGe5MYyJ9CBh89XG9v+0pqh59kty60bHS2mVlYvMRBz/TWtyYaGee
 6DPvLGF4gmO+ydNtlADsD0pePy1bZgIUEOuI6MKAO+uoAn/1coS/UjtKhknbkR0142AAGrtpV
 0RGHNfiRnf0P7bKVbBitQBBbyeuO4bD1aThhdxbmPSC+fQ3JQdybC/WfUOtyTVllA5lgpycjC
 n9FT1HC/NfJsSI+GIZKMWBJri0lXswNat7qRZiOMRr0XsNqhZ7uPIO7WW6xQszBTypByxaxw6
 HSraUnn5yWujApP/ZQfJZ40uxIJj3q3YdID6aUjOBNk718pJizRl8hSnsbB9CDbXdmK/ltv8h
 mHgxK2rjggrYqra8o7FHtYUEiXcDaLJJPwL2L5KHKQCTtL0GCS4mtXQeTv4/gwrMtK6yPOFqE
 0Un+MzLEX5p9YGz+0jCTJlas2S1aiMQSSkPkYMGy0RBC6xlM0GXy+BVXMFWEXBMHCxBbJ9DJL
 2Tmu6nuQvS4u45KNaQvg60KkBzCr6waQPOC4L6wXeZHOlIljh1u5oKisV8H7jMGQ/rtjRBDZ8
 D0qI40KrJXYO1CgoWl1KQ1D9Hq2Fq060XeACwePkLKuAUCU0c2B1qpT2LdSsxvKGjXgRi6Eak
 GKTjMGbJYMFmEB3RsCNvnu7EuLFraSVrsLCBVolsLPldlnEX1cSWSgvSSr5d23JnBq5QuhaFa
 trxoTFI7nl4auWdq3pMpsz69u5HQGl1PFwuNqApfVYv1WBIdSlsdmD9CqxeFbFK0LHlZugiDV
 Ux9Anool/Lbvq7aRTdDIPstok4dckIhzIQLBITkYqrbjVgUzjEPO4MhBPYo7iyqRN9zep46ac
 YaXPsp0QNnlYPNKSB8WrJHtk2Px1gEc9HdIkJzodIzGbjppf1+bYCpii0Xxv8JB/VrIpdxMdO
 VL31D2ZFiQ+E9klm0yoIT8O7pMAW9cLv+p6XU0tcgheUIsGVMPMyJrO6Qi58J7F+gr75lLDC3
 LnEthAVRa+pBTo7eBWeFqj3/wxB1F4G2thOSspw==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00, DATE_IN_PAST_03_06,
 DKIM_SIGNED, DKIM_VALID, FREEMAIL_FROM, GIT_PATCH_0, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 01 Sep 2020 19:49:43 -0000

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 winsup/cygwin/fhandler_tty.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 6294e2c20..b3458595a 100644
=2D-- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2859,7 +2859,7 @@ fhandler_pty_slave::setup_locale (void)
   char charset[ENCODING_LEN + 1] =3D "ASCII";
   LCID lcid =3D get_langinfo (locale, charset);

-  /* Set console code page form locale */
+  /* Set console code page from locale */
   if (get_pseudo_console ())
     {
       UINT code_page;
=2D-
2.27.0

