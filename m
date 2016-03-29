Return-Path: <cygwin-patches-return-8498-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 74236 invoked by alias); 29 Mar 2016 20:50:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 74221 invoked by uid 89); 29 Mar 2016 20:50:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=Foley, foley, HTo:U*cygwin-patches
X-HELO: mail-wm0-f46.google.com
Received: from mail-wm0-f46.google.com (HELO mail-wm0-f46.google.com) (74.125.82.46) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Tue, 29 Mar 2016 20:49:52 +0000
Received: by mail-wm0-f46.google.com with SMTP id r72so73172960wmg.0        for <cygwin-patches@cygwin.com>; Tue, 29 Mar 2016 13:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to:cc;        bh=6f/oUlHDZesWrK9uFIZOwC5czrD8oLr3h2ItgQf5X7I=;        b=MX/hxWgRcnFPevVHsz0wjxa3JfkqDbkYtE9UYQoPFM18HITI9WUCLEJuElLiGvpVJn         ziOH5rIg49Yjve6JXY8SIkwLsSVgjwwzXuaHz9yM45RRVzMMLSM8RnCqYIeMWC1Nel3x         ZKvgYoHXwFDgtSWwMlnnbnqXzICdNRtKqm4rPZWsvniu2Mf2hb+JzJQaUpKvDbS6ha+L         fWkDupyCfIS1q17SBChJgR4Lo/F+O4db9w2Kof2fiHZRSx03wdOL58DtrMqwe7d3xfe5         eTmQ5/Xw+wq9RuBnPxYiF/s5mjKzlVNo6b31mFeEojBGIL1BbcjiADLOpW2RMHG6oY4D         rLqA==
X-Gm-Message-State: AD7BkJIi9P4K+rHq0LeV1M5C52Wq5zc+rz2xZGezBpdWghZjGpiPuhqqn7bIHVx4Yryce2vZnBnaV26HuNPS5Q==
X-Received: by 10.194.174.231 with SMTP id bv7mr4958397wjc.17.1459284589157; Tue, 29 Mar 2016 13:49:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.103.164 with HTTP; Tue, 29 Mar 2016 13:49:29 -0700 (PDT)
In-Reply-To: <1458409557-13156-6-git-send-email-pefoley2@pefoley.com>
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-6-git-send-email-pefoley2@pefoley.com>
From: Peter Foley <pefoley2@pefoley.com>
Date: Tue, 29 Mar 2016 20:50:00 -0000
Message-ID: <CAOFdcFOVg9eghXwEx0ZKuhx_UTRmmfqonWx5Ss=TepvTPmod7w@mail.gmail.com>
Subject: Re: [PATCH 06/11] Remove always true nonnull check on "this" pointer.
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00204.txt.bz2

On Sat, Mar 19, 2016 at 1:45 PM, Peter Foley <pefoley2@pefoley.com> wrote:
> G++ 6.0 can assert that the this pointer is non-null for member functions.
>
> winsup/cygserver/ChangeLog
> process.cc (submission_loop::request_loop): Remove nonnull check on this.
> process.cc (sync_wait_array): Ditto.
> process.cc (check_and_remove_process): Ditto.
> threaded_queue.cc (add_submission_loop): Ditto.
> threaded_queue.cc (add): Ditto.
> threaded_queue.cc (start): Ditto.
> threaded_queue.cc (stop): Ditto.
>
> winsup/cygwin/ChangeLog
> fhandler_dsp.cc (Audio_out::buf_info): Remove nonnull check on this.
> fhandler_dsp.cc (Audio_in::buf_info): Ditto.
> path.cc (fcwd_access_t::Free): Ditto.
> pinfo.cc (_pinfo::exists): Ditto.
> pinfo.cc (_pinfo::commune_request): Ditto.
> pinfo.cc (_pinfo::pipe_fhandler): Ditto.
> pinfo.cc (_pinfo::fd): Ditto.
> pinfo.cc (_pinfo::fds): Ditto.
> pinfo.cc (_pinfo::root): Ditto.
> pinfo.cc (_pinfo::cwd): Ditto.
> pinfo.cc (_pinfo::cmdline): Ditto.
> signal.cc (_pinfo::kill): Ditto.
>
> Signed-off-by: Peter Foley <pefoley2@pefoley.com>
> ---
>  winsup/cygserver/process.cc        |  3 ---
>  winsup/cygserver/threaded_queue.cc |  4 ----
>  winsup/cygwin/fhandler_dsp.cc      |  4 ++--
>  winsup/cygwin/path.cc              |  2 +-
>  winsup/cygwin/pinfo.cc             | 16 ++++++++--------
>  winsup/cygwin/signal.cc            |  2 +-
>  6 files changed, 12 insertions(+), 19 deletions(-)

I got the copyright assignment form back, so this can now be reviewed
and hopefully merged.

Thanks,

Peter Foley
