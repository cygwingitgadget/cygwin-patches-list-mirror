Return-Path: <cygwin-patches-return-4444-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24251 invoked by alias); 26 Nov 2003 15:48:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24224 invoked from network); 26 Nov 2003 15:48:23 -0000
Message-Id: <3.0.5.32.20031126104557.00838210@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Wed, 26 Nov 2003 15:48:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Create Global Privilege
In-Reply-To: <20031126143204.GN21540@cygbert.vinschen.de>
References: <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net>
 <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q4/txt/msg00163.txt.bz2

At 03:32 PM 11/26/2003 +0100, Corinna Vinschen wrote:
>On Tue, Nov 25, 2003 at 08:55:33PM -0500, Pierre A. Humblet wrote:
>
>I have a problem with this patch.
>
>While the SE_CREATE_GLOBAL_NAME privilege is needed in a terminal session
>to create a global object, it's not needed to *access* a global object,
>right?  Wouldn't it be better, if the functions would try to access the
>global object first, and only if that fails, try to create the object
>according to its privilege?
>
>Imagine a sshd service is running on the system.  This service has the
>SE_CREATE_GLOBAL_NAME privilege and would create the global object on
>system startup (given the service is in automatic mode).  Other processes
>would then be able to access the global object, regardless if running in
>a terminal session or not.  This would keep the process list together,
>for instance.

This has crossed my mind (my first attempt was doing it) but requires more
careful design and the ability to test, which I don't have.
As it is, the patch makes Cygwin functional for non-privileged users
on Terminal Services and doesn't change anything for privileged users. 
Some sysadmins are unwilling (for very good reasons) to give the privilege
to their users, so having a snapshot is useful. It's far from solving
all the issues (which are real, but nobody has complained yet).

The problem with the track you start on is that one can end up with a
split system, e.g. the cygwin share in global space and a tty in local
space, invisible to the rest of the system. I am unsure of what can
happen then. Also the user share could be either global or local, depending
if a user (or a seteuid process) is already running at the console/service
at the moment a session starts under Terminal Services. 
That leads to indeterminate behavior.

The current design results in completely isolated cygwin islands for
non-privileged users, which is exactly what a sysadmin requested and
which is safe. One could argue that systems that want to promote user
interactions and run the cygwin server should give the privilege to the 
users (I am not a sysadmin, I don't use Terminal Services, and I don't 
have strong views either way).
 
>Also, shouldn't the prefix variable have a NO_COPY attribute?  If the
>process setuids and forks, the new process might have different privileges
>which might or might not result in the need to use a different object
>name space.

I think it's OK. forks don't call CreateProcessAsUser and memory_init happens
early. However I am not 100% sure of what might happen following a seteuid
(but it won't be worse than before the patch).


Now I am really off for a while :)

Pierre

