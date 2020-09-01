Return-Path: <johannes.schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by sourceware.org (Postfix) with ESMTPS id A3F5E3959CB6
 for <cygwin-patches@cygwin.com>; Tue,  1 Sep 2020 19:50:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A3F5E3959CB6
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=johannes.schindelin@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598989826;
 bh=wMPcy3XbRNJKxxeWi8UqIZhG5XQKFP00u+MEVC8prvo=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=k74xDf1NM/gSzkLcxa3uyvl+ajh3KKC5VRkLOhV2w1dx0/Rfdrekb+QWsJVIyxnQy
 LikR1ABSvHirHusplH+DuFFbQlndLVJb7RYovdaYoIPpLiXDlBNcCIN+3RUKyG/aLM
 K2k+KXhpCTOZQMhQzmnTndXpffft/mb/1ogKf4gA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([89.1.214.118]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MoO6C-1kxFVK1K5w-00olVW for
 <cygwin-patches@cygwin.com>; Tue, 01 Sep 2020 21:50:26 +0200
Date: Tue, 1 Sep 2020 18:19:16 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: cygwin-patches@cygwin.com
Subject: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset ==
 "UTF-8"
Message-ID: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VtoDZoVd9eDVNVDOQxd/R/hF5TE+GulL6foWVOYHajj2IE52YZw
 nSeX40PjPepqAr16nR4PD/9X/KFhfIEbNvFC4wo4N/eSvjt1g0P11O/kHyUD2GxsNPVMvef
 9SvKgpfCntYQYSfTmKjQBKALI4ic3Y80WRnUKp1w25v3zpfJtF2sjeahk1sDEiG48gdkfQR
 zULKNsfUqczSka/2s6LvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rxwJE7h6/CI=:i8hzNJEydcVlk0o8NzXhRn
 eFp2sNGhDzDy0KM0A9hCSLfq6sdVTkHNflU+WpFrYxEWLxDjh/J/TUjvtV2U1s4NEwVgYzosF
 NRTJPvI9hymK8PJa2dn86tcAzn/WGOzGzxtwSqFZzeWB5W/dRAUeqDXLocerBOdlyddD9duYr
 srAD6yHthrLhRpw/yXftx0aWjd2TLPw53JEws+fJSdTD4vn+3eb805HiFJFK8NGvayrop+eJT
 KzYcBYVOjCPArv0HnlUqH0N7vrlyezjfhwhb9KdVK0das8d+70679K0LVh5kjONlxDsAHIul2
 91Nj0rXQZtLisXmoSzRdzfE7rqWfKIIs9k+6Zyt7Xt2ZznOKD3iClesZlMz1k4BTC3BEUyzng
 HZE0MURnUJLDoLwbKPr1NjuM3jB0PjBD7tJ+oFmvxDMBK0KreL3hO25chY+Po535mzEqotBmc
 He8XBJF5KIBgi/raVe8UNytsMLPwCGQZgiLnnObv/wc7kl353znS16YJlxXuTvS3dLo4INZu0
 8yn4rxXCuuE+3jJPZ55sIGS2msWtNtMdDqazDHHuWMWj7QdRujQJm/APx1R2cBQBPPXuJm3cY
 2kkZgZb/O3GhOBuurqP9M4r9VYIbcUcUsg2aMk7BxBvVKvPNDixVjPft7hHItBxFqfIbw+TP2
 KvPXB0lg2TqyxZ5ZWcUcInCPkfkttTCRv7WUuR3FjW5xwrJcLQDSfKiuqVPt61PR5xTNDxWTU
 G7gFsv37kxHU/t+TFSgMM7FygGSePSm7Idh1hxVUzFt/bZ/ocON2L7AxL4AWxxSBmG3WN/ehS
 Yt22W1f4HcrYhP8Woe4ud+OyssRtpuzucWCOhO7zc+zw8GQ27s9owi1j1da3Yn3Tv7bq3zrtp
 tp+wJQBibQ0iPb18BkP/vzGXe2E7wUb84jo9EVjbIpkVRM6xKVtQtoVsyvYGtmLJsArrWfKRg
 tH4/aV6qV7SOMzIC/IKjU4XpxEP1jZjVL7D0+bsfYmxr5reH8QJwVB8BNAhNz//OvDeb/ig3h
 l0AiwxogD5thg4P7x/dlwbzmFUPixhBr2eepEiTWWUVtCmh+pgqbKXp/XeiNQjH960NDcmXY8
 OWU3NknUBNu84oZ0gU5PGWcluBeRgDRgwGUfSAUvvdJWjswLbbeJpHFG2gmKFuETCz2Mf2yl4
 xVS+AjE+ZXzVkikebm/ssfoEXwdcdR48IqEmIKlWW1V3g1qR/q5OZb8GEGoHzVNFgR9wlhR2E
 GCSOSHKk/Vl5QJdtFdvxlBO5/lTT9UYPSNmH5ag==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00, DATE_IN_PAST_03_06,
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
X-List-Received-Date: Tue, 01 Sep 2020 19:50:29 -0000

When `LANG=3Den_US.UTF-8`, the detected `LCID` is 0x0409, which is
correct, but after that (at least if Pseudo Console support is enabled),
we try to find the default code page for that `LCID`, which is ASCII
(437). Subsequently, we set the Console output code page to that value,
completely ignoring that we wanted to use UTF-8.

Let's not ignore the specifically asked-for UTF-8 character set.

While at it, let's also set the Console output code page even if Pseudo
Console support is disabled; contrary to the behavior of v3.0.7, the
Console output code page is not ignored in that case.

The most common symptom would be that console applications which do not
specifically call `SetConsoleOutputCP()` but output UTF-8-encoded text
seem to be broken with v3.1.x when they worked plenty fine with v3.0.x.

This fixes https://github.com/msys2/MSYS2-packages/issues/1974,
https://github.com/msys2/MSYS2-packages/issues/2012,
https://github.com/rust-lang/cargo/issues/8369,
https://github.com/git-for-windows/git/issues/2734,
https://github.com/git-for-windows/git/issues/2793,
https://github.com/git-for-windows/git/issues/2792, and possibly quite a
few others.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 winsup/cygwin/fhandler_tty.cc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 06789a500..414c26992 100644
=2D-- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2859,6 +2859,15 @@ fhandler_pty_slave::setup_locale (void)
   char charset[ENCODING_LEN + 1] =3D "ASCII";
   LCID lcid =3D get_langinfo (locale, charset);

+  /* Special-case the UTF-8 character set */
+  if (strcasecmp (charset, "UTF-8") =3D=3D 0)
+    {
+      get_ttyp ()->term_code_page =3D CP_UTF8;
+      SetConsoleCP (CP_UTF8);
+      SetConsoleOutputCP (CP_UTF8);
+      return;
+    }
+
   /* Set console code page from locale */
   if (get_pseudo_console ())
     {
=2D-
2.27.0

