Return-Path: <SRS0=A2VF=ZD=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id A3A1D3846E64
	for <cygwin-patches@cygwin.com>; Fri, 20 Jun 2025 10:03:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A3A1D3846E64
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A3A1D3846E64
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750413794; cv=none;
	b=K3clMumL1LF4jRObf5zj/RNrlcq0qQHI3UHYo0c/skmneS10foYzhkMN3yJDE0Qq1ePRKjtd9U7f9ZngEIgA5cyh3OebgzLi4AqfLsrNd0iGG/1UsXwxrYMQ/rDwa8WTW7lL9k2D9CqrzfB7dgltRFA+636zFXCKq1pvO7buG7k=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750413794; c=relaxed/simple;
	bh=4mThXftBAR0A9nj9keguW1fg+PTB4zlERJLMQnQNLDw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=bqavskGFlBkp1NQX7gSp5WvFg8oS8SmELy4HDjhdVOgqwYpVSVx+PsnDxvJWbptGdvw2wBYBiQJtaquw6e0dMjZgdRH+YNOnXcvHG2vh9UuJba+0SX6vvlxse/QhsFll4Cm4r+sEuZ0MieGgyQeZuK4TcMn8Dn6ScuL4Iapdj0c=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A3A1D3846E64
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=cabXcqJP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1750413792; x=1751018592;
	i=johannes.schindelin@gmx.de;
	bh=8GE5qW/P2gjrYdxeVNZBPl/r8C2cb9suxQjO6axtWJk=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cabXcqJP79s674Vebk25+mWRTjfWnV6WhH0PV6yQhGYkkTftOcBRf6vdy9xOYXQp
	 +uLzL7c9vIFAka6zhqmuwfZdEMbrqD58fmLWwYgx8aur6Zd1fmGifXodE+90UnzMK
	 M0ZV6fv9cmA9Fsw9nLhgfg905F/OHhRbvvbTq58AF6A7WdqXE/1JFsTm70Fg7rAUp
	 dQE8/H0YFCQEWSSg4X0ow/R5Bzb5bbIHN2Nj3fEN6k/WF+4bphVPot1Og9BxZDmml
	 ekbAg+pfMKQvbCKQvDanMvoMIQ1es3EZHKKMkP/3q0Y9ll1VBSqX45fU64BJ1T2ci
	 ytzXH8LP9MvzB1hXaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.6]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxUnp-1uhsPO47ir-01514z for
 <cygwin-patches@cygwin.com>; Fri, 20 Jun 2025 12:03:12 +0200
Date: Fri, 20 Jun 2025 12:03:11 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH] symlink_native: allow linking to `..`
Message-ID: <6058889e2ae8c9c827a8d6678f09b3b1741e2fcf.1750413578.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YkZODj50QnTJVy2lXFdWlT3HjsqeeARxCID8ILvkZMAkOOTZpxi
 7zUNpukkMC+spHbexzaqFJ24zAmJ3PMBJKREU3y5fKfo7kMu4E177u6tBg9MjE1Hvm/1c20
 faxmfWwLVXAxvF9AdiCPg5iTh45WuTFplZqWVt6VYAwpnB0mH15zOKC9YwtgjWmgGCeHaR7
 SP84fh9lTsCT+rjkHoPSw==
UI-OutboundReport: notjunk:1;M01:P0:YBk5f3WXPAQ=;0nAt7cC6ueWYEIEE2Wg3BqnM37F
 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
 QPc4=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

When running

	CYGWIN=3Dwinsymlinks:nativestrict ln -s .. abc

the counter-intuitive result is _not_ a symbolic link to `..`, but
instead to `../../$(basename "$PWD")`.

The reason for this is that the search for the longest common prefix
assumes that the link target is not a strict prefix of the parent
directory of the link itself.

Let's fix that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
Published-As: https://github.com/dscho/msys2-runtime/releases/tag/fix-dotd=
ot-native_symlink-v1
Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime fix-dotdot-=
native_symlink-v1


	I investigated a failure in the Git test suite and was quite
	surprised that `ln -s .. dir/link-git` resulted in this:

		link-dir -> ../../trash\ directory.t1006-cat-file

	instead of this:

		link-dir -> ..

 winsup/cygwin/path.cc | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 42919a7cf5..ed08398930 100644
=2D-- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -1855,9 +1855,18 @@ symlink_native (const char *oldpath, path_conv &win=
32_newpath)
       while (towupper (*++c_old) =3D=3D towupper (*++c_new))
 	;
       /* The last component could share a common prefix, so make sure we =
end
-         up on the first char after the last common backslash. */
-      while (c_old[-1] !=3D L'\\')
-	--c_old, --c_new;
+         up on the first char after the last common backslash.
+
+	 However, if c_old is a strict prefix of c_new (at a component
+	 boundary), or vice versa, then do not try to find the last common
+	 backslash. */
+      if ((!*c_old || *c_old =3D=3D L'\\') && (!*c_new || *c_new =3D=3D L=
'\\'))
+	c_old +=3D !!*c_old, c_new +=3D !!*c_new;
+      else
+	{
+	  while (c_old[-1] !=3D L'\\')
+	    --c_old, --c_new;
+	}
=20
       /* 2. Check if prefix is long enough.  The prefix must at least poi=
nts to
             a complete device:  \\?\X:\ or \\?\UNC\server\share\ are the =
minimum
@@ -1882,8 +1891,10 @@ symlink_native (const char *oldpath, path_conv &win=
32_newpath)
 	  final_oldpath =3D &final_oldpath_buf;
 	  final_oldpath->Buffer =3D tp.w_get ();
 	  PWCHAR e_old =3D final_oldpath->Buffer;
-	  while (num-- > 0)
-	    e_old =3D wcpcpy (e_old, L"..\\");
+	  while (num > 1 || (num =3D=3D 1 && *c_old))
+	    e_old =3D wcpcpy (e_old, L"..\\"), num--;
+	  if (num > 0)
+	    e_old =3D wcpcpy (e_old, L"..");
 	  wcpcpy (e_old, c_old);
 	}
     }

base-commit: 1186791e9f404644832023b8fa801227c2995ab7
=2D-=20
2.50.0.rc2.windows.1
