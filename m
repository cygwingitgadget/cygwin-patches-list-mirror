Return-Path: <cygwin-patches-return-9798-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 90371 invoked by alias); 1 Nov 2019 02:57:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 90355 invoked by uid 89); 1 Nov 2019 02:57:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=busy, travel, you!
X-HELO: nihcesxwayst06.hub.nih.gov
Received: from nihcesxwayst06.hub.nih.gov (HELO nihcesxwayst06.hub.nih.gov) (165.112.13.54) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 01 Nov 2019 02:57:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;  d=nih.gov; i=@nih.gov; q=dns/txt; s=NIH; t=1572577038;  x=1604113038;  h=from:to:subject:date:message-id:references:in-reply-to:   content-transfer-encoding:mime-version;  bh=Fpm2+4kMK8r/FLi1PbcbtOfYIatApMAhiLxcHEB+qOs=;  b=LJ2u0gX8mpin+XGxNYLFDvc2vHAN98XOyiHmdylUXLddKIMzNdDRMLxP   L/SYDwsm/v9zmSJAmORYrgRrN2D16MBi46HOfxetcQooVLuuSfFtPo7Hq   mw9QKz7Lx8g70Fl5lrP6Pxyu0wMdbOwKwvUfuEOgYDSZATQkD79PhILKr   RwIGIvPoMgh0Fyf3EUde/45XY5DyOSCC5qncOtrKGBmS3Gf+NiARQjvWL   sWEU7/7kDNODPpoHcukmVXTj2QcuaxZc8vV9DZg9YRcKeo95ItpinD0j5   zNdpIu7QkrFrQypHZ+YhXONQL/FOFBd/+1TZGdEXR7ic+Q51FBMyL8BCv   w==;
IronPort-SDR: r7HGLQtPDJVhgM8HsheOx6/6Z+0qD5TTSdIsEFsNPun4GPZZrHKYq6WQgAyjrtfEL1OULAXN4g QjjbD+7getBw==
Received: from uccsx02.nih.gov (HELO ces.nih.gov) ([165.112.194.92])  by nihcesxwayst06.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 31 Oct 2019 22:57:16 -0400
Received: from uccsX02.nih.gov (165.112.194.92) by uccsX02.nih.gov (165.112.194.92) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 31 Oct 2019 22:57:16 -0400
Received: from GCC02-BL0-obe.outbound.protection.outlook.com (165.112.194.6) by uccsX02.nih.gov (165.112.194.92) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend Transport; Thu, 31 Oct 2019 22:57:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=NhtiTmGn2au+a7/TwwHBi85It9n6fFyxBAKXD8ZgqNfAT4hkIHZ2bpk+gEXg2tYTKZtz1vfQKFJayMnXS08w15Vn09XFtyrF2M4z1PJCkABcsKYW9FY5n+pEZX8omEPK6qWL/zXkCGEirzA4JgE6kqXrgFtf34MZVgSu5AjJKHqmJguJ1x0ZxCYsqWoF7HMOS7oGLRFbz5j1gWKuv8VNyYBdiiGVQTrYhZ1tijzZ3x1t8pNsKmrtmKfKK295LihxGw6BK8Qq2S5CcgL5BOdCjyWludE72KTgL93e0lcTSWuO2+Jy/2lH2b9a3gyNw7ltLD36qWByrGVmgMJi9OAudw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=Fpm2+4kMK8r/FLi1PbcbtOfYIatApMAhiLxcHEB+qOs=; b=jjS04tlKjxRJX1aA0fqQp5vyXMeMi63x1+dZi73A5jI8R2RjZjUZ16H/qg+hdtY0FWd9CujJxuZ6H34Z+TjMONLgJ5pHGthz9O1VVPRsCpBaBSpxcePzr94hrlHmltL6X2gC9vHG6q/rrTGFnARId19Clox7oWbJJK75QxYR2gpUXZ3aibD5Sb9PbHctq0MWFIOdT0JcyEb47PycMFjzEve9CWh7wRsH9SSdnrQeWzs8eJIFg8UKcDavcz5eZR1Ul1gp82nLlnxdxdvXVuclqgaPPyTsYcXSkCC/03HhgeKPljt5CWwZzyPe4s5B1QgS7k3GICuU+1LLS6ifD3uCKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=ncbi.nlm.nih.gov; dmarc=pass action=none header.from=ncbi.nlm.nih.gov; dkim=pass header.d=ncbi.nlm.nih.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nih.onmicrosoft.com; s=selector2-nih-onmicrosoft-com; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=Fpm2+4kMK8r/FLi1PbcbtOfYIatApMAhiLxcHEB+qOs=; b=UGCYBL4W2hIG26aiq7zUoI4qn7vQnAo92Em12oRTWHDCxGcfxcB/XkWZ0noU8YhqZwPkWgybrE0N6KywdhJqiyRQFrQyQDrb+NcTFozMf/UsDdokxNmFM/dhOL5NvZfiulJ4xwwy1r94flkeYVWg+qvw7hOH94F0X67aV/4675c=
Received: from BN7PR09MB2724.namprd09.prod.outlook.com (52.135.254.158) by BN7PR09MB2596.namprd09.prod.outlook.com (52.135.255.12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.18; Fri, 1 Nov 2019 02:57:15 +0000
Received: from BN7PR09MB2724.namprd09.prod.outlook.com ([fe80::15e7:f448:5c8a:c7c5]) by BN7PR09MB2724.namprd09.prod.outlook.com ([fe80::15e7:f448:5c8a:c7c5%5]) with mapi id 15.20.2387.027; Fri, 1 Nov 2019 02:57:15 +0000
From: "Lavrentiev, Anton (NIH/NLM/NCBI) [C] via cygwin-patches" <cygwin-patches@cygwin.com>
Reply-To: "Lavrentiev, Anton (NIH/NLM/NCBI) [C]" <lavr@ncbi.nlm.nih.gov>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] Cygwin: getpriority() consistent with process priority
Date: Fri, 01 Nov 2019 02:57:00 -0000
Message-ID: <BN7PR09MB27247672AB84515361172B54A5620@BN7PR09MB2724.namprd09.prod.outlook.com>
References: <20191030154725.4720-1-lavr@ncbi.nlm.nih.gov> <20191031204109.GF16240@calimero.vinschen.de>
In-Reply-To: <20191031204109.GF16240@calimero.vinschen.de>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=lavr@ncbi.nlm.nih.gov;
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RZazD9Yd6rKihHp6snbdW6O3UA5C9ovAUzPyDVNQt60Z0ZRkrRnpokqDejzeWzDe
Return-Path: lavr@ncbi.nlm.nih.gov
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00069.txt.bz2

PiBQdXNoZWQuDQoNClRoYW5rIHlvdSEgIEl0IHRvb2sgbWUgYXdoaWxlLCBz
b3JyeSBhYm91dCB0aGF0IC0tIHdhcyBleHRyZW1lbHkgYnVzeSB3aXRoIHN0
dWZmIGFuZCB0cmF2ZWwNCg==
