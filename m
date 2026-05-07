Return-Path: <SRS0=wjaJ=DE=multicorewareinc.com=chandru.kumaresan@sourceware.org>
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::3])
	by sourceware.org (Postfix) with ESMTPS id 260FC4BA2E13
	for <cygwin-patches@cygwin.com>; Thu,  7 May 2026 10:45:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 260FC4BA2E13
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 260FC4BA2E13
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::3
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1778150739; cv=pass;
	b=TmCO0L0mOLrD4YwY5r9/+DKsLY0bPwFvvmw8imdquEqTchDsFcnl7XHMp2sJLlrhjxNAvDQzJsBN0hRBijZ3ZW3Cd9uUz9Antkaa+fFaO8PA+oZUuPLV3C0GirHBiVYNbhMdnmuV9SA3l5V0Yl2jKL2V0IWSXi3cS6frfvwvGgY=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1778150739; c=relaxed/simple;
	bh=BKEJijpyFthtFRfe1PMH4rCl9JOMGkWvipFLjdWzG7w=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=Cw9vKVeSxki3m9GcgGJ2LJg01wIaKqlQm3ik4O+pTsB9al0o7t9WNk3y95+y5AmAYu3miBPtBc8SqXs/M/OUaefoEcu3180naE5wYlEbsgIV9v8tvC82Gq1QAxT1iV+2r4t6g6F9scsQhddA1SBr8bHPSFybdBMVtx49JPpg0Z8=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=jIcZg4uE
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 260FC4BA2E13
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=jIcZg4uE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjlZLQrXG1WcOFTWcP9s5iOP4bexFvZ6WErr4Sw7euiDTp6wGJnJEsMlleH6l+VP3RgrbOjlEQawXyp8/y6gyKDf5b4nX4EuLLmQANfUT2TQiJVU1cyWWua/zu6NX+7223pF+o6Y1cnBaHLPQgqytqJ2DyiULLpQy73XFAodvjZ7sSXWg+TYfjQel+kWDDzBrwPJ9gws9MLFRo4ebzHIufZReQ58qMwpFrpmWuUQlKPVA1oUBc9IS0U0ImHslL3PjHQTcQDqZdDUJL5ngkLUBlFhGRtf5E0pB5YANj34caORPkO96yQ4sr1l/0teChdLNZefUy8swOBya+VXetRZxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCjKOij2ANX05z7OXamaQu8wtK1rkmLNW1Nju9KGSME=;
 b=gI3s/OTiGK1DCw7wMDSJVnfEPZKICrVTY6ASNmuvWKlPIq6luuc1MOgq0f96XXzgX/PHyzF/mpQgUp5gcgivPsDHt3u9m3xHwI0wQE9dMTIeHH/i08W+E/lTQ+HyEBvZQf2Eyf0RfHhu5in1dyahBoWqLROrAh19TPi0OB1scT5Jy47NFqDyLlXt1FbwXGOnaMC43mIHXWReuxZMQ9T4wv/2SvJRKZPM0wR8fvitYLyfKlBHuzm/UtzLbeZidWhfkyyNEgrpA+xa25MpuQ5BrhRyJXaujNu4M0FGB/ps6xBLw8KMDvSoKNDICXRh3QFaDb59Fon2OlFElvdGsGkUYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCjKOij2ANX05z7OXamaQu8wtK1rkmLNW1Nju9KGSME=;
 b=jIcZg4uE1gG1JHBhDOz1A9eN9hH+Z6RzrXw8pE1QvSbJ/Td2uKLJHzU/BhgN5GD27P4kQTDKSWcVUzVxrha7QBidnPI8mUeP36+pyMgrBleShU1BS/SPzoi3hq9SYgpkV2DR8oQIVQCVFh5AS++x2M3+Il9CUn3CkOm76X5AXlSfvfXjyRaOk4vGfV5oJe7202UIwB8y4BfgUUNLIQSX6IMsnIWkr5aMz5pvChCDObFGtRLunZ77G47mBX7JehR5omk0Fzf7Bm0vUEci1LqUeeoRHCl/n6eCQNOjJebo7JRwJtmi73eSPiHD+QmPumXnIJLyiOBqX0fWWYTIyM+ftw==
Received: from PN0P287MB0295.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:e6::10)
 by PN1P287MB3728.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:251::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 10:45:31 +0000
