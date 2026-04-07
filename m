Return-Path: <SRS0=h8Rg=CG=arm.com=Igor.Podgainoi@sourceware.org>
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	by sourceware.org (Postfix) with ESMTPS id 086EE4BA543C;
	Tue,  7 Apr 2026 17:26:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 086EE4BA543C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 086EE4BA543C
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c20a::7
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1775582765; cv=pass;
	b=FFGifUodUKPb+NjikD2eXQPyh82PJkdd2S4h75YoGbxXvvHvP8tDyBq7e1UZTdLMMbd7VqoPAxepY1R1TuDntndiFF7lEC0hZmwxG1LavlWhog9FfmQgtCmOS+qLGN3s8tekqzaXFnoctTN+PNrDWaptoUXY5lmYCJu4XOporzg=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1775582765; c=relaxed/simple;
	bh=AscME+HZLWUsIPsjqtK4t+Tb219k6BAF7HlSVmCJCZE=;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version; b=EWAxY+3yVhJt7vPSBbsl/oBzbsq59+IIMibRl5TPemHHftcdtlAcElxHRmoXt3Z5A78eB9lSPyIAr9XmnxOKDMqmaD8Unkg4/yM+3ZzoiQ0SAL8AT0ZlMKe7IM9Ww/tEU/YV3vzzi0vSXPhc6ilLMeHOK7rUAdCDbkiHOrZc4fU=
ARC-Authentication-Results: i=3; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 086EE4BA543C
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Wk72N2T1;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Wk72N2T1
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=HaHHVLf4RReSZEXS5V84io1CCGFAtwuZU5U2okI0FKYj8pJ3hqBrqWNoVQNpxi6SUvJj0iKWd71itW5Luw+dUBguICD9HoSimA8adzk/TNP57ljFu2Ub1Vn3oy5yWVzuKo499uA4iA1sk6GISFAUBIIOjk+D1es1Jqo8i4KvxbikVpgYjAo5ScGPhm2bVLAniVnAGVESV7a4FCOUAUMklj/GktPpMijhLJmEwgEZ7+zUaPCcLVoq4k7wG7bUH7LJh5bQ7/NptQFUy288UjHQn1t3vkAj5MOwXsw+BbqiuD4j2fu88hBl9M1w2Eg+RhXNOBToM8425z/aaVXv5mAJOQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AscME+HZLWUsIPsjqtK4t+Tb219k6BAF7HlSVmCJCZE=;
 b=rWpli04U2L28W5aczgmpKsl4Om/D4C1Bbu/1osIx8JxhKgh5QBYDox4266aaa1RQMRAMN1y830quqXMYsz+4kxlzs4JbeAsroK2d2K9xDWOMNrOULlZoZykTzXYI+mhvNTOutEy24gTv6XLKurwEc6UVK6SQJukSjPf2NBX0IfGGnwHwhUihXiWO15DSaXw9LH79whlfzQzFRPDLqUUrXOruqTXNuXElWNb80mYen7ecZtRWkRS+bwofz4LtEHT9cIBLMfM5HRmGX4iyY+NbPo6bxufrxmUATnOyD8eQXaRlvZ+EFuRQkVKGZ4e0dUGGFcZYtGtU5OdQ1w6lgMbZJg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AscME+HZLWUsIPsjqtK4t+Tb219k6BAF7HlSVmCJCZE=;
 b=Wk72N2T1nyeUxnf9LoW3cnVqH9mCrVw8qm9WqQVQIz0QD987oiZkEKA+CqyTlvwLhL7J1chgya08byytQb209fzX4bqKNemNUzcIHaH95qchh8WpsvsB8zkAJiTxCMOS57MSiKyWdZWpwe/8NWEK0cyDsOiARR9egTO1hQMYzb8=
