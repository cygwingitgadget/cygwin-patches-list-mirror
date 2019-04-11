Return-Path: <cygwin-patches-return-9325-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32228 invoked by alias); 11 Apr 2019 12:59:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 31332 invoked by uid 89); 11 Apr 2019 12:59:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=you!
X-HELO: mail-it1-f195.google.com
Received: from mail-it1-f195.google.com (HELO mail-it1-f195.google.com) (209.85.166.195) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 11 Apr 2019 12:59:28 +0000
Received: by mail-it1-f195.google.com with SMTP id a190so972724ite.4        for <cygwin-patches@cygwin.com>; Thu, 11 Apr 2019 05:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=gmail.com; s=20161025;        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;        bh=nmffSIGhmVvQC0tnf5Iu0CCGmAeBanmUbvjP1p67klY=;        b=NScPJawuyzvqXx53ylz1py0lM4Y/et+lj/dmc+p+HKMEJ3x4ewNdqduiXWP/u6PzAO         kg9g+d7qRssdgUAgmzdi5vWuYAx61mCivvkp1WeRa2Qgqj7Z/AwcVmbqmjox16xo+8fe         POAqmbrw9MqqT5gKWd0FFTImX5jjBbh0Uz79+vw4sq29rAPlw2jjmxL5RtdYMKYAkkNo         /yt9DhaKNRWFVzsNFg5DPabwMZUtkXBxCuZFQDCcN6hSidWj9ll5OV8ADvSCokbU9Sgt         Bp9NKI1jUknQ16kveZ5Fw/9mU0Ytp5PqRC3ztuZCsx/GWulAjzNvvMGbiDFyM5Sv0PqK         yO6w==
MIME-Version: 1.0
References: <20190410150522.22920-1-erik.m.bray@gmail.com> <20190410205023.GM4248@calimero.vinschen.de>
In-Reply-To: <20190410205023.GM4248@calimero.vinschen.de>
From: "E. Madison Bray" <erik.m.bray@gmail.com>
Date: Thu, 11 Apr 2019 12:59:00 -0000
Message-ID: <CAOTD34Yy0NjZ7yg=DbpQ8tPquzhqcyv2tnE2yMZ7-voXp-ukfA@mail.gmail.com>
Subject: Re: [PATCH] Improve error handling in /proc/[pid]/ virtual files.
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00032.txt.bz2

On Wed, Apr 10, 2019 at 10:50 PM Corinna Vinschen wrote:
>
> On Apr 10 17:05, Erik M. Bray wrote:
> > * Changes error handling to allow /proc/[pid]/ virtual files to be
> >   empty in some cases (in this case the file's formatter should return
> >   -1 upon error, not 0).
> >
> > * Better error handling of /proc/[pid]/stat for zombie processes:
> >   previously trying to open this file on zombie processes resulted
> >   in an EINVAL being returned by open().  Now the file can be read,
> >   and fields that can no longer be read are just zeroed.
> >
> > * Similarly for /proc/[pid]/statm for zombie processes.
> >
> > * Similarly for /proc/[pid]/maps for zombie processes (in this case the
> >   file can be read but is zero-length, which is consistent with observed
> >   behavior on Linux.
>
> Pushed.  New snapshots building right now.

Excellent, thank you!
