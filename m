Return-Path: <cygwin-patches-return-7946-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1338 invoked by alias); 21 Jan 2014 09:27:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 1320 invoked by uid 89); 21 Jan 2014 09:27:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-lb0-f171.google.com
Received: from mail-lb0-f171.google.com (HELO mail-lb0-f171.google.com) (209.85.217.171) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Tue, 21 Jan 2014 09:27:33 +0000
Received: by mail-lb0-f171.google.com with SMTP id c11so5695649lbj.16        for <cygwin-patches@cygwin.com>; Tue, 21 Jan 2014 01:27:29 -0800 (PST)
MIME-Version: 1.0
X-Received: by 10.152.19.133 with SMTP id f5mr169084lae.52.1390296449691; Tue, 21 Jan 2014 01:27:29 -0800 (PST)
Received: by 10.112.167.35 with HTTP; Tue, 21 Jan 2014 01:27:29 -0800 (PST)
In-Reply-To: <52DDBFBE.2010800@gmail.com>
References: <CABDpyCh3VMDmd4Rb64Fz-cb2HzUwtZ0cY9T3xWUC8_O-eqKO6Q@mail.gmail.com>	<52DDBFBE.2010800@gmail.com>
Date: Tue, 21 Jan 2014 09:27:00 -0000
Message-ID: <CABDpyChNbxjLZdHZBY_Fbq01pQM8wM5Cgmm4DcZiu7xOp=bu7Q@mail.gmail.com>
Subject: Re: [PATCH] Fix parameter passing containing quote/equal to Windows batch command
From: Daniel Dai <daijyc@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=ISO-8859-1
X-IsSubscribed: yes
X-SW-Source: 2014-q1/txt/msg00019.txt.bz2

Max,
Thanks for your reply.

Yes, the double quote issue can be reproducible from command line, but
not the equal sign.

Let's demonstrate the equal sign issue with a C program:

#include "unistd.h"

int main(int argc, char** argv) {
    execl("a.bat", "a.bat", "a=b");
    return 0;
}

The intention of the program is to pass "a=b" as a single argument.
However, compile and run it under cygwin, I get:
$ cc -o myprog myprog.c
$ ./myprog
a

I run the program with Visual Studio, I get "a=b".

The way Windows/Unix handles parameter containing equal sign is
different. IMHO, Cygwin should be the place to fill this semantic gap.

Thanks,
Daniel



On Mon, Jan 20, 2014 at 4:30 PM, Max Polk <maxpolk@gmail.com> wrote:
> On 1/20/2014 1:02 AM, Daniel Dai wrote:
>>
>> We notice one issue when running a Windows batch command inside
>> cygwin. Here is one example.
>>
>> Simple batch file:
>> a.bat:
>> echo %1
>>
>> Run it under cygwin:
>> ./a.bat a=b
>> a
>>
>> ./a.bat "a=b"
>> a
>>
>> If we pass additional \"
>> ./a.bat "\"a=b\""
>> "\"a
>>
>> There seems no way to pass a=b into bat.
>
>
> This is how batch files work, and likely not a problem with Cygwin:
> http://support.microsoft.com/kb/35938
> Excerpt: "it is not possible to include an equal sign as an argument to a
> batch file"
>
> Be careful to note that cmd.exe and .bat files naturally split a=b into two
> arguments and strip out the equals sign:
>
> (Run from cmd.exe)
> C:\>Argecho.bat a=b
> FIRST a
> SECOND b
> THIRD
>
> I did notice that adding double quotes (in cmd.exe) will make will it arrive
> as one argument, and note that the double quotes are still there:
>
> (Run from cmd.exe)
> C:\>Argecho.bat "a=b"
> FIRST "a=b"
> SECOND
> THIRD
>
> There is a problem getting Cygwin the above test case, however.
>
> The test script was:
> C:\>type Argecho.bat
> @echo off
> echo FIRST %1
> echo SECOND %2
> echo THIRD %3
>
> When run from Cygwin bash, and you force the double quotes by surrounding
> double quotes "a=b" with single quotes '"a=b"', you seem to get too *many*
> quotes in the batch file:
>
> (Run from bash, the batch file behaves correctly as if run from cmd.exe)
> $ Argecho.bat a=b
> FIRST a
> SECOND b
> THIRD
>
> (Run from bash, same as above since bash removes the double quotes prior to
> passing to program):
> $ Argecho.bat "a=b"
> FIRST a
> SECOND b
> THIRD
>
> (Run from bash, this is what is surprising double surrounded with single)
> $ Argecho.bat '"a=b"'
> FIRST "\"a
> SECOND b\""
> THIRD
>
> It seems that only the final test case above doesn't behave as expected.
