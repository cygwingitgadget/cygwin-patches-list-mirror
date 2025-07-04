Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 04DBA38515EC; Fri,  4 Jul 2025 08:39:45 +0000 (GMT)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id EB529A80961; Fri, 04 Jul 2025 10:39:42 +0200 (CEST)
Date: Fri, 4 Jul 2025 10:39:42 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
Message-ID: <aGeTTq8wuRumZ3aI@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <aF6N5Ds7jmadgewV@calimero.vinschen.de>
 <7b118296-1d56-0b42-3557-992338335189@jdrake.com>
 <aGJl0crH02tjTIZs@calimero.vinschen.de>
 <5f60e191-e50e-32d3-53cc-903e03cc7a5e@jdrake.com>
 <aGUfpy6cTysuyaId@calimero.vinschen.de>
 <fe6b5e2f-9709-e6fd-6031-1193c7fc8b94@jdrake.com>
 <aGaZq6sSSuNCKX59@calimero.vinschen.de>
 <fcda3f51-7737-5e21-30a9-443f5f4f8c97@jdrake.com>
 <5e4ebc57-cedc-577f-264d-6cc68be6ee99@jdrake.com>
 <aGeQMtwhTueOa4MT@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aGeQMtwhTueOa4MT@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Jul  4 10:26, Corinna Vinschen wrote:
> On Jul  3 12:03, Jeremy Drake via Cygwin-patches wrote:
> > On Thu, 3 Jul 2025, Jeremy Drake via Cygwin-patches wrote:
> > > On Thu, 3 Jul 2025, Corinna Vinschen wrote:
> > > > From the POSIX man page of posix_spawn_file_actions_addchdir:
> > > >
> > > > APPLICATION USAGE
> > > >
> > > >   [...] all file actions are processed in sequence in the context of the
> > > >   child at a point where the child process is still single-threaded
> > > >
> > > >   [...]
> > > >
> > > >   File actions are performed in a new process created by posix_spawn()
> > > >   or posix_spawnp() in the same order that they were added to the file
> > > >   actions object.
> > >
> > > The docs I was reading use "as if", to allow implementations where the
> > > actions are not actually processed in the child.

Oh, btw., I kind of doubt that.  The implementation details required
by posix_spawn are strictly on the POSIX side of things.  POSIX.1
has this to say in the RATIONAL section of posix_spawn:

     The posix_spawn() function and its close relation posix_spawnp()
     have been introduced to overcome the following perceived
     difficulties with fork(): the fork() function is difficult or
     impossible to implement without swapping or dynamic address
     translation.
     * Swapping is generally too slow for a realtime environment.
     * Dynamic address translation is not available everywhere that POSIX
       might be useful.
     * Processes are too useful to simply option out of POSIX whenever it
       must run without address translation or other MMU services.

     Thus, POSIX needs process creation and file execution primitives
     that can be efficiently implemented without address translation or
     other MMU services.

There is no requirement that these functions should be able to be
implemented on non-POSIXy or only marginal POSIXy systems.  The only
time non-POSIXy systems are mentioned are in a comparison:

     [...] posix_spawn() and posix_spawnp() are process creation
     primitives like the Start_Process and Start_Process_Search Ada
     language bindings package POSIX_Process_Primitives and also like
     those in many operating systems that are not UNIX systems, but with
     some POSIX-specific additions.


Corinna
