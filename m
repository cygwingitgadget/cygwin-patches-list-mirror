Return-Path: <cygwin-patches-return-3817-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32483 invoked by alias); 15 Apr 2003 22:28:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32474 invoked from network); 15 Apr 2003 22:28:28 -0000
Message-ID: <007901c3039e$53216740$7999883e@pomello>
From: "Max Bowsher" <maxb@ukf.net>
To: <cygwin-patches@cygwin.com>
References: <LPEHIHGCJOAIPFLADJAHCEMJDIAA.chris@atomice.net> <00f301c3038d$0697a760$5c51893e@pomello> <20030415204230.GC13757@redhat.com>
Subject: Re: hostid patch
Date: Tue, 15 Apr 2003 22:28:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2003-q2/txt/msg00044.txt.bz2

Christopher Faylor wrote:
> On Tue, Apr 15, 2003 at 09:12:35PM +0100, Max Bowsher wrote:
>> Chris January wrote:
>>> *Not* tested on anything other than Windows XP.
>>>
>>> Adds gethostid function to Cygwin. Three patches: one for Cygwin, one
for
>>> newlib and one for w32api.
>>> If I've done anything wrong let me know and I'll try to fix it.
>>
>> "diff -u" format patches are preferred.
>
> Correct, but these applied ok.

<pedantic>
Of course they did! :-)
Normal diffs don't have any context, so they can't have rejects.
They can silently apply in the wrong place though. :-(
</pedantic>


Max.
