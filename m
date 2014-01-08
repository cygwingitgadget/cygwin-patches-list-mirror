Return-Path: <cygwin-patches-return-7937-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32067 invoked by alias); 8 Jan 2014 10:49:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 32053 invoked by uid 89); 8 Jan 2014 10:49:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-we0-f173.google.com
Received: from mail-we0-f173.google.com (HELO mail-we0-f173.google.com) (74.125.82.173) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Wed, 08 Jan 2014 10:49:38 +0000
Received: by mail-we0-f173.google.com with SMTP id t60so1270396wes.32        for <cygwin-patches@cygwin.com>; Wed, 08 Jan 2014 02:49:35 -0800 (PST)
MIME-Version: 1.0
X-Received: by 10.180.105.202 with SMTP id go10mr18931304wib.42.1389178175134; Wed, 08 Jan 2014 02:49:35 -0800 (PST)
Received: by 10.227.69.9 with HTTP; Wed, 8 Jan 2014 02:49:35 -0800 (PST)
In-Reply-To: <20140108092000.GB28847@calimero.vinschen.de>
References: <CAOYw7duMgGSfpxa4OtOPRhY5Mw6q=__shhJxELZ53Ez9_WETRQ@mail.gmail.com>	<20140107151249.GI2440@calimero.vinschen.de>	<CAOYw7dsJ5b5NVDowSAuK9F0uRztYhZLMU97G=T8jGECU-vcFVw@mail.gmail.com>	<20140108092000.GB28847@calimero.vinschen.de>
Date: Wed, 08 Jan 2014 10:49:00 -0000
Message-ID: <CAOYw7dsfrz5Y2AT9E7JFVfzdKcLV3da12GEAs6KQJZaP9Jw7DA@mail.gmail.com>
Subject: Re: [PATCH] Reattach trailing dirsep on existing directories too.
From: Ray Donnelly <mingw.android@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=ISO-8859-1
X-IsSubscribed: yes
X-SW-Source: 2014-q1/txt/msg00010.txt.bz2

On Wed, Jan 8, 2014 at 9:20 AM, Corinna Vinschen wrote:
> On Jan  7 18:15, Ray Donnelly wrote:
>> On Tue, Jan 7, 2014 at 3:12 PM, Corinna Vinschen wrote:
>> > On Dec 22 01:03, Ray Donnelly wrote:
>> >> I hope this is OK and I've done it in the best place. Please advise if
>> >> it needs any changes.
>> >
>> > I have no idea if this is ok.  This is a patch to a very crucial
>> > function in terms of path handling, and it's not clear that this isn't
>> > doing the wrong thing.  What is this patch trying to accomplish?  Do you
>> > have example user space code which is failing for this very reason?
>>
>> The exact issue was that paths that do not exist would maintain their
>> final dirsep whereas paths that do exist would lose this dirsep:
>>
>> test.exe /c/doesnt-exist/ /c/does-exist/
>>
>> test.exe would see:
>> arg1: C:/doesnt-exist/
>> arg2: C:/does-exist
>>
>> These paths were passed to GCC as search paths and while I could've
>> hacked up the GCC code to detect and correct this anomaly, but I think
>> this patch fixes the problem at cause.
>
> And that is a problem, because...?

.. because in this case, GCC appends sysroots directly to those
passed-in-as-#define values and I end up with e.g. C:/does-existusr/
and C:/doesnt-exist/usr/, when I always wanted the final /. Of course
I could add some nasty hacks in GCC and any other program that runs
into this odd behavioural quirk to detect and workaround it, but IMHO
fixing the quirk is a better approach.

Someone's gone to the effort to re-attach the dirsep when the folder
doesn't exist so they must have thought that preserving this was a
good idea, I've just fixed a corner case in that so the results are
consistent.
>
>
> Corinna
>
> --
> Corinna Vinschen                  Please, send mails regarding Cygwin to
> Cygwin Maintainer                 cygwin AT cygwin DOT com
> Red Hat