Received: from DB7PR05CA0036.eurprd05.prod.outlook.com (2603:10a6:10:36::49)
 by AM7PR08MB5366.eurprd08.prod.outlook.com (2603:10a6:20b:10b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 17:25:58 +0000
Received: from DB3PEPF0000885B.eurprd02.prod.outlook.com
 (2603:10a6:10:36:cafe::e6) by DB7PR05CA0036.outlook.office365.com
 (2603:10a6:10:36::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 17:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885B.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Tue, 7 Apr 2026 17:25:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wy1dFhM6Atw9OaJn+9RAOUchWO8ljaHSH6G3CFnafa/XxOF0tV1R5CqEzdx5o13UDd/KvZCa2UJnkbBQzF6+6D1JZUc/9c+C2st9JBwb9DUK+Ofbupy2/4ytLB7g6lIAMmw6UB2PeIGv+lpLd8n33K1YMNvJEkVNHXHsvVcrJXJXEH7gSUVNR6/dODAKAwFWLCBBAqOkcvMsdl3hca0ivrbUTVRz1GpRZDk31PhJS5j0ad/PY0PzvfZ12DiE/MQi1NmyC1Hkx/Bd1QrbP3IR6ia74QDGjwRxktbnJGoraT2MPSAkEOaxmsffCQPcFJsyXC6TNYRlmcZt5UsAtoI20Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AscME+HZLWUsIPsjqtK4t+Tb219k6BAF7HlSVmCJCZE=;
 b=rkDPibaUDuN5VOQ/8zZCKxlKJ8RmmMkXJZZcX38pBziguEkvzZfM801q/IvLuz/+W3EHhVGg61KisH0r+AnrZeTzXKGfcPUqKjNok0/+j/WtRQr6qg3rZ7XqgWW4rN14YczttHQDlwyOaoIZJ9FqivUMgSecOguOHs7Qq+MTwoBwoazQyaWU1t1p3FBdEKgB+43clhpJyhdFx+E1AU3rN62pnxow0IiOJHRNkJIaeqMFPuNzvoLDKZ/B4w0HK9UV4Yl9OmetshtPto7N4HJ55tsqQuprltp87HgE3CLpjRwaJ4tuFx6Wxcqpj+eQgiYAlaW3zNnvkb7NbpQUU088Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AscME+HZLWUsIPsjqtK4t+Tb219k6BAF7HlSVmCJCZE=;
 b=Wk72N2T1nyeUxnf9LoW3cnVqH9mCrVw8qm9WqQVQIz0QD987oiZkEKA+CqyTlvwLhL7J1chgya08byytQb209fzX4bqKNemNUzcIHaH95qchh8WpsvsB8zkAJiTxCMOS57MSiKyWdZWpwe/8NWEK0cyDsOiARR9egTO1hQMYzb8=
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com (2603:10a6:102:212::7)
 by PA4PR08MB7644.eurprd08.prod.outlook.com (2603:10a6:102:262::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Tue, 7 Apr
 2026 17:24:56 +0000
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe]) by PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe%5]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 17:24:55 +0000
From: Igor Podgainoi <Igor.Podgainoi@arm.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: "corinna-cygwin@cygwin.com" <corinna-cygwin@cygwin.com>, nd <nd@arm.com>
Subject: Re: [PATCH v3] Cygwin: SEH: Fix crash and handle second unwind phase
 on AArch64
Thread-Topic: [PATCH v3] Cygwin: SEH: Fix crash and handle second unwind phase
 on AArch64
