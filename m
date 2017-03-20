Return-Path: <cygwin-patches-return-8718-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 114819 invoked by alias); 20 Mar 2017 13:05:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 114357 invoked by uid 89); 20 Mar 2017 13:05:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.4 required=5.0 tests=BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=no version=3.3.2 spammy=Hx-spam-relays-external:209.85.192.194, H*RU:209.85.192.194, H*MI:sk:2017032, HTo:U*cygwin-patches
X-HELO: mail-pf0-f194.google.com
Received: from mail-pf0-f194.google.com (HELO mail-pf0-f194.google.com) (209.85.192.194) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 20 Mar 2017 13:05:33 +0000
Received: by mail-pf0-f194.google.com with SMTP id r137so13457184pfr.3        for <cygwin-patches@cygwin.com>; Mon, 20 Mar 2017 06:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:subject:to:references:from:message-id:date         :user-agent:mime-version:in-reply-to;        bh=1GJGVYxu+UHsAS8+wAUbxK/SWlepeOf6hVxZ9BFWHTg=;        b=AX+EC+I3QsdbtsiuENbxZ81iDU+9jZAgoyShKPachgQ8G7/ncFMM0Itu49KBvGTlUw         DSq62TyWNQbSAulHElJoVAPY95RsTVn/1EYV4DDo9CXbYyVkyJT/qYaS2RebfLR8ofWA         8mP2O2S4KG33Tvv4qdYqH3L9LqiK/41CkH3yDt0gf8i9cEzuifbN8o72U7ilGCnWP5zY         5VASpAb1yxegnPdqlOmAiXu5nfAkqWcfaWi3MShe1pSCc2zRnHLimZtHNhdlWswwZ8O5         dQ3uySgHkpXreZR8J566GPMmZsyz4loUcK5jhIydW5xAD0OvLJi0V5Mc1+9eNmGiyrFq         kauA==
X-Gm-Message-State: AFeK/H0P8I1ntPlMEY1b4we723360NCqVoqRiEpg5US9Qyrzp/VXtuKcz28mYrah8sAJXQ==
X-Received: by 10.98.221.141 with SMTP id w135mr32178349pff.109.1490015132735;        Mon, 20 Mar 2017 06:05:32 -0700 (PDT)
Received: from ?IPv6:2001:e68:4074:625f:f64d:30ff:fe63:5a5a? ([2001:e68:4074:625f:f64d:30ff:fe63:5a5a])        by smtp.gmail.com with ESMTPSA id j62sm33567370pgc.54.2017.03.20.06.05.31        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Mon, 20 Mar 2017 06:05:31 -0700 (PDT)
Subject: Re: [PATCH] Implement getloadavg()
To: cygwin-patches@cygwin.com
References: <20170317175032.26780-1-jon.turney@dronecode.org.uk> <20170320103715.GH16777@calimero.vinschen.de>
From: JonY <10walls@gmail.com>
Message-ID: <19337cb5-19f3-5ebc-db08-2aecc1a01924@gmail.com>
Date: Mon, 20 Mar 2017 13:05:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170320103715.GH16777@calimero.vinschen.de>
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="Bd4UXs68SoWWlAPPcS9Q5RAs0U0El07VD"
X-IsSubscribed: yes
X-SW-Source: 2017-q1/txt/msg00059.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Bd4UXs68SoWWlAPPcS9Q5RAs0U0El07VD
Content-Type: multipart/mixed; boundary="x9CDS4oUVmoO0BGF4WsxCfB35kVV7UToL";
 protected-headers="v1"
From: JonY <10walls@gmail.com>
To: cygwin-patches@cygwin.com
Message-ID: <19337cb5-19f3-5ebc-db08-2aecc1a01924@gmail.com>
Subject: Re: [PATCH] Implement getloadavg()
References: <20170317175032.26780-1-jon.turney@dronecode.org.uk>
 <20170320103715.GH16777@calimero.vinschen.de>
In-Reply-To: <20170320103715.GH16777@calimero.vinschen.de>


--x9CDS4oUVmoO0BGF4WsxCfB35kVV7UToL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-length: 271

On 03/20/2017 10:37 AM, Corinna Vinschen wrote:
>=20
> JonY, any chance for a quick update of w32api-headers to include the
> patch from https://sourceforge.net/p/mingw-w64/mailman/message/35727667/?
>=20

Sure, I'll try to churn out 5.0.2 with this fix by next week.




--x9CDS4oUVmoO0BGF4WsxCfB35kVV7UToL--

--Bd4UXs68SoWWlAPPcS9Q5RAs0U0El07VD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 858

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCAAwFiEE5QrdnbBX9Ppk4bbPcTtf4pwUXUUFAljP05MSHDEwd2FsbHNA
Z21haWwuY29tAAoJEHE7X+KcFF1FzPoP/i2g/9XK2MScCCn/U7E3MU1wIAlefelF
4A24LVUjXeBBGoPZ5GNEO70xM/rCN4gsx9cHm1d5M1yV9tPwNueGeAIdGP/kEaDx
ameMzm0l0cpcmh8Pte+FuzPaWfJEgZ0eFj8RBJEiQtjwwdDwMbKt/FsF9qL2WSRv
McklI+rUAWDfNJ7egPT+9m3P/fUjC+hjP/+BNE89vAtGWF/ujh01Y4QNG005YG7S
Nd4NIKpXoNhCudm3ZkQ7DTjEsAS3gcyuCKDRO+ZNinEeaL61HbMcLT8xl9Ra4Hf7
hZzMC9ABoDpzbKo1fZohWEsi51JmffyrbiwGxlYSUNz7KGx2EmKCcCHXuAPCZO9o
SP6o6iofO1i0L1WNbeLQIzC7eIUs65uPf3GwWKEKBgLA7lt+96eSk9oNJs5VWaNo
P5q38OEoezXKctagNbTRE8nk7ymVM6nbcq+WJB2xAtLuOHeHflvfX5wWAbI6jqLY
wQELcbnQP4qd3fT7QGSZn/yi0V491Koy9vmCJGbiHpHi0WGLXPaEXEk2+FqoQMgk
Ft1XTVA3TwV/6Pnzcnr3VZpaT/Zu3eSZKEYERu8dq64EyYqbcdkI+6ltRw/JaSBV
t9tXNFmMcmAiX0RGmA7SEDY/3uhk+jLzrQxZ+9BIDMgq4H4s2HSYKosgIZ/Wcq62
URVv9d8aLlWF
=Bfjt
-----END PGP SIGNATURE-----

--Bd4UXs68SoWWlAPPcS9Q5RAs0U0El07VD--
