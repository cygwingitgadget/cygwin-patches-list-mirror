Return-Path: <cygwin-patches-return-4450-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21199 invoked by alias); 29 Nov 2003 23:07:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21181 invoked from network); 29 Nov 2003 23:07:24 -0000
Date: Sat, 29 Nov 2003 23:07:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [Patch]: Create Global Privilege
Message-ID: <20031129230722.GB6964@cygbert.vinschen.de>
Mail-Followup-To: Corinna Vinschen <cygwin-patches@cygwin.com>
References: <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net> <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net> <3.0.5.32.20031126104557.00838210@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20031126104557.00838210@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00169.txt.bz2

On Wed, Nov 26, 2003 at 10:45:57AM -0500, Pierre A. Humblet wrote:
> At 03:32 PM 11/26/2003 +0100, Corinna Vinschen wrote:
> >Imagine a sshd service is running on the system.  This service has the
> >SE_CREATE_GLOBAL_NAME privilege and would create the global object on
> >system startup (given the service is in automatic mode).  Other processes
> >would then be able to access the global object, regardless if running in
> >a terminal session or not.  This would keep the process list together,
> >for instance.
> [...]
> The problem with the track you start on is that one can end up with a
> split system, e.g. the cygwin share in global space and a tty in local
> space, invisible to the rest of the system. I am unsure of what can
> happen then. Also the user share could be either global or local, depending
> if a user (or a seteuid process) is already running at the console/service
> at the moment a session starts under Terminal Services. 
> That leads to indeterminate behavior.

If we make sure that the first process started in a process hirarchy
determines where the shared mem is, that shouldn't be a problem.  The
decision should be made only once.

> >Also, shouldn't the prefix variable have a NO_COPY attribute?  If the
> >process setuids and forks, the new process might have different privileges
> >which might or might not result in the need to use a different object
> >name space.
> 
> I think it's OK. forks don't call CreateProcessAsUser and memory_init happens
> early. However I am not 100% sure of what might happen following a seteuid
> (but it won't be worse than before the patch).

My above comment would support the NO_COPY, wouldn't it?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
