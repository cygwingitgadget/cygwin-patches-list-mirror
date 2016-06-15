Return-Path: <cygwin-patches-return-8582-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18402 invoked by alias); 15 Jun 2016 16:13:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18320 invoked by uid 89); 15 Jun 2016 16:13:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=(unknown), pictures, View, Spam
X-HELO: mail-lf0-f49.google.com
Received: from mail-lf0-f49.google.com (HELO mail-lf0-f49.google.com) (209.85.215.49) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Wed, 15 Jun 2016 16:12:59 +0000
Received: by mail-lf0-f49.google.com with SMTP id f6so19183053lfg.0        for <cygwin-patches@cygwin.com>; Wed, 15 Jun 2016 09:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:subject:to:references:from:message-id:date         :user-agent:mime-version:in-reply-to:content-transfer-encoding;        bh=Fsu6C6qOaf3JLZJd57IiQ3VXfgbvA5zhdq1IsmfkuvU=;        b=EKz/Bu64R8A7If2AGK6LxhAt0EaMAj4lvOQ8n12U6OxNy5tu9k9PCMmmLhnOWGGjNU         G9pbn10UCrZM/6xVE6jyvLaTDRH/n3DH2vUC5LHyLvKiSmJhIdGrLcFMIQHjA+4JRNV2         OoZqLsYvcvEgsO1o8Bk6UssaRLxE51TM2W9KGJmlp/Pb36dWdR3+zYiMzg4lG1p3/t+G         tOf+ZK+HEqgdt/dyPt7Wj8XENTG7dTLAYXhguU1VL8Wkjr84co35QPHeyv0WuCsEvkyL         RAx6r4+3iN/A58yd3fYjBnQqXPu65iTeJibDKdZpWX2wdA0IAD6ALT62ow4RkH9sgSTg         wdJg==
X-Gm-Message-State: ALyK8tK+HhljQIvvuwTJjfOTWQymQWq4DJ4z8YyEz2uNBfETvZUtg9tBTUTGb7c+sIoO1w==
X-Received: by 10.28.157.199 with SMTP id g190mr204232wme.2.1466007176149;        Wed, 15 Jun 2016 09:12:56 -0700 (PDT)
Received: from [172.21.188.226] ([62.154.173.198])        by smtp.googlemail.com with ESMTPSA id o129sm4892413wmb.17.2016.06.15.09.12.55        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Wed, 15 Jun 2016 09:12:55 -0700 (PDT)
Subject: Re: [setup] move view from left to right
To: cygwin-patches@cygwin.com
References: <ea3fb37b-8c1f-38be-a52f-3e2dae74d14c@gmail.com> <20160615124947.GE27295@calimero.vinschen.de> <c0854c9c-3b17-4570-733d-fc325b27d1f9@gmail.com> <f1540797-04ba-316b-487e-daaeb85b3381@gmail.com> <20160615153936.GF27295@calimero.vinschen.de>
From: Marco Atzeri <marco.atzeri@gmail.com>
Message-ID: <5326d3dc-69f8-7737-a442-5b01481e0269@gmail.com>
Date: Wed, 15 Jun 2016 16:13:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20160615153936.GF27295@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2016-q2/txt/msg00057.txt.bz2

On 15/06/2016 17:39, Corinna Vinschen wrote:
> On Jun 15 16:52, Marco Atzeri wrote:
>> On 15/06/2016 16:37, Marco Atzeri wrote:
>>> On 15/06/2016 14:49, Corinna Vinschen wrote:

>> Spam filter don't like pictures so, I put them here:
>> http://matzeri.altervista.org/works/setup/
>
> Thank you.  What strikes me immediately is that the search field and
> clear button are not in the same height.  I never noticed before.
> Actually, I think search field and clear button are a pixel too narrow.
>
> And in the second picture the "Not installed" text is too far left.
>
> What about this:
>
> - Arrange the "View" button with the left side of the package table.
>
> - Arrange the accompanying text right of the button.
>
> - Move "Search [...] Clear" to the center?
>
> - If you don't mind the extra work, align the y-pos and height of the
>   search stuff to the other elements in the row?
>


I will play a bit and let you know


>
> Thanks,
> Corinna
>
