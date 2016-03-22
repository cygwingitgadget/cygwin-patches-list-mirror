Return-Path: <cygwin-patches-return-8484-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 59042 invoked by alias); 22 Mar 2016 04:04:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 59024 invoked by uid 89); 22 Mar 2016 04:04:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-ob0-f196.google.com
Received: from mail-ob0-f196.google.com (HELO mail-ob0-f196.google.com) (209.85.214.196) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Tue, 22 Mar 2016 04:04:02 +0000
Received: by mail-ob0-f196.google.com with SMTP id cf7so16399427obc.3        for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 21:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=rIq1xD7zAtIuk7/pQ82XU5NrAaytdMHwLXsdV52TqZ4=;        b=FnO843qtpt8ygGrST1pTqMbcpRCXFRq9cSYKOe85Gtfs+pQm17Sy4teHnn1Y4pBYlH         Z+/U5dmfKRPRsX0LbGDeqG/cxOfr/R4PrDh1Snha6t8/CYSCD6fB8pC4CeRgoOYl+hCu         OgJNkHchfMksKzjchPp8Bubw3TpCYQth48YHz2ayRHMB5LzLyk5/cHgEIBOhygFckD9R         3kiZRg0gAmHeNt8rZvXkrm0jQA6eW0YSQSo+Gv19R2+hnukCvTlGX0snrn6r3vD5JxS+         sEvMt+d4iHENJK1SKc1tH/fNV/F23jBUnOQY6WsBzeCCgHIuuETsW3iT+noevcAvXIrz         Beag==
X-Gm-Message-State: AD7BkJJkVV8ik2p9J0a0Ozripvgw9Khbhk1BK1OfmwJwWQQrIgeGLJjX01eVkO5iZpYa42waoLQaoavR1pNugQ==
X-Received: by 10.60.117.102 with SMTP id kd6mr19270498oeb.73.1458619440083; Mon, 21 Mar 2016 21:04:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.86.194 with HTTP; Mon, 21 Mar 2016 21:03:40 -0700 (PDT)
In-Reply-To: <56F0A4A9.7050305@cygwin.com>
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <1458580546-14484-4-git-send-email-pefoley2@pefoley.com> <20160321193052.GG14892@calimero.vinschen.de> <CAOFdcFM-9XOAEPhSWbED_eiECu-UeWW2FBkg-u8jo40+0FwAjA@mail.gmail.com> <20160321195845.GL14892@calimero.vinschen.de> <CAOFdcFMJon17kNFhOVBccrrUJH0PmD6Vsf75FO9QTAv+qf_d0A@mail.gmail.com> <56F0A4A9.7050305@cygwin.com>
From: Peter Foley <pefoley2@pefoley.com>
Date: Tue, 22 Mar 2016 04:04:00 -0000
Message-ID: <CAOFdcFNm1-de-nTGzLeqnGg__PYnUmgTdzkODANictMzvHBQxQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] Don't build utils/lsaauth when cross compiling.
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00190.txt.bz2

On Mon, Mar 21, 2016 at 9:49 PM, Yaakov Selkowitz <yselkowitz@cygwin.com> wrote:
> I really don't see the point of this.  I maintain the pseudo-official cross
> toolchains for Cygwin, and I just remove what is not needed for
> cross-compiling from the DESTDIR after install.  This is also a fairly
> common step when building library packages for cross-compiler toolchains.

The point is to allow building a cross-compiler without a hard
dependency on a existing
mingw cross toolchain.
Without this patch, you cannot successfully compile a cross cygwin
toolchain without a working
mingw cross-compiler.
I'll have a re-worked version at some point that is hopefully more acceptable.

Thanks,

Peter