Received: from PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
 ([fe80::cb75:9295:2928:9070]) by PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
 ([fe80::cb75:9295:2928:9070%7]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 10:45:31 +0000
From: Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: cpuid: add AArch64 build stubs
Thread-Topic: [PATCH] Cygwin: cpuid: add AArch64 build stubs
Thread-Index: AQHc3gwJgwDLcDumd0y+ZUi/EWzLQw==
Date: Thu, 7 May 2026 10:45:31 +0000
Message-ID:
 <PN0P287MB0295E7BAEC9FFE804D2A7CDD923C2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB0295:EE_|PN1P287MB3728:EE_
x-ms-office365-filtering-correlation-id: 0a490863-1109-498f-d575-08deac25c2c5
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|39142699007|31052699007|6049299003|366016|4053099003|56012099003|8096899003|3023799003|18002099003|38070700021|55112099003;
x-microsoft-antispam-message-info:
 c149fAqNJqdz65dCg9Ht6h/1QaoPt9RA7SniysaTXeNWJ/oiTwLU5WYh2JUo773n58b8Vond91k003UvIaLtANQIJbB2HyilDakxQ2TOTHjAMJArds414ROpzbXxzeA4DSiN402u/VqLCP87yRCXFlj242M3EYJezytsmMSqquB/DxHtoCKqIgW0pn62jrhDLgffpEC5M3FZWyMMhEEG/L9vneYmaPi4NwrBdriYn4ViJPQUClW83B9l3/zuPk4RAek/7DJAVQW43S//0VnCvTc0p+ErFEzK0w1bXvz6CVZomvvPV9TpbnUBzTSgROTJq+Uy2n4+eYR5CoQQ5sn6rcqx/4gLRCgpHOn+WxmLNS8D6u8S2ArG2lBOHM9D1wWv0lnPPQMKAP1QbBsrwTwpPb5LfBkJKIdvefhQd4ks3ODKPq+IFh1+/rVwSg6lEe+uU79fJ/vj8H1ZRdCNgadRziA7ZYSf013wCKtEyDUE5yJaNHZIQqusQTZJ5imqSewPjqDk8ExUgjAGSSgp/fWasmWwrA/k3vFu4nT3g46c584jizoY2YqVnmXtjCDB9l6r4rKqvpE+xF0lMLBohzva61tjQZZv3RyKiYu9LsIje+VlG+UhU0R9nhlWh5FkKUaMHWXTS9qxc3qgcynEl5mz4liMa4jnYuDb41VRQyxGMK0u3d074PxnqzpPULnlSdUSahVReMmoO9SUe6AH1BCBTHTNiJJ8nLdLQ0atErJHr4+PSRNZt94zD014Kkxcp15F
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB0295.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(39142699007)(31052699007)(6049299003)(366016)(4053099003)(56012099003)(8096899003)(3023799003)(18002099003)(38070700021)(55112099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vi/mDmboHNfJXWhNtPkLTZ10OTqnQ/LaZyDe0aXgXjJnmmBsw9qh6DszPh?=
 =?iso-8859-1?Q?Rs/tZJ4X+vyKyHnpmRwWJovvSvVDX0sOR2LcfmHklSG3qkCUuDGKIcEAS/?=
 =?iso-8859-1?Q?9ke2r/ylL89Azxza5WZ7ddYalrwcseRmVVGC7LFFSHK5OQ7gdTRMsCxym2?=
 =?iso-8859-1?Q?7lbZTXZl/2jD8Wk6sLHUZJhkTPMGG2CZqvdQJnrPxxli2Vq9IiQIeP9nKW?=
 =?iso-8859-1?Q?Rd+dOgGHPbB6RWnIPIeV1rNRZ1TVb60md3LJt3B92sl5paIXwl0A5IYctv?=
 =?iso-8859-1?Q?lEQRRM3kLVqpc90XV75haOZ6hF/Tgv0kVFQNtP5krtlt0VcQTrhVkcVUft?=
 =?iso-8859-1?Q?ONH0qKmKO8KNFxyOY/f2cmRYRS/jc/Xx6+EzoRQyFXpIXoT1BV2OyUrf/i?=
 =?iso-8859-1?Q?8Jk+ZFgikrcR/vjj0We2WEIex3LkUH6osuLbh5QXVtaVoGEtw1ifEKpRG6?=
 =?iso-8859-1?Q?YftKB9LL1GUYFSolE0VpkT/3FCyBXoHttxI+j/3qn4eUuTGqbRpyTuHUUL?=
 =?iso-8859-1?Q?zhiRxyQgHwMoI/r/UOMZYVGg5byJmsD7pIJM6NfV+aaQqvEGIUVVlgd/1a?=
 =?iso-8859-1?Q?+XK/g6dZSqJeXLjBbsbFgnIlWk79aaS7gW1u7u5QX6rCpf9Z+fYyyVXbGH?=
 =?iso-8859-1?Q?uIKWODmKXiTDLSVJgf3wa3zXY3nP1+l5FNSffRFmWAfgS29hhapIpUu4d1?=
 =?iso-8859-1?Q?fJ+TJFQZg8TEZgjUW66E3qNUsJ2HLuiID4wQ+vQWfQRxMRGfGDAU1tvCya?=
 =?iso-8859-1?Q?AuBKNZLRcnqsAx4J7eoeqzn6x1O8WeZZb0JKYnvSoBA1PNcbRCYuXrvpD9?=
 =?iso-8859-1?Q?FiopTo/R3qNi/DG76RQf+8ittaK7IV9snNoh3JydrbUFd1rezz3ZbqBrml?=
 =?iso-8859-1?Q?T2N+F+R5eM9qcIg2LLpjDgMyrckiaoSl7s4vEyYm4ExFMOhgrDxl1xYP/m?=
 =?iso-8859-1?Q?5PVpypyeU/+/Hx0M5crlTSO9YrpfSsCrEClWRAHc+2DugWun+6hUuIQJWR?=
 =?iso-8859-1?Q?+YO4OpoBgOfyhNDx8jCvp1e347N94Bc+V5QVPD4mASdp1W/jg3SOlT8KdP?=
 =?iso-8859-1?Q?fmLzRH8lQRKwLmG009Xp4rrOmt6UQYc12Ep3yZ+ygaRat6QcLJfARkVlOk?=
 =?iso-8859-1?Q?k3RfmQhI0hckYcPRxwk0orkOM8E4hjmG/xEMVI6CAWWG5at43+TkpkFHyo?=
 =?iso-8859-1?Q?KmV7J+Gx8tltpjFfhKl7xXmASDZIFuyQMDhntKf4XGHsGQijYUdQQdJAqt?=
 =?iso-8859-1?Q?FqJvkxvfBRa8EYP2a8bSNptX5xvrJ9/fP6PBjzAHUUxVSfSc2jTFiDX2AG?=
 =?iso-8859-1?Q?tfDg3bM8muKUsPxTlauZj6rH4rBn7ARWfyaFteD7auAsMQsxEVOck6VTEK?=
 =?iso-8859-1?Q?K7pz+60zpVU6kiVJt+S0d/Y1qHnOdoagicCwglutaRYaNLdzpGgVDyFfS2?=
 =?iso-8859-1?Q?E8eCp82tUDj4HQpZUPaJoDmOl4FF5wJM3ulKyEm+al3NytLINg+aEsY5nP?=
 =?iso-8859-1?Q?ty6sZLgpIqd5xn+vbSuubdyfvW7GRr/dNwFDwF0iIKcBgbcDV2CBFoRTN6?=
 =?iso-8859-1?Q?Nq+OcSCu3CKaSLEosPseyXFoOUbLOeOiHd4xXo36Gw+QDyVQNusD9KhZ3p?=
 =?iso-8859-1?Q?NcU15+F1JgH888VfpZiw6iOKzPaEvSVmQfcahotPUShUbflNCIxuJ9J5eZ?=
 =?iso-8859-1?Q?5HZttgnHVhTo7ZI5MA4HjUUUSYuTPwqZFEruff+KmongYZNaBk/pLWhd+E?=
 =?iso-8859-1?Q?f1cLmYy/YFOe8r9ItjBSj3qMGPEb9rVgrIj+4desTCkLskmNvZOFS0hidE?=
 =?iso-8859-1?Q?vkWEPyEfXeV6VawEEg4QvHqhNqBgUqs=3D?=
Content-Type: multipart/mixed;
	boundary="_004_PN0P287MB0295E7BAEC9FFE804D2A7CDD923C2PN0P287MB0295INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a490863-1109-498f-d575-08deac25c2c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 10:45:31.4191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TXb0EcivM0o/cTTn8avOBQYlYAy7uCwXHzbah7o+S6MEAp0gb9VXBWnhDKcuJleafp/e8BNWH9bcEN1DVewMDhFHOk2RiIGDGl9fxgvomXcuQfet8wvTLiisQDf0hhFO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1P287MB3728
X-Spam-Status: No, score=-13.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_PN0P287MB0295E7BAEC9FFE804D2A7CDD923C2PN0P287MB0295INDP_
Content-Type: multipart/alternative;
	boundary="_000_PN0P287MB0295E7BAEC9FFE804D2A7CDD923C2PN0P287MB0295INDP_"

--_000_PN0P287MB0295E7BAEC9FFE804D2A7CDD923C2PN0P287MB0295INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Corinna,

This patch adds ARM64 support for CPU information and cache detection used =
by /proc/cpuinfo and sysconf cache queries.
Thanks & regards,
K Chandru
In-lined patch:

---
 winsup/cygwin/fhandler/proc.cc       | 242 +++++++++++++++++++++++++++
 winsup/cygwin/local_includes/cpuid.h |  21 ++-
 winsup/cygwin/sysconf.cc             | 148 ++++++++++++++++
 3 files changed, 408 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler/proc.cc b/winsup/cygwin/fhandler/proc.cc
index f1cd468fc..ddc2f028d 100644
--- a/winsup/cygwin/fhandler/proc.cc
+++ b/winsup/cygwin/fhandler/proc.cc
@@ -643,6 +643,247 @@ mask_bits (uint32_t in)
 static off_t
 format_proc_cpuinfo (void *, char *&destbuf)
 {
+#if defined(__aarch64__)
+  WCHAR cpu_key[128], *cpu_num_p;
+  int cpu_number;
+  size_t buf_size =3D 16384;
+  size_t buf_used =3D 0;
+  char *buf =3D (char *) malloc (buf_size);
+  if (!buf)
+    return 0;
+  char *bufptr =3D buf;
+  GROUP_AFFINITY orig_group_affinity;
+  bool affinity_set =3D false;
+  WORD num_cpu_per_group =3D __get_cpus_per_group ();
+
+  cpu_num_p =3D wcpcpy (cpu_key,
+    L"\\Registry\\Machine\\HARDWARE\\DESCRIPTION\\System\\CentralProcessor=
\\");
+
+  for (cpu_number =3D 0; ; cpu_number++)
+    {
+      __small_swprintf (cpu_num_p, L"%d", cpu_number);
+      if (!NT_SUCCESS (RtlCheckRegistryKey (RTL_REGISTRY_ABSOLUTE, cpu_key=
)))
+        break;
+      buf_used =3D bufptr - buf;
+      if (buf_used + 1024 > buf_size)
+        {
+          buf_size *=3D 2;
+          char *newbuf =3D (char *) realloc (buf, buf_size);
+          if (!newbuf)
+            {
+              if (affinity_set)
+                SetThreadGroupAffinity (GetCurrentThread (),
+                                        &orig_group_affinity, NULL);
+              free (buf);
+              return 0;
+            }
+          buf    =3D newbuf;
+          bufptr =3D buf + buf_used;
+        }
+
+      WORD cpu_group =3D cpu_number / num_cpu_per_group;
+      KAFFINITY cpu_mask =3D 1L << (cpu_number % num_cpu_per_group);
+
+      GROUP_AFFINITY affinity;
+      memset (&affinity, 0, sizeof affinity);
+      affinity.Mask  =3D cpu_mask;
+      affinity.Group =3D cpu_group;
+
+      affinity_set =3D false;
+
+      if (SetThreadGroupAffinity (GetCurrentThread (), &affinity,
+                                  &orig_group_affinity))
+        {
+          affinity_set =3D true;
+          yield ();
+        }
+
+      DWORD cpu_mhz =3D 0;
+      RTL_QUERY_REGISTRY_TABLE tab[2] =3D
+        {
+          { NULL, RTL_QUERY_REGISTRY_DIRECT | RTL_QUERY_REGISTRY_NOSTRING,
+            L"~Mhz", &cpu_mhz, REG_NONE, NULL, 0 },
+          { NULL, 0, NULL, NULL, 0, NULL, 0 }
+        };
+      RtlQueryRegistryValues (RTL_REGISTRY_ABSOLUTE, cpu_key, tab, NULL, N=
ULL);
+
+      if (cpu_mhz > 0)
+        cpu_mhz =3D ((cpu_mhz - 1) / 10 + 1) * 10;
+      DWORD bogomips =3D cpu_mhz * 2;
+
+      /* Read string fields: VendorIdentifier, ProcessorNameString, Identi=
fier.
+         RTL_QUERY_REGISTRY_DIRECT requires a UNICODE_STRING target for RE=
G_SZ
+         values; using a DWORD target silently truncates the data.  */
+      WCHAR vendor_buf[256] =3D {0};
+      WCHAR name_buf[256]   =3D {0};
+      WCHAR ident_buf[256]  =3D {0};
+
+      UNICODE_STRING vendor_us =3D { 0, sizeof vendor_buf, vendor_buf };
+      UNICODE_STRING name_us   =3D { 0, sizeof name_buf,   name_buf   };
+      UNICODE_STRING ident_us  =3D { 0, sizeof ident_buf,  ident_buf  };
+
+      RTL_QUERY_REGISTRY_TABLE str_tab[4] =3D
+        {
+          { NULL, RTL_QUERY_REGISTRY_DIRECT,
+            L"VendorIdentifier",    &vendor_us, REG_SZ, NULL, 0 },
+          { NULL, RTL_QUERY_REGISTRY_DIRECT,
+            L"ProcessorNameString", &name_us,   REG_SZ, NULL, 0 },
+          { NULL, RTL_QUERY_REGISTRY_DIRECT,
+            L"Identifier",          &ident_us,  REG_SZ, NULL, 0 },
+          { NULL, 0, NULL, NULL, 0, NULL, 0 }
+        };
+      RtlQueryRegistryValues (RTL_REGISTRY_ABSOLUTE, cpu_key, str_tab,
+                              NULL, NULL);
+
+      int id_family =3D 0, id_model =3D 0;
+      for (WCHAR *p =3D ident_buf; *p; p++)
+        {
+          if (!wcsncmp (p, L"Family ", 7))
+            id_family =3D (int) wcstol (p + 7, NULL, 10);
+          else if (!wcsncmp (p, L"Model ", 6))
+            id_model  =3D (int) wcstol (p + 6, NULL, 10);
+        }
+
+      uint32_t cpu_implementer =3D 0x00;
+      uint32_t cpu_part        =3D 0x000;
+      uint32_t cpu_variant     =3D 0x0;
+      uint32_t cpu_revision    =3D 0x0;
+      uint32_t cpu_arch        =3D 8;
+
+      {
+        HANDLE hk =3D NULL;
+        UNICODE_STRING key_us;
+        OBJECT_ATTRIBUTES oa;
+        RtlInitUnicodeString (&key_us, cpu_key);
+        InitializeObjectAttributes (&oa, &key_us, OBJ_CASE_INSENSITIVE,
+                                    NULL, NULL);
+        if (NT_SUCCESS (NtOpenKey (&hk, KEY_READ, &oa)))
+          {
+            UNICODE_STRING val_us;
+            /* CP 4000 appears to contain the ARM MIDR value, but this
+               registry value is undocumented and has reportedly changed
+               across Windows updates.  Treat it as best-effort only. */
+            RtlInitUnicodeString (&val_us, L"CP 4000");
+            BYTE kbuf[sizeof (KEY_VALUE_PARTIAL_INFORMATION) + 8] =3D {0};
+            PKEY_VALUE_PARTIAL_INFORMATION kvi =3D
+              (PKEY_VALUE_PARTIAL_INFORMATION) kbuf;
+            ULONG res_len;
+            if (NT_SUCCESS (NtQueryValueKey (hk, &val_us,
+                                             KeyValuePartialInformation,
+                                             kvi, sizeof kbuf, &res_len))
+                && kvi->DataLength >=3D 4)
+              {
+                uint32_t midr =3D 0;
+                memcpy (&midr, kvi->Data, 4);
+                /* Some implementations store the value in the upper 32 bi=
ts. */
+                if (midr =3D=3D 0 && kvi->DataLength >=3D 8)
+                  memcpy (&midr, kvi->Data + 4, 4);
+                if (midr !=3D 0)
+                  {
+                    cpu_implementer =3D (midr >> 24) & 0xFF;
+                    cpu_variant     =3D (midr >> 20) & 0xF;
+                    cpu_arch        =3D (midr >> 16) & 0xF;
+                    cpu_part        =3D (midr >>  4) & 0xFFF;
+                    cpu_revision    =3D  midr        & 0xF;
+                    /* Architecture field 0xF means "ARMv8+ with CPUID
+                       scheme"; report as 8 (ARMv8) since we cannot read
+                       ID_AA64ISAR* registers from userspace on Windows. */
+                    if (cpu_arch =3D=3D 0xF)
+                      cpu_arch =3D 8;
+                  }
+              }
+            NtClose (hk);
+          }
+      }
+
+      bufptr +=3D __small_sprintf (bufptr, "processor\t: %d\n", cpu_number=
);
+
+      if (vendor_buf[0])
+        bufptr +=3D __small_sprintf (bufptr, "vendor_id\t: %W\n", vendor_b=
uf);
+
+      if (ident_buf[0])
+        {
+          bufptr +=3D __small_sprintf (bufptr, "cpu family\t: %d\n", id_fa=
mily);
+          bufptr +=3D __small_sprintf (bufptr, "model\t\t: %d\n",    id_mo=
del);
+        }
+      bufptr +=3D __small_sprintf (bufptr, "stepping\t: %d\n", cpu_revisio=
n);
+
+      if (name_buf[0])
+        bufptr +=3D __small_sprintf (bufptr, "model name\t: %W\n", name_bu=
f);
+
+      bufptr +=3D __small_sprintf (bufptr, "BogoMIPS\t: %d.00\n", bogomips=
);
+
+      /* Emit "cache size" line for /proc/cpuinfo feature parity with the
+         x86 branch.Values come from
+         GetLogicalProcessorInformationEx(RelationCache)
+         via get_cpu_cache_arm64() in sysconf.cc  */
+      {
+        extern long get_cpu_cache_arm64 (int);
+        long cs =3D get_cpu_cache_arm64 (_SC_LEVEL3_CACHE_SIZE);
+        if (cs <=3D 0)
+          cs =3D get_cpu_cache_arm64 (_SC_LEVEL2_CACHE_SIZE);
+        if (cs <=3D 0)
+          {
+            long l1i =3D get_cpu_cache_arm64 (_SC_LEVEL1_ICACHE_SIZE);
+            long l1d =3D get_cpu_cache_arm64 (_SC_LEVEL1_DCACHE_SIZE);
+            if (l1i > 0 || l1d > 0)
+              cs =3D (l1i > 0 ? l1i : 0) + (l1d > 0 ? l1d : 0);
+          }
+        if (cs > 0)
+          bufptr +=3D __small_sprintf (bufptr, "cache size\t: %d KB\n",
+                                     (int) (cs >> 10));
+      }
+
+      print ("Features\t:");
+      if (IsProcessorFeaturePresent (PF_ARM_V8_INSTRUCTIONS_AVAILABLE))
+        {
+          ftuprint ("fp");
+          ftuprint ("asimd");
+          ftuprint ("evtstrm");
+        }
+      if (IsProcessorFeaturePresent (PF_ARM_V8_CRYPTO_INSTRUCTIONS_AVAILAB=
LE))
+        {
+          ftuprint ("aes");
+          ftuprint ("pmull");
+          ftuprint ("sha1");
+          ftuprint ("sha2");
+        }
+      if (IsProcessorFeaturePresent (PF_ARM_V8_CRC32_INSTRUCTIONS_AVAILABL=
E))
+        ftuprint ("crc32");
+      if (IsProcessorFeaturePresent (PF_ARM_V81_ATOMIC_INSTRUCTIONS_AVAILA=
BLE))
+        ftuprint ("atomics");
+      if (IsProcessorFeaturePresent (PF_ARM_V82_DP_INSTRUCTIONS_AVAILABLE))
+        {
+          ftuprint ("asimdhp");
+          ftuprint ("asimddp");
+          ftuprint ("fphp");
+        }
+      if (IsProcessorFeaturePresent (PF_ARM_V83_JSCVT_INSTRUCTIONS_AVAILAB=
LE))
+        ftuprint ("jscvt");
+      if (IsProcessorFeaturePresent (PF_ARM_V83_LRCPC_INSTRUCTIONS_AVAILAB=
LE))
+        ftuprint ("lrcpc");
+      print ("\n");
+
+      if (cpu_implementer !=3D 0 || cpu_part !=3D 0)
+        bufptr +=3D __small_sprintf (bufptr,
+          "CPU implementer\t: 0x%02x\n"
+          "CPU architecture: %d\n"
+          "CPU variant\t: 0x%x\n"
+          "CPU part\t: 0x%03x\n"
+          "CPU revision\t: %d\n",
+          cpu_implementer, cpu_arch, cpu_variant, cpu_part, cpu_revision);
+      bufptr +=3D __small_sprintf (bufptr, "\n");
+
+      if (affinity_set)
+        SetThreadGroupAffinity (GetCurrentThread (), &orig_group_affinity,=
 NULL);
+    }
+
+  off_t len =3D bufptr - buf;
+  destbuf =3D (char *) crealloc_abort (destbuf, len);
+  memcpy (destbuf, buf, len);
+  free (buf);
+  return len;
+#else
   WCHAR cpu_key[128], *cpu_num_p;
   DWORD orig_affinity_mask =3D 0;
   GROUP_AFFINITY orig_group_affinity;
@@ -1767,6 +2008,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
   destbuf =3D (char *) crealloc_abort (destbuf, bufptr - buf);
   memcpy (destbuf, buf, bufptr - buf);
   return bufptr - buf;
+#endif
 }

 static off_t
diff --git a/winsup/cygwin/local_includes/cpuid.h b/winsup/cygwin/local_inc=
ludes/cpuid.h
index 6dbb1bddf..674069a7e 100644
--- a/winsup/cygwin/local_includes/cpuid.h
+++ b/winsup/cygwin/local_includes/cpuid.h
@@ -13,17 +13,32 @@ static inline void __attribute ((always_inline))
 cpuid (uint32_t *a, uint32_t *b, uint32_t *c, uint32_t *d, uint32_t ain,
        uint32_t cin =3D 0)
 {
+#if defined(__x86_64__)
   asm volatile ("cpuid"
      : "=3Da" (*a), "=3Db" (*b), "=3Dc" (*c), "=3Dd" (*d)
      : "a" (ain), "c" (cin));
+#elif defined(__aarch64__)
+  /* AArch64 has no CPUID instruction.  Identify the target as Windows
+     ARM64 on leaf 0, and return zeros for other leaves.  */
+  *a =3D *b =3D *c =3D *d =3D 0;
+  if (ain =3D=3D 0)
+    {
+      *a =3D 0;
+      *b =3D 0x63724141; /* "AArc" */
+      *d =3D 0x57343668; /* "h64W" */
+      *c =3D 0x00006e69; /* "in\0\0" */
+    }
+  (void) cin;
+#else
+#error unimplemented for this target
+#endif
 }

-#ifdef __x86_64__
+#if defined(__x86_64__)
 static inline bool __attribute ((always_inline))
 can_set_flag (uint32_t long flag)
 {
   uint32_t long r1, r2;
-
   asm volatile ("pushfq\n"
      "popq %0\n"
      "movq %0, %1\n"
@@ -39,7 +54,7 @@ can_set_flag (uint32_t long flag)
   );
   return ((r1 ^ r2) & flag) !=3D 0;
 }
-#else
+#elif !defined(__aarch64__)
 #error unimplemented for this target
 #endif

diff --git a/winsup/cygwin/sysconf.cc b/winsup/cygwin/sysconf.cc
index 6529731a5..59646affd 100644
--- a/winsup/cygwin/sysconf.cc
+++ b/winsup/cygwin/sysconf.cc
@@ -98,6 +98,11 @@ get_avphys (int in)
    / (wincap.allocation_granularity () / wincap.page_size ());
 }

+/* Cache detection for Intel and AMD uses CPUID, which are only
+   available on x86_64.  On AArch64, EL1 system registers fault from
+   userspace. Use GetLogicalProcessorInformationEx instead.  */
+#if !defined(__aarch64__)
+
 enum cache_level
 {
   LevelNone,
@@ -454,9 +459,151 @@ get_cpu_cache_amd (int in, uint32_t maxe)
   return ret;
 }

+#endif /* !__aarch64__ */
+
+/* On ARM64, GetLogicalProcessorInformationEx returns one cache
+   descriptor per core, unlike Intel CPUID leaf 4 which returns
+   one descriptor per cache level.  We filter to CPU 0's descriptors
+   and return the first match.  */
+
+#if defined(__aarch64__)
+long
+get_cpu_cache_arm64 (int in)
+{
+  DWORD len =3D 0;
+
+  GetLogicalProcessorInformationEx (RelationCache, NULL, &len);
+  if (GetLastError () !=3D ERROR_INSUFFICIENT_BUFFER || len =3D=3D 0)
+    return 0;
+
+  PSYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX buf =3D
+    (PSYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX) malloc (len);
+  if (!buf)
+    return 0;
+
+  if (!GetLogicalProcessorInformationEx (RelationCache, buf, &len))
+    {
+      free (buf);
+      return 0;
+    }
+
+  long ret =3D 0;
+  PSYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX p =3D buf;
+  DWORD remaining =3D len;
+
+  GROUP_AFFINITY cpu0_affinity =3D {};
+  cpu0_affinity.Group =3D 0;
+  cpu0_affinity.Mask  =3D 1;
+
+  while (remaining > 0)
+    {
+      if (p->Size =3D=3D 0)
+        break;
+      if (p->Relationship =3D=3D RelationCache)
+        {
+          CACHE_RELATIONSHIP *cr =3D &p->Cache;
+          bool covers_cpu0 =3D
+            (cr->GroupMask.Group =3D=3D cpu0_affinity.Group) &&
+            (cr->GroupMask.Mask  &  cpu0_affinity.Mask);
+
+          if (!covers_cpu0)
+            {
+              remaining -=3D p->Size;
+              p =3D (PSYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX)
+                    ((BYTE *) p + p->Size);
+              continue;
+            }
+
+          uint8_t  level =3D cr->Level;
+          uint8_t  type  =3D cr->Type;
+          uint32_t size  =3D cr->CacheSize;
+          uint32_t asc   =3D cr->Associativity;
+          uint32_t lsize =3D cr->LineSize;
+          bool     match =3D false;
+
+          switch (in)
+            {
+            case _SC_LEVEL1_ICACHE_SIZE:
+              if (level =3D=3D 1 && type =3D=3D CacheInstruction)
+                { ret =3D size; match =3D true; }
+              break;
+            case _SC_LEVEL1_ICACHE_ASSOC:
+              if (level =3D=3D 1 && type =3D=3D CacheInstruction)
+                { ret =3D (asc =3D=3D 0xFF) ? 0x8000 : asc; match =3D true=
; }
+              break;
+            case _SC_LEVEL1_ICACHE_LINESIZE:
+              if (level =3D=3D 1 && type =3D=3D CacheInstruction)
+                { ret =3D lsize; match =3D true; }
+              break;
+            case _SC_LEVEL1_DCACHE_SIZE:
+              if (level =3D=3D 1 && type =3D=3D CacheData)
+                { ret =3D size; match =3D true; }
+              break;
+            case _SC_LEVEL1_DCACHE_ASSOC:
+              if (level =3D=3D 1 && type =3D=3D CacheData)
+                { ret =3D (asc =3D=3D 0xFF) ? 0x8000 : asc; match =3D true=
; }
+              break;
+            case _SC_LEVEL1_DCACHE_LINESIZE:
+              if (level =3D=3D 1 && type =3D=3D CacheData)
+                { ret =3D lsize; match =3D true; }
+              break;
+            case _SC_LEVEL2_CACHE_SIZE:
+              if (level =3D=3D 2)
+                { ret =3D size; match =3D true; }
+              break;
+            case _SC_LEVEL2_CACHE_ASSOC:
+              if (level =3D=3D 2)
+                { ret =3D (asc =3D=3D 0xFF) ? 0x8000 : asc; match =3D true=
; }
+              break;
+            case _SC_LEVEL2_CACHE_LINESIZE:
+              if (level =3D=3D 2)
+                { ret =3D lsize; match =3D true; }
+              break;
+            case _SC_LEVEL3_CACHE_SIZE:
+              if (level =3D=3D 3)
+                { ret =3D size; match =3D true; }
+              break;
+            case _SC_LEVEL3_CACHE_ASSOC:
+              if (level =3D=3D 3)
+                { ret =3D (asc =3D=3D 0xFF) ? 0x8000 : asc; match =3D true=
; }
+              break;
+            case _SC_LEVEL3_CACHE_LINESIZE:
+              if (level =3D=3D 3)
+                { ret =3D lsize; match =3D true; }
+              break;
+            case _SC_LEVEL4_CACHE_SIZE:
+              if (level =3D=3D 4)
+                { ret =3D size; match =3D true; }
+              break;
+            case _SC_LEVEL4_CACHE_ASSOC:
+              if (level =3D=3D 4)
+                { ret =3D (asc =3D=3D 0xFF) ? 0x8000 : asc; match =3D true=
; }
+              break;
+            case _SC_LEVEL4_CACHE_LINESIZE:
+              if (level =3D=3D 4)
+                { ret =3D lsize; match =3D true; }
+              break;
+            default:
+              break;
+            }
+          if (match)
+            break;
+        }
+      remaining -=3D p->Size;
+      p =3D (PSYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX) ((BYTE *) p + p->Si=
ze);
+    }
+
+  free (buf);
+  return ret;
+}
+#endif /* __aarch64__ */
+
 static long
 get_cpu_cache (int in)
 {
+#if defined(__aarch64__)
+  return get_cpu_cache_arm64 (in);
+#else
   uint32_t maxf, vendor_id[4];
   cpuid (&maxf, &vendor_id[0], &vendor_id[2], &vendor_id[1], 0x00000000);

@@ -471,6 +618,7 @@ get_cpu_cache (int in)
       return get_cpu_cache_amd (in, maxe);
     }
   return 0;
+#endif
 }

 enum sc_type { cons, func };
--
2.49.0.windows.1




--_000_PN0P287MB0295E7BAEC9FFE804D2A7CDD923C2PN0P287MB0295INDP_--

--_004_PN0P287MB0295E7BAEC9FFE804D2A7CDD923C2PN0P287MB0295INDP_
Content-Type: application/octet-stream;
	name="Cygwin-cpuid-add-AArch64-build-stubs.patch"
Content-Description: Cygwin-cpuid-add-AArch64-build-stubs.patch
Content-Disposition: attachment;
	filename="Cygwin-cpuid-add-AArch64-build-stubs.patch"; size=17781;
	creation-date="Thu, 07 May 2026 10:40:44 GMT";
	modification-date="Thu, 07 May 2026 10:41:02 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1ZmI4M2I2MTdhMDQ0MmM4ZmUyMjFkNGFlYzE2YzY3MGIzODU2MWUw
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBjaGFuZHJ1LW1jdyA8
Q2hhbmRydS5rdW1hcmVzYW5AbXVsdGljb3Jld2FyZWluYy5jb20+CkRhdGU6
IFRodSwgNyBNYXkgMjAyNiAxNTo0NjoxNCArMDUzMApTdWJqZWN0OiBbUEFU
Q0hdIEN5Z3dpbiBjcHVpZCBhZGQgQUFyY2g2NCBidWlsZCBzdHVicwpNSU1F
LVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJz
ZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKSW1w
bGVtZW50IEFSTTY0IHN1cHBvcnQgZm9yIC9wcm9jL2NwdWluZm8gYW5kIHN5
c2NvbmYgY2FjaGUKcXVlcmllcyB1c2luZyBXaW5kb3dzIEFQSXMgYW5kIHJl
Z2lzdHJ5IGRhdGEuCkFkZCBBUk02NCBDUFUgZmVhdHVyZSByZXBvcnRpbmcs
IE1JRFIgcGFyc2luZywgY2FjaGUgZGV0ZWN0aW9uCnZpYSBHZXRMb2dpY2Fs
UHJvY2Vzc29ySW5mb3JtYXRpb25FeCwgYW5kIG1pbmltYWwgY3B1aWQoKQpm
YWxsYmFjayBoYW5kbGluZy4gUmVzdHJpY3QgeDg2IENQVUlEIHBhdGhzIHRv
IHg4Nl82NCBhbmQgZml4CkFBcmNoNjQgcHJlcHJvY2Vzc29yIGNvbmRpdGlv
bnMuCgpTaWduZWQtb2ZmLWJ5OiBSYWRlayBCYXJ0b8OFy4YgPHJhZGVrLmJh
cnRvbkBtaWNyb3NvZnQuY29tPgpTaWduZWQtb2ZmLWJ5OiBUaGlydW1hbGFp
IE5hZ2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3
YXJlaW5jLmNvbT4KU2lnbmVkLW9mZi1ieTogQ2hhbmRydSBLdW1hcmVzYW4g
PGNoYW5kcnUua3VtYXJlc2FuQG11bHRpY29yZXdhcmVpbmMuY29tPgotLS0K
IHdpbnN1cC9jeWd3aW4vZmhhbmRsZXIvcHJvYy5jYyAgICAgICB8IDI0MiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysKIHdpbnN1cC9jeWd3aW4vbG9j
YWxfaW5jbHVkZXMvY3B1aWQuaCB8ICAyMSArKy0KIHdpbnN1cC9jeWd3aW4v
c3lzY29uZi5jYyAgICAgICAgICAgICB8IDE0OCArKysrKysrKysrKysrKysr
CiAzIGZpbGVzIGNoYW5nZWQsIDQwOCBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIv
cHJvYy5jYyBiL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIvcHJvYy5jYwppbmRl
eCBmMWNkNDY4ZmMuLmRkYzJmMDI4ZCAxMDA2NDQKLS0tIGEvd2luc3VwL2N5
Z3dpbi9maGFuZGxlci9wcm9jLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vZmhh
bmRsZXIvcHJvYy5jYwpAQCAtNjQzLDYgKzY0MywyNDcgQEAgbWFza19iaXRz
ICh1aW50MzJfdCBpbikKIHN0YXRpYyBvZmZfdAogZm9ybWF0X3Byb2NfY3B1
aW5mbyAodm9pZCAqLCBjaGFyIComZGVzdGJ1ZikKIHsKKyNpZiBkZWZpbmVk
KF9fYWFyY2g2NF9fKQorICBXQ0hBUiBjcHVfa2V5WzEyOF0sICpjcHVfbnVt
X3A7CisgIGludCBjcHVfbnVtYmVyOworICBzaXplX3QgYnVmX3NpemUgPSAx
NjM4NDsKKyAgc2l6ZV90IGJ1Zl91c2VkID0gMDsKKyAgY2hhciAqYnVmID0g
KGNoYXIgKikgbWFsbG9jIChidWZfc2l6ZSk7CisgIGlmICghYnVmKQorICAg
IHJldHVybiAwOworICBjaGFyICpidWZwdHIgPSBidWY7CisgIEdST1VQX0FG
RklOSVRZIG9yaWdfZ3JvdXBfYWZmaW5pdHk7CisgIGJvb2wgYWZmaW5pdHlf
c2V0ID0gZmFsc2U7CisgIFdPUkQgbnVtX2NwdV9wZXJfZ3JvdXAgPSBfX2dl
dF9jcHVzX3Blcl9ncm91cCAoKTsKKworICBjcHVfbnVtX3AgPSB3Y3BjcHkg
KGNwdV9rZXksCisgICAgTCJcXFJlZ2lzdHJ5XFxNYWNoaW5lXFxIQVJEV0FS
RVxcREVTQ1JJUFRJT05cXFN5c3RlbVxcQ2VudHJhbFByb2Nlc3NvclxcIik7
CisKKyAgZm9yIChjcHVfbnVtYmVyID0gMDsgOyBjcHVfbnVtYmVyKyspCisg
ICAgeworICAgICAgX19zbWFsbF9zd3ByaW50ZiAoY3B1X251bV9wLCBMIiVk
IiwgY3B1X251bWJlcik7CisgICAgICBpZiAoIU5UX1NVQ0NFU1MgKFJ0bENo
ZWNrUmVnaXN0cnlLZXkgKFJUTF9SRUdJU1RSWV9BQlNPTFVURSwgY3B1X2tl
eSkpKQorICAgICAgICBicmVhazsKKyAgICAgIGJ1Zl91c2VkID0gYnVmcHRy
IC0gYnVmOworICAgICAgaWYgKGJ1Zl91c2VkICsgMTAyNCA+IGJ1Zl9zaXpl
KQorICAgICAgICB7CisgICAgICAgICAgYnVmX3NpemUgKj0gMjsKKyAgICAg
ICAgICBjaGFyICpuZXdidWYgPSAoY2hhciAqKSByZWFsbG9jIChidWYsIGJ1
Zl9zaXplKTsKKyAgICAgICAgICBpZiAoIW5ld2J1ZikKKyAgICAgICAgICAg
IHsKKyAgICAgICAgICAgICAgaWYgKGFmZmluaXR5X3NldCkKKyAgICAgICAg
ICAgICAgICBTZXRUaHJlYWRHcm91cEFmZmluaXR5IChHZXRDdXJyZW50VGhy
ZWFkICgpLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICZvcmlnX2dyb3VwX2FmZmluaXR5LCBOVUxMKTsKKyAgICAgICAgICAg
ICAgZnJlZSAoYnVmKTsKKyAgICAgICAgICAgICAgcmV0dXJuIDA7CisgICAg
ICAgICAgICB9CisgICAgICAgICAgYnVmICAgID0gbmV3YnVmOworICAgICAg
ICAgIGJ1ZnB0ciA9IGJ1ZiArIGJ1Zl91c2VkOworICAgICAgICB9CisKKyAg
ICAgIFdPUkQgY3B1X2dyb3VwID0gY3B1X251bWJlciAvIG51bV9jcHVfcGVy
X2dyb3VwOworICAgICAgS0FGRklOSVRZIGNwdV9tYXNrID0gMUwgPDwgKGNw
dV9udW1iZXIgJSBudW1fY3B1X3Blcl9ncm91cCk7CisKKyAgICAgIEdST1VQ
X0FGRklOSVRZIGFmZmluaXR5OworICAgICAgbWVtc2V0ICgmYWZmaW5pdHks
IDAsIHNpemVvZiBhZmZpbml0eSk7CisgICAgICBhZmZpbml0eS5NYXNrICA9
IGNwdV9tYXNrOworICAgICAgYWZmaW5pdHkuR3JvdXAgPSBjcHVfZ3JvdXA7
CisKKyAgICAgIGFmZmluaXR5X3NldCA9IGZhbHNlOworCisgICAgICBpZiAo
U2V0VGhyZWFkR3JvdXBBZmZpbml0eSAoR2V0Q3VycmVudFRocmVhZCAoKSwg
JmFmZmluaXR5LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICZvcmlnX2dyb3VwX2FmZmluaXR5KSkKKyAgICAgICAgeworICAgICAgICAg
IGFmZmluaXR5X3NldCA9IHRydWU7CisgICAgICAgICAgeWllbGQgKCk7Cisg
ICAgICAgIH0KKworICAgICAgRFdPUkQgY3B1X21oeiA9IDA7CisgICAgICBS
VExfUVVFUllfUkVHSVNUUllfVEFCTEUgdGFiWzJdID0KKyAgICAgICAgewor
ICAgICAgICAgIHsgTlVMTCwgUlRMX1FVRVJZX1JFR0lTVFJZX0RJUkVDVCB8
IFJUTF9RVUVSWV9SRUdJU1RSWV9OT1NUUklORywKKyAgICAgICAgICAgIEwi
fk1oeiIsICZjcHVfbWh6LCBSRUdfTk9ORSwgTlVMTCwgMCB9LAorICAgICAg
ICAgIHsgTlVMTCwgMCwgTlVMTCwgTlVMTCwgMCwgTlVMTCwgMCB9CisgICAg
ICAgIH07CisgICAgICBSdGxRdWVyeVJlZ2lzdHJ5VmFsdWVzIChSVExfUkVH
SVNUUllfQUJTT0xVVEUsIGNwdV9rZXksIHRhYiwgTlVMTCwgTlVMTCk7CisK
KyAgICAgIGlmIChjcHVfbWh6ID4gMCkKKyAgICAgICAgY3B1X21oeiA9ICgo
Y3B1X21oeiAtIDEpIC8gMTAgKyAxKSAqIDEwOworICAgICAgRFdPUkQgYm9n
b21pcHMgPSBjcHVfbWh6ICogMjsKKworICAgICAgLyogUmVhZCBzdHJpbmcg
ZmllbGRzOiBWZW5kb3JJZGVudGlmaWVyLCBQcm9jZXNzb3JOYW1lU3RyaW5n
LCBJZGVudGlmaWVyLgorICAgICAgICAgUlRMX1FVRVJZX1JFR0lTVFJZX0RJ
UkVDVCByZXF1aXJlcyBhIFVOSUNPREVfU1RSSU5HIHRhcmdldCBmb3IgUkVH
X1NaCisgICAgICAgICB2YWx1ZXM7IHVzaW5nIGEgRFdPUkQgdGFyZ2V0IHNp
bGVudGx5IHRydW5jYXRlcyB0aGUgZGF0YS4gICovCisgICAgICBXQ0hBUiB2
ZW5kb3JfYnVmWzI1Nl0gPSB7MH07CisgICAgICBXQ0hBUiBuYW1lX2J1Zlsy
NTZdICAgPSB7MH07CisgICAgICBXQ0hBUiBpZGVudF9idWZbMjU2XSAgPSB7
MH07CisKKyAgICAgIFVOSUNPREVfU1RSSU5HIHZlbmRvcl91cyA9IHsgMCwg
c2l6ZW9mIHZlbmRvcl9idWYsIHZlbmRvcl9idWYgfTsKKyAgICAgIFVOSUNP
REVfU1RSSU5HIG5hbWVfdXMgICA9IHsgMCwgc2l6ZW9mIG5hbWVfYnVmLCAg
IG5hbWVfYnVmICAgfTsKKyAgICAgIFVOSUNPREVfU1RSSU5HIGlkZW50X3Vz
ICA9IHsgMCwgc2l6ZW9mIGlkZW50X2J1ZiwgIGlkZW50X2J1ZiAgfTsKKwor
ICAgICAgUlRMX1FVRVJZX1JFR0lTVFJZX1RBQkxFIHN0cl90YWJbNF0gPQor
ICAgICAgICB7CisgICAgICAgICAgeyBOVUxMLCBSVExfUVVFUllfUkVHSVNU
UllfRElSRUNULAorICAgICAgICAgICAgTCJWZW5kb3JJZGVudGlmaWVyIiwg
ICAgJnZlbmRvcl91cywgUkVHX1NaLCBOVUxMLCAwIH0sCisgICAgICAgICAg
eyBOVUxMLCBSVExfUVVFUllfUkVHSVNUUllfRElSRUNULAorICAgICAgICAg
ICAgTCJQcm9jZXNzb3JOYW1lU3RyaW5nIiwgJm5hbWVfdXMsICAgUkVHX1Na
LCBOVUxMLCAwIH0sCisgICAgICAgICAgeyBOVUxMLCBSVExfUVVFUllfUkVH
SVNUUllfRElSRUNULAorICAgICAgICAgICAgTCJJZGVudGlmaWVyIiwgICAg
ICAgICAgJmlkZW50X3VzLCAgUkVHX1NaLCBOVUxMLCAwIH0sCisgICAgICAg
ICAgeyBOVUxMLCAwLCBOVUxMLCBOVUxMLCAwLCBOVUxMLCAwIH0KKyAgICAg
ICAgfTsKKyAgICAgIFJ0bFF1ZXJ5UmVnaXN0cnlWYWx1ZXMgKFJUTF9SRUdJ
U1RSWV9BQlNPTFVURSwgY3B1X2tleSwgc3RyX3RhYiwKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIE5VTEwsIE5VTEwpOworCisgICAgICBpbnQg
aWRfZmFtaWx5ID0gMCwgaWRfbW9kZWwgPSAwOworICAgICAgZm9yIChXQ0hB
UiAqcCA9IGlkZW50X2J1ZjsgKnA7IHArKykKKyAgICAgICAgeworICAgICAg
ICAgIGlmICghd2NzbmNtcCAocCwgTCJGYW1pbHkgIiwgNykpCisgICAgICAg
ICAgICBpZF9mYW1pbHkgPSAoaW50KSB3Y3N0b2wgKHAgKyA3LCBOVUxMLCAx
MCk7CisgICAgICAgICAgZWxzZSBpZiAoIXdjc25jbXAgKHAsIEwiTW9kZWwg
IiwgNikpCisgICAgICAgICAgICBpZF9tb2RlbCAgPSAoaW50KSB3Y3N0b2wg
KHAgKyA2LCBOVUxMLCAxMCk7CisgICAgICAgIH0KKworICAgICAgdWludDMy
X3QgY3B1X2ltcGxlbWVudGVyID0gMHgwMDsKKyAgICAgIHVpbnQzMl90IGNw
dV9wYXJ0ICAgICAgICA9IDB4MDAwOworICAgICAgdWludDMyX3QgY3B1X3Zh
cmlhbnQgICAgID0gMHgwOworICAgICAgdWludDMyX3QgY3B1X3JldmlzaW9u
ICAgID0gMHgwOworICAgICAgdWludDMyX3QgY3B1X2FyY2ggICAgICAgID0g
ODsKKworICAgICAgeworICAgICAgICBIQU5ETEUgaGsgPSBOVUxMOworICAg
ICAgICBVTklDT0RFX1NUUklORyBrZXlfdXM7CisgICAgICAgIE9CSkVDVF9B
VFRSSUJVVEVTIG9hOworICAgICAgICBSdGxJbml0VW5pY29kZVN0cmluZyAo
JmtleV91cywgY3B1X2tleSk7CisgICAgICAgIEluaXRpYWxpemVPYmplY3RB
dHRyaWJ1dGVzICgmb2EsICZrZXlfdXMsIE9CSl9DQVNFX0lOU0VOU0lUSVZF
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCwg
TlVMTCk7CisgICAgICAgIGlmIChOVF9TVUNDRVNTIChOdE9wZW5LZXkgKCZo
aywgS0VZX1JFQUQsICZvYSkpKQorICAgICAgICAgIHsKKyAgICAgICAgICAg
IFVOSUNPREVfU1RSSU5HIHZhbF91czsKKyAgICAgICAgICAgIC8qIENQIDQw
MDAgYXBwZWFycyB0byBjb250YWluIHRoZSBBUk0gTUlEUiB2YWx1ZSwgYnV0
IHRoaXMKKyAgICAgICAgICAgICAgIHJlZ2lzdHJ5IHZhbHVlIGlzIHVuZG9j
dW1lbnRlZCBhbmQgaGFzIHJlcG9ydGVkbHkgY2hhbmdlZAorICAgICAgICAg
ICAgICAgYWNyb3NzIFdpbmRvd3MgdXBkYXRlcy4gIFRyZWF0IGl0IGFzIGJl
c3QtZWZmb3J0IG9ubHkuICovCisgICAgICAgICAgICBSdGxJbml0VW5pY29k
ZVN0cmluZyAoJnZhbF91cywgTCJDUCA0MDAwIik7CisgICAgICAgICAgICBC
WVRFIGtidWZbc2l6ZW9mIChLRVlfVkFMVUVfUEFSVElBTF9JTkZPUk1BVElP
TikgKyA4XSA9IHswfTsKKyAgICAgICAgICAgIFBLRVlfVkFMVUVfUEFSVElB
TF9JTkZPUk1BVElPTiBrdmkgPQorICAgICAgICAgICAgICAoUEtFWV9WQUxV
RV9QQVJUSUFMX0lORk9STUFUSU9OKSBrYnVmOworICAgICAgICAgICAgVUxP
TkcgcmVzX2xlbjsKKyAgICAgICAgICAgIGlmIChOVF9TVUNDRVNTIChOdFF1
ZXJ5VmFsdWVLZXkgKGhrLCAmdmFsX3VzLAorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgS2V5VmFsdWVQYXJ0aWFsSW5m
b3JtYXRpb24sCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBrdmksIHNpemVvZiBrYnVmLCAmcmVzX2xlbikpCisgICAg
ICAgICAgICAgICAgJiYga3ZpLT5EYXRhTGVuZ3RoID49IDQpCisgICAgICAg
ICAgICAgIHsKKyAgICAgICAgICAgICAgICB1aW50MzJfdCBtaWRyID0gMDsK
KyAgICAgICAgICAgICAgICBtZW1jcHkgKCZtaWRyLCBrdmktPkRhdGEsIDQp
OworICAgICAgICAgICAgICAgIC8qIFNvbWUgaW1wbGVtZW50YXRpb25zIHN0
b3JlIHRoZSB2YWx1ZSBpbiB0aGUgdXBwZXIgMzIgYml0cy4gKi8KKyAgICAg
ICAgICAgICAgICBpZiAobWlkciA9PSAwICYmIGt2aS0+RGF0YUxlbmd0aCA+
PSA4KQorICAgICAgICAgICAgICAgICAgbWVtY3B5ICgmbWlkciwga3ZpLT5E
YXRhICsgNCwgNCk7CisgICAgICAgICAgICAgICAgaWYgKG1pZHIgIT0gMCkK
KyAgICAgICAgICAgICAgICAgIHsKKyAgICAgICAgICAgICAgICAgICAgY3B1
X2ltcGxlbWVudGVyID0gKG1pZHIgPj4gMjQpICYgMHhGRjsKKyAgICAgICAg
ICAgICAgICAgICAgY3B1X3ZhcmlhbnQgICAgID0gKG1pZHIgPj4gMjApICYg
MHhGOworICAgICAgICAgICAgICAgICAgICBjcHVfYXJjaCAgICAgICAgPSAo
bWlkciA+PiAxNikgJiAweEY7CisgICAgICAgICAgICAgICAgICAgIGNwdV9w
YXJ0ICAgICAgICA9IChtaWRyID4+ICA0KSAmIDB4RkZGOworICAgICAgICAg
ICAgICAgICAgICBjcHVfcmV2aXNpb24gICAgPSAgbWlkciAgICAgICAgJiAw
eEY7CisgICAgICAgICAgICAgICAgICAgIC8qIEFyY2hpdGVjdHVyZSBmaWVs
ZCAweEYgbWVhbnMgIkFSTXY4KyB3aXRoIENQVUlECisgICAgICAgICAgICAg
ICAgICAgICAgIHNjaGVtZSI7IHJlcG9ydCBhcyA4IChBUk12OCkgc2luY2Ug
d2UgY2Fubm90IHJlYWQKKyAgICAgICAgICAgICAgICAgICAgICAgSURfQUE2
NElTQVIqIHJlZ2lzdGVycyBmcm9tIHVzZXJzcGFjZSBvbiBXaW5kb3dzLiAq
LworICAgICAgICAgICAgICAgICAgICBpZiAoY3B1X2FyY2ggPT0gMHhGKQor
ICAgICAgICAgICAgICAgICAgICAgIGNwdV9hcmNoID0gODsKKyAgICAgICAg
ICAgICAgICAgIH0KKyAgICAgICAgICAgICAgfQorICAgICAgICAgICAgTnRD
bG9zZSAoaGspOworICAgICAgICAgIH0KKyAgICAgIH0KKworICAgICAgYnVm
cHRyICs9IF9fc21hbGxfc3ByaW50ZiAoYnVmcHRyLCAicHJvY2Vzc29yXHQ6
ICVkXG4iLCBjcHVfbnVtYmVyKTsKKworICAgICAgaWYgKHZlbmRvcl9idWZb
MF0pCisgICAgICAgIGJ1ZnB0ciArPSBfX3NtYWxsX3NwcmludGYgKGJ1ZnB0
ciwgInZlbmRvcl9pZFx0OiAlV1xuIiwgdmVuZG9yX2J1Zik7CisKKyAgICAg
IGlmIChpZGVudF9idWZbMF0pCisgICAgICAgIHsKKyAgICAgICAgICBidWZw
dHIgKz0gX19zbWFsbF9zcHJpbnRmIChidWZwdHIsICJjcHUgZmFtaWx5XHQ6
ICVkXG4iLCBpZF9mYW1pbHkpOworICAgICAgICAgIGJ1ZnB0ciArPSBfX3Nt
YWxsX3NwcmludGYgKGJ1ZnB0ciwgIm1vZGVsXHRcdDogJWRcbiIsICAgIGlk
X21vZGVsKTsKKyAgICAgICAgfQorICAgICAgYnVmcHRyICs9IF9fc21hbGxf
c3ByaW50ZiAoYnVmcHRyLCAic3RlcHBpbmdcdDogJWRcbiIsIGNwdV9yZXZp
c2lvbik7CisKKyAgICAgIGlmIChuYW1lX2J1ZlswXSkKKyAgICAgICAgYnVm
cHRyICs9IF9fc21hbGxfc3ByaW50ZiAoYnVmcHRyLCAibW9kZWwgbmFtZVx0
OiAlV1xuIiwgbmFtZV9idWYpOworCisgICAgICBidWZwdHIgKz0gX19zbWFs
bF9zcHJpbnRmIChidWZwdHIsICJCb2dvTUlQU1x0OiAlZC4wMFxuIiwgYm9n
b21pcHMpOworCisgICAgICAvKiBFbWl0ICJjYWNoZSBzaXplIiBsaW5lIGZv
ciAvcHJvYy9jcHVpbmZvIGZlYXR1cmUgcGFyaXR5IHdpdGggdGhlCisgICAg
ICAgICB4ODYgYnJhbmNoLlZhbHVlcyBjb21lIGZyb20KKyAgICAgICAgIEdl
dExvZ2ljYWxQcm9jZXNzb3JJbmZvcm1hdGlvbkV4KFJlbGF0aW9uQ2FjaGUp
CisgICAgICAgICB2aWEgZ2V0X2NwdV9jYWNoZV9hcm02NCgpIGluIHN5c2Nv
bmYuY2MgICovCisgICAgICB7CisgICAgICAgIGV4dGVybiBsb25nIGdldF9j
cHVfY2FjaGVfYXJtNjQgKGludCk7CisgICAgICAgIGxvbmcgY3MgPSBnZXRf
Y3B1X2NhY2hlX2FybTY0IChfU0NfTEVWRUwzX0NBQ0hFX1NJWkUpOworICAg
ICAgICBpZiAoY3MgPD0gMCkKKyAgICAgICAgICBjcyA9IGdldF9jcHVfY2Fj
aGVfYXJtNjQgKF9TQ19MRVZFTDJfQ0FDSEVfU0laRSk7CisgICAgICAgIGlm
IChjcyA8PSAwKQorICAgICAgICAgIHsKKyAgICAgICAgICAgIGxvbmcgbDFp
ID0gZ2V0X2NwdV9jYWNoZV9hcm02NCAoX1NDX0xFVkVMMV9JQ0FDSEVfU0la
RSk7CisgICAgICAgICAgICBsb25nIGwxZCA9IGdldF9jcHVfY2FjaGVfYXJt
NjQgKF9TQ19MRVZFTDFfRENBQ0hFX1NJWkUpOworICAgICAgICAgICAgaWYg
KGwxaSA+IDAgfHwgbDFkID4gMCkKKyAgICAgICAgICAgICAgY3MgPSAobDFp
ID4gMCA/IGwxaSA6IDApICsgKGwxZCA+IDAgPyBsMWQgOiAwKTsKKyAgICAg
ICAgICB9CisgICAgICAgIGlmIChjcyA+IDApCisgICAgICAgICAgYnVmcHRy
ICs9IF9fc21hbGxfc3ByaW50ZiAoYnVmcHRyLCAiY2FjaGUgc2l6ZVx0OiAl
ZCBLQlxuIiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAoaW50KSAoY3MgPj4gMTApKTsKKyAgICAgIH0KKworICAgICAgcHJpbnQg
KCJGZWF0dXJlc1x0OiIpOworICAgICAgaWYgKElzUHJvY2Vzc29yRmVhdHVy
ZVByZXNlbnQgKFBGX0FSTV9WOF9JTlNUUlVDVElPTlNfQVZBSUxBQkxFKSkK
KyAgICAgICAgeworICAgICAgICAgIGZ0dXByaW50ICgiZnAiKTsKKyAgICAg
ICAgICBmdHVwcmludCAoImFzaW1kIik7CisgICAgICAgICAgZnR1cHJpbnQg
KCJldnRzdHJtIik7CisgICAgICAgIH0KKyAgICAgIGlmIChJc1Byb2Nlc3Nv
ckZlYXR1cmVQcmVzZW50IChQRl9BUk1fVjhfQ1JZUFRPX0lOU1RSVUNUSU9O
U19BVkFJTEFCTEUpKQorICAgICAgICB7CisgICAgICAgICAgZnR1cHJpbnQg
KCJhZXMiKTsKKyAgICAgICAgICBmdHVwcmludCAoInBtdWxsIik7CisgICAg
ICAgICAgZnR1cHJpbnQgKCJzaGExIik7CisgICAgICAgICAgZnR1cHJpbnQg
KCJzaGEyIik7CisgICAgICAgIH0KKyAgICAgIGlmIChJc1Byb2Nlc3NvckZl
YXR1cmVQcmVzZW50IChQRl9BUk1fVjhfQ1JDMzJfSU5TVFJVQ1RJT05TX0FW
QUlMQUJMRSkpCisgICAgICAgIGZ0dXByaW50ICgiY3JjMzIiKTsKKyAgICAg
IGlmIChJc1Byb2Nlc3NvckZlYXR1cmVQcmVzZW50IChQRl9BUk1fVjgxX0FU
T01JQ19JTlNUUlVDVElPTlNfQVZBSUxBQkxFKSkKKyAgICAgICAgZnR1cHJp
bnQgKCJhdG9taWNzIik7CisgICAgICBpZiAoSXNQcm9jZXNzb3JGZWF0dXJl
UHJlc2VudCAoUEZfQVJNX1Y4Ml9EUF9JTlNUUlVDVElPTlNfQVZBSUxBQkxF
KSkKKyAgICAgICAgeworICAgICAgICAgIGZ0dXByaW50ICgiYXNpbWRocCIp
OworICAgICAgICAgIGZ0dXByaW50ICgiYXNpbWRkcCIpOworICAgICAgICAg
IGZ0dXByaW50ICgiZnBocCIpOworICAgICAgICB9CisgICAgICBpZiAoSXNQ
cm9jZXNzb3JGZWF0dXJlUHJlc2VudCAoUEZfQVJNX1Y4M19KU0NWVF9JTlNU
UlVDVElPTlNfQVZBSUxBQkxFKSkKKyAgICAgICAgZnR1cHJpbnQgKCJqc2N2
dCIpOworICAgICAgaWYgKElzUHJvY2Vzc29yRmVhdHVyZVByZXNlbnQgKFBG
X0FSTV9WODNfTFJDUENfSU5TVFJVQ1RJT05TX0FWQUlMQUJMRSkpCisgICAg
ICAgIGZ0dXByaW50ICgibHJjcGMiKTsKKyAgICAgIHByaW50ICgiXG4iKTsK
KworICAgICAgaWYgKGNwdV9pbXBsZW1lbnRlciAhPSAwIHx8IGNwdV9wYXJ0
ICE9IDApCisgICAgICAgIGJ1ZnB0ciArPSBfX3NtYWxsX3NwcmludGYgKGJ1
ZnB0ciwKKyAgICAgICAgICAiQ1BVIGltcGxlbWVudGVyXHQ6IDB4JTAyeFxu
IgorICAgICAgICAgICJDUFUgYXJjaGl0ZWN0dXJlOiAlZFxuIgorICAgICAg
ICAgICJDUFUgdmFyaWFudFx0OiAweCV4XG4iCisgICAgICAgICAgIkNQVSBw
YXJ0XHQ6IDB4JTAzeFxuIgorICAgICAgICAgICJDUFUgcmV2aXNpb25cdDog
JWRcbiIsCisgICAgICAgICAgY3B1X2ltcGxlbWVudGVyLCBjcHVfYXJjaCwg
Y3B1X3ZhcmlhbnQsIGNwdV9wYXJ0LCBjcHVfcmV2aXNpb24pOworICAgICAg
YnVmcHRyICs9IF9fc21hbGxfc3ByaW50ZiAoYnVmcHRyLCAiXG4iKTsKKwor
ICAgICAgaWYgKGFmZmluaXR5X3NldCkKKyAgICAgICAgU2V0VGhyZWFkR3Jv
dXBBZmZpbml0eSAoR2V0Q3VycmVudFRocmVhZCAoKSwgJm9yaWdfZ3JvdXBf
YWZmaW5pdHksIE5VTEwpOworICAgIH0KKworICBvZmZfdCBsZW4gPSBidWZw
dHIgLSBidWY7CisgIGRlc3RidWYgPSAoY2hhciAqKSBjcmVhbGxvY19hYm9y
dCAoZGVzdGJ1ZiwgbGVuKTsKKyAgbWVtY3B5IChkZXN0YnVmLCBidWYsIGxl
bik7CisgIGZyZWUgKGJ1Zik7CisgIHJldHVybiBsZW47CisjZWxzZQogICBX
Q0hBUiBjcHVfa2V5WzEyOF0sICpjcHVfbnVtX3A7CiAgIERXT1JEIG9yaWdf
YWZmaW5pdHlfbWFzayA9IDA7CiAgIEdST1VQX0FGRklOSVRZIG9yaWdfZ3Jv
dXBfYWZmaW5pdHk7CkBAIC0xNzY3LDYgKzIwMDgsNyBAQCBmb3JtYXRfcHJv
Y19jcHVpbmZvICh2b2lkICosIGNoYXIgKiZkZXN0YnVmKQogICBkZXN0YnVm
ID0gKGNoYXIgKikgY3JlYWxsb2NfYWJvcnQgKGRlc3RidWYsIGJ1ZnB0ciAt
IGJ1Zik7CiAgIG1lbWNweSAoZGVzdGJ1ZiwgYnVmLCBidWZwdHIgLSBidWYp
OwogICByZXR1cm4gYnVmcHRyIC0gYnVmOworI2VuZGlmCiB9CiAKIHN0YXRp
YyBvZmZfdApkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNs
dWRlcy9jcHVpZC5oIGIvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9j
cHVpZC5oCmluZGV4IDZkYmIxYmRkZi4uNjc0MDY5YTdlIDEwMDY0NAotLS0g
YS93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL2NwdWlkLmgKKysrIGIv
d2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9jcHVpZC5oCkBAIC0xMywx
NyArMTMsMzIgQEAgc3RhdGljIGlubGluZSB2b2lkIF9fYXR0cmlidXRlICgo
YWx3YXlzX2lubGluZSkpCiBjcHVpZCAodWludDMyX3QgKmEsIHVpbnQzMl90
ICpiLCB1aW50MzJfdCAqYywgdWludDMyX3QgKmQsIHVpbnQzMl90IGFpbiwK
ICAgICAgICB1aW50MzJfdCBjaW4gPSAwKQogeworI2lmIGRlZmluZWQoX194
ODZfNjRfXykKICAgYXNtIHZvbGF0aWxlICgiY3B1aWQiCiAJCTogIj1hIiAo
KmEpLCAiPWIiICgqYiksICI9YyIgKCpjKSwgIj1kIiAoKmQpCiAJCTogImEi
IChhaW4pLCAiYyIgKGNpbikpOworI2VsaWYgZGVmaW5lZChfX2FhcmNoNjRf
XykKKyAgLyogQUFyY2g2NCBoYXMgbm8gQ1BVSUQgaW5zdHJ1Y3Rpb24uICBJ
ZGVudGlmeSB0aGUgdGFyZ2V0IGFzIFdpbmRvd3MKKyAgICAgQVJNNjQgb24g
bGVhZiAwLCBhbmQgcmV0dXJuIHplcm9zIGZvciBvdGhlciBsZWF2ZXMuICAq
LworICAqYSA9ICpiID0gKmMgPSAqZCA9IDA7CisgIGlmIChhaW4gPT0gMCkK
KyAgICB7CisgICAgICAqYSA9IDA7CisgICAgICAqYiA9IDB4NjM3MjQxNDE7
IC8qICJBQXJjIiAqLworICAgICAgKmQgPSAweDU3MzQzNjY4OyAvKiAiaDY0
VyIgKi8KKyAgICAgICpjID0gMHgwMDAwNmU2OTsgLyogImluXDBcMCIgKi8K
KyAgICB9CisgICh2b2lkKSBjaW47CisjZWxzZQorI2Vycm9yIHVuaW1wbGVt
ZW50ZWQgZm9yIHRoaXMgdGFyZ2V0CisjZW5kaWYKIH0KIAotI2lmZGVmIF9f
eDg2XzY0X18KKyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCiBzdGF0aWMgaW5s
aW5lIGJvb2wgX19hdHRyaWJ1dGUgKChhbHdheXNfaW5saW5lKSkKIGNhbl9z
ZXRfZmxhZyAodWludDMyX3QgbG9uZyBmbGFnKQogewogICB1aW50MzJfdCBs
b25nIHIxLCByMjsKLQogICBhc20gdm9sYXRpbGUgKCJwdXNoZnFcbiIKIAkJ
InBvcHEgJTBcbiIKIAkJIm1vdnEgJTAsICUxXG4iCkBAIC0zOSw3ICs1NCw3
IEBAIGNhbl9zZXRfZmxhZyAodWludDMyX3QgbG9uZyBmbGFnKQogICApOwog
ICByZXR1cm4gKChyMSBeIHIyKSAmIGZsYWcpICE9IDA7CiB9Ci0jZWxzZQor
I2VsaWYgIWRlZmluZWQoX19hYXJjaDY0X18pCiAjZXJyb3IgdW5pbXBsZW1l
bnRlZCBmb3IgdGhpcyB0YXJnZXQKICNlbmRpZgogCmRpZmYgLS1naXQgYS93
aW5zdXAvY3lnd2luL3N5c2NvbmYuY2MgYi93aW5zdXAvY3lnd2luL3N5c2Nv
bmYuY2MKaW5kZXggNjUyOTczMWE1Li41OTY0NmFmZmQgMTAwNjQ0Ci0tLSBh
L3dpbnN1cC9jeWd3aW4vc3lzY29uZi5jYworKysgYi93aW5zdXAvY3lnd2lu
L3N5c2NvbmYuY2MKQEAgLTk4LDYgKzk4LDExIEBAIGdldF9hdnBoeXMgKGlu
dCBpbikKIAkgLyAod2luY2FwLmFsbG9jYXRpb25fZ3JhbnVsYXJpdHkgKCkg
LyB3aW5jYXAucGFnZV9zaXplICgpKTsKIH0KIAorLyogQ2FjaGUgZGV0ZWN0
aW9uIGZvciBJbnRlbCBhbmQgQU1EIHVzZXMgQ1BVSUQsIHdoaWNoIGFyZSBv
bmx5CisgICBhdmFpbGFibGUgb24geDg2XzY0LiAgT24gQUFyY2g2NCwgRUwx
IHN5c3RlbSByZWdpc3RlcnMgZmF1bHQgZnJvbQorICAgdXNlcnNwYWNlLiBV
c2UgR2V0TG9naWNhbFByb2Nlc3NvckluZm9ybWF0aW9uRXggaW5zdGVhZC4g
ICovCisjaWYgIWRlZmluZWQoX19hYXJjaDY0X18pCisKIGVudW0gY2FjaGVf
bGV2ZWwKIHsKICAgTGV2ZWxOb25lLApAQCAtNDU0LDkgKzQ1OSwxNTEgQEAg
Z2V0X2NwdV9jYWNoZV9hbWQgKGludCBpbiwgdWludDMyX3QgbWF4ZSkKICAg
cmV0dXJuIHJldDsKIH0KIAorI2VuZGlmIC8qICFfX2FhcmNoNjRfXyAqLwor
CisvKiBPbiBBUk02NCwgR2V0TG9naWNhbFByb2Nlc3NvckluZm9ybWF0aW9u
RXggcmV0dXJucyBvbmUgY2FjaGUKKyAgIGRlc2NyaXB0b3IgcGVyIGNvcmUs
IHVubGlrZSBJbnRlbCBDUFVJRCBsZWFmIDQgd2hpY2ggcmV0dXJucworICAg
b25lIGRlc2NyaXB0b3IgcGVyIGNhY2hlIGxldmVsLiAgV2UgZmlsdGVyIHRv
IENQVSAwJ3MgZGVzY3JpcHRvcnMKKyAgIGFuZCByZXR1cm4gdGhlIGZpcnN0
IG1hdGNoLiAgKi8KKworI2lmIGRlZmluZWQoX19hYXJjaDY0X18pCitsb25n
CitnZXRfY3B1X2NhY2hlX2FybTY0IChpbnQgaW4pCit7CisgIERXT1JEIGxl
biA9IDA7CisKKyAgR2V0TG9naWNhbFByb2Nlc3NvckluZm9ybWF0aW9uRXgg
KFJlbGF0aW9uQ2FjaGUsIE5VTEwsICZsZW4pOworICBpZiAoR2V0TGFzdEVy
cm9yICgpICE9IEVSUk9SX0lOU1VGRklDSUVOVF9CVUZGRVIgfHwgbGVuID09
IDApCisgICAgcmV0dXJuIDA7CisKKyAgUFNZU1RFTV9MT0dJQ0FMX1BST0NF
U1NPUl9JTkZPUk1BVElPTl9FWCBidWYgPQorICAgIChQU1lTVEVNX0xPR0lD
QUxfUFJPQ0VTU09SX0lORk9STUFUSU9OX0VYKSBtYWxsb2MgKGxlbik7Cisg
IGlmICghYnVmKQorICAgIHJldHVybiAwOworCisgIGlmICghR2V0TG9naWNh
bFByb2Nlc3NvckluZm9ybWF0aW9uRXggKFJlbGF0aW9uQ2FjaGUsIGJ1Ziwg
JmxlbikpCisgICAgeworICAgICAgZnJlZSAoYnVmKTsKKyAgICAgIHJldHVy
biAwOworICAgIH0KKworICBsb25nIHJldCA9IDA7CisgIFBTWVNURU1fTE9H
SUNBTF9QUk9DRVNTT1JfSU5GT1JNQVRJT05fRVggcCA9IGJ1ZjsKKyAgRFdP
UkQgcmVtYWluaW5nID0gbGVuOworCisgIEdST1VQX0FGRklOSVRZIGNwdTBf
YWZmaW5pdHkgPSB7fTsKKyAgY3B1MF9hZmZpbml0eS5Hcm91cCA9IDA7Cisg
IGNwdTBfYWZmaW5pdHkuTWFzayAgPSAxOworCisgIHdoaWxlIChyZW1haW5p
bmcgPiAwKQorICAgIHsKKyAgICAgIGlmIChwLT5TaXplID09IDApCisgICAg
ICAgIGJyZWFrOworICAgICAgaWYgKHAtPlJlbGF0aW9uc2hpcCA9PSBSZWxh
dGlvbkNhY2hlKQorICAgICAgICB7CisgICAgICAgICAgQ0FDSEVfUkVMQVRJ
T05TSElQICpjciA9ICZwLT5DYWNoZTsKKyAgICAgICAgICBib29sIGNvdmVy
c19jcHUwID0KKyAgICAgICAgICAgIChjci0+R3JvdXBNYXNrLkdyb3VwID09
IGNwdTBfYWZmaW5pdHkuR3JvdXApICYmCisgICAgICAgICAgICAoY3ItPkdy
b3VwTWFzay5NYXNrICAmICBjcHUwX2FmZmluaXR5Lk1hc2spOworCisgICAg
ICAgICAgaWYgKCFjb3ZlcnNfY3B1MCkKKyAgICAgICAgICAgIHsKKyAgICAg
ICAgICAgICAgcmVtYWluaW5nIC09IHAtPlNpemU7CisgICAgICAgICAgICAg
IHAgPSAoUFNZU1RFTV9MT0dJQ0FMX1BST0NFU1NPUl9JTkZPUk1BVElPTl9F
WCkKKyAgICAgICAgICAgICAgICAgICAgKChCWVRFICopIHAgKyBwLT5TaXpl
KTsKKyAgICAgICAgICAgICAgY29udGludWU7CisgICAgICAgICAgICB9CisK
KyAgICAgICAgICB1aW50OF90ICBsZXZlbCA9IGNyLT5MZXZlbDsKKyAgICAg
ICAgICB1aW50OF90ICB0eXBlICA9IGNyLT5UeXBlOworICAgICAgICAgIHVp
bnQzMl90IHNpemUgID0gY3ItPkNhY2hlU2l6ZTsKKyAgICAgICAgICB1aW50
MzJfdCBhc2MgICA9IGNyLT5Bc3NvY2lhdGl2aXR5OworICAgICAgICAgIHVp
bnQzMl90IGxzaXplID0gY3ItPkxpbmVTaXplOworICAgICAgICAgIGJvb2wg
ICAgIG1hdGNoID0gZmFsc2U7CisKKyAgICAgICAgICBzd2l0Y2ggKGluKQor
ICAgICAgICAgICAgeworICAgICAgICAgICAgY2FzZSBfU0NfTEVWRUwxX0lD
QUNIRV9TSVpFOgorICAgICAgICAgICAgICBpZiAobGV2ZWwgPT0gMSAmJiB0
eXBlID09IENhY2hlSW5zdHJ1Y3Rpb24pCisgICAgICAgICAgICAgICAgeyBy
ZXQgPSBzaXplOyBtYXRjaCA9IHRydWU7IH0KKyAgICAgICAgICAgICAgYnJl
YWs7CisgICAgICAgICAgICBjYXNlIF9TQ19MRVZFTDFfSUNBQ0hFX0FTU09D
OgorICAgICAgICAgICAgICBpZiAobGV2ZWwgPT0gMSAmJiB0eXBlID09IENh
Y2hlSW5zdHJ1Y3Rpb24pCisgICAgICAgICAgICAgICAgeyByZXQgPSAoYXNj
ID09IDB4RkYpID8gMHg4MDAwIDogYXNjOyBtYXRjaCA9IHRydWU7IH0KKyAg
ICAgICAgICAgICAgYnJlYWs7CisgICAgICAgICAgICBjYXNlIF9TQ19MRVZF
TDFfSUNBQ0hFX0xJTkVTSVpFOgorICAgICAgICAgICAgICBpZiAobGV2ZWwg
PT0gMSAmJiB0eXBlID09IENhY2hlSW5zdHJ1Y3Rpb24pCisgICAgICAgICAg
ICAgICAgeyByZXQgPSBsc2l6ZTsgbWF0Y2ggPSB0cnVlOyB9CisgICAgICAg
ICAgICAgIGJyZWFrOworICAgICAgICAgICAgY2FzZSBfU0NfTEVWRUwxX0RD
QUNIRV9TSVpFOgorICAgICAgICAgICAgICBpZiAobGV2ZWwgPT0gMSAmJiB0
eXBlID09IENhY2hlRGF0YSkKKyAgICAgICAgICAgICAgICB7IHJldCA9IHNp
emU7IG1hdGNoID0gdHJ1ZTsgfQorICAgICAgICAgICAgICBicmVhazsKKyAg
ICAgICAgICAgIGNhc2UgX1NDX0xFVkVMMV9EQ0FDSEVfQVNTT0M6CisgICAg
ICAgICAgICAgIGlmIChsZXZlbCA9PSAxICYmIHR5cGUgPT0gQ2FjaGVEYXRh
KQorICAgICAgICAgICAgICAgIHsgcmV0ID0gKGFzYyA9PSAweEZGKSA/IDB4
ODAwMCA6IGFzYzsgbWF0Y2ggPSB0cnVlOyB9CisgICAgICAgICAgICAgIGJy
ZWFrOworICAgICAgICAgICAgY2FzZSBfU0NfTEVWRUwxX0RDQUNIRV9MSU5F
U0laRToKKyAgICAgICAgICAgICAgaWYgKGxldmVsID09IDEgJiYgdHlwZSA9
PSBDYWNoZURhdGEpCisgICAgICAgICAgICAgICAgeyByZXQgPSBsc2l6ZTsg
bWF0Y2ggPSB0cnVlOyB9CisgICAgICAgICAgICAgIGJyZWFrOworICAgICAg
ICAgICAgY2FzZSBfU0NfTEVWRUwyX0NBQ0hFX1NJWkU6CisgICAgICAgICAg
ICAgIGlmIChsZXZlbCA9PSAyKQorICAgICAgICAgICAgICAgIHsgcmV0ID0g
c2l6ZTsgbWF0Y2ggPSB0cnVlOyB9CisgICAgICAgICAgICAgIGJyZWFrOwor
ICAgICAgICAgICAgY2FzZSBfU0NfTEVWRUwyX0NBQ0hFX0FTU09DOgorICAg
ICAgICAgICAgICBpZiAobGV2ZWwgPT0gMikKKyAgICAgICAgICAgICAgICB7
IHJldCA9IChhc2MgPT0gMHhGRikgPyAweDgwMDAgOiBhc2M7IG1hdGNoID0g
dHJ1ZTsgfQorICAgICAgICAgICAgICBicmVhazsKKyAgICAgICAgICAgIGNh
c2UgX1NDX0xFVkVMMl9DQUNIRV9MSU5FU0laRToKKyAgICAgICAgICAgICAg
aWYgKGxldmVsID09IDIpCisgICAgICAgICAgICAgICAgeyByZXQgPSBsc2l6
ZTsgbWF0Y2ggPSB0cnVlOyB9CisgICAgICAgICAgICAgIGJyZWFrOworICAg
ICAgICAgICAgY2FzZSBfU0NfTEVWRUwzX0NBQ0hFX1NJWkU6CisgICAgICAg
ICAgICAgIGlmIChsZXZlbCA9PSAzKQorICAgICAgICAgICAgICAgIHsgcmV0
ID0gc2l6ZTsgbWF0Y2ggPSB0cnVlOyB9CisgICAgICAgICAgICAgIGJyZWFr
OworICAgICAgICAgICAgY2FzZSBfU0NfTEVWRUwzX0NBQ0hFX0FTU09DOgor
ICAgICAgICAgICAgICBpZiAobGV2ZWwgPT0gMykKKyAgICAgICAgICAgICAg
ICB7IHJldCA9IChhc2MgPT0gMHhGRikgPyAweDgwMDAgOiBhc2M7IG1hdGNo
ID0gdHJ1ZTsgfQorICAgICAgICAgICAgICBicmVhazsKKyAgICAgICAgICAg
IGNhc2UgX1NDX0xFVkVMM19DQUNIRV9MSU5FU0laRToKKyAgICAgICAgICAg
ICAgaWYgKGxldmVsID09IDMpCisgICAgICAgICAgICAgICAgeyByZXQgPSBs
c2l6ZTsgbWF0Y2ggPSB0cnVlOyB9CisgICAgICAgICAgICAgIGJyZWFrOwor
ICAgICAgICAgICAgY2FzZSBfU0NfTEVWRUw0X0NBQ0hFX1NJWkU6CisgICAg
ICAgICAgICAgIGlmIChsZXZlbCA9PSA0KQorICAgICAgICAgICAgICAgIHsg
cmV0ID0gc2l6ZTsgbWF0Y2ggPSB0cnVlOyB9CisgICAgICAgICAgICAgIGJy
ZWFrOworICAgICAgICAgICAgY2FzZSBfU0NfTEVWRUw0X0NBQ0hFX0FTU09D
OgorICAgICAgICAgICAgICBpZiAobGV2ZWwgPT0gNCkKKyAgICAgICAgICAg
ICAgICB7IHJldCA9IChhc2MgPT0gMHhGRikgPyAweDgwMDAgOiBhc2M7IG1h
dGNoID0gdHJ1ZTsgfQorICAgICAgICAgICAgICBicmVhazsKKyAgICAgICAg
ICAgIGNhc2UgX1NDX0xFVkVMNF9DQUNIRV9MSU5FU0laRToKKyAgICAgICAg
ICAgICAgaWYgKGxldmVsID09IDQpCisgICAgICAgICAgICAgICAgeyByZXQg
PSBsc2l6ZTsgbWF0Y2ggPSB0cnVlOyB9CisgICAgICAgICAgICAgIGJyZWFr
OworICAgICAgICAgICAgZGVmYXVsdDoKKyAgICAgICAgICAgICAgYnJlYWs7
CisgICAgICAgICAgICB9CisgICAgICAgICAgaWYgKG1hdGNoKQorICAgICAg
ICAgICAgYnJlYWs7CisgICAgICAgIH0KKyAgICAgIHJlbWFpbmluZyAtPSBw
LT5TaXplOworICAgICAgcCA9IChQU1lTVEVNX0xPR0lDQUxfUFJPQ0VTU09S
X0lORk9STUFUSU9OX0VYKSAoKEJZVEUgKikgcCArIHAtPlNpemUpOworICAg
IH0KKworICBmcmVlIChidWYpOworICByZXR1cm4gcmV0OworfQorI2VuZGlm
IC8qIF9fYWFyY2g2NF9fICovCisKIHN0YXRpYyBsb25nCiBnZXRfY3B1X2Nh
Y2hlIChpbnQgaW4pCiB7CisjaWYgZGVmaW5lZChfX2FhcmNoNjRfXykKKyAg
cmV0dXJuIGdldF9jcHVfY2FjaGVfYXJtNjQgKGluKTsKKyNlbHNlCiAgIHVp
bnQzMl90IG1heGYsIHZlbmRvcl9pZFs0XTsKICAgY3B1aWQgKCZtYXhmLCAm
dmVuZG9yX2lkWzBdLCAmdmVuZG9yX2lkWzJdLCAmdmVuZG9yX2lkWzFdLCAw
eDAwMDAwMDAwKTsKIApAQCAtNDcxLDYgKzYxOCw3IEBAIGdldF9jcHVfY2Fj
aGUgKGludCBpbikKICAgICAgIHJldHVybiBnZXRfY3B1X2NhY2hlX2FtZCAo
aW4sIG1heGUpOwogICAgIH0KICAgcmV0dXJuIDA7CisjZW5kaWYKIH0KIAog
ZW51bSBzY190eXBlIHsgY29ucywgZnVuYyB9OwotLSAKMi40OS4wLndpbmRv
d3MuMQoK

--_004_PN0P287MB0295E7BAEC9FFE804D2A7CDD923C2PN0P287MB0295INDP_--
