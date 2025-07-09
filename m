Return-Path: <SRS0=dg59=ZW=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout01.t-online.de (mailout01.t-online.de [194.25.134.80])
	by sourceware.org (Postfix) with ESMTPS id 14ED3385735B
	for <cygwin-patches@cygwin.com>; Wed,  9 Jul 2025 14:02:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 14ED3385735B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 14ED3385735B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.80
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752069729; cv=none;
	b=KdlOezyR2SwL6P+g51Fz7n7dGDoCI3dX16qtxoFHPASl1cflh3aGzd1+bd72NWLbYTFYSrz9jFa6tpIgOaRwAKHcynf8VoE5wr5jUNzHdhXk45NZnepD/gkU7099ZlHoBSu+9AwJlfjycU4GLRezwM9hFhhIKLEF8UbxLaD3I+o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752069729; c=relaxed/simple;
	bh=u9s723By1Pxp2i8Fq472DplSm1edG1H+D/Vwv2/UFk4=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=E2ZIZus8Z+xu8R0zydQSxPH1fhTnJ7lQ71p6l24V3CM6TIv74F3Cbr4vhljZKS16TeuZIH1IHVrLcG7C8rVYFD9pFUjwteaiphMKz8DeOs8+LpE17D2t4RaybS6TZM2vbGwaGX40upQnGVqErrkWXbCdGy5uCBu1O8p/Tao+pMI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 14ED3385735B
Received: from fwd76.aul.t-online.de (fwd76.aul.t-online.de [10.223.144.102])
	by mailout01.t-online.de (Postfix) with SMTP id 95D8F1D083
	for <cygwin-patches@cygwin.com>; Wed,  9 Jul 2025 16:01:54 +0200 (CEST)
Received: from [192.168.2.101] ([79.230.172.57]) by fwd76.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1uZVMu-3dLIsy0; Wed, 9 Jul 2025 16:01:52 +0200
Subject: Re: [PATCH] Cygwin: CI: cygstress: update for stress-ng 0.19.02 and
 current Cygwin
To: cygwin-patches@cygwin.com
References: <b5fae801-1732-99ac-1fe1-6c2552407055@t-online.de>
 <8941f3e9-16ae-7130-0215-3c65dc3f9aaf@jdrake.com>
 <8e61bc54-b80f-cc69-6a54-4640cceff5cc@t-online.de>
 <0f17f3d0-94c9-febe-ac77-0c9e28ba1c2c@t-online.de>
 <77c8f91a-c51c-4d3f-9faf-e5d9d1430542@dronecode.org.uk>
 <d03eaccd-c618-2f19-156c-61e12af4f132@t-online.de>
 <9518cf44-897c-4c08-8eba-e775b8921324@dronecode.org.uk>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <73c4326c-4869-990e-8246-807d47addb79@t-online.de>
Date: Wed, 9 Jul 2025 16:01:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <9518cf44-897c-4c08-8eba-e775b8921324@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1752069712-957F84FC-AD47215F/0/0 CLEAN NORMAL
X-TOI-MSGID: b14d9952-e74b-421a-9593-aeeaebef227a
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Jon Turney wrote:
> On 08/07/2025 12:06, Christian Franke wrote:
>> Jon Turney wrote:
> [...]
>>>
>>> It seems that the 'filerace' test (new?) doesn't work reliably in 
>>> the CI environment.
>>
>> This (new!) test never failed during many runs I did locally before 
>> tagging it as WORKS. There are also occasional failures of 'flock' 
>> and 'fork' at GH.
>>
>> Today I could reproduce one hang of filerace when the number of cores 
>> is closer to the VM behind GH actions.
>>
>> $ cygstress -r 100 -c 16,18,20,22 filerace flock fork
>> ...
>>   >>> FAILURE: 11:58:32.68: filerace (exit status 0, command hangs, 
>> processes left, files left in '/tmp/stress-ng.410.141.d')
>> ...
>>   >>> SUMMARY:
>>   >>> FAILURE: filerace: 1 of 100 test(s) failed
>>   >>> SUCCESS: flock: all 100 test(s) succeeded
>>   >>> SUCCESS: fork: all 100 test(s) succeeded
>>
>>>
>>> Would it be possible for you to take a look?
>>
>> Yes.
>
> Thank you.
>
>> Should I push a new script version which excludes this test for now?
>
> I think that would be a good idea - keeping it green so we stand a 
> chance to notice any other problems

Done:
https://cygwin.com/git/?p=newlib-cygwin.git;a=commit;h=ace88c7ba17a
https://github.com/cygwin/cygwin/actions/runs/16170259198

The 'filerace' test actually succeeds but may take much longer than the 
requested 5 seconds.
The also disabled 'flock' and 'fork' tests need further investigation...

-- 
Regards,
Christian

