Return-Path: <cygwin-patches-return-3674-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21681 invoked by alias); 6 Mar 2003 23:53:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21662 invoked from network); 6 Mar 2003 23:53:17 -0000
Message-ID: <000e01c2e43b$8cc94800$78d96f83@pomello>
From: "Max Bowsher" <maxb@ukf.net>
To: "Chris January" <chris@atomice.net>,
	<cygwin-patches@cygwin.com>
References: <LPEHIHGCJOAIPFLADJAHGEFCDGAA.chris@atomice.net>
Subject: Re: PATCH: Implements /proc/cpuinfo and /proc/partitions
Date: Thu, 06 Mar 2003 23:53:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2003-q1/txt/msg00323.txt.bz2

Chris January wrote:
>> Chris January wrote:
>>>
>>> 2003-03-06  Christopher January  <chris@atomice.net>
>>>
>>> * include/winbase.h (FindFirstVolume): Add declaration.
>>> (FindNextVolume): Add declaration.
>>> (FindVolumeClose): Add declaration.
>>> (GetSystemTimes): Add declaration.
>>> * include/winnt.h: Add define for PF_XMMI64_INSTRUCTIONS_AVAILABLE.
>>>
>>
>> Do you plan to use these API?  You'll need to supply a corresponding
>> patch to the appropriate .def file in the lib directory.
>
> The Cygwin DLL uses autoload.cc to load its functions so it works
> without the .def entries. Of the above I only use GetSystemTimes
> anyway. Do you want the .def entries for completeness then? I was
> really providing a patch against Cygwin, not w32api. I'm not really
> up to speed on what's necessary for a w32api patch.

Think about user programs wanting to use those APIs. They *will* need
entries in the .def file.

Max.
