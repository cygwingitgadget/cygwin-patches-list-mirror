Return-Path: <cygwin-patches-return-3760-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15451 invoked by alias); 27 Mar 2003 12:44:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15442 invoked from network); 27 Mar 2003 12:44:56 -0000
Message-ID: <01c501c2f45e$a93d1150$8f6f883e@pomello>
From: "Max Bowsher" <maxb@ukf.net>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>
References: <006701c2f432$c62a5380$fa6d86d9@ellixia> <008401c2f436$eca2f8b0$fa6d86d9@ellixia> <20030327094634.GE23762@cygbert.vinschen.de>
Subject: Re: [PATCH] New '--install-type' option for cygcheck?
Date: Thu, 27 Mar 2003 12:44:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2003-q1/txt/msg00409.txt.bz2

Corinna Vinschen wrote:
> On Thu, Mar 27, 2003 at 08:00:24AM -0000, Elfyn McBratney wrote:
>>> I've been working on a new option for `cygcheck' that checks who Cygwin
>>> was installed for. This could be used when users on the mailing list
>>> have problems running services when the installation was done for "Just
>>> Me", executing files in the same situation etc. Would this be a
>>> desirable feature? Yes/no...patch attached :-)
>>
>> Sorry, forgot this...
>>
>> 2003-03-27  Elfyn McBratney  <elfyn@exposure.org.uk>
>>
>> * utils/cygcheck.cc (longopts): Add install-type option.
>> (opts): Add 'i' install-type option.
>> (check_install_type): New function.
>> (main): Accommodate new install_type option.
>
> Well, the problem is that you're checking in HKLM first.  You should
> check the HKCU key first since this would override the existing same
> key in HKLM.  Probably it would be nice(tm) if cygcheck reports
> always both keys if they both exist and print some warning about this
> (hmm, I'm musing if it makes sense to print a suggestion to drop the
> HKCU key in that case...)
>
> Corinna
>
> PS: Your ChangeLog is incorrect (think "tabs") ;-)

Outlook Express doesn't do tabs.

Unfortunately, I've never found another email client that wasn't either ugly
or buggy or user-unfriendly.

Max.
