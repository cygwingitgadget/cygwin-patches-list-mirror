Return-Path: <johannes.schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by sourceware.org (Postfix) with ESMTPS id 98AAB3858411
 for <cygwin-patches@cygwin.com>; Tue, 16 Nov 2021 10:26:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 98AAB3858411
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1637058372;
 bh=i1mhMonyIlqLbGQgB9oDUO3SYHxTuE4V02H4ibJXOUs=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=XiCbpubr7/NEKAdVKhAGz0SnEGZnfzlC9MmyUo32+q1k1+OMlzfMHCPQLgtBPcphu
 Ys80akS/2qBJkV6v6HD0dbC06rkmcdtyqO3FtJwvmB0MASBBrvwUi+71Hb8TdzZQ/Y
 M5SMudpML+jcGFucu7+cl9QFd1gr56xJ4BPSwO9s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.213.220]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7i8O-1mZA3C0b5e-014iOk for
 <cygwin-patches@cygwin.com>; Tue, 16 Nov 2021 11:26:12 +0100
Date: Tue, 16 Nov 2021 11:26:10 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: cygwin-patches@cygwin.com
Subject: [PATCH] console: handle Unicode surrogate pairs
Message-ID: <nycvar.QRO.7.76.6.2111161125300.21127@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1Hq8F3hcYGchcJz3waEEJV1TFs9QXvl8E639xPrZtVxTvVvcgcx
 5Qapi11OjUoAWe2aHgtmcIod/7PilgG2+XdPzVaUbJ2VegJvQD8wJHXdJQkJZjdMSrrTrjr
 3QdUamSZNq4y1uqCgDwAufwtnfzTJAykYU/b8c8Lag4lshKVTVCWeayv6vbQyYDgW4AfHEL
 3PyRoW5YCVoeVGLuUCyEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O/Nu174ptHE=:gf69tYnFM3XbKVKBmIwwUV
 a28YTFVux5tVdK41f7gf9mYLm5FWVXBvo2+RVMz+64RYwl5GpavEfFstT6JX6QCjw75gUzpj4
 gOgjsZuIH1OLcH+HwCJYyeyt7YrCEN0shPDjwJOWfjLc5I2sie7qs2NBSMRvFQiH0TgAaqzFI
 TdHfziHmoWTPGsd3fOPp0zWbms1xOZGFFIWPrWuvno1olhEGi8z3LIg6mERXr5l2O+2aEJYVp
 7Ct7mqCJ1WydzYcOxBfzok/dqEMkx21vqlQvV6JFZNyFDVM8rJLbtIjlKNyeO9A6utxEH4Z2U
 AbEEI/Yc+k5HvW8AQ8Nv5BINKodbWv85Ef1Ksp5hNCpkIwfvcesPzzSv42/5jrHRrmFdkIGzM
 aS24DNxLcdJzPYtMsu1KafkO+fdqdiLf4mp5eynsXFJbn9RbSaUMIc016ebfthqFzNvHmoVqw
 4961+VOKtHySW7sVOqMUkFpkYdg+M03H4DoeqWG2abkGe5tWFa+nCmUPB8oOdIz8csMLXORlk
 600zeizmVr5Rgg3WvbX3+s5HDdkXJJo0tByCZpLbSiy8CXwR3KDyVhM0M+Z/w/Gti6dSI06zR
 jI7TFqMpEOl+vZzx/Tqv5N3VRhmNVHXzuGbzwNoffytBDukYc37V3OLr9UEzhlM2e1HuuDt+J
 pUgSNRLZglOiZMWVG4ltV7IYd6iDQJ0wWa9p4/2+QbZFOnFBt8fcbNrSpitE7YnZaYmTxrV+B
 04dkfQb28t5cjMncJzhGtSgW0aBvy5imFE6ZNymfZA8Asx7w8gtE4Lftlmn1L4MXSWyoQois2
 IsNuMf95Tb/ZANKQdQ59LXM3pbt0d8tkkMW+hsV89QmWO1/OQ2embPO+e1OSBwX4w4Bm4sxFx
 n+xRzlWYeElPt3kR1JbxZ7Qr3tHWmURP62R6kFY97iQ4dghuDFvvpWKbHWTRU/WWdK1XMRDqq
 /3jrL5WSZfLVunagYbh7WLUcUTw8SaMNQLOenw5Ueht/8UmTIGhEW1N6SgJPVax9d6GteG/Qk
 qLQsehvNBq0++WOuH9xWrBeyYVxkiqMvw81I6koBJslqbuIhr4UKP9Fq2dTwIAfwq+xurIEdu
 K2pFvBrZBvx5Z0=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, FREEMAIL_FROM, GIT_PATCH_0, RCVD_IN_DNSWL_LOW, SPF_HELO_NONE,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Tue, 16 Nov 2021 10:26:16 -0000

When running Cygwin's Bash in the Windows Terminal (see
https://docs.microsoft.com/en-us/windows/terminal/ for details), Cygwin
is receiving keyboard input in the form of UTF-16 characters.

UTF-16 has that awkward challenge that it cannot map the full Unicode
range, and to make up for it, there are the ranges U+D800-U+DBFF and
U+DC00-U+DFFF which are illegal except when they come in a pair encoding
for Unicode characters beyond U+FFFF.

Cygwin does not handle such surrogate pairs correctly at the moment, as
can be seen e.g. when running Cygwin's Bash in the Windows Terminal and
then inserting an emoji (e.g. via Windows + <dot>, which opens an emoji
picker on recent Windows versions): Instead of showing an emoji, this
shows the infamous question mark in a black triangle, i.e. the invalid
Unicode character.

Let's special-case surrogate pairs in this scenario.

This fixes https://github.com/git-for-windows/git/issues/3281

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--

	This applies without merge conflict all the way back to
	cygwin_2_7_0-release.

 winsup/cygwin/fhandler_console.cc | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_co=
nsole.cc
index 3e17fd9a41..d11f4a4770 100644
=2D-- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -453,7 +453,22 @@ fhandler_console::read (void *pv, size_t& buflen)
 	    }
 	  else
 	    {
-	      nread =3D con.con_to_str (tmp + 1, 59, unicode_char);
+	      WCHAR second =3D unicode_char >=3D 0xd800 && unicode_char <=3D 0xd=
bff
+		  && i + 1 < total_read ?
+		  input_rec[i + 1].Event.KeyEvent.uChar.UnicodeChar : 0;
+
+	      if (second < 0xdc00 || second > 0xdfff)
+		{
+		  nread =3D con.con_to_str (tmp + 1, 59, unicode_char);
+		}
+	      else
+		{
+		  /* handle surrogate pairs */
+		  WCHAR pair[2] =3D { unicode_char, second };
+		  nread =3D sys_wcstombs (tmp + 1, 59, pair, 2);
+		  i++;
+		}
+
 	      /* Determine if the keystroke is modified by META.  The tricky
 		 part is to distinguish whether the right Alt key should be
 		 recognized as Alt, or as AltGr. */
=2D-
2.34.0.rc2.windows.1

