Return-Path: <cygwin-patches-return-7945-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4812 invoked by alias); 21 Jan 2014 00:30:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 4796 invoked by uid 89); 21 Jan 2014 00:30:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.4 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-qe0-f41.google.com
Received: from mail-qe0-f41.google.com (HELO mail-qe0-f41.google.com) (209.85.128.41) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Tue, 21 Jan 2014 00:30:56 +0000
Received: by mail-qe0-f41.google.com with SMTP id gc15so3727932qeb.14        for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2014 16:30:54 -0800 (PST)
X-Received: by 10.229.220.3 with SMTP id hw3mr32665129qcb.19.1390264254214;        Mon, 20 Jan 2014 16:30:54 -0800 (PST)
Received: from [192.168.1.85] (99-94-174-195.lightspeed.gnbonc.sbcglobal.net. [99.94.174.195])        by mx.google.com with ESMTPSA id j7sm3858521qas.13.2014.01.20.16.30.52        for <cygwin-patches@cygwin.com>        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);        Mon, 20 Jan 2014 16:30:53 -0800 (PST)
Message-ID: <52DDBFBE.2010800@gmail.com>
Date: Tue, 21 Jan 2014 00:30:00 -0000
From: Max Polk <maxpolk@gmail.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix parameter passing containing quote/equal to Windows batch command
References: <CABDpyCh3VMDmd4Rb64Fz-cb2HzUwtZ0cY9T3xWUC8_O-eqKO6Q@mail.gmail.com>
In-Reply-To: <CABDpyCh3VMDmd4Rb64Fz-cb2HzUwtZ0cY9T3xWUC8_O-eqKO6Q@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2014-q1/txt/msg00018.txt.bz2

On 1/20/2014 1:02 AM, Daniel Dai wrote:
> We notice one issue when running a Windows batch command inside
> cygwin. Here is one example.
>
> Simple batch file:
> a.bat:
> echo %1
>
> Run it under cygwin:
> ./a.bat a=b
> a
>
> ./a.bat "a=b"
> a
>
> If we pass additional \"
> ./a.bat "\"a=b\""
> "\"a
>
> There seems no way to pass a=b into bat.

This is how batch files work, and likely not a problem with Cygwin:
http://support.microsoft.com/kb/35938
Excerpt: "it is not possible to include an equal sign as an argument to 
a batch file"

Be careful to note that cmd.exe and .bat files naturally split a=b into 
two arguments and strip out the equals sign:

(Run from cmd.exe)
C:\>Argecho.bat a=b
FIRST a
SECOND b
THIRD

I did notice that adding double quotes (in cmd.exe) will make will it 
arrive as one argument, and note that the double quotes are still there:

(Run from cmd.exe)
C:\>Argecho.bat "a=b"
FIRST "a=b"
SECOND
THIRD

There is a problem getting Cygwin the above test case, however.

The test script was:
C:\>type Argecho.bat
@echo off
echo FIRST %1
echo SECOND %2
echo THIRD %3

When run from Cygwin bash, and you force the double quotes by 
surrounding double quotes "a=b" with single quotes '"a=b"', you seem to 
get too *many* quotes in the batch file:

(Run from bash, the batch file behaves correctly as if run from cmd.exe)
$ Argecho.bat a=b
FIRST a
SECOND b
THIRD

(Run from bash, same as above since bash removes the double quotes prior 
to passing to program):
$ Argecho.bat "a=b"
FIRST a
SECOND b
THIRD

(Run from bash, this is what is surprising double surrounded with single)
$ Argecho.bat '"a=b"'
FIRST "\"a
SECOND b\""
THIRD

It seems that only the final test case above doesn't behave as expected.
