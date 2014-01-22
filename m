Return-Path: <cygwin-patches-return-7949-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32661 invoked by alias); 22 Jan 2014 01:15:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 32648 invoked by uid 89); 22 Jan 2014 01:15:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.5 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-qc0-f181.google.com
Received: from mail-qc0-f181.google.com (HELO mail-qc0-f181.google.com) (209.85.216.181) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Wed, 22 Jan 2014 01:15:13 +0000
Received: by mail-qc0-f181.google.com with SMTP id e9so7904051qcy.40        for <cygwin-patches@cygwin.com>; Tue, 21 Jan 2014 17:15:11 -0800 (PST)
X-Received: by 10.224.26.15 with SMTP id b15mr42122826qac.46.1390353311047;        Tue, 21 Jan 2014 17:15:11 -0800 (PST)
Received: from [192.168.1.85] (99-94-174-195.lightspeed.gnbonc.sbcglobal.net. [99.94.174.195])        by mx.google.com with ESMTPSA id o75sm3917183qgd.11.2014.01.21.17.15.09        for <cygwin-patches@cygwin.com>        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);        Tue, 21 Jan 2014 17:15:10 -0800 (PST)
Message-ID: <52DF1B9F.5070002@gmail.com>
Date: Wed, 22 Jan 2014 01:15:00 -0000
From: Max Polk <maxpolk@gmail.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix parameter passing containing quote/equal to Windows batch command
References: <CABDpyCh3VMDmd4Rb64Fz-cb2HzUwtZ0cY9T3xWUC8_O-eqKO6Q@mail.gmail.com>	<52DDBFBE.2010800@gmail.com> <CABDpyChNbxjLZdHZBY_Fbq01pQM8wM5Cgmm4DcZiu7xOp=bu7Q@mail.gmail.com>
In-Reply-To: <CABDpyChNbxjLZdHZBY_Fbq01pQM8wM5Cgmm4DcZiu7xOp=bu7Q@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2014-q1/txt/msg00022.txt.bz2

On 1/21/2014 4:27 AM, Daniel Dai wrote:
> Max,
> Thanks for your reply.
>
> Yes, the double quote issue can be reproducible from command line, but
> not the equal sign.
>
> Let's demonstrate the equal sign issue with a C program:
>
> #include "unistd.h"
>
> int main(int argc, char** argv) {
>      execl("a.bat", "a.bat", "a=b");
>      return 0;
> }
>
> The intention of the program is to pass "a=b" as a single argument.
> However, compile and run it under cygwin, I get:
> $ cc -o myprog myprog.c
> $ ./myprog
> a
>
> I run the program with Visual Studio, I get "a=b".
>
> The way Windows/Unix handles parameter containing equal sign is
> different. IMHO, Cygwin should be the place to fill this semantic gap.

In Visual Studio, you don't get "a=b", you get the same results, a and b 
are separate arguments.

(Run from cmd.exe window)
C:\path>BatchTest.exe

C:\path>FIRST a
SECOND b
THIRD

(Run from bash.exe)
$ BatchTest.exe
$ FIRST a
SECOND b
THIRD

Source code to Visual Studio project:

#include "stdafx.h"
#include <process.h>

int _tmain(int argc, _TCHAR* argv[])
{
     _execl ("Argecho.bat", "Argecho.bat", "a=b", NULL);
}

Script for Argecho.bat:

@echo off
echo FIRST %1
echo SECOND %2
echo THIRD %3

Cygwin looks consistent with both Visual Studio compiled app calling a 
batch file and the command line calling the batch file.  It looks the 
same both ways.
