Return-Path: <SRS0=YHfL=IK=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo012.btinternet.com (btprdrgo012.btinternet.com [65.20.50.237])
	by sourceware.org (Postfix) with ESMTP id 834E54BB5932
	for <cygwin-patches@cygwin.com>; Tue, 20 Oct 2026 19:10:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 834E54BB5932
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 834E54BB5932
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.237
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792523417; cv=none;
	b=eX5cDyu17lxDbpCGZswREbRcR15t7xkXrtEKE017xwMQAmJ/+9/5bd+5fmbUo/sHJLKTeWbEV/F5GLsQ8fdEPZGhCA2yyGTbQP9/sBXAGzUSAkLpNNyxg72V9t6Fm0x0Sw5SwtGO7Nm8jHQNCAVETJOrwDL5Z1UI7SKG/QVSmOQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792523417; c=relaxed/simple;
	bh=ionXO16bFj1c2Pq+PxCkcnwIY/5IpIBG37AE+jjdu6k=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=pBHikfrWW9r8G0TAU21VeR64atMAMvqD1jfiwA1+bvJz/kW2N1U987/zU6g1yUEULC3hiSKrwptTLV5oi/g5NwHKy+uOItMRdGX8S7tFWMJwvvD11sa4SAwx0OX5C4rH2B9PLcxkdjf4EEciwOmtZ4cK4vS8YL+dsNoWedRJ7UY=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 834E54BB5932
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A7161CE0F39CE9D
X-Originating-IP: [62.49.190.104]
X-OWM-Source-IP: 62.49.190.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTF117REqw6mqkZA+dihLCKBGKPo3FuvfS0g2bzLir5UlGAbsvlvfUSYzFofZi53vuxMkX0Z2SkMAq31CxvS2lKHP6G16KZc79ZixUn3SZh2g+EWNlM7UniKnR+PRe/ZjxgSycr4NC0YjOlxc+KPawc/npoYXonc4stKmPDXoerYyb6XT8PqteKAL3KNZbIuBdBtkmKViLEhGT1pRWjV8GrtY94slCTt/6rOGEGXb1Z/7Yj1gMNqbuYyjGXSHT6G7vCEheNXzgtTnrSBW6/N+7U/DS1YmLCTIv3TlhLnXFpr24l8WeC/xfuU2nm2Kiw1PJW4h/XCHbJDqGTlETGUULN7LzaUIXTjLj/25BxIinSVGZL20VwKR6Zby4A2fT2IF2/wtqk4ed8w/NBjG1EvAz4qN5q6W3npgz7TvgdoaRO2dSDBv7rtAP8PsFueGCeqdkuWucTKrHgEVgeUjBIuOVmcnkEO6pU3s01KQjJXsaDXxDfhA3RsYh6moG3rSmwQWYWvrKGsL9adFhB1WTnaA54ejscnptEf6dXAiV3ZCuyZc8PMZZHbUr3CvnEdOof8Sm/1ZDHWzXwbyP6sp+uIaanXK5JGwDeJaj59v8TOAmj+dniiNd4AOdcZ4WzDo41aHH0Tm0kzkgRMiN08/szKDaf6rtPeOUCfnBmJrJNBpjNifw
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.49.190.104) by btprdrgo012.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A7161CE0F39CE9D; Tue, 20 Oct 2026 20:10:12 +0100
Message-ID: <389ae877-664f-407c-9a4a-540834fc3c66@dronecode.org.uk>
Date: Tue, 20 Oct 2026 20:10:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cygwin: define IPTOS_DSCP_VA in netinet/ip.h
References: <20260920043247.4589-1-omikorin@disroot.org>
 <c251f9bf-1881-47bd-a4a4-3a14b6f542f0@maxrnd.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com, Mark Geisert <mark@maxrnd.com>
In-Reply-To: <c251f9bf-1881-47bd-a4a4-3a14b6f542f0@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 25/09/2026 01:29, Mark Geisert wrote:
> Hello Michał,
> 
> On 9/19/2026 9:32 PM, Michał Korczak via Cygwin-patches wrote:
>> Define IPTOS_DSCP_VA (0xb0) according to RFC 5865 to complete the DSCP
>> code point definitions in <netinet/ip.h>. This fixes compilation for
>> utilities like openbsd-netcat.
>>
>> I provide this patch to the Cygwin sources under the 2-clause BSD 
>> license.
>>
>> Signed-off-by: Michał Korczak <omikorin@disroot.org>
>> ---
>> v2: Fix whitespace formatting to match surrounding code style.
>>
>>   winsup/cygwin/include/netinet/ip.h | 1 +
>>   1 file changed, 1 insertion(+)
>>   winsup/cygwin/include/netinet/ip.h | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/winsup/cygwin/include/netinet/ip.h b/winsup/cygwin/ 
>> include/netinet/ip.h
>> index 5db1bd9ce..8b67a5c6e 100644
>> --- a/winsup/cygwin/include/netinet/ip.h
>> +++ b/winsup/cygwin/include/netinet/ip.h
Mark,

I happened to notice that the "Author:" field for this commit got reset.

I'm not sure how you are applying patches. "git am" should set it to the 
email sender, but seems like that's fallen victim to "From rewriting" by 
the mailing list here?

If possible, use "git commit --amend --author="..." to correct it in 
cases like this.
