Return-Path: <cygwin-patches-return-2811-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9920 invoked by alias); 8 Aug 2002 18:17:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9903 invoked from network); 8 Aug 2002 18:17:48 -0000
Message-ID: <01be01c23f07$bc24bb40$5592883e@wdg.uk.ibm.com>
From: "Max Bowsher" <maxb@ukf.net>
To: <cygwin-patches@cygwin.com>
References: <3D52ABE4.1010403@hekimian.com> <20020808174811.GE11425@redhat.com>
Subject: Re: patch so strace can be used with C code
Date: Thu, 08 Aug 2002 11:17:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00259.txt.bz2

Christopher Faylor wrote:
> On Thu, Aug 08, 2002 at 01:35:32PM -0400, Joe Buehler wrote:
>> Attached is a patch to allow the strace printf functionality to be
>> used inside C code in Cygwin.  It looks like this might have
>> worked at some point in the past -- the changes were easy.
>>
>> Christopher had objected that it would be better to convert the
>> C files to C++, but this is a lot easier until that is done -- there
>> are several C files still in Cygwin.
>
> http://cygwin.com/ml/cygwin/2002-07/msg00577.html

What about the "must be C because we can't do COM from C++" files (e.g.
winsup/cygwin/shortcut.c)

Max.


