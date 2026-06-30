Return-Path: <SRS0=5cOX=E2=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo012.btinternet.com (btprdrgo012.btinternet.com [65.20.50.227])
	by sourceware.org (Postfix) with ESMTP id E06324BA2E21
	for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2026 18:19:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E06324BA2E21
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E06324BA2E21
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.227
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782843542; cv=none;
	b=vYN8HpnHtGzBrD3EZvNc6jrj5ZJtiUqav3xwxykb9UPucXNrx5upLkruAZvzx5md3ST8atJCa91dGYr2CB++GvSGLeslj4xoakV0GXhAulurrxD8ImJI6Kj6KuaHpbyTOrecGYXJ231Q7W7rMsz2PYIQ26VJNwDQyTAMs5Eg+y8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782843542; c=relaxed/simple;
	bh=LrxGYKAVRIEp5SM0uO/3VDqnBn9WmZjkEoyZl5oPJ/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=IHx3CoDNkoPj5zFXLUQLv/DXBOhy1CuWlSIGjkH2Yrxk5lHyQViGnx8Uhc4Hrmxx3C7mlLs9gkuwSRMMMD50k65k4bryNAY48sJ++42Y3lv6AyzyICpmAeLJgs9g4QOerD/7C0ERua10IC8/ipVMK/kWoDb6P6jt364NPbX+Iew=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E06324BA2E21
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A02527903FD9A0F
X-Originating-IP: [62.56.66.111]
X-OWM-Source-IP: 62.56.66.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTE0V49MCMLSx3PMI1RNnPj1z+snpskguZRnH92A/g9AHueLATFs2ifeneF5SqBPYMNC7uujK2ksXm7JxBMOaHif2t39jpHC2MjCk9bhC1S7fxYlYBn7pFEpdqTYXszfiSEMLH9UnCXKphcDrzwl5Itm1QAGD7pyrD4jGy2fRrg0lq/YeAdjnB7cSADGXW1JGS47VYRl0H2X6MbFCLq59Ukcz96pbc3PZYEbhXNOcuCjjf1MooOIu1dfVXyQMpNRis+uugAJqB1XlFxCAsMBlAfRgkI4mltjWeuWPtkmL2MZMqjrF61lNUgdMXmMUrCKVEqNekkHcd6sYUA9rVTml7JBEIdz40BeI89xItk5n3n55952ZfFp0lp8pAZ+LdEyESN7luCo57VnANb3hka9dsRXjZW2ChaUi3blH0zZtRmaYs7QmH9NO6HUsxCfgVd4lIuNZg/s6pSKq+xPdgZafoKD2e058wxqr8ENuSnjzXwkct/Kmmsx/8v0JESPPBTs5RiSFlGUkwyuahj7vxQTTea4Qjcl0ZUuHgkRIqNN7NsH8FOOYcZ2turE4u8Cz8eaIBh73+Hgs+beR02yTORBmMEw7zgoG2KKS8lNIpFcwPra68udRKMoEDHP9ZkwHL6DR9YTxH4oFhIOM5UjpH6osTp68esn/Uali4JwEimhFBpr6g
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (62.56.66.111) by btprdrgo012.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A02527903FD9A0F; Tue, 30 Jun 2026 19:18:52 +0100
Message-ID: <defb81b8-94b1-4d75-b15e-591045dc2389@dronecode.org.uk>
Date: Tue, 30 Jun 2026 19:18:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Cygwin: ssp: Move command-line copy into run_program
To: Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>
References: <PN0P287MB02952FCE57C59FF18096B96D920E2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <34b42100-1722-4bdc-abf9-e9d159456ee0@dronecode.org.uk>
 <PN0P287MB0295E9D540A342B741B82CC592122@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <PN0P287MB0295F1D93B25FA3B90293E35921C2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <d775f31b-f552-409c-b21b-f280180e8089@dronecode.org.uk>
 <PN0P287MB02952A907048F49E206674D492EC2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <PN0P287MB02952A907048F49E206674D492EC2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 25/06/2026 15:33, Chandru Kumaresan wrote:
> Hi Jon,
> 
>> Hmmm... from the explanation above, it seems like this is in the wrong
>> place and should be inside run_program, around the call to CreateProcess?
>> Otherwise, the same pointer which is passed to CreateProcess and
>> potentially has its contents mutated by that is also assigned to
>> dll_info[0].name, leading to a potentially corrupted string appearing in
>> the DLL-profile table.
>> If that supposition is correct, I'd appreciate it if you could come up
>> with a follow-up patch to change that.
> 
> You are correct — moving the strdup into run_program, just before the
> CreateProcess call, is the right fix. Please find the follow-up patch below.

Great, thanks. Pushed!


This actually looks kind of like a Windows aarch64 bug, since the MSDN 
page for CreateProcessA() now says (and I seem to remember that text has 
been there a long time) about lpCommandLine:

"The Unicode version of this function, CreateProcessW, can modify the 
contents of this string."

The implication being that CreateProcessA does not modify its 
lpCommandLine parameter.

