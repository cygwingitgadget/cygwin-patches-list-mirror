Return-Path: <cygwin-patches-return-8503-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 83344 invoked by alias); 30 Mar 2016 13:10:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 83321 invoked by uid 89); 30 Mar 2016 13:10:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:335, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-ob0-f178.google.com
Received: from mail-ob0-f178.google.com (HELO mail-ob0-f178.google.com) (209.85.214.178) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Wed, 30 Mar 2016 13:10:32 +0000
Received: by mail-ob0-f178.google.com with SMTP id x3so64751652obt.0        for <cygwin-patches@cygwin.com>; Wed, 30 Mar 2016 06:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=k0RwGKZlzSIfE+YODQ7foQIhrGb9bMfm/gZ+sPr9S/U=;        b=TIhal11xxEQPavonyq3XLYbeZRA0xtFJUlpNDRuWmD6QEvLSEtLCuhtRpRo9iceeI7         FmhWRve/VfZ2PUvTCOM+eZ/IMgHtbz8+1AuJ3T42ubkCYMMeeR6Yyt3+TcptyS9Quzng         meL8uD7damxP0gddszU0JctNZrbcouhFLnjzRbueUUoL18t5CJBZT6ZbhVpNMjODfe2M         OlS0MtTXAORrvjS3huuRrHFbjQ/B5BsqheIeXcIXpxlHqakvKV4Y6I392pkziJyr1D2V         r8h6XPzPCP4d8Ko6wOwrR0pjvJcz9GOJjmi2ZryrJQ4Jys42MSUYcLZHQ93c5O8/FYcU         eehA==
X-Gm-Message-State: AD7BkJL14YI9jlNhEiaDtUXRV0ni9w9TiUUdvGBPg2NOOMVTvy0hrhcnGyFEN+S2iDRpU4UHNUB5ly0qF++OJw==
X-Received: by 10.182.47.165 with SMTP id e5mr4865187obn.69.1459343379327; Wed, 30 Mar 2016 06:09:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.157.136 with HTTP; Wed, 30 Mar 2016 06:09:19 -0700 (PDT)
In-Reply-To: <20160330121146.GH3793@calimero.vinschen.de>
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <1458580546-14484-4-git-send-email-pefoley2@pefoley.com> <20160321193052.GG14892@calimero.vinschen.de> <CAOFdcFM-9XOAEPhSWbED_eiECu-UeWW2FBkg-u8jo40+0FwAjA@mail.gmail.com> <20160321195845.GL14892@calimero.vinschen.de> <CAOFdcFMJon17kNFhOVBccrrUJH0PmD6Vsf75FO9QTAv+qf_d0A@mail.gmail.com> <56F0A4A9.7050305@cygwin.com> <1458740052-19618-1-git-send-email-pefoley2@pefoley.com> <20160330121146.GH3793@calimero.vinschen.de>
From: Peter Foley <pefoley2@pefoley.com>
Date: Wed, 30 Mar 2016 13:10:00 -0000
Message-ID: <CAOFdcFMpCkLHCCwwdZby6UG_owTgZbT2Zd-1S_e92okAa1wjjQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Add option to not build mingw programs when cross compiling.
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00209.txt.bz2

On Wed, Mar 30, 2016 at 8:11 AM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> Applied with changes.  The below check was skewed.
>
>> +if test "x$with_mingw_progs" != xyes; then
>> +    AC_CONFIG_SUBDIRS([utils lsaauth])
>> +fi

Whoops, good catch.
