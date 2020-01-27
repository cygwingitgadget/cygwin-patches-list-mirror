Return-Path: <cygwin-patches-return-10014-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 122021 invoked by alias); 27 Jan 2020 13:21:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 121917 invoked by uid 89); 27 Jan 2020 13:21:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM04-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr690139.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) (40.107.69.139) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 27 Jan 2020 13:21:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=Wcf5Gawtgh0r3jLgzBgGntDJvK5c3GA+A0j754J87OJEjXL16C0sN+5X0NXsrCIOXcFGf1Iogyj77g/Q4oY6/raem8sNYLhH3M+7YY5qDvjhCxnyLJBfVk04hcC1VGu71MVvpL0IxiNCjaw7QH9ep5j7lru+wMvHVqMUKVBjZ8icsZh2xor4dszXaYXoLDWKk7Atpaspgj6npn4ljsWMrEl04eFxTcPl1dei2vGk7qYsDxo8kwvpDVmcEUt3Q7tqD3Hu0/0532koWvxBogHwrX1j6oPnIDc125S+9yA+xByR3Swpj18znuzzncDxelViGgkAhMi9rR/W/9gVSF6DNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=qpCfL6CFszW92pyx8BgfpLljxzOw1sxFNx6B4C3+0sw=; b=F9a/xd30oih+O9Euxdbnd0kjVxcITuaMk57uPpP5nqhfkZBNXhlc0evoIxq6CmxpYlEl5a5Apj7JjtUa0yBTaQccwNfxnsCyqfC7yzKXeDyN8YyAWc5dyiFa0AItB1v7igd243lY4VbozCO3xDbXtxuecbnruQqaLX7et/1RGPLkJ3JVg4Az4sukPxmPsG8WJ5SgcCC7m7fkh1Ba3TrvnZ3fRlbbqZUT5CD0488P5dszdyBIKb8ncxJoUo8xvMCYn1zsUmShoAf0ndYFTHVkwqQzsNbVThCFvoBlsxvHmmJJjjZimBPioaxvzDxnsBV20Ja1KdsYO+DxKaM+DUMB6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=qpCfL6CFszW92pyx8BgfpLljxzOw1sxFNx6B4C3+0sw=; b=DFrYbS//urSZJ5sB56AX2cRpB45frNBt8fdVCfzRJp0LAlAOXozm6BAP/NnjvW0HhQWPUmUJGwtiJy4VD15ddJBcog1zgOy65UG8qKl2OGJ674F+3c459xf/pg9oAm1YcI/2Zighjljn9T8v3o5ZL9FzqUQy3GODBCVxkqe7wRU=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4859.namprd04.prod.outlook.com (20.176.109.28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.24; Mon, 27 Jan 2020 13:21:14 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2665.017; Mon, 27 Jan 2020 13:21:14 +0000
Received: from localhost.localdomain (65.112.130.194) by BN3PR03CA0107.namprd03.prod.outlook.com (2603:10b6:400:4::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend Transport; Mon, 27 Jan 2020 13:21:14 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 1/3] Cygwin: fhandler_base::fstat_fs: accomodate the O_PATH flag
Date: Mon, 27 Jan 2020 13:21:00 -0000
Message-ID: <20200127132050.4143-2-kbrown@cornell.edu>
References: <20200127132050.4143-1-kbrown@cornell.edu>
In-Reply-To: <20200127132050.4143-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:7691;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-messagedata: P8kDAMkpbqtrSlkysnrO80Fn2I84RiJ/iKsM03xbS/FZ+dnDSEbTD71WDq7ueRK2MALE1a9iuukTvw0kxXmsYSYPLpb21GSol6ek7NeCcjBpfFMh/AHC9Bnn0pYdz5bEQm1Cx/1S6/don9MqWDF1tw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LLt/mvI6g7lqkAqiiSoaFf+4Q94fOXAjNslKA8O926sl+pHV5q8Hs1fGJxlfeA+XJTquP07wNJ4V1WRowElOmQ==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00120.txt

Treat a special file opened with O_PATH the same as a regular file,
i.e., use its handle to get the stat information.

Before this change, fstat_fs opened the file a second time, with the
wrong flags and without closing the existing handle.  A side effect
was to change the openflags of the file, possibly causing further
system calls to fail.

Currently this change only affects FIFOs, but it will affect
AF_LOCAL/AF_UNIX sockets too once they support O_PATH.
---
 winsup/cygwin/fhandler_disk_file.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_d=
isk_file.cc
index 32381a0b0..a1ab2bbdd 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -359,7 +359,7 @@ fhandler_base::fstat_fs (struct stat *buf)
=20
   if (get_stat_handle ())
     {
-      if (!nohandle () && !is_fs_special ())
+      if (!nohandle () && (!is_fs_special () || get_flags () & O_PATH))
 	res =3D pc.fs_is_nfs () ? fstat_by_nfs_ea (buf) : fstat_by_handle (buf);
       if (res)
 	res =3D fstat_by_name (buf);
--=20
2.21.0
