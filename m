Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2094.outbound.protection.outlook.com [40.107.243.94])
 by sourceware.org (Postfix) with ESMTPS id 0F9473850437
 for <cygwin-patches@cygwin.com>; Mon, 12 Jul 2021 12:57:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 0F9473850437
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nv/ADkclbPztDT0AER7RustCXlwoFG6PM+PpUvVMJC68Tc2LOb6+el/ctK9vryMxkM6ftG7jdV8S6EDosu30CRc5Xy7zkY60T4va7+OA5Y0xp6WywkCGySoFtbTzNZmGHLf5BjdCZj0ne8fS4MjdP2/gVtYwUgzDxj+e3VLlk4BYh61V4aP6tMzij67X5EurnYmJlF/vUSRd5CMwWcFAeHzyQttjlAAg7o3QEXyLtgc9Jmux9y9r+2VDEqNupUghcktXAQHdPc2Wj+Fxp//FCaoIMmmcJWHAdqnzeWvD+N5iLxSJhKNFJVQzHp5TCcRmwXo/F7BoNQ47BRpl9OM0Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aut8pZhItSo2w9oK8aG1Fl6BLRYXK5ufcQSzXgoICDk=;
 b=XU1828T5eAcv3FAubMzCpCU8zePqnboeXG6TySH+TtXa7N922VY+0RshT0uzlPW4SW/2TotOLqK5NjEl3FioJc1FlPhY5LyBERMOQxDsT8mQJbCb2EIC2hf2R9kl8lXdHG054tjCoTux6in5CoZESk3R44FxIoFc8zwg6Kur/LFOGKqQcT5r2k+piBALR/kKK5VKMajcv1DYkPKVxjg4r8Rr2rvL5LEXQbMCtFPzZqPO42ScK0SX1g39Kgx1gOt8t/wRIGUTapk9SXusBRcwvB7j/lI5fLW+xZQl5hnZUX7vWlZtL15F2ka05HJQMOJ+O5Je+dl/UpjgdVK5nSGoRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aut8pZhItSo2w9oK8aG1Fl6BLRYXK5ufcQSzXgoICDk=;
 b=N9Y1GylkvANiDQl1XoEN76pIcDVC9xfup6Pzc7mnzKOC5R1nuqSOtu/qgaSQan6oh/MxnDpJwp1qZZEs8s3HU4uHs3cqBfVWy0awxNeR3JfZgreFsAkvGc8gLsgm8iGsY4iwUNp58mgd4aB9Vyg2tm3Ykow98kM4uoalXLwAbhg=
Authentication-Results: cygwin.com; dkim=none (message not signed)
 header.d=none;cygwin.com; dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB6388.namprd04.prod.outlook.com (2603:10b6:408:dd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Mon, 12 Jul
 2021 12:57:54 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::cda2:359c:cb66:5c42]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::cda2:359c:cb66:5c42%7]) with mapi id 15.20.4308.021; Mon, 12 Jul 2021
 12:57:54 +0000
