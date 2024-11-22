Return-Path: <SRS0=GGDi=SR=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.218])
	by sourceware.org (Postfix) with ESMTP id 53D7A3857025
	for <cygwin-patches@cygwin.com>; Fri, 22 Nov 2024 16:23:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 53D7A3857025
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 53D7A3857025
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.218
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732292623; cv=none;
	b=YcQ3G96XKCwlzx1+IW36+ghGJgFhmlluqO2+ml2X/p16tCXFjUa9ooHVdryzLYuIzVqgUfCiE3wOeS1cyAls/wGHMDT2htgyFArMnkN0HSZIYQG1UGpWh8pkcn4Kz0s1G8DBHO+fH/+MJ3y2QlDiicqU1+46sTqWwffQdfwg+ak=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732292623; c=relaxed/simple;
	bh=N5LIfKzXVcHvaevavnF4Bwd0h40+bztl1MTy38wJC9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=ZNEnossFx8YsBoQiMa5dGIkVbWoi3bY9ToPYLZiWOFWiUTuVZP38ETh2cVDzRjH4bkPMQz9uMZknEjRZ45VctED6oOTOMzcyP01QSKgV7/Ohw217T82985kxxcD0lUwBLURTpcY51H7ddcm0xL8t0vsCdmRd7bKsPhqTIezsOxM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 53D7A3857025
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6722B00202C1EEAE
X-Originating-IP: [81.152.101.74]
X-OWM-Source-IP: 81.152.101.74
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefuddrfeelgdeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvedvkefgffetteeuhefgudeggfekveeljeduudehveeutdevjeefvedvvedvgfdvnecukfhppeekuddrudehvddruddtuddrjeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekuddrudehvddruddtuddrjeegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeduqdduhedvqddutdduqdejgedrrhgrnhhgvgekuddqudehvddrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddthedpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtoheptgihghifihhn
	sehjughrrghkvgdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (81.152.101.74) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6722B00202C1EEAE; Fri, 22 Nov 2024 16:23:40 +0000
Message-ID: <7b9a8a81-a1ff-4287-ac9f-c2278d8ccb5f@dronecode.org.uk>
Date: Fri, 22 Nov 2024 16:23:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Cygwin: cache IsWow64Process2 host arch in wincap.
To: Jeremy Drake <cygwin@jdrake.com>
References: <d544a3f1-3b6f-0392-aecf-65125cf5e8f7@jdrake.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <d544a3f1-3b6f-0392-aecf-65125cf5e8f7@jdrake.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 21/11/2024 19:42, Jeremy Drake via Cygwin-patches wrote:
> 
> @@ -282,4 +284,30 @@ wincapc::init ()
> 
>     __small_sprintf (osnam, "NT-%d.%d", version.dwMajorVersion,
>   		   version.dwMinorVersion);
> +
> +  if (!IsWow64Process2 (GetCurrentProcess (), &emul_mach, &host_mach))
> +    {
> +      /* assume the only way IsWow64Process2 fails for the current process is
> +	 that we're running on an OS version where it's not implemented yet.
> +	 As such, the only two realistic options are AMD64 or I386 */

As an aid to comprehension for stupid, half-awake people, this comment 
might make it clearer that the normal case is that host_mach is filled 
in by IsWow64Process2(), and the complexity is just trying to guess a 
fallback if it fails...

> +#if defined (__x86_64__)
> +      host_mach = IMAGE_FILE_MACHINE_AMD64;
> +#elif defined (__i386__)
> +      host_mach = wow64 ? IMAGE_FILE_MACHINE_AMD64 : IMAGE_FILE_MACHINE_I386;
> +#else
> +      /* this should not happen */
> +      host_mach = IMAGE_FILE_MACHINE_UNKNOWN;
> +#endif
> +    }


