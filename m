Return-Path: <cygwin-patches-return-4461-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26911 invoked by alias); 1 Dec 2003 13:57:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26900 invoked from network); 1 Dec 2003 13:57:35 -0000
Date: Mon, 01 Dec 2003 13:57:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Create Global Privilege
Message-ID: <20031201135734.GA2181@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net> <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net> <3.0.5.32.20031126104557.00838210@incoming.verizon.net> <20031129230722.GB6964@cygbert.vinschen.de> <20031201111805.GA28741@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031201111805.GA28741@cygbert.vinschen.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00180.txt.bz2

On Mon, Dec 01, 2003 at 12:18:05PM +0100, Corinna Vinschen wrote:
>On Sun, Nov 30, 2003 at 12:07:22AM +0100, Corinna Vinschen wrote:
>> On Wed, Nov 26, 2003 at 10:45:57AM -0500, Pierre A. Humblet wrote:
>> > At 03:32 PM 11/26/2003 +0100, Corinna Vinschen wrote:
>> > >Imagine a sshd service is running on the system.  This service has the
>> > >SE_CREATE_GLOBAL_NAME privilege and would create the global object on
>> > >system startup (given the service is in automatic mode).  Other processes
>> > >would then be able to access the global object, regardless if running in
>> > >a terminal session or not.  This would keep the process list together,
>> > >for instance.
>> > [...]
>> > The problem with the track you start on is that one can end up with a
>> > split system, e.g. the cygwin share in global space and a tty in local
>> > space, invisible to the rest of the system. I am unsure of what can
>> > happen then. Also the user share could be either global or local, depending
>> > if a user (or a seteuid process) is already running at the console/service
>> > at the moment a session starts under Terminal Services. 
>> > That leads to indeterminate behavior.
>> 
>> If we make sure that the first process started in a process hirarchy
>> determines where the shared mem is, that shouldn't be a problem.  The
>> decision should be made only once.
>
>I've applied the patch which just a minor change to remove the
>`if (!prefix)'.
>
>However, I think the right thing to do would be to add prefix to
>cygheap_init so that it survives exec(2) calls.
>
>Chris, any problem with this?  It's another 8 bytes...

No, no problems with this.

cgf
