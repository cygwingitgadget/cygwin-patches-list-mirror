Return-Path: <cygwin-patches-return-7950-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19558 invoked by alias); 22 Jan 2014 07:11:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 19544 invoked by uid 89); 22 Jan 2014 07:11:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-lb0-f182.google.com
Received: from mail-lb0-f182.google.com (HELO mail-lb0-f182.google.com) (209.85.217.182) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Wed, 22 Jan 2014 07:11:56 +0000
Received: by mail-lb0-f182.google.com with SMTP id w7so1410lbi.27        for <cygwin-patches@cygwin.com>; Tue, 21 Jan 2014 23:11:52 -0800 (PST)
MIME-Version: 1.0
X-Received: by 10.112.64.166 with SMTP id p6mr5316lbs.10.1390374712780; Tue, 21 Jan 2014 23:11:52 -0800 (PST)
Received: by 10.112.167.35 with HTTP; Tue, 21 Jan 2014 23:11:52 -0800 (PST)
In-Reply-To: <52DF1B9F.5070002@gmail.com>
References: <CABDpyCh3VMDmd4Rb64Fz-cb2HzUwtZ0cY9T3xWUC8_O-eqKO6Q@mail.gmail.com>	<52DDBFBE.2010800@gmail.com>	<CABDpyChNbxjLZdHZBY_Fbq01pQM8wM5Cgmm4DcZiu7xOp=bu7Q@mail.gmail.com>	<52DF1B9F.5070002@gmail.com>
Date: Wed, 22 Jan 2014 07:11:00 -0000
Message-ID: <CABDpyChf5uEgBTX_1vSE_zu7bMiaxKXOhtbzZzTkW6J-OXNN+g@mail.gmail.com>
Subject: Re: [PATCH] Fix parameter passing containing quote/equal to Windows batch command
From: Daniel Dai <daijyc@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=ISO-8859-1
X-IsSubscribed: yes
X-SW-Source: 2014-q1/txt/msg00023.txt.bz2

Max,
Yes, you are right. I did a "echo %*" mistakenly in my bat script on Windows.

In terms of consistency, this one does makes a difference (parameter
contains space):

int main(int argc, char** argv) {
    execl("a.bat", "a.bat", "a b");
    return 0;
}

On cygwin, $1=="a b", on Windows however, I get %1==a. Cygwin quote
the parameters containing space automatically.

Anyway, I am not bothered by inconsistent behavior between
Windows/Cygwin. What I really care about is fixing the quote issue,
otherwise I have no way to pass parameter with equal sign to bat.

Thanks,
Daniel



On Tue, Jan 21, 2014 at 5:15 PM, Max Polk <maxpolk@gmail.com> wrote:
> On 1/21/2014 4:27 AM, Daniel Dai wrote:
>>
>> Max,
>> Thanks for your reply.
>>
>> Yes, the double quote issue can be reproducible from command line, but
>> not the equal sign.
>>
>> Let's demonstrate the equal sign issue with a C program:
>>
>> #include "unistd.h"
>>
>> int main(int argc, char** argv) {
>>      execl("a.bat", "a.bat", "a=b");
>>      return 0;
>> }
>>
>> The intention of the program is to pass "a=b" as a single argument.
>> However, compile and run it under cygwin, I get:
>> $ cc -o myprog myprog.c
>> $ ./myprog
>> a
>>
>> I run the program with Visual Studio, I get "a=b".
>>
>> The way Windows/Unix handles parameter containing equal sign is
>> different. IMHO, Cygwin should be the place to fill this semantic gap.
>
>
> In Visual Studio, you don't get "a=b", you get the same results, a and b are
> separate arguments.
>
> (Run from cmd.exe window)
> C:\path>BatchTest.exe
>
> C:\path>FIRST a
> SECOND b
> THIRD
>
> (Run from bash.exe)
> $ BatchTest.exe
> $ FIRST a
> SECOND b
> THIRD
>
> Source code to Visual Studio project:
>
> #include "stdafx.h"
> #include <process.h>
>
> int _tmain(int argc, _TCHAR* argv[])
> {
>     _execl ("Argecho.bat", "Argecho.bat", "a=b", NULL);
> }
>
> Script for Argecho.bat:
>
>
> @echo off
> echo FIRST %1
> echo SECOND %2
> echo THIRD %3
>
> Cygwin looks consistent with both Visual Studio compiled app calling a batch
> file and the command line calling the batch file.  It looks the same both
> ways.
>
