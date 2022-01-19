Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihcesxwayst04.hub.nih.gov (nihcesxwayst04.hub.nih.gov
 [165.112.13.42])
 by sourceware.org (Postfix) with ESMTPS id F1B153858D37
 for <cygwin-patches@cygwin.com>; Wed, 19 Jan 2022 13:12:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org F1B153858D37
X-SBRS-Extended: Low
X-IronPortListener: ces-out
X-IronPort-AV: E=Sophos;i="5.88,299,1635220800"; d="scan'208";a="227444664"
Received: from unknown (HELO mail.nih.gov) ([165.112.194.64])
 by nihcesxwayst04.hub.nih.gov with ESMTP/TLS/AES256-GCM-SHA384;
 19 Jan 2022 08:12:20 -0500
Received: from nihexs3.nih.gov (165.112.194.63) by NIHEXS4.nih.gov
 (165.112.194.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 08:12:20 -0500
Received: from GCC02-DM3-obe.outbound.protection.outlook.com (165.112.194.6)
 by nihexs3.nih.gov (165.112.194.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18 via Frontend Transport; Wed, 19 Jan 2022 08:12:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QG+B20BUjhI5XwQCjRqIyZ4rfA9m9O+AP3M48HaVL7a7YzcOdhD6FVcRbdx9Zdvc+rt3eyPAO6vnNwHloFOscPiaYudXTtazVem1ZYW8HUvIcfMh75r+VmiZbl1pjVF2rCGcayrm1RT9duu4dAVU/MRuAkjxtqbTbGtsD+0cGkoCMZpBCU2+Gr2Zj/RCc54aGINasdJUnkDx/pDqIe640C9Hoar0XIfRjxX0sOHsPF9+Xzzxd9fmWWelfEuCa6VfEwjA8Jr7e5ukqI3tloaAem76Gny8QdhiIW4LbuErt0+7LzC4uY30zFeBKXy5E1jL82O1OUWarFzdNMpftxpyWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ac13104NvouBgTNdtUCYO5/95ZuZy4ETxzaAlapzXTg=;
 b=HX+oBUUcJtxpt0nrM3QYyB5K0VaydEotOH+MU1GYDTwzW/CWyHPT998F0hlpj3hfqnis/avhr5rRNQqh9XbGhjFA80VADNatOne7wKmI0EjG3M1ghSDRmWD9uCxg9hy6ZqLVZwI+IHFF3uxNjDJT6uDWuJO2e0edQm4L1fz512AUyQ1AiZU20CueIUxbNFggiAGxM6dkP55sH4quZjkqqXBC5hT3RE9Atwu/+tMb56wn0nahkgaE+ppyGiaatDPV3lXWtn5z2bI0JQDEJkdBpwhCILQP618zpNluVNICK/4CowDnmLfOmhPEVxReGFlW94RgYLqtKyBn6Q2OdXuy6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM8PR09MB7095.namprd09.prod.outlook.com (2603:10b6:5:2e3::14)
 by DM8PR09MB6023.namprd09.prod.outlook.com (2603:10b6:5:2ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 13:12:19 +0000
Received: from DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::d82c:2f49:8b4a:6d41]) by DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::d82c:2f49:8b4a:6d41%4]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 13:12:19 +0000
From: "Lavrentiev, Anton (NIH/NLM/NCBI) [C]" <lavr@ncbi.nlm.nih.gov>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] Cygwin: resolver: A few fixes for cygwin_query(), part 2
Thread-Topic: [PATCH] Cygwin: resolver: A few fixes for cygwin_query(), part 2
Thread-Index: AdgNNi+IgwjedB9SQe6yohMVbKCunA==
Date: Wed, 19 Jan 2022 13:12:19 +0000
Message-ID: <DM8PR09MB7095B3AA836BB2F500060790A5599@DM8PR09MB7095.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0aff717-47de-4d9e-bc5b-08d9db4d52ca
x-ms-traffictypediagnostic: DM8PR09MB6023:EE_
x-microsoft-antispam-prvs: <DM8PR09MB6023E42754CD39531E8D2162A5599@DM8PR09MB6023.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i9HYrN4vI/fS/hzatdVG+RuGQIGSORPIojm90v2xXc62UYjXWtfk41ZjPKL+lREktM1jZSnEmcxo7ajrKRI02lUhSEVV17CoSlaLJ4q68LFn9f8yR+a3M6OnK4CzRScryudQcnXSc3EgMEjy+eaHXgHsf9Sd2cFzziwXY8ZI/ig8ud+eLz60uCVjkEPfcV7wGK+PjV0tNGzOXmMMFzLp8u0SlGu+uwZRR0+OXR56X74DDs3VHCTZMT0RTduX4NE9326qKucPZoeNhUJ4+RFQyPoi3uDh/TCxIALoE/64jurBl+3/wU/UJoH4E7hVF9HuOSVenMeTLpIMJXftkQ463y/NtzMOO3JgFCrBAnU9T5LShgiTOH8xSluNck2RlBv/9RI75Otc3hDd6jv4gahnIApKvQn+hBWI3+mdSsHIbFfKHIX1WvjWM8uvJZ1AKBCJrNVs7weYqb4gg9Z2hOAOpRJo0aOB46d/59npq6Q3gUZHRlwCq/OQSpUS0gpDw47XmePGVHj72EJZGBxSQ/y5zLpY2sGa7U+1nBy17BPEAG5UBGuiWdAklESuAVgJM60Z44v6mjnO1z1e4b8zcwajgpCFJDCAUkYckjlIRM9gWimNhSrsWORednIYwZXspay2GMmiyoGukN8tebF93bQ9mJwSuVakNuFXi5aTY7+ggw/piuW23r2ae0F2+EXq37szNNMa9ahyQQavjxajxDTMIw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR09MB7095.namprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(9686003)(71200400001)(66476007)(66946007)(86362001)(55016003)(8936002)(33656002)(316002)(66446008)(64756008)(66556008)(122000001)(38100700002)(76116006)(558084003)(508600001)(6916009)(2906002)(7696005)(186003)(5660300002)(6506007)(52536014)(38070700005)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3lHMCtaZEE4Uy9pVTl2ZG5NS1RYNEpaUlRSVTYwTFJIcElaZyt4ajJXZ0wr?=
 =?utf-8?B?SzNQd3h3N3JYOFhPcmZ6dlpvVlAyMTNOKzd3eU82ZGFDekdPUnBJckE1eWxu?=
 =?utf-8?B?TFBvellsSFRFcW1KY2VBTGwzTHMwVWlMcTl6YTRqRkJVNnBjdXM1TEtENE9x?=
 =?utf-8?B?ZVc5WHhEekZ3SE84a1MxdDZXVHhsb051NHdmaDNRd1VCWC9oQy9OVVFONng1?=
 =?utf-8?B?NC8xV1puZDFBYWdKZ2ptN1RqVytaZ2pqYUhOWGh3L2cxaEVSMWtXLzBKRFBn?=
 =?utf-8?B?NnVuQ21udjB0d0hMa2wyU3V0QjV1MnpuVWlXUzB4ZnpUTnkwZk4wb2h1c1Rn?=
 =?utf-8?B?QzhyNDY4Sk9EdjE3UE9FNXFpWW1oekl1bkh2RXpvblcybmJqMUszNWduMWV2?=
 =?utf-8?B?aExrOTZNTHN4Nmh2SUhrS21mdnhDVElraFd2cnExZnBmM3NCcDlWY0J2Q3lT?=
 =?utf-8?B?U3ZEYy9RNjBrUWRhblVkUG1saW9LRUtkbFNnS2E1WHJncHlPNjVRTCtBZ01n?=
 =?utf-8?B?ZDBqZEZzdzh6Z3E3ZnZEcEhTUzlzclJYWmpQeU02dTVFVGNmNzZ1ZWlKbkhF?=
 =?utf-8?B?UWQrMmxkY1poU0RXYzkvdVkvRTQvZXN0TFRieEJiZENuRUZjZXI5RkVlUmQ4?=
 =?utf-8?B?S0dZYWt2cml2UVhtQWJ4UjRzTHRCclEvdlVBZktIeEp6Uzk0ZzFhTWN5QkFZ?=
 =?utf-8?B?SWk1ckhJUFU3clRoNGRHY21Fd3JJZ1VVMlNxeGFLZ0c2dHd0MjV4TnpiNS9E?=
 =?utf-8?B?bmZEbU9xWllJTkVsRG5wWUJNaHIrQURxMlI1dyt6SWFuaEEyRzNxKy9rWC94?=
 =?utf-8?B?UDE5b0NOTFZkMFVCemZ2bVovUHh0azd2ZGZRRisxWHhzR1VNcWtiakhtaFEw?=
 =?utf-8?B?YmJNd2sraGUxaXIyTlpRS2E5TzY0MitRL0dreE1qeGRFVFJjR3NHbDRVa00y?=
 =?utf-8?B?NmhtdzQvbkFJRWUyRDExaVRBd0dwc25OVHJxbHpkamJMbUV5OXkxY282UElF?=
 =?utf-8?B?citoSTVYSi8zdCt4NVJNQ0tVWHFNYUZTY3F1YnE5Z3FYL0dPNFlEdmh5RjBB?=
 =?utf-8?B?dWMvNnBDT3BFWjlPRUZXUTN5SzhKQ1FzS2ViaFJSWGdwZytyZm55bGdmKy9B?=
 =?utf-8?B?cllVbkgzc0t0cDJsbmlwSDJreEJLT1p2UzJ6K0VnQ2dtTjFNRERieVI1NUJ4?=
 =?utf-8?B?RDJ2eGFZVzUwWndJOEM2UWljT25ZYURxSTBhUWhIMmJIc25uZVplUUZtM0pR?=
 =?utf-8?B?bkJEeWF3bEhTWEhuSDA0VXdOV2JnNWNoTzROOC9CMjczeXlyc2xEa2FxTldD?=
 =?utf-8?B?Wk9KaVB6ZDBCNlhEZlZldU9sSnZXSWRPVDNyaS9iaDlHQk5ia2Q4b3dFVG9Q?=
 =?utf-8?B?cUNtSDVQY3ZhUW9hSHIwWFduT1Z1dG10OUZRQVZOZVUvNGpzbkN5bW0raFJn?=
 =?utf-8?B?aVFNY2djemg2aVFYMnE5WVdQc0YxY3dRZE5mbmk2dWFkQnJBSDUvYTFkaEdh?=
 =?utf-8?B?SFhRYXh3bWpnU3hyczhvS0QxSnVCMnpMZExvNXlPS3V6RklEbHpaNXFMVlNr?=
 =?utf-8?B?emVvWDk4Y0s5cmYrQ3lZTVJmVmpBTjltSVpTTWpkdS9aOTZodmZHeFVTWEJM?=
 =?utf-8?B?ckpYWFJJZHQ4VE9GczlyelFqcU16SjBqTlJROHVLNDA0VHdyWkI5ZGltQnUz?=
 =?utf-8?B?TEZKenBuSnJZczY2eVJWMU5FVVNFVEpBNndiOG1ISlZvTk1oS20rME9mL3RM?=
 =?utf-8?Q?lcAvhOt3z+saEcxkdI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR09MB7095.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0aff717-47de-4d9e-bc5b-08d9db4d52ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 13:12:19.6543 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 14b77578-9773-42d5-8507-251ca2dc2b06
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR09MB6023
X-OriginatorOrg: ncbi.nlm.nih.gov
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_EF, KAM_NUMSUBJECT, SPF_PASS, TXREP,
 T_SPF_HELO_PERMERROR autolearn=no autolearn_force=no version=3.4.4
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
X-List-Received-Date: Wed, 19 Jan 2022 13:12:22 -0000

PiBHcmVhdCwgdGhhbmtzISAgSSBwdXNoZWQgYWxsIHlvdXIgcmVzb2x2ZXIgcGF0Y2hlcy4NCg0K
VGhhbmsgeW91ISAgSSdsbCBiZSBzdWJtaXR0aW5nIHRoZSBsYXN0IHRpbnkgbGl0dGxlIG9uZSBp
biBhIHNlYyA6LSkNCg0KQW50b24gTGF2cmVudGlldg0KQ29udHJhY3RvciBOSUgvTkxNL05DQkkN
Cg0K