Thread-Index: AQHcwQePj1quTQQV+kurdyj3ccRRyrXIylEAgAsaggA=
Date: Tue, 7 Apr 2026 17:24:55 +0000
Message-ID: <adU95HxqoWa4xgSQ@arm.com>
References: <acu6Bt7BbG-_Cyrr@arm.com> <acvtbIu--Oafeca9@calimero.vinschen.de>
In-Reply-To: <acvtbIu--Oafeca9@calimero.vinschen.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	PAXPR08MB7247:EE_|PA4PR08MB7644:EE_|DB3PEPF0000885B:EE_|AM7PR08MB5366:EE_
X-MS-Office365-Filtering-Correlation-Id: 2992d2f5-d563-4e0b-c2f2-08de94cabbc4
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 N3VV7WOlN9r6cSoAF44QqhAfkNlQV2xkTF1K15+fS948XTQ23LHq6arj5KqhWzTuxBz7cRwnhWHCVTAhNNODCSxmhrPGpL9miTBeE9SfouNdElkZVRXOpZyDlHaeF5ehpkouVMAUg6apMfvlphAhrxDF8TwcgS4R9zTyX2AfDh5P+VU4lRq8aTJSrw8080h7MlwQ+hZrqqeDV+nUAxv+ZuKRP4WSwqiG6+gBpKkW2iokRR/Ujv4ZCobDXiUsbF9PCyhFgBjmFjiMvsXhWrSZ367uGaliCJRQVOoZdWRdS/LyFHR8HXSMf8BQ49ELqqXGca0IIged41I2OSFmsp9PTLisdnne7huvIhGJIcoO9M/CE3GzzhPLwAN3LL5iDIUhZ34tlkXJpPoAtzUh3JmbHy2I9iTxNOAfESqXXyll2ij2RmqNFfukgRfhVQcH+hoftKkOZg1XTvArhxQTc1Y6EHM3p/k7sZUV0uZ787ZxQCd0OcaceZeN/W8yeQmfh6iVNARqPAFLAgwn8cisOd253o6zxCQNoL9rgNabOMyiMR78VdEiF0pyeUW0IXc/o9xP0ZbHvSYfaeoZgbg8nZ29yC8SnZTOV9yoVUB68VLuYRwzr+hs9efIyA5bWMTgwRgvqNGbAPUkfYdRe1+lOUq5UzKIG7GZJM0PPu9fkAXJMpaELTHShD4CxalwtD1rg3U7F0dt6VUuhIyYD3wTQ5SLX1ohwo3vmmAg+21jfLWdXb3wAjWonJhap1MmU4NCRB7V2xkC0uAfHP998zVuJeW8h30zo1bmFvM5QTrPhu+V2pc=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB7247.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <19D8CB6C1134D14BA6A29780F2F7CD50@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 peu/QKfJIO9oWoMH4+344UIWipletoLf4REPuJhEaZEzKxIpHHOqhqnxJ4XWj7EvM95UEDYXJp244pnjxeqDXH+HRjKmbISRvqM4ZrDewnVYXjIILXFQvlDUHa1vgA4e8wlImso2/E0HHEiKuaW/Yvu8bXlJy6Q5vNx2axa0PJ0SCaW7/in6aFjTy4netT902p4KUkvFAiuGHGTo0Ukc2hv4Y8qQyMohkok1UoGmyB0g1YeyHyA0PyuyWHpjqCMtniYg1Ai66Ehw2XhWlDql9MTfjGJJfsARsKAzu/RinFiphuPJtGMLkHsm1E+pyQr1/1ErNgvczNEDww4QPsuMzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7644
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5b1705a1-783b-4b8c-df3f-08de94ca9642
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|36860700016|376014|1800799024|35042699022|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	smnaGHOV0MGvxt4iKGOOj9OV0pHM9g/Wi2WpoksynM+D9nVNqL2xEkoXh9JsPH01yt93obyiWoYVxiobCzdi1N5ogv3WEjp/SHc1lsfLIcDDq8ExOJIrhzN3NceOkb8uqTsK4rN/ZU9ZouegEoJh3rAkteujo5HNZg8vUmbHB0kYrJzCESrwKVqlumdJDIXUT1atfkCYh1qZbvXAdS+EZZ6qTxF8Olz/s8479z1ENF1MDZ/pU8ayV6Ezs9ZVi4N8r2MuNfq0622SsfeI7WBiZ6s/UNpV2tDrZR9U6A1Q9Ifv+uAsbkAGfSw/CNitlXGAXFa9+9aWU40QLOA2PakAQ4GQCahBmo6zt8BhmpjZHlJNdTevZg6vaZgaSR/+eHrDrxWCMkeaWFAP5IRzw0DjmkfsS4Fx6EaGoaFCTjPeuSU6f6zrBPkfydLR/yX803UUncoJbLdB0hTmVQYMG8YDtGAB3KgNg7SIgJ1N9DFkqUd04GTQO2/9XNSO3/Jyq58blmxKpHrnID7udaT3aE25UyU8qCQ/Ia7KhhB4jMBwU7Qcjxx++m1sN6pw+JeNutCAF3+LuAfWiGjofOnzURwf2PV1NsDN5dCzxEQvDvel7urUoNfCHTZ1+ld1G7OZ33FwrtdH113Ws4d7JqV8fWVlbTDrPjp2TPJuGjSoKXe0YTLAWlk90cRzUvAZe0ayGdsJOhbL+9sabJx6FB1ST2JX8beut2SSEjxJYuTmyez1mWeofAjdDnc5zh2n98/+ynHyfw/IgGk5C9t9wc+SJ2a6Mw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(36860700016)(376014)(1800799024)(35042699022)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YU/3EtBZhS8jsqmTF5rpOfwLVRCu7aeQop5jewWvM4qjSJrGZqyHfpgxcbl9IfxKPba+lQj9wNilfEEJ22ttEPp8GtFz3yVPUSzkH1pKeH7yXYHgBCcZHd2lz+W7a9pz6GyNomJY9AQTnfGI/k7E1OriMs4EgC6/4V+3mUZ80McUBYPsDDA3mbxfW2diLYeosmwEZTXZya8TMI+JjP/nr4DGkrbh9CWlZjFR7coCDrUvR9Clq9DBGQJ3GOQhHvxcKURpA/8BOCBNxHoBgJN9ZJLPewhK7YQBgvKUHzHJhdnxMeMzlmQfah32bmbmrhlvcnOblQDguZSUkm7qSV+v8M2M0jxSvuXgGHEkQPNBKITkNa3pdcGsNiaxiimMLF5dieT3oPcZK2ztg6xJBtdwlYghbaCIRWP/ZjrKqYUHBzxZvFJNzNKkuVTHbwvq1lJw
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 17:25:58.7251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2992d2f5-d563-4e0b-c2f2-08de94cabbc4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5366
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

