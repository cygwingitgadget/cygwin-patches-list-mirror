Return-Path: <cygwin-patches-return-8583-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26583 invoked by alias); 16 Jun 2016 11:13:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26569 invoked by uid 89); 16 Jun 2016 11:13:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:605, View, HTo:U*cygwin-patches, arrange
X-HELO: mail-wm0-f48.google.com
Received: from mail-wm0-f48.google.com (HELO mail-wm0-f48.google.com) (74.125.82.48) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Thu, 16 Jun 2016 11:13:28 +0000
Received: by mail-wm0-f48.google.com with SMTP id m124so64348845wme.1        for <cygwin-patches@cygwin.com>; Thu, 16 Jun 2016 04:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:subject:to:references:from:message-id:date         :user-agent:mime-version:in-reply-to:content-transfer-encoding;        bh=d/Xi0hB2uSzBZ1r80ICzf23xQsTo/yDVAIWnkkTLgrw=;        b=XrNZH/iLwK5hoyVII6X85Te8nQvCWAseogiQnBJSK9hSMvmiVmPgMAcrWbXt2F+a2X         H/dMnNywVhfRbAYm36Mfr6EL9LRzlaCQlP3FZVnIEAdA+fg047AEOu+Vd9uFVfTAfaIe         enzAEnQ8icVqBYrnTLeNPubM+XOA2lvUfVM36IxgXSNdGhxg2nVz6ZaxggIXo0z+hWEM         CxcJyX7BXmaVTgHZbZv0Zj493DXG19BX4EEHR9Cxl5coRgRvQwZXw46MM+EUiWRY/hrc         nAjwj9pzKQWJgWtMkpEyTbcUAN/5mRy+7ew7vomnN+B9xHp8KbvIaagVYRmk/bT9VRye         kGig==
X-Gm-Message-State: ALyK8tLrd2IV+3o2b5RE7vqAQASVqOnUxtwU7HOIL2J7i/mYE1FYlkYDAE7ct3k3x5e0BQ==
X-Received: by 10.28.141.4 with SMTP id p4mr462945wmd.46.1466075604652;        Thu, 16 Jun 2016 04:13:24 -0700 (PDT)
Received: from [172.21.188.226] ([62.154.173.198])        by smtp.googlemail.com with ESMTPSA id w188sm2787481wmw.11.2016.06.16.04.13.23        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Thu, 16 Jun 2016 04:13:23 -0700 (PDT)
Subject: Re: [setup] move view from left to right
To: cygwin-patches@cygwin.com
References: <ea3fb37b-8c1f-38be-a52f-3e2dae74d14c@gmail.com> <20160615124947.GE27295@calimero.vinschen.de> <c0854c9c-3b17-4570-733d-fc325b27d1f9@gmail.com> <f1540797-04ba-316b-487e-daaeb85b3381@gmail.com> <20160615153936.GF27295@calimero.vinschen.de>
From: Marco Atzeri <marco.atzeri@gmail.com>
Message-ID: <6e6c7336-45c1-bc47-5470-c48810376e64@gmail.com>
Date: Thu, 16 Jun 2016 11:13:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20160615153936.GF27295@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2016-q2/txt/msg00058.txt.bz2

On 15/06/2016 17:39, Corinna Vinschen wrote:
> On Jun 15 16:52, Marco Atzeri wrote:
>> On 15/06/2016 16:37, Marco Atzeri wrote:
>>> On 15/06/2016 14:49, Corinna Vinschen wrote:

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

http://matzeri.altervista.org/works/setup/Round2/

let me know
