Return-Path: <marco.atzeri@gmail.com>
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by sourceware.org (Postfix) with ESMTPS id 2A0463858C27
 for <cygwin-patches@cygwin.com>; Sat, 25 Dec 2021 19:00:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 2A0463858C27
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-x535.google.com with SMTP id x15so45325408edv.1
 for <cygwin-patches@cygwin.com>; Sat, 25 Dec 2021 11:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=wZwTFOjj/GS7hGyFBxLBGmWzydD+/YWwUQIkV/lu3lk=;
 b=GtZWCTVZA2UD+RN0gNmI2r5BZMvUkJR8DpknumOiqQKvUvITMeRTXyD1EPAhM6u64M
 yPOF3yUu7/rx+16HagpRJoMZ7MuAa9XAIIPKvYgLtDytyzbqY0QByfjIJ+VOe9BlWbnJ
 0ONzHmGNwGYvdbvlKlawDyWXoKwJ7NQe0SjlAE53SLAc3pAtZy5s9C87oCcdzMCK4cFh
 HWFMfjyT/lKo5zt/ysWmkPCo5IQY4cvMOnPuuJwR1AZQ2YFD/BloiaUysuWrSc24ZSWU
 KUehdzdOCLYpuDmwz6UGn87XFofuAPz5uLzx6kPs8bX9rWJ1dKsSZMjOlPRjATAEOpuX
 AOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=wZwTFOjj/GS7hGyFBxLBGmWzydD+/YWwUQIkV/lu3lk=;
 b=rt/R4dniXyb6RDl2+S8Ri2iU+P4qBtPZzow4pMSz2Qk24rJBb60y/w0INUZ8Fp6uTh
 t33dyywtT7GS4k+f6V3eboLdTe8W1a7cOYbT94YfWDBtgFjxxU90Nn82QBmtuhEkpkE1
 hh9tl9AdqjLbCmXS+KUZi+e1KFD6ndpSotnfXJGtUdqr2oUWhkH7qnmtiLtUkaVqcQb7
 S271/d3Ghn2ppqkNLWYWGkIbGuA2OSARjrOep5awky+pxvett9esvGtyWKADu/zzLwND
 rkNa7WPYn2ZcfysIOP5rgU52rHMn9XLVl/xOJ8v3mPs5Qf7Hr4Goj0aRhVccM1fT6aqy
 W5iA==
X-Gm-Message-State: AOAM530cmrv/d9wpUq48wb+rlG8nIASEiI3t7gdEU0qjxMZebk/XEm0n
 IMhRe8WKgKDPJ0ea6xrpppSOptJ1g8e/Bvc2
X-Google-Smtp-Source: ABdhPJwuiP2S2gKQddVI8wVDmma+/7Fej0SXKPX6x51X0n0OMATIZHNcQQKOBGcT0HNz4SlrEIgJHg==
X-Received: by 2002:a17:907:1c1f:: with SMTP id
 nc31mr8580508ejc.712.1640458813119; 
 Sat, 25 Dec 2021 11:00:13 -0800 (PST)
Received: from [192.168.0.4] ([151.33.115.150])
 by smtp.gmail.com with ESMTPSA id s8sm3694111ejs.174.2021.12.25.11.00.12
 for <cygwin-patches@cygwin.com>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Dec 2021 11:00:12 -0800 (PST)
Message-ID: <78daa3c7-4a80-9628-0048-269e60314e4f@gmail.com>
Date: Sat, 25 Dec 2021 20:00:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] fhandler_pipe: add sanity limit to handle loops
Content-Language: it
To: cygwin-patches@cygwin.com
References: <alpine.BSO.2.21.2112231503400.11760@resin.csoft.net>
 <f97bba17-16ab-d7be-01f6-1c057fb5f1a5@cornell.edu>
 <alpine.BSO.2.21.2112231623490.11760@resin.csoft.net>
 <c5115e9b-6475-d30e-04d3-cb84cfa92b3a@cornell.edu>
 <alpine.BSO.2.21.2112241136160.11760@resin.csoft.net>
 <622d3ac6-fa5d-965c-52da-db7a4463fffd@cornell.edu>
 <alpine.BSO.2.21.2112241638280.11760@resin.csoft.net>
 <20211225121902.54b82f1bb0d4f958d34a8bb7@nifty.ne.jp>
 <alpine.BSO.2.21.2112241945060.11760@resin.csoft.net>
 <20211225131242.adef568db53d561a6b134612@nifty.ne.jp>
 <alpine.BSO.2.21.2112242101520.11760@resin.csoft.net>
 <20211226021010.a2b2ad28f12df9ffb25b6584@nifty.ne.jp>
 <20211226021639.80aa08c25bc16ae0ceaf19a6@nifty.ne.jp>
From: Marco Atzeri <marco.atzeri@gmail.com>
In-Reply-To: <20211226021639.80aa08c25bc16ae0ceaf19a6@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FREEMAIL_FROM, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=no autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sat, 25 Dec 2021 19:00:15 -0000

On 25.12.2021 18:16, Takashi Yano wrote:
> On Sun, 26 Dec 2021 02:10:10 +0900
> Takashi Yano wrote:
>> 	if (phi->NumberOfHandles > n_handle) {
>> 		HeapFree(GetProcessHeap(), 0, phi);
>> 		exit(1);
>> 	}
> [...]
>> 	if (shi->NumberOfHandles > n_handle) {
>> 		HeapFree(GetProcessHeap(), 0, shi);
>> 		exit(1);
>> 	}
> 
> Sorry, please remove above lines.
> 

I think it is better to put as attachment the full
requested test code.

Regards
Marco
