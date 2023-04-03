Return-Path: <SRS0=7Fjc=72=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id 6DB76385842A
	for <cygwin-patches@cygwin.com>; Mon,  3 Apr 2023 14:45:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6DB76385842A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1680533105; i=johannes.schindelin@gmx.de;
	bh=rdlqqX1i9rotQsJspmbsq7uiN53Yh8xjfM4sAH4lylI=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=TcfOWpU4PfX+XOKcl2Wli81jdZ+zqlWMIqo/lr4v3F6KsJ8hgQjew0lT2/7gJzwcz
	 zMLrxvptAoU9K6rJt7X8+5Wa4/j4igY+EWOSc4TwVq2pKQsDaQ0Eqb9apbWxZhn84q
	 mVFkuxUWgnAOPCVRkINe5blL8UGtCkMFKLM7ktJOnlZabenVX0PZB5Cq1t6JAkMRgo
	 DijstdsM3ezjt3nIvW+j/r3Xh0ZFCesLY0oQfGpkY4C81GLThjfHyCEUlEafqN2AlP
	 U+GDwsJ73ZySTHbf+PqwAzN0R6iBY6PqVYmk1Da90Nr53Q5ZClfve2txRS+iT9MRm4
	 aBegWDBvPAEHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.182]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2wL0-1piFVF0Ev6-003Kya for
 <cygwin-patches@cygwin.com>; Mon, 03 Apr 2023 16:45:05 +0200
Date: Mon, 3 Apr 2023 16:45:03 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v5 2/3] Respect `db_home` setting even for SYSTEM/Microsoft
 accounts
In-Reply-To: <cover.1680532960.git.johannes.schindelin@gmx.de>
Message-ID: <085d4dd8b67f603f0de49999d8e877a27a6751e1.1680532960.git.johannes.schindelin@gmx.de>
References: <cover.1679991274.git.johannes.schindelin@gmx.de> <cover.1680532960.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:74xzltwJnV/m9KDKeoWlJiAlBaeeJvrcQtWNoMpEGxYmjFNX8yc
 gsv5XYoNCmtZC5W94tJBg7fLCtm11uYu3dn4+toLFhVJ4WKvvTBXgo5E6ISomJCwHZanXRx
 diF0zabuhiJJysjdcFm741I3Xw+SRjD6IS813Br3J0a8HFfbxk6KSOg4D4TTG7VTnRqQxZ/
 3GJmXcnpBp8eiRNZ3W/cA==
UI-OutboundReport: notjunk:1;M01:P0:t/CXMo/MXbo=;oMiKjehlslaZ5ljgXp+YHhVlarF
 cdjbIQjy7QGRF2nfBqnGQW5KlF4dg9RRsJmMAqIUaBrnKRnjF/p+yQgZiTPu/8nzNrTng9QWy
 kmntQgGhngcNt/jL57SC+lyu+R63MUdoYlwaqEMENXmwud1fLCBzEMYFZjbs1bMAGUaXhxlyO
 tuRLqr7zqcSq9e9S52RXGUA0ozVShU4ATA41OvZtKm9IXD2JyDjo+fldepFeKEita9O5lfCzA
 7C1e1dyE9yJ8brw7bvPttUV/J0il+dy0JZp4P8iKN1hhehUJAtG473acOLbc+l4CulTI8/6YX
 mVJ4c/Fju7BMV3LG7bhcfcNsLn/m7jp5JpBYEmxZDO+5ML7JupEBR08+Zu5fvnTfFgMjRYpnC
 MEiI7fA39rJrsOS4yL4FtgPn1LImbFnWnc/kVrr3YzXjYTMGA53oZesK3smVRaR3Kn2Wwt7/m
 +9cbU83fZs2fjtvKh3MJ1tYKrWO04+4J0iiT4r98c2qR0MssZgZvSogLUj9cSDksFZeZ0qQpF
 p65U77TnPApfY8N6yKkOiVOKnPlbppdF0llmVxYsnZpZ9CNU4a/k9jW+dI6/fHQtKBXhNgin3
 kkGBIvhN+mq/6/PehZW6rEZjQhhLY1HSXV6I7Pmaj1ruIUTb5gbts6KG2NU16jXaAIanhHLlq
 zM2OWu8OkKHV73OKnXGkkRp863AauBG8EuRt1j9WoFayjuFCYw/oJxu7kOrDYFyBptDwwxdi4
 a5pl8DkcvU9bRISnS2G3ymFaMvulo5h3vsIaMYnFhKlZnMsjTcbaW9YizgD7mPoOcK7CdvzXQ
 A8M6sbS7fhLO2iI7vRnmEwQ4xmAskMGonZn+wczEi+ipUoy0saXkjvjuSQQhPy7kBc87mBhot
 UNIA0bBEl0su6kjggXt8FRjXErnWzmS8AwanPrAQYmg94vgtJ+y4ajHHc6+wwLbAIBZ1RzSfd
 jZszvA==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

We should not blindly set the home directory of the SYSTEM account (or
of Microsoft accounts) to `/home/<name>`, especially
`/etc/nsswitch.conf` defines `db_home: env`, in which case we want to
respect the `HOME` variable.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 winsup/cygwin/uinfo.cc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
index baa670478d..d493d29b3b 100644
=2D-- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -2234,7 +2234,11 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg_=
t &arg, cyg_ldap *pldap)
 	 it to a well-known group here. */
       if (acc_type =3D=3D SidTypeUser
 	  && (sid_sub_auth_count (sid) <=3D 3 || sid_id_auth (sid) =3D=3D 11))
-	acc_type =3D SidTypeWellKnownGroup;
+	{
+	  acc_type =3D SidTypeWellKnownGroup;
+	  home =3D cygheap->pg.get_home ((PUSER_INFO_3) NULL, sid, dom, name,
+				       fully_qualified_name);
+	}
       switch ((int) acc_type)
 	{
 	case SidTypeUser:
=2D-
2.40.0.windows.1


