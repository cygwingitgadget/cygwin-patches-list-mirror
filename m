Return-Path: <cygwin-patches-return-8475-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 46094 invoked by alias); 21 Mar 2016 20:19:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 46027 invoked by uid 89); 21 Mar 2016 20:19:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=desktop, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-ob0-f195.google.com
Received: from mail-ob0-f195.google.com (HELO mail-ob0-f195.google.com) (209.85.214.195) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 21 Mar 2016 20:19:32 +0000
Received: by mail-ob0-f195.google.com with SMTP id e7so15778217obv.2        for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 13:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=/dXxqhDRBwI17Ohy0VbbHRzwjB8lRJM2xgKEYGtAdpw=;        b=K3EsM+zISPtFHzL4kHa0JYWO3Y0zLh9VqIPs1w6BCXGYU2JfkSvoYRhCWwxNOcghL7         E9yyCt3YqFf/NHccNi+fC183fKAddUTz5P7f+mkYTV5N+imqy76qgL1rQZPngGjV98PM         1LUfLnZ4/kbWMBQUpVk1+/Yw8L8vAYS9Gm3PSEW0CSxdVvJSmW7upAqXPed8wJF7ZcDA         nEbVCO0y2yddWXwnXHNrxR74okZuILDsi1D7aOUSz+ToZ9wrNAEkvUnbUXPL0zqlr6kS         WJY1Zm7kepVxuCh1S1wd2d3LfyR2zvJUO60xNGMzJ4N0FcNb5GIAdDF5MctMF3FoE4vY         Sx8w==
X-Gm-Message-State: AD7BkJIVXbzNZKX8lQX9WXrVxwAg+70/Gh3d0Q42QcqU/Hk/0G8zPucJBAed0Q0bWlYkqkZSd3MArAhuyUUJ5A==
X-Received: by 10.182.58.5 with SMTP id m5mr20091229obq.26.1458591570525; Mon, 21 Mar 2016 13:19:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.86.194 with HTTP; Mon, 21 Mar 2016 13:19:10 -0700 (PDT)
In-Reply-To: <20160321195244.GJ14892@calimero.vinschen.de>
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <1458580546-14484-2-git-send-email-pefoley2@pefoley.com> <20160321192450.GD14892@calimero.vinschen.de> <CAOFdcFP=cJyuiB=dPEqa2XpFV5jmVoepwr0CQ1=2R0j9bA-CHA@mail.gmail.com> <20160321195244.GJ14892@calimero.vinschen.de>
From: Peter Foley <pefoley2@pefoley.com>
Date: Mon, 21 Mar 2016 20:19:00 -0000
Message-ID: <CAOFdcFMbLNOXCNcMYexqqUWa5GS4CyiSgrcjPHuUr7dnnR_ifg@mail.gmail.com>
Subject: Re: [PATCH 2/5] Link against libdnsapi to avoid undefined reference
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00181.txt.bz2

On Mon, Mar 21, 2016 at 3:52 PM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> While you're at it, ideally we make ourselves independent of the MingW
> header version and use DnsFree directly, replacing DnsRecordListFree
> in autoload.cc and libc/minires-os-if.c, no?

Hmm, it isn't immediately obvious as to the meaning of the 2nd (n)
parameter to LoadDLLfunc()
How would I go about finding the correct value for the DnsFree function?
Function documentation is at
https://msdn.microsoft.com/en-us/library/windows/desktop/ms682011(v=vs.85).aspx

Thanks,

Peter