SGkgQ29yaW5uYSwNCg0KT24gTWFyIDMxIDE1OjUxLCBDb3Jpbm5hIFZpbnNjaGVuIHdyb3RlOg0K
PiBEbyB3ZSBhY3R1YWxseSAqbmVlZCogdGhlIC5zZWhfY29kZSBvbiB4ODZfNjQsIG9yIHdvdWxk
IGl0IGJlIHN1ZmZpY2llbnQNCj4gdG8gY2hhbmdlIHRoaXMgdG8gLnRleHQgZm9yIGJvdGggdGFy
Z2V0cz8NCg0KTm8sIGFzIHRoZSBTRUggbWV0YWRhdGEgaXMgZGVmaW5lZCBpbiB0aGUgLnRleHQg
c2VjdGlvbiBqdXN0IGxpa2UgdGhlDQpwcmVjZWRpbmcgY29kZSwgdGhlcmUgc2hvdWxkIGJlIG5v
IGZ1bmN0aW9uYWwgZGlmZmVyZW5jZSBiZXR3ZWVuIHRoZW0NCm9uIHg4Nl82NC4gQXMgZmFyIGFz
IEkgY2FuIHRlbGwsIHRoaXMgaXMgbGFyZ2VseSBhIG1hdHRlciBvZiBzdHlsZSAtDQpmb3IgZXhh
bXBsZSwgTExWTSBkb2VzIG5vdCBhcHBlYXIgdG8gcmVmZXJlbmNlIC5zZWhfY29kZSBhbnl3aGVy
ZSBpbg0KaXRzIGNvZGViYXNlLg0KDQpUaGUgbGF0ZXN0IHByb3Bvc2VkIEFBcmNoNjQgU0VIIGlt
cGxlbWVudGF0aW9uIGluIGJpbnV0aWxzIGRvZXMgbm90DQpzdXBwb3J0IHRoZSAuc2VoX2NvZGUg
ZGlyZWN0aXZlIGF0IHRoaXMgc3RhZ2UuDQoNCkFzIGZvciB0aGUgb3JpZ2luYWwgcmVhc29uIGZv
ciB0aGUgaW50cm9kdWN0aW9uIG9mIHRoaXMgZGlyZWN0aXZlLA0KdGhlIGJpbnV0aWxzIGNvbW1p
dCAzYzYyNTZkMjllMmM1Mjg4ODBhM2NmOGRmNDNhZGYzMmM3NzgwZGU1IGZyb20NCjIwMTQtMDMt
MjUgYnkgTmljayBDbGlmdG9uIDxuaWNrY0ByZWRoYXQuY29tPiBleHBsaWNpdGx5IHN0YXRlczoN
Cj4gVGhpcyBpcyBoZWxwZnVsIGJlY2F1c2UgdGhlIGNvZGUgc2VjdGlvbiBtYXkgbm90IGJlIC50
ZXh0Lg0KDQpTbyBpdCBzZWVtcyB0byBoYXZlIGJlZW4gaW5pdGlhbGx5IHVzZWQgZm9yIGNvbnZl
bmllbmNlLg0KDQpSZWdhcmRzLA0KSWdvciBQb2RnYWlub2kNCkFybQ==
