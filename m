Return-Path: <cygwin-patches-return-4644-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2384 invoked by alias); 30 Mar 2004 18:59:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2371 invoked from network); 30 Mar 2004 18:59:28 -0000
X-Authenticated: #623905
Message-ID: <4069C38D.8080701@gmx.net>
Date: Tue, 30 Mar 2004 18:59:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Dr.Volker.Zell@oracle.com: Re: uxterm from xterm-185-3 and xfontsel
 crashing when running under cygserver support]
References: <7168.1080653666@www58.gmx.net> <20040330135514.GI17229@cygbert.vinschen.de> <20040330162402.GB8138@redhat.com>
In-Reply-To: <20040330162402.GB8138@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q1/txt/msg00134.txt.bz2

Christopher Faylor wrote:
> On Tue, Mar 30, 2004 at 03:55:14PM +0200, Corinna Vinschen wrote:
> 
>>On Mar 30 15:34, Thomas Pfaff wrote:
>>>But you can also change cygrunsrv to create a thread via pthread_create and
>>>fork from this thread. This should work either.
>>
>>That's not the way to go, IMO.  It requires *all* Cygwin applications
>>written to be started under SCM to be rewritten.
> Right.  I've been working hard to keep cygwin functional with cygrunsrv
> and SCM.  In fact, I think I've removed the requirement that inetd has
> to fork a process after it calls SCM so that signals are delivered properly.
> 
> Since this is a breaking of backwards compatibility we won't even consider
> changing applications.
> 
> I've read the rest of the thread and know that there is a patch ready but I
> wanted to get these thoughts into the archive.

You can believe me that i did not really considered this as on option.

Thomas

