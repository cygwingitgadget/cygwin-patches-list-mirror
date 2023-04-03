Return-Path: <SRS0=7Fjc=72=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id E50F83853D05
	for <cygwin-patches@cygwin.com>; Mon,  3 Apr 2023 14:45:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E50F83853D05
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1680533112; i=johannes.schindelin@gmx.de;
	bh=PCYVYc8NCr+rGWAYO5cREJ6PSZRREXpIxMo0cf/iSOQ=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=TnCsGlFH+UCZtjaqYCMQK+TN4cebFROnvmKsQevtdIfFB5TqmEgUS7Kr6YikSSxAt
	 5aRlIcBwtObqYks2Si2qXzGvPCGOR5zQpO3RMg84ARGgYKj8exUktAKGz6FiTogj2u
	 fKP/cUEuCxwjledElIruJu4KOZe+cA+kYBlg4mefCIXz9PmNeFlukZh6TY8WWVS2ZI
	 eaYYD6HRbOvAtu77jRPdYOImB8TV0IEEMQgPvz3SYhxpVxWg/r7bVbyQlKhXIszAxa
	 AD0lyE0wKwjBxB2Qxar/H68pUGnTca0akEI2Hs2u9BHBI1umGZiZ24BsJQ+4gOrrH/
	 xe33HJPzyuQIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.182]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2wGs-1piFV61qgO-003JrK for
 <cygwin-patches@cygwin.com>; Mon, 03 Apr 2023 16:45:12 +0200
Date: Mon, 3 Apr 2023 16:45:11 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v5 3/3] Respect `db_home: env` even when no uid can be
 determined
In-Reply-To: <cover.1680532960.git.johannes.schindelin@gmx.de>
Message-ID: <cf47afcebad07c1187d14542db34cfef3c909c47.1680532960.git.johannes.schindelin@gmx.de>
References: <cover.1679991274.git.johannes.schindelin@gmx.de> <cover.1680532960.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:74B58e+T9Vm3AQ6C7f50whWuFfrjVbwSwBaxDoc+YK6Zzmbgn+7
 fpUh3GGwlFQiBnlC73uUMhcZQ+Z5UrizwkYnGodjImh3TbFAEy8nDZpXi5kZGdaOnj3YtfF
 DHSiy9N2FZWoTPePaHlyZDGXLuoJFOUeyvb5Os4SlcPXmREXl2jQx6pc7Am5aX9OEb3BQoa
 dk0H3BCW/LSlzICxMt82Q==
UI-OutboundReport: notjunk:1;M01:P0:Nurv4nTK7fw=;xPY2hOSK98ojqrh0WVvuRpj01HG
 DD5q11/wbV912U60yuxIb5b4W4clObBprOuCQhzH6Ln8wYs90Zhbn/bQqfiZ3ADyCU67Xa3J+
 VOsB43xrytHmyCH4ORsQ1YFcOqJ8+Y8JpKEfd+jL8UEIOmNMoRaspdkvtj2NBty8TMj09fsDn
 d+uaYxkAl1XWXkAxnAiMUp+PARKVXjLo8uWdEisYLd/nFQKeSEwMwLHMi3W77LLQNlKqq0hWg
 HeNR7AJpjW8eTQrperr787DvyI9Ag/MNfHtJidnJctfFUMpkirqpUGbwLdyJAgpBRnNf1ZoK+
 JnQXBefmkkFIsrUotuCUJpDX5Tqew/EzyYkKi7wRd2naKLYxIbkFruvCRLDvoTNv4aLV9CPAv
 Tsb0ZNZShtOsdQSpxxwEN7bfJwcjeBojg0tu4OdeYH+TDoQ/Djw/m/1UwQuTC+WXU5oWzAeu7
 CHr1wvDb3yvEZdl2F5nQ5iz+aw7RsQXqVGc0Ey/C8OyKmaqdf51P/Gfl51D9fRYQWx9E6V0ua
 aQxF2WtCozk+nkcgKTL84cuY5fiuQdAllQ7hylHkDMN32YGc8AmBSytGa0ATlqUWf9vXBe19m
 1favmL5Zt5YyHEQ3LWQI+0QHU2VkKLZtLXetkjDwS/s6eR1aWN4mdt0LlrpG1heLGAu6joLj6
 5nvjkNvqAEkgatHDhdeLArBGdVGDxHD3oeQL22vC3DXTAqWGYd+ZRsHYW9IvDRU2dV16B/byJ
 A+H3ZFnohJsLBydkgguMIRx5syZ51eIkMzytdsXOv5vjtfw3GNwqgVSCVk0Ul/6FLidUqqUxp
 V4xgDVlAPSnnH5PPZyEkvr2JUKoaor32kIDQ9oviLqQ3eAbSJ/+RYziGP6fryib0JL5SG35oi
 qgZh+mu8v1J7lJWWZQPDtoDuDMseX37rAHqcpN7nzawWcc57EcbVMS83qTe7oH3pIRxtnMP9j
 wDkOUw==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

