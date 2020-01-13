Return-Path: <cygwin-patches-return-9928-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21158 invoked by alias); 13 Jan 2020 21:17:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 21149 invoked by uid 89); 13 Jan 2020 21:17:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.1 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=responsive, images
X-HELO: mail-wm1-f68.google.com
Received: from mail-wm1-f68.google.com (HELO mail-wm1-f68.google.com) (209.85.128.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Jan 2020 21:17:54 +0000
Received: by mail-wm1-f68.google.com with SMTP id q9so11430211wmj.5        for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2020 13:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=gmail.com; s=20161025;        h=subject:to:references:from:message-id:date:user-agent:mime-version         :in-reply-to:content-transfer-encoding;        bh=ZFjfNvcBW/h9TLkJZ8aq1K+IDOK+1FHtskJH81N9qEI=;        b=lUjBoic5j4UHECCG52nZ3ccrGB2a4RQHbO771aIpHhiqigsDH+xQisXitF/qz1RhIz         3vSPi7VbtQeC8oDfwkCJ759UJWmGobhlrTBL1vtHA6TRVNSFagtGEH5GUZ8TgibbWpYY         SRvsVm1vTloB9PzDWjNMpaDai+HzL9NBbkmvRGvTvnKV4q3i4PyDlGQmjkvTWSNwA6ju         i/HXOBPKKxN+h98hWB5fjCbwY3NpBkDC5LR5y/IVEOXbkCczPfgZQc2ZbzlZqN5Ss6yM         KXkroHK6ikltSZF1Sq/2FLAG9qYitewi3mO4tuP42BOF0+krsWGnv3py00fk5NqPnl+w         wF7g==
Return-Path: <marco.atzeri@gmail.com>
Received: from ?IPv6:2003:ee:6727:2e01:5de7:6708:751b:e07? (p200300EE67272E015DE76708751B0E07.dip0.t-ipconnect.de. [2003:ee:6727:2e01:5de7:6708:751b:e07])        by smtp.gmail.com with ESMTPSA id i5sm15643602wml.31.2020.01.13.13.17.51        for <cygwin-patches@cygwin.com>        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);        Mon, 13 Jan 2020 13:17:51 -0800 (PST)
Subject: Re: [PATCH] Cygwin: select: Speed up select() call for pty, pipe and fifo.
To: cygwin-patches@cygwin.com
References: <20200106143834.1994-1-takashi.yano@nifty.ne.jp> <20200113163316.GQ5858@calimero.vinschen.de>
From: Marco Atzeri <marco.atzeri@gmail.com>
Message-ID: <4e2f7132-0e2b-a87f-a73e-a427abbdc7e9@gmail.com>
Date: Mon, 13 Jan 2020 21:17:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200113163316.GQ5858@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00034.txt

Am 13.01.2020 um 17:33 schrieb Corinna Vinschen:
> On Jan  6 23:38, Takashi Yano wrote:
>> - The slowing down issue of X11 forwarding using ssh -Y, reported
>>    in https://www.cygwin.com/ml/cygwin/2019-12/msg00295.html,
>>    is due to the change of select() code for pty in the commit
>>    915fcd0ae8d83546ce135131cd25bf6795d97966. cygthread::detach()
>>    takes at most about 10msec because Sleep() is used in the thread.
>>    For this issue, this patch uses cygwait() instead of Sleep() and
>>    introduces an event to abort the wait. For not only pty, but pipe
>>    and fifo also have the same problem potentially, so this patch
>>    applies same strategy to them as well.
> 
> Pushed.  And thanks for testing, Marco!
> 
> 
> Thanks,
> Corinna
> 

you are welcome.

I found the improvement better than anything I ever seen
on octave plotting with QT interface.
Redrawing of the images when moving windows is now very responsive,
in the past, also 3.0.x or before, the visual effect was poor.
