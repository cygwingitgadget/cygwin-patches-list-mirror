Return-Path: <cygwin-patches-return-4386-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32460 invoked by alias); 14 Nov 2003 20:31:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32425 invoked from network); 14 Nov 2003 20:31:23 -0000
Message-ID: <3FB53BAE.3000803@cygwin.com>
Date: Fri, 14 Nov 2003 20:31:00 -0000
From: Robert Collins <rbcollins@cygwin.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030723 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
CC:  rdparker@butlermfg.com
Subject: Re: For masochists: the leap o faith
References: <3FB4D81C.6010808@cygwin.com>
In-Reply-To: <3FB4D81C.6010808@cygwin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q4/txt/msg00105.txt.bz2

Robert Collins wrote:

> Ok, so this it for tonight, my bed is calling me.
> 
> If playing with this, be sure to:
> rebuild libc as well as cygwin1.dll.
> be setup to debug cygwin1.dll.
> 
> I don't *think* I've changed the size of the shared stuff, but then 
> again, I'm pretty tired, so I'll believe anything right now.
> 
> My plan is to unbreak cygwin tomorrow, and then work through the list of 
> potentially update-requiring API calls:

Turns out, that we still have a bug with gcc, where registeres are 
trashed when alloca is used to allocate large stack objects.

I posted a test case to the developers list when we where working on -O3 
support ?two? years back - it looks like the same issue.

So, I've dropped CYG_MAX_PATH to 512 in winsup.h, and that makes the dll 
usable. There is an issue with the win32 responses on loong files - but 
at least we can continue progressing.

So, Chris, are there any parts you've seen so far, that you've be happy 
to ok (i.e. the MAX_PATH->CYG_MAX_PATH rename), or the global search and 
replaces to the thunk functions?

As far as applications maing assumptions, unix file systems don't 
guarantee PATH_MAX: thats an upper limit of the OS, applications are 
expected to be able to handle to up to PATH_MAX... but can't expect the 
OS to do so in every case.

Now, for global use of an A or W function, Chris' utf patch which I just 
ran into digging into a INVALID_NAME error, also chose at runtime. I can 
easily alter IOThunkState to always use W if available, and then check a 
cached flag from then on in. I really think that the current overhead 
will be low enough to be a non-issue though.

Rob
