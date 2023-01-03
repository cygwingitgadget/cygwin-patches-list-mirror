Return-Path: <SRS0=ZLqz=5A=shaw.ca=brian.inglis@sourceware.org>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id 974CA3858D37
	for <cygwin-patches@cygwin.com>; Tue,  3 Jan 2023 01:44:11 +0000 (GMT)
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
	by cmsmtp with ESMTP
	id CPdQpb050c9C4CWLbpdy3q; Tue, 03 Jan 2023 01:44:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1672710251; bh=bzwVg7LCEN3uuKuzPyBeO3YBPFCort2IrziuFrAG0tk=;
	h=Date:Reply-To:To:From:Subject;
	b=Hkz/FrkWHPpOq6GhpeyclRkfGKXHimdDdMHwV0+Zihq01poSHcoGrRBAmjTAeZzXX
	 oZZYgorFo1NeaXJHU1i1QKkCeB5mffn4+ZqiA5pdjWiW/jQqiyQaJtsJLMqVT75WAD
	 wX39oMHpxPHMYI/bPFWVolIm5wNdtKgMJH0A5vgBF3uEDBSxpQ+elH7SCyo/RD9sG+
	 a/EzXKZdizTnzavMB3bxpF05+V60+8DUgiUuCNAwVy2fbMjY6QDY0x/aLIJB3f3Bzg
	 BkrZQ7t7LCb4T2rJkliHuaRRKvz28aw/fhQO1cjNKfiLnAE3AD3fssZHJJVkf4ihmM
	 ojwd4znjaFDOg==
Received: from [10.0.0.5] ([184.64.124.72])
	by cmsmtp with ESMTP
	id CWLapoB4EHFsOCWLapoV2m; Tue, 03 Jan 2023 01:44:11 +0000
X-Authority-Analysis: v=2.4 cv=XZqaca15 c=1 sm=1 tr=0 ts=63b3886b
 a=oHm12aVswOWz6TMtn9zYKg==:117 a=oHm12aVswOWz6TMtn9zYKg==:17
 a=IkcTkHD0fZMA:10 a=CCpqsmhAAAAA:8 a=mJCVXRSeM0gsWaSQ8n8A:9 a=QEXdDO2ut3YA:10
 a=ul9cdbp4aOFLsgKbc677:22
Message-ID: <a50c2610-3fb0-f1d6-0e89-a7b622f768b3@Shaw.ca>
Date: Mon, 2 Jan 2023 18:44:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Content-Language: en-CA
To: Cygwin Patches <cygwin-patches@cygwin.com>
From: Brian Inglis <Brian.Inglis@Shaw.ca>
Subject: newlib-cygwin master shortlog missing cygwin release tags
Organization: Inglis
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJIPoT7pww7gkZCN3FlJlMVCtHI6XD1DL/J6M10LBW03BwAnszd06aZyljsX6XI9CxwxFw03tzGk9OlxgOu4myMhODUQCQgk+qI/f6zNUpnExyb9dJAT
 3oa41PzeT1YXumYH18DbtKkoSsUOVBgwLMjFd40AvA9cxZqgfwBGwgO0pPG6/q1gxevw47kFGAb2Mw==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

I am confused looking at master shortlog missing cygwin release tags:

https://sourceware.org/git/?p=newlib-cygwin.git;a=shortlog;h=refs/heads/master

the only cygwin tags shown are cygwin-3.5.0-dev and cygwin-3.4.0 the day before 
and nothing else back until 2021-10-28 cygwin-3.4.0-dev and cygwin-3_3_0-release 
the day before, whereas the summary page shows more tags and different dates:

tags
2 weeks ago	cygwin-3.4.3		Cygwin 3.4.3 release	tag
3 weeks ago	cygwin-3.4.2		Cygwin 3.4.2 release	tag
3 weeks ago	cygwin-3.4.1		Cygwin 3.4.1 release	tag
4 weeks ago	cygwin-3.5.0-dev				tag
4 weeks ago	cygwin-3.4.0		Cygwin 3.4.0 release	tag
5 weeks ago	cygwin-3.4.0-dev				tag
3 months ago	cygwin-3_3_6-release	Cygwin 3.3.6 release	tag
7 months ago	cygwin-3_3_5-release	Cygwin 3.3.5 release	tag
11 months ago	cygwin-3_3_4-release	Cygwin 3.3.4 release	tag
12 months ago	cygwin-3_3_3-release	Cygwin 3.3.3 release	tag
13 months ago	cygwin-3_3_2-release	Cygwin 3.3.2 release	tag
14 months ago	cygwin-3_3_1-release	Cygwin 3.3.1 release	tag
14 months ago	cygwin-3_3_0-release	Cygwin 3.3.0 release	tag

so what am I not getting?

-- 
Take care. Thanks, Brian Inglis			Calgary, Alberta, Canada

La perfection est atteinte			Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter	not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer	but when there is no more to cut
			-- Antoine de Saint-Exupéry
