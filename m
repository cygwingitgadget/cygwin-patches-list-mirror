Return-Path: <cygwin-patches-return-4205-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9408 invoked by alias); 11 Sep 2003 04:47:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9398 invoked from network); 11 Sep 2003 04:47:02 -0000
Date: Thu, 11 Sep 2003 15:23:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fixing a security hole in pinfo.
Message-ID: <20030911044701.GA31314@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030911000542.00818340@incoming.verizon.net> <3.0.5.32.20030911000542.00818340@incoming.verizon.net> <3.0.5.32.20030911002700.00824d50@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030911002700.00824d50@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00223.txt.bz2

On Thu, Sep 11, 2003 at 12:27:00AM -0400, Pierre A. Humblet wrote:
>At 12:15 AM 9/11/2003 -0400, you wrote:
>>On Thu, Sep 11, 2003 at 12:05:42AM -0400, Pierre A. Humblet wrote:
>>>The flag PID_MAP_RW is added in the few pinfo constructors
>>>that need to be write into _pinfo if it exists. 
>>>[snip]
>>>diff -u -p -r1.166 exceptions.cc
>>>--- exceptions.cc	10 Sep 2003 17:26:12 -0000	1.166
>>>+++ exceptions.cc	11 Sep 2003 03:40:57 -0000
>>>@@ -610,7 +610,7 @@ sig_handle_tty_stop (int sig)
>>>      its list of subprocesses.  */
>>>   if (my_parent_is_alive ())
>>>     {
>>>-      pinfo parent (myself->ppid);
>>>+      pinfo parent (myself->ppid, PID_MAP_RW);
>>>       if (NOTSTATE (parent, PID_NOCLDSTOP))
>>> 	sig_send (parent, SIGCHLD);
>>>     }
>>
>>The above won't need to be RW when I check in my new signal changes.
>>(Not that there won't be other inheritance type problems)
>
>Yep, I kind of suspected that, but it's still needed now.
>I count on your solution to solve the issue of seteuid'ed children.
>In fact, does your solution ever write to a remote _pinfo? 
>The PID_MAP_RW flag may have a very short life!

The parent still needs to write status flags (as in proc_subproc) in its
children processes doesn't it?  Is that an issue here?  Otherwise,
you're right.  I think that only parent processes will need to open this
read/write.  I suspect there's still a security hole there, somewhere.

cgf
