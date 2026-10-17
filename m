Return-Path: <SRS0=X8J8=IH=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo004.btinternet.com (btprdrgo004.btinternet.com [65.20.50.128])
	by sourceware.org (Postfix) with ESMTP id E6D574BA2E11
	for <cygwin-patches@cygwin.com>; Sat, 17 Oct 2026 13:35:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E6D574BA2E11
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E6D574BA2E11
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.128
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792244129; cv=none;
	b=UnN2vT0ScRlxUl5TNgImb2dcV4KC5COpw3LWB9BO6vc6zgbTl+RTFIENLmiO+Pf0WxJanS2jNwJ6Owa1xCBJEZuaMQ4S7fhFhoovMpn7B67vM5DON+JiwjisQ/M5IgRarQHHDf+tXXdbbLENvEXA7uKJw1eYFZSNBlQ7irTrO40=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792244129; c=relaxed/simple;
	bh=6iWkryd8DO8hbBDnhx1dH6vFHl7ulu1X8msrTJhcKyY=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=jfY5EeqXwZyKDNpfs3yHe7QQzQxuvAqUlwBKf5+B+EK424YsQEB+MBCWl5im9tEGmQ5M4sE2ZPMke3n4+uwUExY/gD2XVKr2KQZ8x26uH/z7WrBL1Td5dXnNM68tgAcaCLV5N6jTiCJxDR3MpYFw4njQrjQn9+p43WNvxMrD6jQ=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E6D574BA2E11
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A715CD60E8D2C56
X-Originating-IP: [62.49.190.104]
X-OWM-Source-IP: 62.49.190.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTFQt5tsehEMABwa2e2fPM0fZ9VjhzEsAEVPn1vzAlWy6RFO58HqohQJH7kuNZoYRhkTuRBjWsGFf7GTHWrvPIA6QcTMHm5SnZ+E3TiAtL7qmQEFgwAT1yDdQqIyxa2OOeQJ4VERhHaRIDjdE0/xRWvKdx4Xu0KY2vGJFlaT8tSI57sRcPUMQW53zncBvb5jhgIgMnKJIW6XTfHTgv2K9KmbNZqgNCk9hYQ6R0jRnSNUIw79dzN2WucVE2ze0mHwPXDUj7N6bYknnUGpcRDOJsCt0n3aWirIgtsrI7ns6x+bOUKAlpLJptrDeFKXOJ/9v7vTd7kRach6Pei3JxJuxOh4eeZ/8x9kQ7S98z3y+lFwGKNH3U4taJkRj8oqjqOZKHG9Z8mYgioqCKUw0srzpA54LoHceM+6uqJm8u5ajcXCiNAhWpKbmMdAzPnhQAktWp6SXCh7PtbQyO/dFn92b+i+G2IEne7Cf7eYa17OVnzpRG3C5WOM0UNRCyokvqETXIbNBmpssB7Q6wKXt4v4H8dZH+MrhKq+lZnfqAB58alDwMbpjT8j4SP3dWTxi6aOrU6o+x2FBNuVKSoQVV8cYJj+V3F2j5ahAxesTkRdLsyoCUect9avFpte4uS/u716RDfL8JUfWMFpc3QklWemuxCChZdZw3jYFp+YnZPqUoyZTA
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.49.190.104) by btprdrgo004.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A715CD60E8D2C56; Sat, 17 Oct 2026 14:35:24 +0100
Message-ID: <093cb58b-5d5f-4059-8420-4bcf3d9f9aee@dronecode.org.uk>
Date: Sat, 17 Oct 2026 14:35:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Cygwin: autoload: fix ws2_32 chained init on AArch64
References: <PN0P287MB0295342E2109C2CB8EECCE6B92062@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <ag8IvAkqoNVM-AH2@arm.com>
 <PN0P287MB02951A11C49A1208A9BA66F392102@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <99590c72-bc88-4466-95c2-ae540a11c031@dronecode.org.uk>
 <PN0P287MB0295EC86F97A259F0C99818F92EB2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com,
 Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>
In-Reply-To: <PN0P287MB0295EC86F97A259F0C99818F92EB2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 26/06/2026 10:03, Chandru Kumaresan wrote:
> Hi Jon,
> 
>> I've applied this patch.
> 
> Thanks!!
> 
>> Just so I'm doing my due diligence, I'd like you confirm that you are
>> submitting this under an open source license as per [1], and you and
>> your colleagues at multicoreware are authorized to do so.
> 
> We have been contributing to Cygwin for about a year, all modifying
> existing files rather than creating new ones. We will confirm and get
> back to you shortly.

It seems that we didn't get a response to this.

I apologize for not raising this issue initially, but that's us 
operating under an assumption of good faith (and the fact that we'd much 
rather spend our time dealing with technical issues than legal ones).

I believe there's no legal difference between "modifying a file" and 
"creating a file" in terms of the authorship and intellectual property 
rights which accrue to the creator.

So again, a statement clarifying the situation would be appreciated.

