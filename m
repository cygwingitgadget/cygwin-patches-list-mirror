Return-Path: <cygwin-patches-return-9485-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 104942 invoked by alias); 16 Jul 2019 17:34:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 104869 invoked by uid 89); 16 Jul 2019 17:34:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1031, 4847
X-HELO: NAM01-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr820093.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) (40.107.82.93) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 16 Jul 2019 17:34:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=E/VUguYvv98JeVS1vNchGoVTC040+ehODlqwJvll5sbQVbb+v8zId9hqRGb4OhkOCxai5yAuviUogx0toVAXVuv+wS06MOcp8S1OFiB3nCvI39JWeXhBbxithUwHSkNOM+Xd6WZWN15LYb+k3LyYeijw1jrBcs0OXTzDIsFx0UKMPiVoTvbFMhs6AXrn1qEX6dr2edvJwfI/moWJOaZkmtN+1Xn0WgymirgHeNQzo8uSC48E8952H7QlsTJonovvvgGkQirqOaelLU1gdPNBHrS6BYBS3R9hemDkB96tKfJd4UGvZCpTC6lQGN8AXyk7bZD5RsbLGauNB1/f7Mr0Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=73BI4w6lSPzjaB9nS5N5YV2lZ4YSBMH0XcJ78owlyTE=; b=Za42M9gES27VYLq6sO2kY7/aZ6I/KTLoPMyU1dqoX4YCdR9FI6o5T1iUh8gqy+pYlZD1JabQyoqOG6pUyFR//dQOeK2zdlK/a8hWWKQUG57sbdS2x3SrhXiHDRLms1pYO4NKvG9g7ZwIu7KzhvaeV+YVwd0VeYntA7IQVJKyNrNTthL2BiZiUlFfG/FKWWZvKZnq+66k5XNi8Dm8ZR3+g6MKl4DbMk45oGfksrMQDkbxJlbxfW/vNmaVk7ZiBxv4EgYNZkq3T4BPg5EztyZRIXQv3T8cr1c4o4+etlpjAmI3N119MI32SQpc8rfuJVex5gHR6BP6m9LYRkykrUAhXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=73BI4w6lSPzjaB9nS5N5YV2lZ4YSBMH0XcJ78owlyTE=; b=GCjlFwBOCX8sC4n9tETgiVp15zYxzqW81FJt7wJaDiagSP4+Sm5aJHkSNhlGBrTmOocKRmg0EsWcnqGRUXBygVdyynq0JNMZtYU4y/xENezkEOb80drXTb4WHU6fDEH1UA93xTC/JuHDXwSGBz79pMU0oH5KYRmFKABwMCpLEdE=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2234.namprd04.prod.outlook.com (10.167.16.18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.14; Tue, 16 Jul 2019 17:34:26 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8%8]) with mapi id 15.20.2073.012; Tue, 16 Jul 2019 17:34:26 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 3/5] Cygwin: suppress GCC 8.3 errors with -Warray-bounds
Date: Tue, 16 Jul 2019 17:34:00 -0000
Message-ID: <20190716173407.17040-4-kbrown@cornell.edu>
References: <20190716173407.17040-1-kbrown@cornell.edu>
In-Reply-To: <20190716173407.17040-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:1824;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00005.txt.bz2

---
 winsup/utils/dumper.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/utils/dumper.cc b/winsup/utils/dumper.cc
index 14b993316..f71bdda8b 100644
--- a/winsup/utils/dumper.cc
+++ b/winsup/utils/dumper.cc
@@ -417,6 +417,7 @@ dumper::dump_thread (asection * to, process_thread * th=
read)
   bfd_putl32 (NT_WIN32PSTATUS, header.elf_note_header.type);
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wstringop-overflow"
+#pragma GCC diagnostic ignored "-Warray-bounds"
   strncpy (header.elf_note_header.name, "win32thread", NOTE_NAME_SIZE);
 #pragma GCC diagnostic pop
=20
@@ -483,6 +484,7 @@ dumper::dump_module (asection * to, process_module * mo=
dule)
   bfd_putl32 (NT_WIN32PSTATUS, header.elf_note_header.type);
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wstringop-overflow"
+#pragma GCC diagnostic ignored "-Warray-bounds"
   strncpy (header.elf_note_header.name, "win32module", NOTE_NAME_SIZE);
 #pragma GCC diagnostic pop
=20
--=20
2.21.0
