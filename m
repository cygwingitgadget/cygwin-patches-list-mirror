Return-Path: <cygwin-patches-return-8580-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 109730 invoked by alias); 15 Jun 2016 14:52:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 109588 invoked by uid 89); 15 Jun 2016 14:52:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1049, refresh, pictures, HTo:U*cygwin-patches
X-HELO: mail-lb0-f169.google.com
Received: from mail-lb0-f169.google.com (HELO mail-lb0-f169.google.com) (209.85.217.169) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Wed, 15 Jun 2016 14:52:23 +0000
Received: by mail-lb0-f169.google.com with SMTP id oe3so2904140lbb.1        for <cygwin-patches@cygwin.com>; Wed, 15 Jun 2016 07:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:subject:to:references:from:message-id:date         :user-agent:mime-version:in-reply-to:content-transfer-encoding;        bh=Z4HxXBHi5GI/v5eB+j0GCO0GWFy2j+OrhsAUKuB9eos=;        b=BMr99SEhHL/skxMQhEUS2kS1KGCncskfRqOtS51eFbaK2hZ0AwHdnewoTISTesIUvt         VwpOSfBfS9glIUr5LMAeXFK43J99buCVe0b0ILPgurO5+8KH9gGiwOXXidbpU7j2kE1v         UVPB9jbVX6w0EW6MdyQGB6zKKUF780LfbBm80AUWvtAbbcAqNC4cGyGjXZCQTpPqKTIc         s/wg8TytdSHIM9Z2V8R3WHHj1393dtIdhmV2IyEOxOkrGThLKx96AEpr94LpsmOPzr7T         QJuWYtYQttdHLjI/49hz9IvQ5pfgOhGS8x99DPoJ+ijeqkcd1fP0nDDN7Msg76Dz2j6B         Q10A==
X-Gm-Message-State: ALyK8tLsPxqXI/yiWtCDS1QhAnTFgOgXMprwYIhxPzGgg8IcNOp9n+50+ztSlpGq330JpQ==
X-Received: by 10.28.109.137 with SMTP id b9mr10322582wmi.68.1466002340126;        Wed, 15 Jun 2016 07:52:20 -0700 (PDT)
Received: from [172.21.188.226] ([62.154.173.198])        by smtp.googlemail.com with ESMTPSA id q6sm11120913wjt.46.2016.06.15.07.52.19        for <cygwin-patches@cygwin.com>        (version=TLSv1/SSLv3 cipher=OTHER);        Wed, 15 Jun 2016 07:52:19 -0700 (PDT)
Subject: Re: [setup] move view from left to right
To: cygwin-patches@cygwin.com
References: <ea3fb37b-8c1f-38be-a52f-3e2dae74d14c@gmail.com> <20160615124947.GE27295@calimero.vinschen.de> <c0854c9c-3b17-4570-733d-fc325b27d1f9@gmail.com>
From: Marco Atzeri <marco.atzeri@gmail.com>
Message-ID: <f1540797-04ba-316b-487e-daaeb85b3381@gmail.com>
Date: Wed, 15 Jun 2016 14:52:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <c0854c9c-3b17-4570-733d-fc325b27d1f9@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2016-q2/txt/msg00055.txt.bz2

On 15/06/2016 16:37, Marco Atzeri wrote:
> On 15/06/2016 14:49, Corinna Vinschen wrote:
>> Hi Marco,
>>
>>
>> in theory patches to setup should go to the cygwin-apps list, but
>> never mind, cygwin-patches is just as well.
>>
>> On Jun 15 12:06, Marco Atzeri wrote:
>>> I always found counter intuitive to have the view button filter on
>>> the right.
>>
>> Do you have a screenshot to show how this looks, by any chance?
>

Spam filter don't like pictures so, I put them here:
http://matzeri.altervista.org/works/setup/

>
>>> I was also thinking to replace the 3 button choice with
>>> 2 sets:
>>>
>>> keep vs update
>>> exp vs current
>>>
>>> but the update logic on
>>>
>>>  ChooserPage::keepClicked()
>>>  ChooserPage::changeTrust(trusts aTrust)
>>>
>>> it is not really immediate.
>>
>> I agree, but the idea makes sense.  If you ever have fun to hack on
>> this, please feel free.
>

I need to refresh my C++ knowledge to understand what
changeTrust is doing, so it could take a while.
>
>
>
>> Corinna
