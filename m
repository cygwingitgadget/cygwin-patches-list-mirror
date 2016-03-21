Return-Path: <cygwin-patches-return-8466-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 61803 invoked by alias); 21 Mar 2016 19:52:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 61793 invoked by uid 89); 21 Mar 2016 19:52:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-ob0-f193.google.com
Received: from mail-ob0-f193.google.com (HELO mail-ob0-f193.google.com) (209.85.214.193) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 21 Mar 2016 19:52:31 +0000
Received: by mail-ob0-f193.google.com with SMTP id cf7so15651487obc.3        for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 12:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=YWjk9SUHMxNjs1cgESNtpv8l0eqK5AwDL0gllnQwvHo=;        b=cpa2MQm6PuoSQLbHFRsYLvBteVHUlBHW1OR348Ku6IJ/vvPFWzw5Pq+xHJmZtLI1/P         IyrRxyf4sGrslIunfw3qnEOWHqT0be0f4kPFJ3bpl8z3fS5ee4btkhnUMYNf1X85fx8k         XBlBdiRT19BFVC07JPlKCHOs8U29g8hrVsQeb10HDm94FLEzw2s2UQdApHhurloHGdOd         w/N8ElsQoUYHnBjWEbimJ9Yw9vzu4vLljcxEciiioc0e9Dpt+V7Uyelmc/hjBAXlF4mv         MiRrytogM7uC7/CPQvH0tJxQg+mQR6k4vpx+1YxQC9lHC9jGowp9nBUpwE/ZcnIDj6J6         ACpQ==
X-Gm-Message-State: AD7BkJLaCntNJQL3skCbEvrYeljZJkpx2thL+noIszkHbXYRs4zy03SjeTJsi9c0lgdj6PI9bckgtErgVIUW6Q==
X-Received: by 10.182.86.33 with SMTP id m1mr18539959obz.48.1458589949057; Mon, 21 Mar 2016 12:52:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.86.194 with HTTP; Mon, 21 Mar 2016 12:52:09 -0700 (PDT)
In-Reply-To: <20160321193052.GG14892@calimero.vinschen.de>
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <1458580546-14484-4-git-send-email-pefoley2@pefoley.com> <20160321193052.GG14892@calimero.vinschen.de>
From: Peter Foley <pefoley2@pefoley.com>
Date: Mon, 21 Mar 2016 19:52:00 -0000
Message-ID: <CAOFdcFM-9XOAEPhSWbED_eiECu-UeWW2FBkg-u8jo40+0FwAjA@mail.gmail.com>
Subject: Re: [PATCH 4/5] Don't build utils/lsaauth when cross compiling.
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00172.txt.bz2

On Mon, Mar 21, 2016 at 3:30 PM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> I'm not sure this is the right thing to do.  I'm cross compiling
> Cygwin all the time, and I certainly need the mingw compiler to
> build the utils and lsaauth dir.  In what case do you not need them,
> and shouldn't that bordercase(?) be handled by some configure option?

The effect of this change is to not compile anything under the utils
or lsaauth directories when cross compiling.
The idea is that the code under these directories is unnecessary for a
cross toolchain, so if we only build those dirs
when compiling natively, then a mingw toolchain is no longer a
pre-requisite for building a cross Cygwin toolchain.
If there is an instance where you're building a cross toolchain, but
still want the utils, it might make sense to add a
flag, rather then checking $cross_compiling, but I can't think of one
off the top of my head.

Thanks,

Peter
