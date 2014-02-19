Return-Path: <cygwin-patches-return-7971-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14897 invoked by alias); 19 Feb 2014 17:53:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 14882 invoked by uid 89); 19 Feb 2014 17:53:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.5 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-wi0-f175.google.com
Received: from mail-wi0-f175.google.com (HELO mail-wi0-f175.google.com) (209.85.212.175) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Wed, 19 Feb 2014 17:53:31 +0000
Received: by mail-wi0-f175.google.com with SMTP id hm4so4991807wib.8        for <cygwin-patches@cygwin.com>; Wed, 19 Feb 2014 09:53:28 -0800 (PST)
MIME-Version: 1.0
X-Received: by 10.194.71.47 with SMTP id r15mr29896851wju.19.1392832408357; Wed, 19 Feb 2014 09:53:28 -0800 (PST)
Received: by 10.227.206.2 with HTTP; Wed, 19 Feb 2014 09:53:28 -0800 (PST)
In-Reply-To: <20140209203308.GA5453@ednor.casa.cgf.cx>
References: <1391905541-986-1-git-send-email-mingw.android@gmail.com>	<20140209203308.GA5453@ednor.casa.cgf.cx>
Date: Wed, 19 Feb 2014 17:53:00 -0000
Message-ID: <CAOYw7dsc42S=0FMUZPoY5apQDft6g71WwZ0ZFLKfzO_C2EwFAA@mail.gmail.com>
Subject: Re: [PATCH] Expand $CYGWIN error_start processing
From: Ray Donnelly <mingw.android@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=ISO-8859-1
X-IsSubscribed: yes
X-SW-Source: 2014-q1/txt/msg00044.txt.bz2

What about the token side of things? <program-name> and <process-id>?
For my use case, its important that I can do something like that too.

On Sun, Feb 9, 2014 at 8:33 PM, Christopher Faylor <> wrote:
> On Sun, Feb 09, 2014 at 12:25:40AM +0000, Ray Donnelly wrote:
>>I want to use QtCreator as my debugger but the hardcoded
>>nature of error_start makes that impossible.
>>
>>This change allows a formatted commandline to be used where
>>'|' is used to represent spaces and <program-name> and
>><process-id> are special tokens.
>>
>>In my case, I set my CYGWIN env. var to
>>error_start:C:/Qt/bin/qtcreator.exe|-debug|<process-id>
>>
>>.. note, QtCreator doesn't work if passed the program name
>>and must be invoked with the -debug option.
>>
>>Ray Donnelly (1):
>>  * winsup/cygwin/exceptions.cc: Expand $CYGWIN error_start
>>    processing so that custom commandlines can be passed to
>>    the debugger program using '|' as an argument delimiter
>>    and <program-name> and <process-id> as special tokens.
>>
>> winsup/cygwin/exceptions.cc | 50 +++++++++++++++++++++++++++++++++++++++++----
>> 1 file changed, 46 insertions(+), 4 deletions(-)
>
> Thanks for the patch but adding a new argument delimiter or way to quote
> is not something that I'm too keen on.

I didn't add a new way to quote (not that any way existed before), just
a substitute argument delimiter using '|'. It's difficult to get double
quotes and spaces into env. vars, so I worked around that
difficulty in what I think is a sensible way.

>
> I have just added, in CVS, the ability to do this:
>
> set CYGWIN=error_start="blah whatever \"more stuff'" and more"
>

Great, but what about <program-name> and <process-id>, that is the substantial
part of the patch. I can't hook up QtCreator with the fixed arguments that are
added currently, QtCreator doesn't care for the program-name and only works if
presented with <-debug process-id>

> (The above is CMD quoting style of course)
>
> cgf
