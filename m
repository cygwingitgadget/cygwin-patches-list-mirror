Return-Path: <cygwin-patches-return-4467-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9370 invoked by alias); 2 Dec 2003 03:56:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9298 invoked from network); 2 Dec 2003 03:56:55 -0000
Message-Id: <3.0.5.32.20031201225546.0082ce20@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Tue, 02 Dec 2003 03:56:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Create Global Privilege
In-Reply-To: <20031130104219.GA10627@cygbert.vinschen.de>
References: <20031129230722.GB6964@cygbert.vinschen.de>
 <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net>
 <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net>
 <3.0.5.32.20031126104557.00838210@incoming.verizon.net>
 <20031129230722.GB6964@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q4/txt/msg00186.txt.bz2

Corinna Vinschen wrote:
>On Sun, Nov 30, 2003 at 12:07:22AM +0100, Corinna Vinschen wrote:
>> On Wed, Nov 26, 2003 at 10:45:57AM -0500, Pierre A. Humblet wrote:
>> > At 03:32 PM 11/26/2003 +0100, Corinna Vinschen wrote:
>> > >Imagine a sshd service is running on the system.  This service has the
>> > >SE_CREATE_GLOBAL_NAME privilege and would create the global object on
>> > >system startup (given the service is in automatic mode).  Other
processes
>> > >would then be able to access the global object, regardless if running in
>> > >a terminal session or not.  This would keep the process list together,
>> > >for instance.
>> > [...]
>> > The problem with the track you start on is that one can end up with a
>> > split system, e.g. the cygwin share in global space and a tty in local
>> > space, invisible to the rest of the system. I am unsure of what can
>> > happen then. Also the user share could be either global or local,
depending
>> > if a user (or a seteuid process) is already running at the
console/service
>> > at the moment a session starts under Terminal Services. 
>> > That leads to indeterminate behavior.
>> 
>> If we make sure that the first process started in a process hirarchy
>> determines where the shared mem is, that shouldn't be a problem.  The
>> decision should be made only once.
>> 
>I've applied the patch which just a minor change to remove the
>`if (!prefix)'.

>However, I think the right thing to do would be to add prefix to
>cygheap_init so that it survives exec(2) calls.

Great Corinna, putting prefix in the cygheap is exactly what I meant to do,
as discussed earlier in the thread. It wasn't in this patch only to keep
it simple.

Below is another small patch to lookup pinfo's in the global name space
when possible.

Also, the utmp/wtmp functions use mutexes to insure safe access.
That creates two problems, particularly on servers:
- When users have private copies of Cygwin with different mounts,
  there can be several utmp/wtmp files. Having a global mutex isn't
  helpful.
- If the utmp/wtmp files are unique, a user may not be have the
  privilege to create a global mutex, so that no mutual protection
  is achieved.
Both problems could be solved very simply by using file locking.
Should I do that some day?

Pierre


2003-12-02  Pierre Humblet <pierre.humblet@ieee.org>

	* pinfo.cc (pinfo::init): Use shared_name to construct the mapname.


Index: pinfo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pinfo.cc,v
retrieving revision 1.92
diff -u -p -r1.92 pinfo.cc
--- pinfo.cc    28 Nov 2003 20:55:58 -0000      1.92
+++ pinfo.cc    2 Dec 2003 01:26:54 -0000
@@ -147,7 +147,7 @@ pinfo::init (pid_t n, DWORD flag, HANDLE
     {
       int created;
       char mapname[CYG_MAX_PATH]; /* XXX Not a path */
-      __small_sprintf (mapname, "cygpid.%x", n);
+      shared_name (mapname, "cygpid", n);
 
       int mapsize;
       if (flag & PID_EXECED)
