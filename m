Return-Path: <SRS0=ckSk=XN=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	by sourceware.org (Postfix) with ESMTPS id 6EEF33858D1E
	for <cygwin-patches@cygwin.com>; Sun, 27 Apr 2025 18:53:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6EEF33858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6EEF33858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1745779990; cv=none;
	b=iucaW3/RDGJjUKzC/e3jkEagrFXKLTvPiA4ysHvE0fJfvXuTWIJll5OcoLM0FX0qC4TgU8pOgkqPpNh4R/sF4mTeuxyxKqhgdK1cowlg6uY6jjYcA5OcHzKoR3anvDZgIOm48hFL6efmWILSzzvKOdra0Sd2fdnGg4LY+wsJQMI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1745779990; c=relaxed/simple;
	bh=ul+hqAP6trgyApXtdFWt+k8pMFzcmtSUaJiDEzj5TGk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=xC/4J0OHfmUy733FVWFFNA6D/snAQ7Dpkuiw0Ddq6Bkl6O38wyJwC4CM2snvQM6CKdPMF60/+JpJP3fDBuNgEAtTR7TP5BZ5s3WeOUaAu4IB5dIyJ7hIr7KYjlbtfn7qo+ht6oKUdLmsmO5R2ysTcmmG2eiJtWVqyKXZoafz+mI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6EEF33858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=gVuxF95k
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 288141A08F0
	for <cygwin-patches@cygwin.com>; Sun, 27 Apr 2025 18:53:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf19.hostedemail.com (Postfix) with ESMTPA id B96AD20028
	for <cygwin-patches@cygwin.com>; Sun, 27 Apr 2025 18:53:08 +0000 (UTC)
Message-ID: <804e3202-54d4-4604-a962-0e15360e1a09@SystematicSW.ab.ca>
Date: Sun, 27 Apr 2025 12:53:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: kill(1): skip kill(2) call if '-f -s -' is used
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <16c95bad-2310-e66c-d538-403321033d2c@t-online.de>
 <20250415164029.c118309bc33c25f4b404b48d@nifty.ne.jp>
 <4356587f-51ed-302d-03f1-7415590813f6@t-online.de>
 <ac9d481c-00f0-46fd-a28f-c6938418e5d1@dronecode.org.uk>
Organization: Systematic Software
In-Reply-To: <ac9d481c-00f0-46fd-a28f-c6938418e5d1@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: 4d1sp1uiywndduojf6c6er8msewzwtm1
X-Rspamd-Server: rspamout04
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: B96AD20028
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/thMi6jydvB20oSStNCnHKO7VLDznwJpo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=JI8CdUZoh62heSG/fsmikJeCbM6stxJAW073zq5TgRU=; b=gVuxF95kz4HO14NmHmNQkZagz+WqlCkCn/VbEkSWFRQn7cA0Pww5QAfLSgWLoDl8WOXoQZTN7jquO4MfG8n9q+O+sOjt5daWeBRTguiW2VjELVE+ZRG2+h2UcJl8Ea+fYtgv7kvg/p5eIvyeH+p8+oDIxtkc1glrxxeCKcDHXjltJgndpUC9ii5QmX1UeucCH0F3IxzHRWwAN5if5P3n9BkaiWFEUfRYrSDGXFBif4okCPJPqzgwGljH8AncULXgoz4quQ/TNVojY6KXHzfcNgp6zu9g81lBU0LEQIqjNU5La6jaQmEuw1Yw74kTvSOgpUxKxRA4bR1aJO8kXgiPbA==
X-HE-Tag: 1745779988-84778
X-HE-Meta: U2FsdGVkX1+Hjh+Z/3GJQ1zd+fCpKZTmtKr99RQ1vZeowEF8z2ojn2e7Viso1mJjzow8+WFwJWTbyB6O7/cD2r28FJCEHi3czRUy/vtuwsYPQ14CFrEg+KbhOCzxErlssTbesENjkJSkMwLQJR5vKPt3UMM0TmawxTfvRQUbs3UU0+7vSqFLAUeZ9XAHCAhK/nUeG1CmZLbYHGWZFAo+9f1qhc0CWOvetmgMZ5KOVdgurwE0yt9gZ8kCc5/dkl28xWC67hRqRJ0s96EB9SUa6WfKEEHy+g5h5WeYRiFGYeKVWf0ecIdaKZUp8UbANSeJhpUhX1kLYw0OZCtaWGruh70Xv3nJfGr5
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-04-27 12:22, Jon Turney wrote:
> On 15/04/2025 10:02, Christian Franke wrote:
>> Hi Takashi,
>>
>> Takashi Yano wrote:
>>> Hi Christian,
>>>
>>> On Fri, 11 Apr 2025 16:46:07 +0200
>>> Christian Franke wrote:
>>>> In rare cases, '/bin/kill -f PID' hangs because kill(2) is always tried
>>>> first. With this patch, this could be prevented with '/bin/kill -f -s -
>>>> PID'.
> 
> As it currently stands, the -f flag to kill seems a bit misdesigned, i.e. if the 
> signal isn't SIGKILL, -f shouldn't be accepted?

Docs say -f uses Win32 interface so SIG... is irrelevant?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
