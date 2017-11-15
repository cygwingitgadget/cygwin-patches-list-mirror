Return-Path: <cygwin-patches-return-8929-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 122774 invoked by alias); 15 Nov 2017 19:46:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 122763 invoked by uid 89); 15 Nov 2017 19:46:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.2 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,KB_WAM_FROM_NAME_SINGLEWORD,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=no version=3.3.2 spammy=Star, Award, award, HTo:U*cygwin-patches
X-HELO: mail-io0-f180.google.com
Received: from mail-io0-f180.google.com (HELO mail-io0-f180.google.com) (209.85.223.180) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 15 Nov 2017 19:46:01 +0000
Received: by mail-io0-f180.google.com with SMTP id v21so2776755ioi.4        for <cygwin-patches@cygwin.com>; Wed, 15 Nov 2017 11:46:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:subject:to:references:reply-to:from:message-id         :date:user-agent:mime-version:in-reply-to:content-language         :content-transfer-encoding;        bh=6Zuwsun3COncoTCCLE9WQXJtSawFjh9uz/mlTGboIBo=;        b=KFwuoEOUalnYrlwrpCP7PB2r5xUJpRStNhtY5VESL9vAodVF5Dmm0t57H/PTBJSJwW         wQO9T0E08ZxblU00Kb4fmi3liwLLmV4a1CHx+4hzNkr86hLtV36u+zX1XmDG4G7+sNPn         qKCR5fHPkmMVGhvX2YDG5VrLpsNnz500ptz2gqtZoO+79PKuQpp/8KXHu0POq+kHOe86         +P27WtvUhf5h9fb4gtW6/h1JpYwHnFOXmJlhhEzDK96n19g1P60jqHo/2jkLznfqKfNm         Ja0i9G1RBhxHqjJEP9oc4k19OGwJecwhvYGbc37iQG2CwqsY5F2837dpd3nluTAR1ntC         btFw==
X-Gm-Message-State: AJaThX5iKUcQYBmaX0nenm5TN7xGKy5VRcbAxia6Vn9KpkhZZjIu/y/U	V1TkhqpjueNPQPghOo+lNPDuEg==
X-Google-Smtp-Source: AGs4zMY/c/O/xgW11mhsKiyJmj6pPYCe47fFQFwoPIDWtMtLo4rT4H/aKarVsMfPUabxdqa2eEQTlQ==
X-Received: by 10.107.78.6 with SMTP id c6mr20908318iob.68.1510775160024;        Wed, 15 Nov 2017 11:46:00 -0800 (PST)
Received: from [192.168.0.9] (d4-50-42-50.try.wideopenwest.com. [50.4.50.42])        by smtp.gmail.com with ESMTPSA id w186sm6930987itd.12.2017.11.15.11.45.59        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Wed, 15 Nov 2017 11:45:59 -0800 (PST)
Subject: Re: [PATCH] Add FAQ How do I fix find_fast_cwd warnings?
To: cygwin-patches@cygwin.com
References: <e4e9d518-3a00-6d60-f653-7162711e9672@SystematicSw.ab.ca> <8be9463b-1349-c309-afe1-828712489f74@cornell.edu> <cb561bef-71bc-4261-a5ba-7a5164d10400@SystematicSw.ab.ca> <20171113120509.GA3881@calimero.vinschen.de> <50152c8a-8086-57c5-0b4e-603a771ed7b8@SystematicSw.ab.ca> <3a0ad9a8-0cb7-00ca-e698-dca59bc600e4@SystematicSw.ab.ca> <20171114092902.GF6054@calimero.vinschen.de> <d9422d11-f5f0-4f8e-9e56-04efd40cec4b@SystematicSw.ab.ca> <20171114212618.GA14730@calimero.vinschen.de> <5252eda6-e26d-d5a1-5d51-2a4c1441fbe7@SystematicSw.ab.ca> <20171115132107.GC1058@calimero.vinschen.de> <d511f675-59ad-61fe-7b3a-b3561a87f12b@SystematicSw.ab.ca>
Reply-To: cygwin@cygwin.com
From: cyg Simple <cygsimple@gmail.com>
Message-ID: <5ca5f797-e10a-3238-d7ff-ea74f70bd9b7@gmail.com>
Date: Wed, 15 Nov 2017 19:46:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <d511f675-59ad-61fe-7b3a-b3561a87f12b@SystematicSw.ab.ca>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00059.txt.bz2

On 11/15/2017 11:09 AM, Brian Inglis wrote:
> On 2017-11-15 06:21, Corinna Vinschen wrote:
>> On Nov 14 23:01, Brian Inglis wrote:
>>> >From 61fe6f174a840cffdac4ae8772e1a10a68e80beb Mon Sep 17 00:00:00 2001
>>> From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
>>> Date: Tue, 14 Nov 2017 22:57:02 -0700
>>> Subject: [PATCH] add FAQ How do I fix find_fast_cwd warnings
>>
>> Pushed.
>>
>> Thanks,
>> Corinna
> 
> Cheers!
> 

Thanks for seeing this through Brian.  Gold Star Award in my view.

-- 
cyg Simple
