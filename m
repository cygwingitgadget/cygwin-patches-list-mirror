Return-Path: <cygwin-patches-return-3818-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18571 invoked by alias); 16 Apr 2003 00:54:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18517 invoked from network); 16 Apr 2003 00:54:16 -0000
Date: Wed, 16 Apr 2003 00:54:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: hostid patch
Message-ID: <20030416005425.GA16497@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <LPEHIHGCJOAIPFLADJAHCEMJDIAA.chris@atomice.net> <00f301c3038d$0697a760$5c51893e@pomello> <20030415204230.GC13757@redhat.com> <007901c3039e$53216740$7999883e@pomello>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007901c3039e$53216740$7999883e@pomello>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00045.txt.bz2

On Tue, Apr 15, 2003 at 11:28:21PM +0100, Max Bowsher wrote:
>Christopher Faylor wrote:
>> On Tue, Apr 15, 2003 at 09:12:35PM +0100, Max Bowsher wrote:
>>> Chris January wrote:
>>>> *Not* tested on anything other than Windows XP.
>>>>
>>>> Adds gethostid function to Cygwin. Three patches: one for Cygwin, one
>for
>>>> newlib and one for w32api.
>>>> If I've done anything wrong let me know and I'll try to fix it.
>>>
>>> "diff -u" format patches are preferred.
>>
>> Correct, but these applied ok.
>
><pedantic>
>Of course they did! :-)
>Normal diffs don't have any context, so they can't have rejects.
>They can silently apply in the wrong place though. :-(
></pedantic>

<sarcasm>
Duh, gee.  Me not know about this kind of stuff.  Me just type
patch and it not say error.
</sarcasm>

cgf
