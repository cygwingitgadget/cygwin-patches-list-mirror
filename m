Return-Path: <cygwin-patches-return-4828-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3020 invoked by alias); 4 Jun 2004 16:21:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2980 invoked from network); 4 Jun 2004 16:20:57 -0000
Date: Fri, 04 Jun 2004 16:21:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: XP crash (OT)
Message-ID: <20040604162057.GA3301@coe.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040531184611.0080be60@incoming.verizon.net> <40BF81C4.1020105@att.net> <20040603203500.GA6889@coe.casa.cgf.cx> <20040603221458.GA8514@coe.casa.cgf.cx> <20040603222926.GA8964@coe.casa.cgf.cx> <40BFB018.3090306@att.net> <20040604000801.GA23653@coe.casa.cgf.cx> <40C00D9D.6060202@att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C00D9D.6060202@att.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00180.txt.bz2

On Fri, Jun 04, 2004 at 01:50:21AM -0400, David Fritz wrote:
>Christopher Faylor wrote:
>>On Thu, Jun 03, 2004 at 07:11:20PM -0400, David Fritz wrote:
>>
>>>Christopher Faylor wrote:
>>>
>>>[...]
>>>
>>>>>Interestingly enough, I just added some checking to fhandler_base::open 
>>>>>which
>>>>>used RtlIsDosDeviceName_U.  It caused a reboot of my XP system every 
>>>>>time
>>>>>I tried it.  That's a first for XP.
>>>>
>>>>
>>>>Oops.  No, that was the result of passing garbage to
>>>>InitializeObjectAttributes apparently.  Seems like a pretty serious XP
>>>>bug regardless.
>>>
>>>[...]
>>>
>>>Are you sure?  InitializeObjectAttributes() is a macro.
>>>
>>>How was the garbage being passed?
>
>I ask because I'm interested.  NT showstoppers deserve a little research if 
>you have the time (I do).  So if you remember the specifics, I'd be 
>interested.  If not, thanks anyway.

In fhandler_base::open I just accidentally nuked the call to
pc.get_nt_native_path and ended up passing the random contents of upath
and wpath to (I suppose) NtCreateFile.  *boom*

cgf
