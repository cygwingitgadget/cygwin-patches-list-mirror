Return-Path: <cygwin-patches-return-7947-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5018 invoked by alias); 21 Jan 2014 12:31:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 5001 invoked by uid 89); 21 Jan 2014 12:31:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.4 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-la0-f54.google.com
Received: from mail-la0-f54.google.com (HELO mail-la0-f54.google.com) (209.85.215.54) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Tue, 21 Jan 2014 12:31:29 +0000
Received: by mail-la0-f54.google.com with SMTP id y1so6643138lam.27        for <cygwin-patches@cygwin.com>; Tue, 21 Jan 2014 04:31:25 -0800 (PST)
MIME-Version: 1.0
X-Received: by 10.112.141.225 with SMTP id rr1mr189764lbb.59.1390307485618; Tue, 21 Jan 2014 04:31:25 -0800 (PST)
Received: by 10.115.2.2 with HTTP; Tue, 21 Jan 2014 04:31:25 -0800 (PST)
In-Reply-To: <52DDBFBE.2010800@gmail.com>
References: <CABDpyCh3VMDmd4Rb64Fz-cb2HzUwtZ0cY9T3xWUC8_O-eqKO6Q@mail.gmail.com>	<52DDBFBE.2010800@gmail.com>
Date: Tue, 21 Jan 2014 12:31:00 -0000
Message-ID: <CAKw7uVh_=cs56dT7njMqpLAePyEMpbQQ6Fw1bmenQ-5t-QeK5w@mail.gmail.com>
Subject: Re: [PATCH] Fix parameter passing containing quote/equal to Windows batch command
From: =?UTF-8?Q?V=C3=A1clav_Zeman?= <vhaisman@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2014-q1/txt/msg00020.txt.bz2

On 21 January 2014 01:30, Max Polk wrote:
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

Beware! The way CMD.exe handles command line and parameters is
different/incompatible from the way C (MSVCRT) application handles
them. Do not confuse the two. You cannot prove/show anything about how
C application handles arguments by using CMD.exe as a show case.

-- 
VZ
