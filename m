Return-Path: <cygwin-patches-return-8034-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17430 invoked by alias); 19 Nov 2014 19:30:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 17413 invoked by uid 89); 19 Nov 2014 19:30:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.2 required=5.0 tests=AWL,BAYES_20,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-qa0-f45.google.com
Received: from mail-qa0-f45.google.com (HELO mail-qa0-f45.google.com) (209.85.216.45) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Wed, 19 Nov 2014 19:30:14 +0000
Received: by mail-qa0-f45.google.com with SMTP id x12so901494qac.18        for <cygwin-patches@cygwin.com>; Wed, 19 Nov 2014 11:30:12 -0800 (PST)
MIME-Version: 1.0
X-Received: by 10.224.28.193 with SMTP id n1mr54373916qac.93.1416425412638; Wed, 19 Nov 2014 11:30:12 -0800 (PST)
Received: by 10.229.54.138 with HTTP; Wed, 19 Nov 2014 11:30:12 -0800 (PST)
In-Reply-To: <CAD97vhocMs1xoSoPsLWzJrMqahkONyx_KrVYwFJSeoupvfsvRQ@mail.gmail.com>
References: <CAE3zD3WZU8ZvqwW69f4hs+vFigShstjvh9HKuHGewXTLDsx==w@mail.gmail.com>	<20141118204344.GJ3151@calimero.vinschen.de>	<CAE3zD3WE4ELw0eGHW=Y6Pvo+5b2ezV48UhzhdGxA+_uJXmOm=A@mail.gmail.com>	<CAD97vhocMs1xoSoPsLWzJrMqahkONyx_KrVYwFJSeoupvfsvRQ@mail.gmail.com>
Date: Wed, 19 Nov 2014 19:30:00 -0000
Message-ID: <CAD97vhrodbPM8AgC1JLXyrMSr3v01p6ZLfPQnDooW-+NtK0fLg@mail.gmail.com>
Subject: Re: Fix performance on 10Gb networks
From: Lev Bishop <lev.bishop@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2014-q4/txt/msg00013.txt.bz2

Maybe my analysis from some years ago can be relevant here? Another
issue with delayed acks and winsock. I haven't been following cygwin
for some time, so not sure exactly what the status is:
https://cygwin.com/ml/cygwin-patches/2006-q2/msg00031.html

Lev

-- 
Lev Bishop
