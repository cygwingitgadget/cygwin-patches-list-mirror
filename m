Return-Path: <cygwin-patches-return-8238-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 45024 invoked by alias); 17 Aug 2015 08:21:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 45013 invoked by uid 89); 17 Aug 2015 08:21:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.1 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-wi0-f170.google.com
Received: from mail-wi0-f170.google.com (HELO mail-wi0-f170.google.com) (209.85.212.170) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 17 Aug 2015 08:21:54 +0000
Received: by wicne3 with SMTP id ne3so68100384wic.1        for <cygwin-patches@cygwin.com>; Mon, 17 Aug 2015 01:21:51 -0700 (PDT)
MIME-Version: 1.0
X-Received: by 10.180.108.175 with SMTP id hl15mr31597265wib.1.1439799711749; Mon, 17 Aug 2015 01:21:51 -0700 (PDT)
Received: by 10.28.51.80 with HTTP; Mon, 17 Aug 2015 01:21:51 -0700 (PDT)
In-Reply-To: <20150817081508.GG25127@calimero.vinschen.de>
References: <CAGHpTBLBua-DJQ1tBapYd_6ypdWGMW+ehAq4r7k_TA44Tn_Oxg@mail.gmail.com>	<20150817075954.GB25127@calimero.vinschen.de>	<CAGHpTBJaZmtKq_NvXgjVEz9QLv6siK9CdHBK+FXAn0Pb1iMfBw@mail.gmail.com>	<20150817081508.GG25127@calimero.vinschen.de>
Date: Mon, 17 Aug 2015 08:21:00 -0000
Message-ID: <CAGHpTBKF_VfGRBxg2J1W=zamF-meYxTgRbGvoa-3i5BN3hb1OQ@mail.gmail.com>
Subject: Re: [PATCH] mkglobals: Fix EOL detection
From: Orgad Shaneh <orgads@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2015-q3/txt/msg00020.txt.bz2

On Mon, Aug 17, 2015 at 11:15 AM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> On Aug 17 11:02, Orgad Shaneh wrote:
>> On Mon, Aug 17, 2015 at 10:59 AM, Corinna Vinschen
>> <corinna-cygwin@cygwin.com> wrote:
>> > On Aug 17 10:41, Orgad Shaneh wrote:
>> >> When globals.cc has CRLF line endings, winsup.h is not removed, and
>> >> compilation fails for duplicate definitions.
>> >
>> > Why on earth should globals.h get CRLF line endings?  It's stored
>> > with LF line endings in git.  There's no reason to convert the file.
>>
>> globals.h is generated, I guess you refer to globals.cc.
>>
>> Well, git has a setting named core.autocrlf which converts
>> line-endings to CRLF on Windows.
>>
>> This is very commonly used with msysGit and Git for Windows.
>>
>> If the cygwin repository is cloned with autocrlf set, then all the
>> source files will have CRLF line endings, including globals.cc...
>
> You should set core.autocrlf to no in Cygwin's local git config.

Well, I don't see that in the FAQ[1].

Is there a reason *not* to accept this patch? It's merely reordering
substitutions...

- Orgad

[1] https://cygwin.com/faq/faq.html#faq.programming.building-cygwin
