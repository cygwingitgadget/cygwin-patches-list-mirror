Return-Path: <cygwin-patches-return-3965-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20978 invoked by alias); 16 Jun 2003 06:37:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20945 invoked from network); 16 Jun 2003 06:37:35 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Message-ID: <3EED65A4.7010703@gmx.net>
Date: Mon, 16 Jun 2003 06:37:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [RFA] enable dynamic (thread safe) reents
References: <Pine.WNT.4.44.0305160915170.1356-200000@algeria.intern.net> <3EC4D5A0.7020005@gmx.net> <20030613031603.GA12302@redhat.com> <3EE96D3F.5010303@gmx.net> <20030616032457.GA10910@redhat.com>
In-Reply-To: <20030616032457.GA10910@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00192.txt.bz2

Christopher Faylor wrote:
> On Fri, Jun 13, 2003 at 08:20:47AM +0200, Thomas Pfaff wrote:
> 
>>Unfortunately stdin, stdout and stderr were defined with _REENT 
>>directly. Sigh.
> 
> 
> I've checked in this patch.  I'll ask again if it makes sense
> to fix this problem in newlib.  Does it?
> 

It is a little late for cygwin, but i would suggest to change stdin, out 
and err to

#define stdin (*__stdin())
extern  __FILE **__stdin _PARAMS ((void));

and implement as

__FILE **
__stdin ()
{
   return &_REENT->_stdin;
}

Same for stdout and err. This would allow to define and undefine 
__DYNAMIC_REENT__ without recompiling all user apps. And _getreent must 
not be exported.
I think that this is cleaner.

Thomas

