Return-Path: <cygwin-patches-return-4389-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1904 invoked by alias); 14 Nov 2003 22:07:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1877 invoked from network); 14 Nov 2003 22:07:12 -0000
Date: Fri, 14 Nov 2003 22:07:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: For masochists: the leap o faith
Message-ID: <20031114220708.GA26100@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3FB4D81C.6010808@cygwin.com> <3FB53BAE.3000803@cygwin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB53BAE.3000803@cygwin.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00108.txt.bz2

On Sat, Nov 15, 2003 at 07:31:42AM +1100, Robert Collins wrote:
>Robert Collins wrote:
>
>>Ok, so this it for tonight, my bed is calling me.
>>
>>If playing with this, be sure to:
>>rebuild libc as well as cygwin1.dll.
>>be setup to debug cygwin1.dll.
>>
>>I don't *think* I've changed the size of the shared stuff, but then 
>>again, I'm pretty tired, so I'll believe anything right now.
>>
>>My plan is to unbreak cygwin tomorrow, and then work through the list of 
>>potentially update-requiring API calls:
>
>Turns out, that we still have a bug with gcc, where registeres are 
>trashed when alloca is used to allocate large stack objects.
>
>I posted a test case to the developers list when we where working on -O3 
>support ?two? years back - it looks like the same issue.

This problem is fixed in the gcc cvs trunk.  I've asked Danny and Gerrit
about backporting the fix to 3.3.2.  It should be trivial to do so.

>So, Chris, are there any parts you've seen so far, that you've be happy 
>to ok (i.e. the MAX_PATH->CYG_MAX_PATH rename), or the global search and 
>replaces to the thunk functions?

I haven't looked at anything in great detail.  This is not the best
possible time for me to be reviewing massive changes to cygwin,
unfortunately.

>As far as applications maing assumptions, unix file systems don't 
>guarantee PATH_MAX: thats an upper limit of the OS, applications are 
>expected to be able to handle to up to PATH_MAX... but can't expect the 
>OS to do so in every case.

It is fairly unusual for PATH_MAX to be many times greater than what
is support by pathconf.

>Now, for global use of an A or W function, Chris' utf patch which I just 
>ran into digging into a INVALID_NAME error, also chose at runtime. I can 
>easily alter IOThunkState to always use W if available, and then check a 
>cached flag from then on in. I really think that the current overhead 
>will be low enough to be a non-issue though.

Sorry but you've lost me.  I don't know what my utf patch is.

For the record, I don't have any problems with changing PATH_MAX to
CYG_PATH_MAX as a first step for this change.  Small steps are, as
always, appreciated.

cgf
