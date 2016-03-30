Return-Path: <cygwin-patches-return-8504-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 83987 invoked by alias); 30 Mar 2016 13:11:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 83947 invoked by uid 89); 30 Mar 2016 13:10:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-ig0-f181.google.com
Received: from mail-ig0-f181.google.com (HELO mail-ig0-f181.google.com) (209.85.213.181) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Wed, 30 Mar 2016 13:10:48 +0000
Received: by mail-ig0-f181.google.com with SMTP id cl4so101316879igb.0        for <cygwin-patches@cygwin.com>; Wed, 30 Mar 2016 06:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=35PxPPBk1zLPrSOrTBMlpDNe7Y6RdHUNXuZ/3ym5NPI=;        b=O4OzOWVivGugBio1tpDUH+BEN1FbD/+hK+bcog2uu/vCTovH4faPATWBIk0S5jq8Pg         YN0rUIIXHEa5aeq0oXSNlPIPGboSv9VEpK5Jx8oT0lab06QgqgksGpOJnBascoPaCTdQ         HIG5TfmEzNyI/F1NPsRGpKUYLvqW5prSUOC293ZpAutXF8YiO3t3Ue/5ipKMtb+zVEET         TEBYW2ejsC1qK0mOcil8SM0q8rr5f/cqWmbUgOfBqaGZccyL32GiXgdyRsoLX5eZ1mvV         V1vdsDvEFGalcokkKqowr2HjdBufl18TwqIxu07oHzu1P9CtVSLoS1A5h5VJpXuVmxWz         db9Q==
X-Gm-Message-State: AD7BkJLrT6hAr/4rjKBip5iSZFPhGHk4fVctlFH7YUOwAu5t6ivhZ7+iD5teNwqd9fy2zgZCwKsaf0+O/v8iBg==
X-Received: by 10.202.195.69 with SMTP id t66mr4571366oif.26.1459343445740; Wed, 30 Mar 2016 06:10:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.157.136 with HTTP; Wed, 30 Mar 2016 06:10:26 -0700 (PDT)
In-Reply-To: <20160330112434.GG3793@calimero.vinschen.de>
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-6-git-send-email-pefoley2@pefoley.com> <20160330112434.GG3793@calimero.vinschen.de>
From: Peter Foley <pefoley2@pefoley.com>
Date: Wed, 30 Mar 2016 13:11:00 -0000
Message-ID: <CAOFdcFOeuGEY=2JemRQxft-Tvz+MqwXp+JYY6szvBM8ce2YU6w@mail.gmail.com>
Subject: Re: [PATCH 06/11] Remove always true nonnull check on "this" pointer.
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00210.txt.bz2

On Wed, Mar 30, 2016 at 7:24 AM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> Hi Peter,
>
> On Mar 19 13:45, Peter Foley wrote:
>> G++ 6.0 can assert that the this pointer is non-null for member functions.
>
> Maybe, but if it compains, it's bound to find false positives...
>

Alright, I'll take a closer look at this.
