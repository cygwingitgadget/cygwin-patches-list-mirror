Return-Path: <cygwin-patches-return-4468-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24628 invoked by alias); 2 Dec 2003 04:06:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24566 invoked from network); 2 Dec 2003 04:06:09 -0000
Date: Tue, 02 Dec 2003 04:06:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Create Global Privilege
Message-ID: <20031202040608.GA32358@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20031129230722.GB6964@cygbert.vinschen.de> <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net> <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net> <3.0.5.32.20031126104557.00838210@incoming.verizon.net> <20031129230722.GB6964@cygbert.vinschen.de> <3.0.5.32.20031201225546.0082ce20@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20031201225546.0082ce20@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00187.txt.bz2

On Mon, Dec 01, 2003 at 10:55:46PM -0500, Pierre A. Humblet wrote:
>Corinna Vinschen wrote:
>>On Sun, Nov 30, 2003 at 12:07:22AM +0100, Corinna Vinschen wrote:
>>> On Wed, Nov 26, 2003 at 10:45:57AM -0500, Pierre A. Humblet wrote:
>>> > At 03:32 PM 11/26/2003 +0100, Corinna Vinschen wrote:
>>> > >Imagine a sshd service is running on the system.  This service has the
>>> > >SE_CREATE_GLOBAL_NAME privilege and would create the global object on
>>> > >system startup (given the service is in automatic mode).  Other
>processes
>>> > >would then be able to access the global object, regardless if running in
>>> > >a terminal session or not.  This would keep the process list together,
>>> > >for instance.
>>> > [...]
>>> > The problem with the track you start on is that one can end up with a
>>> > split system, e.g. the cygwin share in global space and a tty in local
>>> > space, invisible to the rest of the system. I am unsure of what can
>>> > happen then. Also the user share could be either global or local,
>depending
>>> > if a user (or a seteuid process) is already running at the
>console/service
>>> > at the moment a session starts under Terminal Services. 
>>> > That leads to indeterminate behavior.
>>> 
>>> If we make sure that the first process started in a process hirarchy
>>> determines where the shared mem is, that shouldn't be a problem.  The
>>> decision should be made only once.
>>> 
>>I've applied the patch which just a minor change to remove the
>>`if (!prefix)'.
>
>>However, I think the right thing to do would be to add prefix to
>>cygheap_init so that it survives exec(2) calls.
>
>Great Corinna, putting prefix in the cygheap is exactly what I meant to do,
>as discussed earlier in the thread. It wasn't in this patch only to keep
>it simple.
>
>Below is another small patch to lookup pinfo's in the global name space
>when possible.

One might wonder why I, the author of shared_name, didn't use shared_name
to begin with...  I'm pretty sure I had a good reason but it escapes me
at the moment.

>Also, the utmp/wtmp functions use mutexes to insure safe access.
>That creates two problems, particularly on servers:
>- When users have private copies of Cygwin with different mounts,

i.e., an unsupported installation.

cgf

>Index: pinfo.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/pinfo.cc,v
>retrieving revision 1.92
>diff -u -p -r1.92 pinfo.cc
>--- pinfo.cc    28 Nov 2003 20:55:58 -0000      1.92
>+++ pinfo.cc    2 Dec 2003 01:26:54 -0000
>@@ -147,7 +147,7 @@ pinfo::init (pid_t n, DWORD flag, HANDLE
>     {
>       int created;
>       char mapname[CYG_MAX_PATH]; /* XXX Not a path */
>-      __small_sprintf (mapname, "cygpid.%x", n);
>+      shared_name (mapname, "cygpid", n);
> 
>       int mapsize;
>       if (flag & PID_EXECED)
