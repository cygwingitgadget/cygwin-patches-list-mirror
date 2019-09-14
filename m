Return-Path: <cygwin-patches-return-9677-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 61301 invoked by alias); 14 Sep 2019 16:04:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 61286 invoked by uid 89); 14 Sep 2019 16:04:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=Geisert, geisert, HX-Languages-Length:1182
X-HELO: NAM03-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr780130.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) (40.107.78.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 14 Sep 2019 16:04:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=ZAvo7rN8bw8kcsVr0nV2NTb1KQcfKOANeexdQvnj4065FW0/cFjNurg2E1qYGazU7hMiDWdmvxVdVCThFZRU5tTCVg+xi/1aoCu1mRgsNxgoMsxW1ciYrlE9P7zKx35XrUOu26Jiz0AMmAM3azDDNs2dItlyWOduKMp6LGPzNTAdChkSb0Sf8xVTcIVkPT9DhIx1dTnxYEDggsMyWCaKe+wxzMRWHUBgW9LxvkjzAp/aAG7/OJklwc9y+Rn07PMIynWaSdi0SAy59YHjZozJJCpNFoyGuJihHpQX5W8C/T+FSBax0Tv8CEi9CREjHTDpA1lUeAMZPTnjZVLM2K7I0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=ZUqmvWa/xdA2wwlGjqgT05BGn6g1jS6yjy68wClPq+4=; b=kKiWwYqKXsrjTnmbvGH+mkPDBV3v9G8QclTbsgW3pCVf+4iZ8kyzujlUdSFdBR0vd1kfHyxeZRTM3QFROpW59Hq6hKd6gRri5sDCPcfV9bQQDNMJeTJvlwNRm8589oCXFEqz2lecRE3Q0+APaXf5St41Wvh40lxeIBZ5tm+woFE9+SbYcRZd9442PBKoBoVleRd5eTm73Kn9BgDE7OgSxNk8juZ1WEGdmiSnD9cHMjZAgUnJrw6yddqWWkEBl4slo55NNNWpaGDiqIxIhvI/Tf1RJJiqAYVfgcUxovOzJ5+bUlbvj/9bE3wdr3u74TN3V73jFWYNUBKdMF6GD8YY7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=ZUqmvWa/xdA2wwlGjqgT05BGn6g1jS6yjy68wClPq+4=; b=VgiCLEO4D4huY8TCGerRa9NOeTo+bJfQrZu3x0JvsIHbfqArrTmlYsUXsT4HNYGpuXgynqxnsUZzmn7V1XOgnJLdynRzKk7icjY8i9vTDKlfVWZWg15kY7q5aFEga1xSxEJf7TBWKHf7pWTcEZgW3rodC/8kLU7qmR7d2E25QeY=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB7001.namprd04.prod.outlook.com (10.186.143.151) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.17; Sat, 14 Sep 2019 16:04:30 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2263.023; Sat, 14 Sep 2019 16:04:30 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: fix CPU_SET macro visibility
Date: Sat, 14 Sep 2019 16:04:00 -0000
Message-ID: <e351d7c2-3101-7066-95f4-6e7aa66bc8e0@cornell.edu>
References: <855a9543-6908-42f0-576a-0f161777f715@ssi-schaefer.com> <20190914045802.693-1-mark@maxrnd.com>
In-Reply-To: <20190914045802.693-1-mark@maxrnd.com>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:4303;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <1F82C4C56BAAF64593EF66D8707E19F8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eb6WcsJMRbD7PIW2lookKRs37Djic/veB78jkULl/d9yuuehjWTJi6QwsQkmnIFir5st7GnYCRk1DlumaRdDYg==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00197.txt.bz2

On 9/14/2019 12:58 AM, Mark Geisert wrote:
> The CPU_SET macros defined in Cygwin's include/sys/cpuset.h must not
> be visible in an application's namespace unless _GNU_SOURCE has been
> #defined.  Internally this means wrapping them in #if __GNU_VISIBLE.
>=20
> ---
>   winsup/cygwin/include/sys/cpuset.h | 3 +++
>   1 file changed, 3 insertions(+)
>=20
> diff --git a/winsup/cygwin/include/sys/cpuset.h b/winsup/cygwin/include/s=
ys/cpuset.h
> index 2056f6af7..1adf48d54 100644
> --- a/winsup/cygwin/include/sys/cpuset.h
> +++ b/winsup/cygwin/include/sys/cpuset.h
> @@ -26,6 +26,7 @@ typedef struct
>     __cpu_mask __bits[__CPU_GROUPMAX];
>   } cpu_set_t;
>=20=20=20
> +#if __GNU_VISIBLE
>   int __sched_getaffinity_sys (pid_t, size_t, cpu_set_t *);
>=20=20=20
>   /* These macros alloc or free dynamically-sized cpu sets of size 'num' =
cpus.
> @@ -88,6 +89,8 @@ int __sched_getaffinity_sys (pid_t, size_t, cpu_set_t *=
);
>   #define CPU_XOR(dst, src1, src2)  CPU_XOR_S(sizeof (cpu_set_t), dst, sr=
c1, src2)
>   #define CPU_EQUAL(src1, src2)     CPU_EQUAL_S(sizeof (cpu_set_t), src1,=
 src2)
>=20=20=20
> +#endif /* __GNU_VISIBLE */
> +
>   #ifdef __cplusplus
>   }
>   #endif

Pushed.  Thanks.

Ken
