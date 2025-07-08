Return-Path: <SRS0=LSO3=ZV=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo011.btinternet.com (btprdrgo011.btinternet.com [65.20.50.92])
	by sourceware.org (Postfix) with ESMTP id DCC2B3850B21
	for <cygwin-patches@cygwin.com>; Tue,  8 Jul 2025 11:56:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DCC2B3850B21
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DCC2B3850B21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.92
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751975769; cv=none;
	b=Sb15JBA71pcvBM/jhC9A+f5whMpeOnElk9h5V5WFbTaUzDIPBo6QcTn4neIToAdYoWOTsQ5RZVggwHgDcR3cclfpz1LX2jpPV6Zu1DzOMDZVt3J/nfTp58bKJvIlL5TQu9YINEl3Jnn+CltXX/0eNB0uWN7Nz3h1qeDcpZGXGbg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751975769; c=relaxed/simple;
	bh=GXwlQZzOyiFJOCpgo09m9JNd9pwTlxiUFfMYG0tkbIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=oe8QIiU9eWF0h1nKFsZAlMakoXribd5xKPa9HnuVogQraCO3BvOQW9J3cbNEgtlxFp+lPWNg0Fw5X/lD1mYfo/1x7jV9NCZ7brG6TX4IH1zcVx36TnQwCulMyBC7Gq0vpJ7gkZACD4zxUpWm7EEYjwZSkE1Nlj/kUpL6Axc48Po=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DCC2B3850B21
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6864C026009EB0F0
X-Originating-IP: [86.140.193.33]
X-OWM-Source-IP: 86.140.193.33
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeeivdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtkeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeetgeetgfehiedukeejleekgeffjedvgedvudffvdeftddvkeehtdffveefgeekheenucfkphepkeeirddugedtrdduleefrdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddugedtrdduleefrdeffedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudegtddqudelfedqfeefrdhrrghnghgvkeeiqddugedtrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdtuddupdhnsggprhgtphhtthhopedvpdhrtghpthhtohepvehhrhhishhtihgrnhdrhfhrrghnkhgvseht
	qdhonhhlihhnvgdruggvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.140.193.33) by btprdrgo011.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6864C026009EB0F0; Tue, 8 Jul 2025 12:56:06 +0100
Message-ID: <9518cf44-897c-4c08-8eba-e775b8921324@dronecode.org.uk>
Date: Tue, 8 Jul 2025 12:56:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: CI: cygstress: update for stress-ng 0.19.02 and
 current Cygwin
To: Christian Franke <Christian.Franke@t-online.de>
References: <b5fae801-1732-99ac-1fe1-6c2552407055@t-online.de>
 <8941f3e9-16ae-7130-0215-3c65dc3f9aaf@jdrake.com>
 <8e61bc54-b80f-cc69-6a54-4640cceff5cc@t-online.de>
 <0f17f3d0-94c9-febe-ac77-0c9e28ba1c2c@t-online.de>
 <77c8f91a-c51c-4d3f-9faf-e5d9d1430542@dronecode.org.uk>
 <d03eaccd-c618-2f19-156c-61e12af4f132@t-online.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <d03eaccd-c618-2f19-156c-61e12af4f132@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 08/07/2025 12:06, Christian Franke wrote:
> Jon Turney wrote:
[...]
>>
>> It seems that the 'filerace' test (new?) doesn't work reliably in the 
>> CI environment.
> 
> This (new!) test never failed during many runs I did locally before 
> tagging it as WORKS. There are also occasional failures of 'flock' and 
> 'fork' at GH.
> 
> Today I could reproduce one hang of filerace when the number of cores is 
> closer to the VM behind GH actions.
> 
> $ cygstress -r 100 -c 16,18,20,22 filerace flock fork
> ...
>   >>> FAILURE: 11:58:32.68: filerace (exit status 0, command hangs, 
> processes left, files left in '/tmp/stress-ng.410.141.d')
> ...
>   >>> SUMMARY:
>   >>> FAILURE: filerace: 1 of 100 test(s) failed
>   >>> SUCCESS: flock: all 100 test(s) succeeded
>   >>> SUCCESS: fork: all 100 test(s) succeeded
> 
>>
>> Would it be possible for you to take a look?
> 
> Yes.

Thank you.

> Should I push a new script version which excludes this test for now?

I think that would be a good idea - keeping it green so we stand a 
chance to notice any other problems

