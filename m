Return-Path: <mhentges@mozilla.com>
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 by sourceware.org (Postfix) with ESMTPS id 1614E3858D1E
 for <cygwin-patches@cygwin.com>; Fri, 11 Feb 2022 05:10:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 1614E3858D1E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=mozilla.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=mozilla.com
Received: by mail-yb1-xb32.google.com with SMTP id j2so21871604ybu.0
 for <cygwin-patches@cygwin.com>; Thu, 10 Feb 2022 21:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mozilla.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Dm6P/b4yA+ouyiW8n9eq3sA/QmwmNgiiLfcQoRjshT8=;
 b=JZo7HaGbuTfwZi/u/tUCn76uO2bYD667RN9PKGKYQAJBWzBCWyqLj2W19ugrTl03NL
 Ju70AZo0dSMepWx/cwBW7UCXW3FpTmouD9+19855B6BtRuaNJa5umeQJOX7Q2lxnuaNU
 cI9pE0nAPxSRFN4olrJ0UHOZpoR1X3c7yWXzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dm6P/b4yA+ouyiW8n9eq3sA/QmwmNgiiLfcQoRjshT8=;
 b=xIbfPLtxEY34V1do2riRRRVKgWIgWIxtrma7VMzTBd2AVMzGxDhASdxsFij+c5LscA
 1kyEpdJvFLQ66M36NlXlGQb/bdDQM8PqoLSD1BTk1c6rybv66wkgA4qR0bqOQexBrtV0
 giNtRWu/3d48/HFZ1WNXWI9weTTU7Mg3RmPftswIzI+aKtnKHVqLThukL2ILiA8E1uw7
 /uXuTxFSv2iF2P2ujENCEy+6XX+HUvudnBoD4494APdHFIslJsUa5iw1LW+pzFLYxr6P
 PBPnYKyo7bBO++49PgdzsXeLS1g8NKHX4FPM6AFilL9YXqzJIUsNBHMSqZbu6T5kP+t3
 4cZQ==
X-Gm-Message-State: AOAM533CzTWbiFVCV4UyEo2gaY6Sm3c4zrJyT24OWQeq1KZ4K76Rvs4z
 xvS2OkgAxHfIsn3jTnzfXvwyNVHoOu9fu7f2wIJkTw==
X-Google-Smtp-Source: ABdhPJzPhce6IeUu3lzH5EsAelzhaiOkCOqL7D/ncIq9vujB7tqFIcam7ebSCsK48zwaX6NqXliZatYE0Jy1m0ZsIpY=
X-Received: by 2002:a25:c04f:: with SMTP id c76mr9755315ybf.327.1644556223580; 
 Thu, 10 Feb 2022 21:10:23 -0800 (PST)
MIME-Version: 1.0
References: <20220210170756.a2efb012fdc916e3873b1b55@nifty.ne.jp>
 <20220210153808.2655-1-mhentges@mozilla.com>
 <CAAvot8-BObo_X1d1E3x8o+qpZYFQO0qicYpz9G0dB3bkEtgvsA@mail.gmail.com>
 <20220211091204.409213793d1c2e4b961299eb@nifty.ne.jp>
In-Reply-To: <20220211091204.409213793d1c2e4b961299eb@nifty.ne.jp>
From: Mitchell Hentges <mhentges@mozilla.com>
Date: Fri, 11 Feb 2022 00:10:13 -0500
Message-ID: <CAAvot8_9gycBDpQ2VfiGrKLakx7RL88tjf1OYfmMODMYo4g=sw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Cygwin: console: Maintain EXTENDED_FLAGS state
To: Takashi Yano <takashi.yano@nifty.ne.jp>
Cc: cygwin-patches@cygwin.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, HTML_MESSAGE, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 11 Feb 2022 05:10:26 -0000

For future reference, as my git commit message lost some information: the
"[1]" link I was trying to refer to was to here:
https://www.os2museum.com/wp/disabling-quick-edit-mode/
This was my first experience working with email-based patch contributing,
so I apologize for the mis-steps here.
Thanks again :)

On Thu, Feb 10, 2022 at 7:12 PM Takashi Yano <takashi.yano@nifty.ne.jp>
wrote:

> On Thu, 10 Feb 2022 10:40:36 -0500
> Mitchell Hentges wrote:
> > Thanks, I appreciate it.
> > The initial send was via GMail, but I've wired up git-send-email to
> msmtp,
> > and I'm hoping that it's happy now - at least, it looks like tabs are
> being
> > preserved now, which is a good sign.
>
> Pushed along with modifying the commit message.
>
> Thansk!
>
> --
> Takashi Yano <takashi.yano@nifty.ne.jp>
>


-- 
Mitchell Hentges
Engineering Workflow
Mozilla
