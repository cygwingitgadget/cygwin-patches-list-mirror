Return-Path: <kbrown@cornell.edu>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2111.outbound.protection.outlook.com [40.107.94.111])
 by sourceware.org (Postfix) with ESMTPS id 82EC03861011
 for <cygwin-patches@cygwin.com>; Tue, 23 Feb 2021 17:45:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 82EC03861011
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBn1WzL0vSkJgUz84qh5HPThbfTZx9nHFZm/gczdxPdoiQVtnTHLwblZHzHRnllxgMrrX+0DsezTGSfIi1rQfqmKmAhcf2qvsvU/f00gxdD18MyfqO/cuJfWjlhfhXqapZST0vkp2ss0dC4/eUnmUoY7Nb3Hwm8IEzCsm7teFp+4h/lAZXHEPokhQVT9qTP7TMl3l11lqQDcBimPqW+rOWq9kCqMqiSKVkUYZztFKfm+Il4wHuCy2Z0LKtLc6rqIHu4VQDUZcduMKW0CZMew5P+JtI8f1PAoOEE6yZueC0FN39cLfUreCbpUltz8PzZv+cDzzWFDS18ykEBBXi1M8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oaKbtHDspCOyetvg8d9aVrgYhBykbuwRMjVrxAwCZo=;
 b=i571pD1qa1GAfZ91L4LD8mAP7wFxBzvCuqoy/W+tCceCygYX6TX7X7lKpQBFQCZbZUxf3Ma7P6YO00Mb7gecVagsNOIBAOHGFvn7RS4l+OeQnj/DHKiQBzxz7nPWTAjL9240bK65W5dVXG7Kkl4jMdOi26vAqj6aLjBiAn+M3YpeXlJAJdv+Q6pUk3HRSSumGVpuL5NpBSZd9KOC47xuoPm8SlgLURly5pEoknNuChqukE6PqXUM6hgKlWZSzedt85/R+Rc39eJUTvd2HIu+512yJIGfnUy/Y76dRg4FeJHVx35YKUVYSJ9HhfvAkrGMWctXi9OGOQG202UkZ09yWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB6386.namprd04.prod.outlook.com (2603:10b6:408:d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Tue, 23 Feb
 2021 17:45:15 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3868.032; Tue, 23 Feb 2021
 17:45:15 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: AF_UNIX: allow opening with the O_PATH flag
Date: Tue, 23 Feb 2021 12:44:55 -0500
Message-Id: <20210223174455.36621-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [24.194.34.31]
X-ClientProxiedBy: CH0PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:610:cd::7) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (24.194.34.31) by
 CH0PR03CA0092.namprd03.prod.outlook.com (2603:10b6:610:cd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27 via Frontend Transport; Tue, 23 Feb 2021 17:45:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de6d6371-7245-40cb-de15-08d8d822c6d1
X-MS-TrafficTypeDiagnostic: BN8PR04MB6386:
X-Microsoft-Antispam-PRVS: <BN8PR04MB63862A12F31778F0005663C0D8809@BN8PR04MB6386.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8vSXywLLl10g3ylcxrPL0SnzZ0gnnD7Hq6o+moXcB/DW6S7v7U382BD/V3nCEABDv++nYaKjrlpR62NXtZr4IQbLyEyUvuSPJaK6DGoGYkyJEtV4U1sAIWZPc46BhKliY6bAMKTc2ivwxFuskJmDo+uTjpjPT6eurs3hiSx0wsHzCqey8eDyHZzkSNVOTxNlwG8S/lA1ZouZ3uVA6SzjXrswywbPoIMWqQSbqr6/LEKI0k9LcqvkueGotiPxqopBj8x51LzetXQRx4aYQDBOTBuWCHCTsE/DgLRdaXeO2F2P6aRiFsfXrsngGObPYJqVJABQ1YDlBxFw/MeejG/asmH8B1PcLShb7UNHtyxZPkeKZtHVb5a/cPdNFoTJDT4+JmH+HVi9Jj0fqrgGm3ReNCnWKcLgCUv3cBS7+4NgQ5KoXq/UnPpY1vxH3c2PcUb7IJlopXDjN4QRkRroXW9Au52qavef9pm/v3uJgtqGr1PPM1vWYlApXZdPJUyG6VXrWF3Oqn55U84rEWdg/9kKCTNrsNWluAsp5y0ihjqXKDq1IV68vKw0TDkeIYCGSYI9qlPABwbrHCWgpJU/RQwZhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(5660300002)(6512007)(75432002)(36756003)(2906002)(8676002)(83380400001)(16526019)(52116002)(6666004)(1076003)(69590400012)(66556008)(66946007)(6506007)(6916009)(66476007)(478600001)(6486002)(26005)(186003)(86362001)(316002)(956004)(2616005)(786003)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Kga92Q50/+WZiGdNVl52bav3YfhKNRd8p34UNnxBctCmQSP1/7LMagqBF271?=
 =?us-ascii?Q?iZbjxT/0FddRprNKZNE+qv2dhN2Fa+sfl++YYpPOk2RY4+S6EBKBblG6Bd/x?=
 =?us-ascii?Q?BvnUCOtW8Iz5raAAwfqlzPWQiRtlkqxj3atXTtZjXJICeEvLesDOYReHMeaN?=
 =?us-ascii?Q?UBWxnl4hiIJ5Wvliyskbiiurec7C88sADXR8Ju+ol2tR6LJKjWK+EXoW5kx/?=
 =?us-ascii?Q?cdaUj7EZxCP3Tb+4PTEPs+An7djqDZsGL20BDR4RAtttZePwIgA5tnTAcTkF?=
 =?us-ascii?Q?i6IUX7RQlJliG2VLt/LtRVjMvU6xOLuo84jCyiBmEBSnNBMxHSJI1so1SaLu?=
 =?us-ascii?Q?a7OIddejFGQUuSI+sOYYva1Zv78CSCdb4XsbWFcwgJrMTD8HvDMHsuQoDO22?=
 =?us-ascii?Q?/BKSRCYOBTmh1WzWkQIYr3UUZEZVBEInJ6KLZg/BWTJuLHUG3UaKeeK65ULW?=
 =?us-ascii?Q?6N1rYWc9jKeDI/T1r1nzSO2Y0lDG1hqxGx6+M+ggvd467S9pJytaxWRmsa4Q?=
 =?us-ascii?Q?+wamPk8ccoclKlu1gRr1H37XiuA53jtQB9hWO6GINaJBRdilhBfvtjhGIlH/?=
 =?us-ascii?Q?3UnZv6twJm66YEAYeqs3bGQHnUoFly89gKIvNeLjRiuW3cTSxmBtJ4uCZExU?=
 =?us-ascii?Q?tSTRs9jpHh5gR4O2Mprcn0c2QD5863/NE8ZNRr6Buf/KMv/5vJwgKiffhfD4?=
 =?us-ascii?Q?9Jycc0n9gzJsFrN0bluPSFzDcQ6TudWfFh9Npo9WtIn8ELvV0hJZ9B4kW4lN?=
 =?us-ascii?Q?q+DG/zGeDcgDsglbDaafxRw/ZtBLcBFWLkdnZY9asPoTtCR42HTOdG4p0tjV?=
 =?us-ascii?Q?MLJxTjHAiMtULkVVl29WgfGmYkuSeXm161vEOojN5wruxQ2sXuXPM/XFYx0y?=
 =?us-ascii?Q?AtG1Ex/O+0gCoyd1/Auc5T3SE2tGKZtpoXAh33qDqiuHI39YJ0DBN+M0E1Tw?=
 =?us-ascii?Q?Qexg8HkA77FOVPE4GPToXbp3Sc+IalcG5Zg+FNPxTd98JLLb7v3cmxGXvQRq?=
 =?us-ascii?Q?xoVMYXkjGSZaI6VP5/2VGfCE9m64HAYmlIcWH6SH+DklulXmR3e+IFFkhn8P?=
 =?us-ascii?Q?7lP78+bIKqkOWO89y6T6BTQeZOJhWCdEQWdFkZ/bbRnmQu2glob7dWYgZ+/R?=
 =?us-ascii?Q?EHbXYBlRJeUs3jOm2JqiNPNk69w+nIhi2XRErsYeZtwT1pxxSNZyeGvjSB2j?=
 =?us-ascii?Q?UjluAAtxAMKq2JpmJCHBpcAx+nmFWicxVJm8GwNwQOxVnIi23LzC4qoBEgpr?=
 =?us-ascii?Q?JVjPOPFzSzRSX3x4fUF6jleUgI1X1fqN4pA3r5Vm9P5U6JFGBEcmIcqJpmwi?=
 =?us-ascii?Q?himGcuZ5J3dyROKSMqPWPXWQ?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: de6d6371-7245-40cb-de15-08d8d822c6d1
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 17:45:15.0924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WG8/vZVFDkt06VXWIKP/mqqFsNPcwqaCbUO6KLP3PIL7L3SwExjwjFGMp2B/rd1eV0toSzHqHrbER9dirmFTZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6386
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
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
X-List-Received-Date: Tue, 23 Feb 2021 17:45:18 -0000

This was done for the fhandler_socket_local class in commits
3a2191653a, 141437d374, and 477121317d, but the fhandler_socket_unix
class was overlooked.
---
 winsup/cygwin/fhandler.h              |  1 +
 winsup/cygwin/fhandler_socket_unix.cc | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 21e1df172..ad90cf33d 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1111,6 +1111,7 @@ class fhandler_socket_unix : public fhandler_socket
   int getsockname (struct sockaddr *name, int *namelen);
   int getpeername (struct sockaddr *name, int *namelen);
   int shutdown (int how);
+  int open (int flags, mode_t mode = 0);
   int close ();
   int getpeereid (pid_t *pid, uid_t *euid, gid_t *egid);
   ssize_t recvmsg (struct msghdr *msg, int flags);
diff --git a/winsup/cygwin/fhandler_socket_unix.cc b/winsup/cygwin/fhandler_socket_unix.cc
index 9f7f86c47..eedb0847e 100644
--- a/winsup/cygwin/fhandler_socket_unix.cc
+++ b/winsup/cygwin/fhandler_socket_unix.cc
@@ -1208,6 +1208,11 @@ fhandler_socket_unix::~fhandler_socket_unix ()
 int
 fhandler_socket_unix::dup (fhandler_base *child, int flags)
 {
+  if (get_flags () & O_PATH)
+    /* We're viewing the socket as a disk file, but fhandler_base::dup
+       suffices here. */
+    return fhandler_base::dup (child, flags);
+
   if (fhandler_socket::dup (child, flags))
     {
       __seterrno ();
@@ -1801,9 +1806,23 @@ fhandler_socket_unix::shutdown (int how)
   return 0;
 }
 
+int
+fhandler_socket_unix::open (int flags, mode_t mode)
+{
+  /* We don't support opening sockets unless O_PATH is specified. */
+  if (flags & O_PATH)
+    return open_fs (flags, mode);
+
+  set_errno (EOPNOTSUPP);
+  return 0;
+}
+
 int
 fhandler_socket_unix::close ()
 {
+  if (get_flags () & O_PATH)
+    return fhandler_base::close ();
+
   HANDLE evt = InterlockedExchangePointer (&cwt_termination_evt, NULL);
   HANDLE thr = InterlockedExchangePointer (&connect_wait_thr, NULL);
   if (thr)
@@ -2281,6 +2300,11 @@ fhandler_socket_unix::ioctl (unsigned int cmd, void *p)
 int
 fhandler_socket_unix::fcntl (int cmd, intptr_t arg)
 {
+  if (get_flags () & O_PATH)
+    /* We're viewing the socket as a disk file, but
+       fhandler_base::fcntl suffices here. */
+    return fhandler_base::fcntl (cmd, arg);
+
   int ret = -1;
 
   switch (cmd)
-- 
2.30.0

