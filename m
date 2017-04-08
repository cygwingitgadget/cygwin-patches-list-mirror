Return-Path: <cygwin-patches-return-8735-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 109824 invoked by alias); 8 Apr 2017 16:18:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 109804 invoked by uid 89); 8 Apr 2017 16:18:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.4 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=no version=3.3.2 spammy=Hx-languages-length:346, HTo:U*cygwin-patches
X-HELO: mail-io0-f172.google.com
Received: from mail-io0-f172.google.com (HELO mail-io0-f172.google.com) (209.85.223.172) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 08 Apr 2017 16:18:39 +0000
Received: by mail-io0-f172.google.com with SMTP id b140so64710202iof.1        for <cygwin-patches@cygwin.com>; Sat, 08 Apr 2017 09:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:subject:to:references:from:message-id:date         :user-agent:mime-version:in-reply-to:content-transfer-encoding;        bh=DQpeq19Urh2l+5wjQ/I79E2Q0qqxtDqBJthhWM4kmGU=;        b=dIzWPxMBN8XKK/BuS8FRhJEECWasNBAmwDU1kS6zLmuHLW7/cRwvkY5VjT30AC2wea         tDy39+YhcPQdYnWHpCOytaiKMywsvRup96XvgE7KWLdknK+/33Kl5MpWzIzvmfG5Kb30         Hv6LtXpBVsk6olJWhkkT6wOifnzhLIeTSP95kX1sF0qux81c8M9mPW3FFnvZW2sUVs2M         2nOOm0n/1mvt5SspqoeY3RejXvoZYN7LQZzIGrTKllk4jMbBxt58ueEWh9EmjB+OkGNl         y6wGxLfL2YewqU2DvUmd+v7P7RXSs15cP+IdKzQY14sfMBU2z4g5mzgklqOxqrRWQEaU         gInQ==
X-Gm-Message-State: AN3rC/5fcGCGG89b07o63jXyS+eD4KnHhUdxHRc98NlD70orHa0GjCptoplEpiQfC3xehg==
X-Received: by 10.107.6.6 with SMTP id 6mr6105747iog.78.1491668319043;        Sat, 08 Apr 2017 09:18:39 -0700 (PDT)
Received: from [192.168.0.6] (d27-96-48-76.nap.wideopenwest.com. [96.27.76.48])        by smtp.gmail.com with ESMTPSA id y203sm3978384iod.11.2017.04.08.09.18.38        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Sat, 08 Apr 2017 09:18:38 -0700 (PDT)
Subject: Re: [PATCH] Avoid decimal point localization in /proc/loadavg
To: cygwin-patches@cygwin.com
References: <20170408125537.15728-1-jon.turney@dronecode.org.uk>
From: cyg Simple <cygsimple@gmail.com>
Message-ID: <8a034d22-0b06-c2e0-34ed-fa607ec90257@gmail.com>
Date: Sat, 08 Apr 2017 16:18:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170408125537.15728-1-jon.turney@dronecode.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00006.txt.bz2

On 4/8/2017 8:55 AM, Jon Turney wrote:
> Explicitly format the contents of /proc/loadavg to avoid the decimal point
> getting localized according to LC_NUMERIC. Using anything other than '.'
> breaks top.
> 

Would it be more prudent to update top to be locale aware?

-- 
cyg Simple