To: cygwin-patches <cygwin-patches@cygwin.com>
From: Ken Brown <kbrown@cornell.edu>
Subject: [PATCH] Cygwin: cfsetspeed: allow speed to be a numerical baud rate
Message-ID: <d2c4a9cf-6ab0-26ca-596f-bdd7c0eec227@cornell.edu>
Date: Mon, 12 Jul 2021 08:57:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Content-Type: multipart/mixed; boundary="------------77DA45D41FA8A320A50D7693"
Content-Language: en-US
X-ClientProxiedBy: BL1PR13CA0256.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::21) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.18] (24.194.34.31) by
 BL1PR13CA0256.namprd13.prod.outlook.com (2603:10b6:208:2ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.12 via Frontend
 Transport; Mon, 12 Jul 2021 12:57:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ed04783-2ec1-455d-489a-08d94534a9c1
X-MS-TrafficTypeDiagnostic: BN8PR04MB6388:
X-Microsoft-Antispam-PRVS: <BN8PR04MB6388F524E1BCFAAD980C1F09D8159@BN8PR04MB6388.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0ms26H1i+iaX0aPInZnLWrHlB8XlcXi7YN8HaAfSR39CcLWQvg+jlf+Coh974Tzrs+MiRbNAhORCU96RHy1ju6fWo4G3VetkET1FXV/KTfiP9jGSk6zMllEy8a3It6Y+b29TE5Wk3SlHxbS9qxTXxoiKfCNCJx9t6hHtklMveiwZ2DwK+BPVYwuFHeNDXn1HSB9MttQustRbDK9uI1fSNna4InxtMuiOBw5rH6iZ/mgNsCNx8be+tR7dhRkDcG9Z7/3Ud6Vd69bZgyTummEBlbYZpvu1MtvujT8qg5Bf7/kjjpDZJNaq+ruH7G0v2DHaJHcp56IZWtvceBaz0OyfGKUZioz42Bnp3Ipuno1NrnsxlSmkv+JwBWSguq2MVZP3mmNrIOSq468mgdKwHVnp/5BiIdDtxVzZ2D2G+A8gPaTRgVfvRAM/WKihSD5/JH+x+MGCVpKEa6+ffE24rpZ4sl9i7pMrZ2lr9/cudt4VKTTINyKqjh7DwKscUN2/MAUpKsss70ky6uwuVn2nfqHIZGJcN9MBhGtWpNR4Su+ZxJsB+E6l8QRARQqMxwfCT6uZ3uJDGIF3koR6/03q9zQMGdQWFq3RaklwBA3//KPVPDYvfGn5Qyife+bv4IxvH0lNlxTdvjSHzi1yHTzEqZ+BhL21vbcAZ7LPlYNehIraYVZopzEHNRvetZTyvUjkqfgpAvjS8z9Il+4soQrHuOrQIdqB62QLkVP2dqfVNWeWH8+3eHdWOTHHNaGg3NBOyTpjzX8RYo8qstLf6v3FUDgoIWQ0fee4ALcoDI0d83d0952XgKRtN8+DT5mLFyVKO9O
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(478600001)(33964004)(16576012)(86362001)(786003)(8676002)(8936002)(36756003)(186003)(75432002)(31686004)(966005)(26005)(38100700002)(235185007)(2906002)(5660300002)(66616009)(66556008)(66946007)(564344004)(66476007)(6916009)(316002)(6486002)(31696002)(2616005)(956004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?HMW9iSoC7z2Rmn0KQOhxG6FzHF6rxBIAc9V3dsZHihX6vZfdQJew7V/v?=
 =?Windows-1252?Q?P2yBE3A4h2iNGlkVs3PH65Z23TAjFOwRL2YVABlK4p6jeLwDYnfqCENP?=
 =?Windows-1252?Q?eQCx//FxbrQPdJKzSzlBWShlgnX4wqeJXpYLiPG3/0+nqJn+ZsSKIbiF?=
 =?Windows-1252?Q?rspOLDguFPmvJocqze/ah9dWAmnUpWrrfO/HfLdyBOmMnEaKFOfbs6ZU?=
 =?Windows-1252?Q?yoMGiQ4WrkXoaa4xmDqCAcUPacEBMbutv1SWUzuj6M2eVxOP48iKWutD?=
 =?Windows-1252?Q?PMuhY3vVMbX3M1taKhKpdZw5Zdy827oYp2h3mUOgu4NEMokEQaSFpM/m?=
 =?Windows-1252?Q?+C8lgWDN9IaNlaV045q6WH2fAYqvyQX3/apf3BPSg/F/lulvmuygDCYJ?=
 =?Windows-1252?Q?aYZ91ceUPF7dCsdsHwXXkqA0/ee1bJP5RZOJXXfglG3vRNV4NZmQaAFa?=
 =?Windows-1252?Q?DEcv+KE6R8lausAJuIfF7K4osCKgqRRWL/Op9ftgYsqsOuu1KUgFV+qz?=
 =?Windows-1252?Q?7lFqq5w5tsZoaQUyYfFmEAbMf+EU+uY4p4hid+giWzzb1nWLG2vDm6ck?=
 =?Windows-1252?Q?OLI4iYq+RFtKP/uo0/hL4pxLhsSoHc51phZ/jzH6ZK8Di4zM2oTtRsZm?=
 =?Windows-1252?Q?pUb7ywjHYmmi2+S/j6Zd6fEYHzqMLmPSGvAzRuDJL4mMqFht7wAbN+29?=
 =?Windows-1252?Q?PuGLotin5OjlP+JS/Z/mRf0O+C1PbKmX1nvb3Ja57eKloA43lDnx6O7a?=
 =?Windows-1252?Q?1g5FIfas6D6/ZoNvQdP8b2kKd4iSHTU00KnFpU7ynWZ5dAUzR4u/4V11?=
 =?Windows-1252?Q?WefEEn5u0bvmh0L1JhXsFmgDzTDNk+rcHqavfPuJ4WbkHGGOO9omwKHC?=
 =?Windows-1252?Q?z0MhWHytz0JgJsdVH/3gDC5YGasSsWvLN0Mq8EZLHPQYnEcUA5C9l5mD?=
 =?Windows-1252?Q?xG+ukmHJluIoKn4/WwOBsJLkyBWFI08uaHqyC5uM8/0xoEMEYii3p+Da?=
 =?Windows-1252?Q?X9NvA1h3xRq1hOWD1hfub/D06KH3ZrCExZAP8F0KgSYIc/hrs8oGoREr?=
 =?Windows-1252?Q?EbmJ7KLGuocb3DugUOEvlUL0Ebixq68KrXqVCRuZfjdFxZ3JIHnmhc4t?=
 =?Windows-1252?Q?SA542aJVyfsN8/lRQhM0HRpnliAWWY1+5PvXXcmg9UbzDBpMXcPc0ZHw?=
 =?Windows-1252?Q?mwyotw7uCLkSohLnqfUJXUmOH3zBUlxMyZ/CeRCeomowPRAwTX+mkFeL?=
 =?Windows-1252?Q?1PjBINGCZcaq1Jm2s1MF928SCmkhLW5u9qE/cJw3RXh3xztDJJGYiMRb?=
 =?Windows-1252?Q?lrO8g3cGCrlQWtV+hoAlPimtYomoC9kIE6dH7XkI0DeMN2XYHAU0Uv+N?=
 =?Windows-1252?Q?OLdrutJsa5mFtsy9WT2vwx8rbV33j0khWxg3jD3XH8wyi6/82MG2GLKp?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed04783-2ec1-455d-489a-08d94534a9c1
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 12:57:54.1736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dej3nmDj0fUtyNPKUtmoQ/X3k6ZqsLO8RSr+8oUiHm9vzByO9tljPfYwm86QrMz+i5a/aoC2mKffvyPzoYGwdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6388
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Mon, 12 Jul 2021 12:57:59 -0000

--------------77DA45D41FA8A320A50D7693
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch addresses

   https://cygwin.com/pipermail/cygwin/2021-July/248887.html

I don't really understand the GPL issue, but I hope it's OK.

Ken

--------------77DA45D41FA8A320A50D7693
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-cfsetspeed-allow-speed-to-be-a-numerical-baud.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Cygwin-cfsetspeed-allow-speed-to-be-a-numerical-baud.pa";
 filename*1="tch"

From 0321ecd99050ad702a528797af48ea4d01531508 Mon Sep 17 00:00:00 2001
From: Ken Brown <kbrown@cornell.edu>
Date: Sun, 11 Jul 2021 07:04:58 -0400
Subject: [PATCH] Cygwin: cfsetspeed: allow speed to be a numerical baud rate

The Linux man page for cfsetspeed(3) specifies that the speed argument
must be one of the constants Bnnn (e.g., B9600) defined in termios.h.
But Linux in fact allows the speed to be the numerical baud rate
(e.g., 9600).  For consistency with Linux, we now do the same.

Addresses: https://cygwin.com/pipermail/cygwin/2021-July/248887.html
---
 winsup/cygwin/release/3.2.1 |  4 +++
 winsup/cygwin/termios.cc    | 59 +++++++++++++++++++++++++++++++++++++
 winsup/doc/new-features.xml | 11 +++++--
 3 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/release/3.2.1 b/winsup/cygwin/release/3.2.1
index 6ebe68fa6..99c65ce30 100644
--- a/winsup/cygwin/release/3.2.1
+++ b/winsup/cygwin/release/3.2.1
@@ -5,6 +5,10 @@ What's new:
 What changed:
 -------------
 
+- The speed argument to cfsetspeed(3) can now be a numerical baud rate
+  rather than a Bnnn constant, as on Linux.
+  Addresses: https://cygwin.com/pipermail/cygwin/2021-July/248887.html
+
 
 Bug Fixes
 ---------
diff --git a/winsup/cygwin/termios.cc b/winsup/cygwin/termios.cc
index b29a64af2..ee9cd23b7 100644
--- a/winsup/cygwin/termios.cc
+++ b/winsup/cygwin/termios.cc
@@ -325,12 +325,71 @@ cfsetispeed (struct termios *in_tp, speed_t speed)
   return res;
 }
 
+struct speed_struct
+{
+  speed_t value;
+  speed_t internal;
+};
+
+static const struct speed_struct speeds[] =
+  {
+    { 0, B0 },
+    { 50, B50 },
+    { 75, B75 },
+    { 110, B110 },
+    { 134, B134 },
+    { 150, B150 },
+    { 200, B200 },
+    { 300, B300 },
+    { 600, B600 },
+    { 1200, B1200 },
+    { 1800, B1800 },
+    { 2400, B2400 },
+    { 4800, B4800 },
+    { 9600, B9600 },
+    { 19200, B19200 },
+    { 38400, B38400 },
+    { 57600, B57600 },
+    { 115200, B115200 },
+    { 128000, B128000 },
+    { 230400, B230400 },
+    { 256000, B256000 },
+    { 460800, B460800 },
+    { 500000, B500000 },
+    { 576000, B576000 },
+    { 921600, B921600 },
+    { 1000000, B1000000 },
+    { 1152000, B1152000 },
+    { 1500000, B1500000 },
+    { 2000000, B2000000 },
+    { 2500000, B2500000 },
+    { 3000000, B3000000 },
+  };
+
+/* Given a numerical baud rate (e.g., 9600), convert it to a Bnnn
+   constant (e.g., B9600). */
+static speed_t
+convert_speed (speed_t speed)
+{
+  for (size_t i = 0; i < sizeof speeds / sizeof speeds[0]; i++)
+    {
+      if (speed == speeds[i].internal)
+	return speed;
+      else if (speed == speeds[i].value)
+	return speeds[i].internal;
+    }
+  return speed;
+}
+
 /* cfsetspeed: 4.4BSD */
+/* Following Linux (undocumented), allow speed to be a numerical baud rate. */
 extern "C" int
 cfsetspeed (struct termios *in_tp, speed_t speed)
 {
   struct termios *tp = __tonew_termios (in_tp);
   int res;
+
+  speed = convert_speed (speed);
   /* errors come only from unsupported baud rates, so setspeed() would return
      identical results in both calls */
   if ((res = setspeed (tp->c_ospeed, speed)) == 0)
diff --git a/winsup/doc/new-features.xml b/winsup/doc/new-features.xml
index 5ec36e409..b58872935 100644
--- a/winsup/doc/new-features.xml
+++ b/winsup/doc/new-features.xml
@@ -71,9 +71,14 @@ facl(2) now fails with EBADF on a file opened with O_PATH.
 </para></listitem>
 
 <listitem><para>
-- Allow to start Windows Store executables via their "app execution
-  aliases".  Handle these aliases (which are special reparse points)
-  as symlinks to the actual executables.
+Allow to start Windows Store executables via their "app execution
+aliases".  Handle these aliases (which are special reparse points)
+as symlinks to the actual executables.
+</para></listitem>
+
+<listitem><para>
+The speed argument to cfsetspeed(3) can now be a numerical baud rate
+rather than a Bnnn constant, as on Linux.
 </para></listitem>
 
 </itemizedlist>
-- 
2.32.0


--------------77DA45D41FA8A320A50D7693--
