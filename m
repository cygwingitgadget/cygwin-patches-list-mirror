Return-Path: <cygwin-patches-return-4455-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2752 invoked by alias); 30 Nov 2003 17:57:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2743 invoked from network); 30 Nov 2003 17:57:55 -0000
Message-ID: <3FCA2F9C.4070207@netscape.net>
Date: Sun, 30 Nov 2003 17:57:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]:  Add flock syscall emulation
References: <Pine.CYG.4.58.0311271409240.1064139@reddragon.clemson.edu> <20031129230104.GA6964@cygbert.vinschen.de>
In-Reply-To: <20031129230104.GA6964@cygbert.vinschen.de>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 130.127.121.187
X-SW-Source: 2003-q4/txt/msg00174.txt.bz2

Corinna wrote:

> On Thu, Nov 27, 2003 at 02:51:10PM -0500, Nicholas Wourms wrote:
> 
>>Hi All,
>>
>>Here is a patch to add the flock() syscall to Cygwin.  I've noticed that some
> 
> 
> Applied with changes.
> 
> I've run indent on flock.c since its formatting was non-GNU.

I can understand why you did it in this case (the tabs were out of 
control), but can we make an exception for bsd/isc-derived code?  I 
think that enforcing this rule strictly on written-from-scratch source 
is ok, but doing it on derived source reduces the overall transparency 
of changes against the upstream version.  Indent in GNU mode will 
practically rewrite every line in just about any BSD source file out 
there, since their formatting style is clearly different.  I'd argue, 
however, that the BSD style is just as clear and readable as the GNU 
style.  For instance, because DJ didn't run localtime.cc through indent, 
resolving the changes in the latest tzdata sources is like 50x easier.

 > I've removed the _DEFUN, since it's nowhere else used in Cygwin.  I've
> added a change message to include/sys/file.h according to the
> licensing terms in include/sys/copying.dj.

The _DEFUN was leftover from when I had been debating about whether to 
add it to newlib or cygwin, but clearly cygwin was the proper choice. 
Thanks for catching that DJ licensing thing, though.

> I removed the _flock from cygwin.din.  This should in future really only be
 > used if newlib expects a new syscall.

As I said, it was mostly an afterthought.

> 
>>As a side note, I noticed that sys/file.h was from DJGPP.  Will DJ allow us to
>>use code from DJGPP in Newlib/Cygwin?  If so, I noticed some code in the DJGPP
>>libc which I could port and use in future contributions.
> 
> This is a question you should ask DJ.  AFAIK, DJGPP is GPLd.  This
> would mean that its code isn't suitable for use in Cygwin itself.

Ok, I'll ask him, though I find it curious that there is DJGPP libc code 
in Cygwin despite this.  I'll also see if he's interested in the changes 
I made.

Thanks for cleaning it up.

Cheers,
Nicholas