When we cannot figure out a uid for the current user, we should still
respect the `db_home: env` setting.

This is particularly important when programs like `ssh` look for the
home directory of the usr, the user overrode `HOME` to "help" Cygwin
determine where the home directory is. Cygwin should not ignore this.

One situation where we cannot determine a uid is when the domain
returned by `LookupAccountSid()` is not our machine name and at the same
time our machine is no domain member: In that case, we have nobody to
ask for the POSIX offset necessary to come up with the uid.

Azure Web Apps represent such a scenario, which can be verified e.g. in
a Kudu console (for details about Kudu consoles, see
https://github.com/projectkudu/kudu/wiki/Kudu-console): the domain is
`IIS APPPOOL`, the account name is the name of the Azure Web App, the
SID starts with 'S-1-5-82-`, and `pwdgrp::fetch_account_from_windows()`
runs into the code path where "[...] the domain returned by
LookupAccountSid is not our machine name, and if our machine is no
domain member, we lose.  We have nobody to ask for the POSIX offset."

In such a scenario, OpenSSH's `getuid()` call will receive the return
value -1, and the subsequent `getpwuid()` call (whose return value's
`pw_dir` is used as home directory) needs to be forced to respect
`db_home: env`, which this here patch does.

Reported-by: David Ebbo <david.ebbo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 winsup/cygwin/uinfo.cc | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
index d493d29b3b..b01bcff5cb 100644
=2D-- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -883,6 +883,8 @@ fetch_from_path (cyg_ldap *pldap, PUSER_INFO_3 ui, cyg=
psid &sid, PCWSTR str,
 	    case L'u':
 	      if (full_qualified)
 		{
+		  if (!dom)
+		    break;
 		  w =3D wcpncpy (w, dom, we - w);
 		  if (w < we)
 		    *w++ =3D NSS_SEPARATOR_CHAR;
@@ -893,6 +895,8 @@ fetch_from_path (cyg_ldap *pldap, PUSER_INFO_3 ui, cyg=
psid &sid, PCWSTR str,
 	      w =3D wcpncpy (w, name, we - w);
 	      break;
 	    case L'D':
+	      if (!dom)
+		break;
 	      w =3D wcpncpy (w, dom, we - w);
 	      break;
 	    case L'H':
@@ -2181,6 +2185,10 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg_=
t &arg, cyg_ldap *pldap)
 	{
 	  /* Just some fake. */
 	  sid =3D csid.create (99, 1, 0);
+	  if (arg.id =3D=3D cygheap->user.real_uid)
+	    home =3D cygheap->pg.get_home ((PUSER_INFO_3) NULL,
+					 cygheap->user.sid(),
+					 NULL, NULL, false);
 	  break;
 	}
       else if (arg.id >=3D UNIX_POSIX_OFFSET)
@@ -2710,10 +2718,11 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg=
_t &arg, cyg_ldap *pldap)
      logon.  Unless it's the SYSTEM account.  This conveniently allows to
      logon interactively as SYSTEM for debugging purposes. */
   else if (acc_type !=3D SidTypeUser && sid !=3D well_known_system_sid)
-    __small_sprintf (linebuf, "%W:*:%u:%u:U-%W\\%W,%s:/:/sbin/nologin",
+    __small_sprintf (linebuf, "%W:*:%u:%u:U-%W\\%W,%s:%s:/sbin/nologin",
 		     posix_name, uid, gid,
 		     dom, name,
-		     sid.string ((char *) sidstr));
+		     sid.string ((char *) sidstr),
+		     home ? home : "/");
   else
     __small_sprintf (linebuf, "%W:*:%u:%u:%s%sU-%W\\%W,%s:%s%W:%s",
 		     posix_name, uid, gid,
=2D-
2.40.0.windows.1
