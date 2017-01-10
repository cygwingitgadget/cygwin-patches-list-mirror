Return-Path: <cygwin-patches-return-8680-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 36934 invoked by alias); 10 Jan 2017 16:54:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 36350 invoked by uid 89); 10 Jan 2017 16:54:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.4 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_PASS,URIBL_BLACK autolearn=no version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, you!
X-HELO: mail-ua0-f193.google.com
Received: from mail-ua0-f193.google.com (HELO mail-ua0-f193.google.com) (209.85.217.193) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 10 Jan 2017 16:54:48 +0000
Received: by mail-ua0-f193.google.com with SMTP id i68so53086293uad.1        for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2017 08:54:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=kS9rIn8E7S+RIqIR52hrwbT7c21rivqKSdh/v78Z9LY=;        b=Mhn2ntn4o+I5Nj/I0ZgfkBn6l/0ovaVx0gfjSLGS8O43j5lOu7vlFssSa6kCOjSRwC         4qF02qstWLXxk5PApsgTU+W9iun53W9xF3obuWnktQ4D/cc4SIVEESb1Wq4B4mxnJLys         xZRdYUwZZeerCfm5GDrsz5ASpH4ADwFAz+wwGwdBRqKuUN1BmujafRKsRJmcx1NxZLON         /9GkGVgdONWmS9oaFHVFh+tniTb/p3xt9WUL//uG78fhpsNDkvcP7wkn2HUpwwm1cd95         +y4g5SLwpGd616iJ2En1fWFr9A/6TQhS6PM+7wfUmnEWuUDAWRWdbgEuUwgyDN56rIPQ         rhJA==
X-Gm-Message-State: AIkVDXLy0w3NvSB+Rpm59+uZAp2afm+hRIYBY/hriijB4W/epm/DSiYIq3b1o3oQ2t9mnV27LdRqixWFmrwuyQ==
X-Received: by 10.159.32.195 with SMTP id 61mr2090199uaa.147.1484067286234; Tue, 10 Jan 2017 08:54:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.133.147 with HTTP; Tue, 10 Jan 2017 08:54:45 -0800 (PST)
In-Reply-To: <20170110154123.GA24502@calimero.vinschen.de>
References: <20170110150209.87028-1-erik.m.bray@gmail.com> <20170110154123.GA24502@calimero.vinschen.de>
From: Erik Bray <erik.m.bray@gmail.com>
Date: Tue, 10 Jan 2017 16:54:00 -0000
Message-ID: <CAOTD34aRithGYc4rgnG60Ndvy7fqc0RbroqWoDgi1ZziNcpEkg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Updated patches for /proc/<pid>/environ
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2017-q1/txt/msg00021.txt.bz2

On Tue, Jan 10, 2017 at 4:41 PM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> On Jan 10 16:02, Erik Bray wrote:
>> From: "Erik M. Bray" <erik.bray@lri.fr>
>>
>> Updated versions of the patch set originally submitted at
>> https://cygwin.com/ml/cygwin-patches/2017-q1/msg00000.html
>>
>> I think all the indentation/whitespace/braces are cleaned up and consistent.
>>
>> I've also made sure that /proc/self/environ works now.
>>
>> All new code in these patches is licensed under the 2-clause BSD:
>> [...]
>
> You don't have to repeat that for any later patch you'd like to propose,
> I added you to the CONTRIBUTORS file now.  Thank you!

Great!

>> ===============================================================================
>>
>> Erik M. Bray (3):
>>   Move the core environment parsing of environ_init into a new
>>     win32env_to_cygenv function.
>>   Add a _pinfo.environ() method analogous to _pinfo.cmdline(), and
>>     others.
>>   Add a /proc/<pid>/environ proc file handler, analogous to
>>     /proc/<pid>/cmdline.
>>
>>  winsup/cygwin/environ.cc          | 84 +++++++++++++++++++++++----------------
>>  winsup/cygwin/environ.h           |  2 +
>>  winsup/cygwin/fhandler_process.cc | 22 ++++++++++
>>  winsup/cygwin/pinfo.cc            | 83 +++++++++++++++++++++++++++++++++++++-
>>  winsup/cygwin/pinfo.h             |  4 +-
>>  5 files changed, 157 insertions(+), 38 deletions(-)
>
> Patchset applied.  The formatting in pinfo.cc was still not entirely
> correct, but I tweaked it manually.  Please have a look into commit
> 171046d.

Ah, I see now.  I think what happened is that in my vim it *does* look
properly aligned, but I haven't changed my settings the way you
suggested yet.  Part of the problem is still the mixing of tabs and
spaces (even within that function), and I have ts=4, sw=4 so to me it
looked aligned.

Thanks for fixing it, and for accepting the patches!

Erik
