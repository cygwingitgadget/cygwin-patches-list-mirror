Return-Path: <cygwin-patches-return-4625-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13228 invoked by alias); 23 Mar 2004 15:46:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13189 invoked from network); 23 Mar 2004 15:46:41 -0000
Message-ID: <40605BD4.9020306@netscape.net>
Date: Tue, 23 Mar 2004 15:46:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Patch 20040321 for audio recording with /dev/dsp (indented),
 test issues
References: <01C41057.52EAB850.Gerd.Spalink@t-online.de> <20040323110933.GM17229@cygbert.vinschen.de> <20040323151525.GA3150@redhat.com>
In-Reply-To: <20040323151525.GA3150@redhat.com>
X-Enigmail-Version: 0.76.8.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 130.127.121.187
X-SW-Source: 2004-q1/txt/msg00115.txt.bz2

cgf wrote:

> On Tue, Mar 23, 2004 at 12:09:33PM +0100, Corinna Vinschen wrote:
> 
>>Chris, do you have a personally approved set of indent options which
>>give a useful result, perhaps?
> 
> 
> No, I don't use indent very often.
> 
> Gdb has an indent script, though.  I've attached it to this message.  I
> can't confirm or deny if it works well for c++, though.
> 

Indent is really for C code only, so it totally botches C++ 
constructors, destructors, classes, templates, virtuals, and just about 
anything else not C (especially templates).  I was not aware that GNU 
had any style standards for C++-specific code.  But then again, I find 
their standards to be boring, so I really haven't read them.  Like 
Corinna, I usually run it through ident using -gnu and fix it up 
afterwards.  Sometimes, if you pass private, public, class names and 
method names using -T<name1> -T<name2> it won't totally screw up.  It 
still will treat labels (both C++ public/private and C goto) as if they 
were part of a switch statement, indenting them.  Also, you'll want to 
use -T to declare any non-basic typedefs, such as off_t, clock_t, or 
size_t.  If you don't, it will indent a pointer declaration as if it 
were a multiplication statement.  Anyhow, IIRC, I believe these extra 
flags can be stored in a local dot file in the directory of the source 
file being indented (.indent.pro?).

Cheers,
Nicholas
