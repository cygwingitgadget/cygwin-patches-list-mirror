Return-Path: <cygwin-patches-return-9878-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 82384 invoked by alias); 26 Dec 2019 15:25:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 82375 invoked by uid 89); 26 Dec 2019 15:25:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-16.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=opening, H*RU:sk:NAM10-D, HX-Spam-Relays-External:sk:NAM10-D, HX-HELO:sk:NAM10-D
X-HELO: NAM10-DM6-obe.outbound.protection.outlook.com
Received: from mail-dm6nam10on2098.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) (40.107.93.98) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 26 Dec 2019 15:25:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=NtLY8PcJnieWma4wMAdVpTxjuSgzUEjdGTveNLqGkDRVQqX0XTWzpqbLwuIPO9A48LM20nhlkZjTCjtlv9UsJ4TTgfUhofd7aoougamyPyKusNV53XTS6tDy4tGEvG1XKujLOj47IxmCmyNJ9Kwp/WU/Zq7IgoNiPzu0iq8EX6BuVU1EoN5yobClb6XB5fcDy9bKeQE6eCTE8Gs1YA4IdpI0i+SLz67uCR5jSaYy+ihHEGsZPmjPooU8e/vU5HQped6ISO2XS1Zk68Jl/g8gQhdHiZYQ5y31v3s/H7zHvFSGKLoE6B5KpplWyitjDe7POUCOqu91v1iMg2iivFbdQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=T57HMVZLkFp+Bn0MxjaoVQK+yOmSo3Wx1UmCyw2nnLY=; b=aJe+S0ita4gJhqo2OYWOBysHO7g06NNBMaifAQ4bHPHk95swrZ57of1SH3UeLF5WJJAuIW0GGYaHsJazl4S2z5cz5zvS/u1ZhhBas88dDVPeAgJk8feAYToDA1MeCUJbjobhdWfY5L5hLiPX0+UfroTL81pftlop5pQYV7RCLJiEqZRJZh695PEg+usBCxtFP1sZFPv59K5xpmQ6D+H4SNy1Deds3dO3/FKA81pvWWNWkklHCKtW+/kuiRbtApCnfLTgU4cIzk5CwyBTN0w9yVETvFz8PV6sYV6bwILOuuK9CcJuf8Xnd8I8v3OEw8/UCZzLBGXYcBFlGjj2J+psoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=T57HMVZLkFp+Bn0MxjaoVQK+yOmSo3Wx1UmCyw2nnLY=; b=MRiPkCYeBY4A0dKB6NuQ3/QUwSOb6mM6n4+vQGeG9OYZYVAyNq5eTkLGfzm/2Bd3EFlRl3F+9zvknCaAsS7cneOpta65aLFlpsDM/Qmdm6essKAXpN3zCzvuzdQPYEiCUc+tvr6NgGwabXQWUDH7aCeLiZhyYA5Q19ewYQt+u+0=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB6923.namprd04.prod.outlook.com (10.186.141.85) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.12; Thu, 26 Dec 2019 15:25:42 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524%3]) with mapi id 15.20.2581.007; Thu, 26 Dec 2019 15:25:42 +0000
Received: from localhost.localdomain (68.175.129.7) by MN2PR10CA0028.namprd10.prod.outlook.com (2603:10b6:208:120::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Thu, 26 Dec 2019 15:25:42 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: fhandler_socket::open: support the O_PATH flag
Date: Thu, 26 Dec 2019 15:25:00 -0000
Message-ID: <20191226152524.10816-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:8273;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hET9n0itB27uXMgT863BuMgDIjF+kiztuxJ9bu1xWlzDtYn7MJv5tZc3ppEoUgWY9f4Ic26JLVaYO49gN5Tu4A==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00149.txt.bz2

If that flag is not set, fail with EOPNOTSUPP instead of ENXIO.  This
is consistent with POSIX, starting with the 2016 edition.  Earlier
editions were silent on this issue.
---
 winsup/cygwin/fhandler_socket.cc | 13 +++++++++++--
 winsup/cygwin/release/3.1.3      |  5 +++++
 winsup/doc/new-features.xml      |  5 +++++
 3 files changed, 21 insertions(+), 2 deletions(-)
 create mode 100644 winsup/cygwin/release/3.1.3

diff --git a/winsup/cygwin/fhandler_socket.cc b/winsup/cygwin/fhandler_sock=
et.cc
index 9f33d8087..4a46d5a64 100644
--- a/winsup/cygwin/fhandler_socket.cc
+++ b/winsup/cygwin/fhandler_socket.cc
@@ -269,8 +269,17 @@ fhandler_socket::fcntl (int cmd, intptr_t arg)
 int
 fhandler_socket::open (int flags, mode_t mode)
 {
-  set_errno (ENXIO);
-  return 0;
+  /* We don't support opening sockets unless O_PATH is specified. */
+  if (!(flags & O_PATH))
+    {
+      set_errno (EOPNOTSUPP);
+      return 0;
+    }
+
+  query_open (query_read_attributes);
+  nohandle (true);
+  set_flags (flags);
+  return 1;
 }
=20
 int __reg2
diff --git a/winsup/cygwin/release/3.1.3 b/winsup/cygwin/release/3.1.3
new file mode 100644
index 000000000..8755c93df
--- /dev/null
+++ b/winsup/cygwin/release/3.1.3
@@ -0,0 +1,5 @@
+What changed:
+-------------
+
+- Sockets can now be opened with the O_PATH flag.  If that flag is not
+  specified, the errno is now EOPNOTSUPP instead of ENXIO.
diff --git a/winsup/doc/new-features.xml b/winsup/doc/new-features.xml
index 65bdc17ab..c8b48d1ca 100644
--- a/winsup/doc/new-features.xml
+++ b/winsup/doc/new-features.xml
@@ -54,6 +54,11 @@ Allow times(2) to have a NULL argument, as on Linux.
 Improve /proc/cpuinfo output and align more closely with Linux.
 </para></listitem>
=20
+<listitem><para>
+Sockets can now be opened with the O_PATH flag.  If that flag is not
+specified, the errno is now EOPNOTSUPP instead of ENXIO.
+</para></listitem>
+
 </itemizedlist>
=20
 </sect2>
--=20
2.21.0
