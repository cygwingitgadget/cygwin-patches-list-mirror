Return-Path: <cygwin-patches-return-7948-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19006 invoked by alias); 21 Jan 2014 20:58:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18992 invoked by uid 89); 21 Jan 2014 20:58:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-lb0-f182.google.com
Received: from mail-lb0-f182.google.com (HELO mail-lb0-f182.google.com) (209.85.217.182) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Tue, 21 Jan 2014 20:58:04 +0000
Received: by mail-lb0-f182.google.com with SMTP id w7so5945512lbi.13        for <cygwin-patches@cygwin.com>; Tue, 21 Jan 2014 12:58:01 -0800 (PST)
MIME-Version: 1.0
X-Received: by 10.152.8.47 with SMTP id o15mr3526640laa.20.1390337881147; Tue, 21 Jan 2014 12:58:01 -0800 (PST)
Received: by 10.112.167.35 with HTTP; Tue, 21 Jan 2014 12:58:01 -0800 (PST)
In-Reply-To: <CAKw7uVh_=cs56dT7njMqpLAePyEMpbQQ6Fw1bmenQ-5t-QeK5w@mail.gmail.com>
References: <CABDpyCh3VMDmd4Rb64Fz-cb2HzUwtZ0cY9T3xWUC8_O-eqKO6Q@mail.gmail.com>	<52DDBFBE.2010800@gmail.com>	<CAKw7uVh_=cs56dT7njMqpLAePyEMpbQQ6Fw1bmenQ-5t-QeK5w@mail.gmail.com>
Date: Tue, 21 Jan 2014 20:58:00 -0000
Message-ID: <CABDpyCgQN2p9xA3kKT45jNGFxp8Q=nGNHb4ycG5WuGJeAdaB2A@mail.gmail.com>
Subject: Re: [PATCH] Fix parameter passing containing quote/equal to Windows batch command
From: Daniel Dai <daijyc@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-IsSubscribed: yes
X-SW-Source: 2014-q1/txt/msg00021.txt.bz2

Thanks V=E1clav!

You are right, I tried on exe file, things works fine on exe, but not
bat file. Seems some cleanup is done before we running into main
function of exe.

So how do we want to fix bat? The rules in my patch seems apply even for ex=
e:
1. if parameter is already quoted, don't quote again
2. if parameter contains equal, quote it

It probably duplicate some logic with exe bootstrap code, but I don't
see any harm.

Another way to fix is to apply the rule only we see a bat file. That
should solve my problem as well.

Thanks,
Daniel





On Tue, Jan 21, 2014 at 4:31 AM, V=E1clav Zeman <vhaisman@gmail.com> wrote:
> On 21 January 2014 01:30, Max Polk wrote:
>> On 1/20/2014 1:02 AM, Daniel Dai wrote:
>>>
>>> We notice one issue when running a Windows batch command inside
>>> cygwin. Here is one example.
>>>
>>> Simple batch file:
>>> a.bat:
>>> echo %1
>>>
>>> Run it under cygwin:
>>> ./a.bat a=3Db
>>> a
>>>
>>> ./a.bat "a=3Db"
>>> a
>>>
>>> If we pass additional \"
>>> ./a.bat "\"a=3Db\""
>>> "\"a
>>>
>>> There seems no way to pass a=3Db into bat.
>>
>>
>> This is how batch files work, and likely not a problem with Cygwin:
>> http://support.microsoft.com/kb/35938
>> Excerpt: "it is not possible to include an equal sign as an argument to a
>> batch file"
>>
>> Be careful to note that cmd.exe and .bat files naturally split a=3Db int=
o two
>> arguments and strip out the equals sign:
>>
>> (Run from cmd.exe)
>> C:\>Argecho.bat a=3Db
>> FIRST a
>> SECOND b
>> THIRD
>>
>> I did notice that adding double quotes (in cmd.exe) will make will it ar=
rive
>> as one argument, and note that the double quotes are still there:
>>
>> (Run from cmd.exe)
>> C:\>Argecho.bat "a=3Db"
>> FIRST "a=3Db"
>> SECOND
>> THIRD
>>
>> There is a problem getting Cygwin the above test case, however.
>>
>> The test script was:
>> C:\>type Argecho.bat
>> @echo off
>> echo FIRST %1
>> echo SECOND %2
>> echo THIRD %3
>>
>> When run from Cygwin bash, and you force the double quotes by surrounding
>> double quotes "a=3Db" with single quotes '"a=3Db"', you seem to get too =
*many*
>> quotes in the batch file:
>>
>> (Run from bash, the batch file behaves correctly as if run from cmd.exe)
>> $ Argecho.bat a=3Db
>> FIRST a
>> SECOND b
>> THIRD
>>
>> (Run from bash, same as above since bash removes the double quotes prior=
 to
>> passing to program):
>> $ Argecho.bat "a=3Db"
>> FIRST a
>> SECOND b
>> THIRD
>>
>> (Run from bash, this is what is surprising double surrounded with single)
>> $ Argecho.bat '"a=3Db"'
>> FIRST "\"a
>> SECOND b\""
>> THIRD
>>
>> It seems that only the final test case above doesn't behave as expected.
>
> Beware! The way CMD.exe handles command line and parameters is
> different/incompatible from the way C (MSVCRT) application handles
> them. Do not confuse the two. You cannot prove/show anything about how
> C application handles arguments by using CMD.exe as a show case.
>
> --
> VZ
