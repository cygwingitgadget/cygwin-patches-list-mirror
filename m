Return-Path: <cygwin-patches-return-9885-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 86981 invoked by alias); 29 Dec 2019 17:57:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 86875 invoked by uid 89); 29 Dec 2019 17:57:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:771
X-HELO: NAM12-MW2-obe.outbound.protection.outlook.com
Received: from mail-mw2nam12on2132.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) (40.107.244.132) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 29 Dec 2019 17:57:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=mFhnIZ5RVTuoU9nC/naH8o/m8XQLEHlHBfuPA27MSKrjV8ie2D1zLa7yKYaLVGURfrgcMkiMdaaz5U7PdDs4zer7UgukF/IUrNm2GIPCXkJCEg1pu9HVk8fWKToq7EgCWYOiyhkdIsz8+KAfgBUu11EU9a+i/Dbjz0oNYcRseGwLvSX1Ok5MwAy0AD+uSRHlXyW35oZEOJBFLOIL70UvAVZYMNQyej3qwC+wNQUFMKzmL3QQI7Vyj9zXAlHmUkbY2S6c7o3bvfNnw4rSnrwfgIyuu86MirqQgh+7GWlHnlJYJd9y7hOqGM049ZAGTU7N7MWGjZ1BpFxPVse+z78ebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=+8tKjAKpN4egFlaFKchE7uxfSgIWvJYnzenAYPwio00=; b=lJ+9Xq+yFUPSB0UkwNSWk+3e+l38SA+M1FyQYCQbJEFFVTe0Dip6vIRv0g8nGL7aoGcX2KpkrcsW22fGvQPYQkHlY8jqpcQTcGlIDptVCfdM231+x3+ikslR5RvoE7B1NUjpuDabTtTI2myBosnu9LywaBdpgnbsrPB1F9458IOYTo/LCaejrLxueSfetRc7faZUI16jwpFZIcBjFA6a3EvBhnaQijBLPguro5U92DXkqCE9xkY5vK3H2pQFq8J3VGJAHWNvukiOZneBXrNQrgDExatbZDNlODYluIPXbmE/per4n4QJmxeX+G1dyCPgwwZMPVI/9iz6+Y1HRpbWHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=+8tKjAKpN4egFlaFKchE7uxfSgIWvJYnzenAYPwio00=; b=hl9LYbNHaT5YQHBziagNzH1A1zXLa/IAJWYodP3wb6YWrAfbygq5kK8kwPylLigqf2+QqMdgfJ3WyeMRR9rqeXt7JDg5xXC2XHkbfRM0YpX4jyvi7PopKLfZ6aOi3IxLpXpNiqJOIkh+/UAxIF37VxKcsdHH6bH+RAD5jkTB/zM=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4345.namprd04.prod.outlook.com (20.176.76.21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11; Sun, 29 Dec 2019 17:56:57 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524%3]) with mapi id 15.20.2581.007; Sun, 29 Dec 2019 17:56:57 +0000
Received: from localhost.localdomain (68.175.129.7) by CH2PR15CA0013.namprd15.prod.outlook.com (2603:10b6:610:51::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.12 via Frontend Transport; Sun, 29 Dec 2019 17:56:56 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v2 1/3] Cygwin: allow opening a symlink with O_PATH | O_NOFOLLOW
Date: Sun, 29 Dec 2019 17:57:00 -0000
Message-ID: <20191229175637.1050-2-kbrown@cornell.edu>
References: <20191229175637.1050-1-kbrown@cornell.edu>
In-Reply-To: <20191229175637.1050-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:2582;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P0q9aD4zoJvksdqLA+994OzU4LYhM7FP/Ld9PzkVw0U0JffGdedkadCDZdg+sodRnZZ8DQmOnANhMQrRwkvUfw==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00156.txt.bz2

Up to now, opening a symlink with O_NOFOLLOW fails with ELOOP.
Following Linux, allow this to succeed if O_PATH is also specified.
---
 winsup/cygwin/syscalls.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 20126ce10..038a316db 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1470,7 +1470,7 @@ open (const char *unix_path, int flags, ...)
=20
       if (!(fh =3D build_fh_name (unix_path, opt, stat_suffixes)))
 	__leave;		/* errno already set */
-      if ((flags & O_NOFOLLOW) && fh->issymlink ())
+      if ((flags & O_NOFOLLOW) && fh->issymlink () && !(flags & O_PATH))
 	{
 	  set_errno (ELOOP);
 	  __leave;
--=20
2.21.0
