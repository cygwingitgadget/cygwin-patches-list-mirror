Return-Path: <cygwin-patches-return-7958-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27245 invoked by alias); 7 Feb 2014 17:14:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 27141 invoked by uid 89); 7 Feb 2014 17:14:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.5 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2
X-HELO: dancol.org
Received: from dancol.org (HELO dancol.org) (96.126.100.184) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Fri, 07 Feb 2014 17:14:03 +0000
Received: from [8.22.9.108] (helo=[192.168.10.30])	by dancol.org with esmtpsa (TLS1.0:DHE_RSA_CAMELLIA_256_CBC_SHA1:256)	(Exim 4.82)	(envelope-from <dancol@dancol.org>)	id 1WBp05-0002EY-Pz	for cygwin-patches@cygwin.com; Fri, 07 Feb 2014 09:14:02 -0800
Message-ID: <52F51450.7010601@dancol.org>
Date: Fri, 07 Feb 2014 17:14:00 -0000
From: Daniel Colascione <dancol@dancol.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add minidump write utility
References: <52F50B71.8030608@dronecode.org.uk>
In-Reply-To: <52F50B71.8030608@dronecode.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2014-q1/txt/msg00031.txt.bz2

May I recommend setting MiniDumpWithHandleData | 
MiniDumpWithFullMemoryInfo | MiniDumpWithThreadInfo | 
MiniDumpWithFullAuxiliaryState | MiniDumpIgnoreInaccessibleMemory | 
MiniDumpWithTokenInformation | MiniDumpWithModuleHeaders | 
MiniDumpWithIndirectlyReferencedMemory by default?

On 02/07/2014 08:36 AM, Jon TURNEY wrote:
>
> This patch adds a 'minidumper' utility, which functions identically to
> 'dumper' except it writes a Windows minidump, rather than a core file.
> 	
> I'm not sure if this is of use to anyone but me, but since I've had the patch
> sitting around for a couple of years, here it is...
>
> 2014-02-07  Jon TURNEY  <jon.turney@dronecode.org.uk>
>
> 	* minidumper.cc: New file.
> 	* Makefile.in (CYGWIN_BINS): Add minidumper.
> 	* utils.xml (minidumper): New section.
>
