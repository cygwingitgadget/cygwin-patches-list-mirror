Return-Path: <cygwin-patches-return-3672-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15730 invoked by alias); 6 Mar 2003 23:35:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15720 invoked from network); 6 Mar 2003 23:35:43 -0000
Message-ID: <3E67DBA2.2020002@yahoo.com>
Date: Thu, 06 Mar 2003 23:35:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To:  cygwin-patches@cygwin.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris January <chris@atomice.net>
CC: "Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
Subject: Re: PATCH: Implements /proc/cpuinfo and /proc/partitions
References: <LPEHIHGCJOAIPFLADJAHMEFADGAA.chris@atomice.net>
In-Reply-To: <LPEHIHGCJOAIPFLADJAHMEFADGAA.chris@atomice.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q1/txt/msg00321.txt.bz2

Chris January wrote:
> 
> 2003-03-06  Christopher January  <chris@atomice.net>
> 
> 	* include/winbase.h (FindFirstVolume): Add declaration.
> 	(FindNextVolume): Add declaration.
> 	(FindVolumeClose): Add declaration.
> 	(GetSystemTimes): Add declaration.
> 	* include/winnt.h: Add define for PF_XMMI64_INSTRUCTIONS_AVAILABLE.
> 

Do you plan to use these API?  You'll need to supply a corresponding 
patch to the appropriate .def file in the lib directory.

Earnie.
