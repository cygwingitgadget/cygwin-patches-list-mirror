Return-Path: <cygwin-patches-return-3855-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5655 invoked by alias); 16 May 2003 07:59:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5544 invoked from network); 16 May 2003 07:59:00 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Message-ID: <3EC49A2E.3040008@gmx.net>
Date: Fri, 16 May 2003 07:59:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygpatches <cygwin-patches@cygwin.com>
Subject: Re: [RFA] enable dynamic (thread safe) reents
References: <Pine.WNT.4.44.0305160915170.1356-200000@algeria.intern.net>
In-Reply-To: <Pine.WNT.4.44.0305160915170.1356-200000@algeria.intern.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00082.txt.bz2

Thomas Pfaff wrote:
> 2003-05-16  Thomas Pfaff  <tpfaff@gmx.net>
> 
> 	* include/cygwin/config.h (__DYNAMIC_REENT__): Define.
> 	* include/cygwin/version.h: Bump API minor version.
> 	* cygwin.din: Export __getreent
> 	* cygerrno.h: Include errno.h.
> 	Fix places where _impure_ptr is used directly to store the errno
> 	value.

	* debug.cc (__set_errno): Ditto.

> 	* errno.cc: Remove _RRENT_ONLY define to get errno.cc compiled.
> 	* signal.cc: Rename _reent_clib to _REENT throughout.
> 	* thread.h (reent_clib): Remove prototype.
> 	* thread.cc (reent_clib): Rename reent_clib to __getreent.
> 	Return _impure_ptr until MTinterface is initialized.
> 	(reent_winsup): Fix a possible SEGV when _r == NULL.
> 	Return NULL instead.
> 	* MTinterface::fixup_after_fork: Switch reent back to
>       _impure_ptr
> 	to keep signal handling running when fork is called from a
>       thread other than the mainthread.
