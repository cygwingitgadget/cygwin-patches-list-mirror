Return-Path: <cygwin-patches-return-4201-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2167 invoked by alias); 11 Sep 2003 04:15:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2156 invoked from network); 11 Sep 2003 04:15:47 -0000
Date: Thu, 11 Sep 2003 14:08:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fixing a security hole in pinfo.
Message-ID: <20030911041545.GA27495@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030911000542.00818340@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030911000542.00818340@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00218.txt.bz2

On Thu, Sep 11, 2003 at 12:05:42AM -0400, Pierre A. Humblet wrote:
>The flag PID_MAP_RW is added in the few pinfo constructors
>that need to be write into _pinfo if it exists. 
>[snip]
>diff -u -p -r1.166 exceptions.cc
>--- exceptions.cc	10 Sep 2003 17:26:12 -0000	1.166
>+++ exceptions.cc	11 Sep 2003 03:40:57 -0000
>@@ -610,7 +610,7 @@ sig_handle_tty_stop (int sig)
>      its list of subprocesses.  */
>   if (my_parent_is_alive ())
>     {
>-      pinfo parent (myself->ppid);
>+      pinfo parent (myself->ppid, PID_MAP_RW);
>       if (NOTSTATE (parent, PID_NOCLDSTOP))
> 	sig_send (parent, SIGCHLD);
>     }

The above won't need to be RW when I check in my new signal changes.
(Not that there won't be other inheritance type problems)

I'm going to hold off on checking this in until 1.5.4 is released.
Otherwise, it looks ok.

cgf
