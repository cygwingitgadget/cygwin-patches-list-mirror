Return-Path: <cygwin-patches-return-3957-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17934 invoked by alias); 13 Jun 2003 06:21:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17840 invoked from network); 13 Jun 2003 06:21:11 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Message-ID: <3EE96D3F.5010303@gmx.net>
Date: Fri, 13 Jun 2003 06:21:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [RFA] enable dynamic (thread safe) reents
References: <Pine.WNT.4.44.0305160915170.1356-200000@algeria.intern.net> <3EC4D5A0.7020005@gmx.net> <20030613031603.GA12302@redhat.com>
In-Reply-To: <20030613031603.GA12302@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00184.txt.bz2

Christopher Faylor wrote:
> On Fri, May 16, 2003 at 02:12:16PM +0200, Thomas Pfaff wrote:
> 
>>Thomas Pfaff wrote:
>>
>>
>>>While single threaded apps should keep run without problems (_impure_ptr
>>>is still used for the mainthread) multithreaded apps should be recompiled
>>>to get the full power of the thread safe reents. This is due the
>>>fact that _RRENT is used in some newlib headers directly. Unfortunately
>>>this affects also static libs, therefore this is will be a longer
>>>transition.
>>>
>>
>>TTTT,
>>
>>this will only affect stdio
>>
>>stdio.h:147:#define     stdin   (_REENT->_stdin)
>>stdio.h:148:#define     stdout  (_REENT->_stdout)
>>stdio.h:149:#define     stderr  (_REENT->_stderr)
>>
>>and i consider this harmless.
> 
> 
> Does this imply that using a DLL rebuilt like this will require recompilation
> of static libraries using errno?
> 

No. errno is handled differently.

#ifndef _REENT_ONLY
#define errno (*__errno())
extern int *__errno _PARAMS ((void));
#endif

and __errno is in newlib implemented as

int *
__errno ()
{
   return &_REENT->_errno;
}

Therefore threads safe errnos are automatically enabled when newlib is 
compiled with __DYNAMIC_REENT__.

Unfortunately stdin, stdout and stderr were defined with _REENT 
directly. Sigh.

Thomas
