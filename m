Return-Path: <SRS0=fhL/=DO=gmail.com=alves.ped@sourceware.org>
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	by sourceware.org (Postfix) with ESMTPS id 801AE3853D26
	for <cygwin-patches@cygwin.com>; Fri, 28 Jul 2023 16:12:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 801AE3853D26
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=palves.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3fd190065a8so25441575e9.3
        for <cygwin-patches@cygwin.com>; Fri, 28 Jul 2023 09:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690560726; x=1691165526;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TO1aEX+9yI6n3pYrtyA8r6OiXNfdrekYhCn0sdPp40k=;
        b=iI80leiad+4IWZbDT/4mpYLpkdsOnuN/LT+9hNyTcir99UWDoHAUd/ylR26YXOWX6J
         xygyezA1i3HMe2UN/ADVyWQ8jSS9Vz5JY+16H6GD8qq/p+JrQGbu8k6W8RAGg+LZWoUg
         4IyXvllon9yms7/A9aGvKwTaCPxw/aJqn3H8MC4duNJmduAipVh/pjQWLufYriCQwVUx
         WwnmrKaSV5Euu4jjzHvaEFq/W+WFw9BO3eDhDsrvgBms/8XFbUDeE1powBTV7rZZ8C+I
         vOuEYqTx4Qf/9SSKXzjBh0rZ/l+suoUR3RVQNxnMItXLhCpULo3oIRQSKvoSrTTsLNmj
         4mdA==
X-Gm-Message-State: ABy/qLap9vKeUiz2SP35Ps0eU6EaIsxs4S8UIyVbkUT7oO/SMLJZUYQf
	LIol+y1gcoMVjddcgIvkIsptNJ5NcJ8=
X-Google-Smtp-Source: APBJJlGCkRcc91BsZWa/4xgau2feaPCZIKMBr8cQhCrTpzBJSmgZnOQtvJqVwK3uwCG4H6ZR5UOfzQ==
X-Received: by 2002:a7b:cb97:0:b0:3fb:b280:f548 with SMTP id m23-20020a7bcb97000000b003fbb280f548mr2456435wmi.0.1690560726300;
        Fri, 28 Jul 2023 09:12:06 -0700 (PDT)
Received: from ?IPV6:2001:8a0:f922:de00:5b94:75a9:c970:55df? ([2001:8a0:f922:de00:5b94:75a9:c970:55df])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fc02219081sm4453006wmi.33.2023.07.28.09.12.05
        for <cygwin-patches@cygwin.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 09:12:05 -0700 (PDT)
Message-ID: <135bb49e-08b3-865e-a19f-6aab03a5f348@palves.net>
Date: Fri, 28 Jul 2023 17:11:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Pedro Alves <pedro@palves.net>
Subject: Re: [PATCH 5/5] Cygwin: add AT_EMPTY_PATH fix to release message
To: cygwin-patches@cygwin.com
References: <20230712120804.2992142-1-corinna-cygwin@cygwin.com>
 <20230712120804.2992142-6-corinna-cygwin@cygwin.com>
Content-Language: en-US
In-Reply-To: <20230712120804.2992142-6-corinna-cygwin@cygwin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2023-07-12 13:08, Corinna Vinschen wrote:
> +- Fix AT_EMPTY_PATH handling in fchmodat and fstatat if dirfd referres to

referres -> refers
