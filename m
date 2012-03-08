Return-Path: <cygwin-patches-return-7620-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4485 invoked by alias); 8 Mar 2012 18:48:42 -0000
Received: (qmail 4474 invoked by uid 22791); 8 Mar 2012 18:48:40 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,TW_CP,T_RP_MATCHES_RCVD,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from mailout09.t-online.de (HELO mailout09.t-online.de) (194.25.134.84)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 08 Mar 2012 18:48:26 +0000
Received: from fwd07.aul.t-online.de (fwd07.aul.t-online.de )	by mailout09.t-online.de with smtp 	id 1S5iO0-00064N-L8; Thu, 08 Mar 2012 19:48:24 +0100
Received: from [192.168.2.108] (EXVUn8ZJohLMvdUUS72gho2bsaAUCjOOXD67wSJr8CuKiVzOJgfjlsMGs0IIa+hZ2j@[79.224.111.44]) by fwd07.t-online.de	with esmtp id 1S5iNy-0Fkjia0; Thu, 8 Mar 2012 19:48:22 +0100
Message-ID: <4F58FEF6.2040004@t-online.de>
Date: Thu, 08 Mar 2012 18:48:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Firefox/10.0.2 SeaMonkey/2.7.2
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: avoid calling strlen() twice in readlink()
References: <CAKw7uVgatdim4-LuANxwv9UL59jc_EizrEKx6wX4DO1RZ+aKmQ@mail.gmail.com> <4F58D059.1090608@redhat.com> <20120308155610.GA646@calimero.vinschen.de>
In-Reply-To: <20120308155610.GA646@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q1/txt/msg00043.txt.bz2

Corinna Vinschen wrote:
> On Mar  8 08:29, Eric Blake wrote:
>> On 03/08/2012 06:37 AM, VÃ¡clav Zeman wrote:
>>> Hi.
>>>
>>> Here is a tiny patch to avoid calling strlen() twice in readlink().
>>>
>>>
>>> -  ssize_t len = min (buflen, strlen (pathbuf.get_win32 ()));
>>> +  size_t pathbuf_len = strlen (pathbuf.get_win32 ());
>>> +  size_t len = MIN (buflen, pathbuf_len);
>>>     memcpy (buf, pathbuf.get_win32 (), len);
>> For that matter, is calling pathbuf.get_win32() twice worth factoring out?
> It's just a const char *pointer, and it's an inline method.  I'm pretty
> sure the compiler will optimize this just fine.
>
>

Yes - and it does ever more:
strlen() is one of the compiler builtins declared with a const attribute 
internally. Then gcc optimizes duplicate calls away.

Testcase:

$ cat opt.cc
#include <string.h>

class X {
   const char * p;
   public:
     X();
     const char * get() { return p; }
};

int f(X & x)
{
   int i = 0;
   i += strlen(x.get());
   i += strlen(x.get());
   i += strlen(x.get());
   i += strlen(x.get());
   i += strlen(x.get());
   return i;
}

int g(X & x)
{
   return 5 * strlen(x.get());
}


$ gcc -S -O2 -fomit-frame-pointer opt.cc

$ cat opt.s | c++filt
...
f(X&):
         subl    $28, %esp
         movl    32(%esp), %eax
         movl    (%eax), %eax
         movl    %eax, (%esp)
         call    _strlen
         addl    $28, %esp
         leal    (%eax,%eax,4), %eax
         ret
...
g(X&):
         subl    $28, %esp
         movl    32(%esp), %eax
         movl    (%eax), %eax
         movl    %eax, (%esp)
         call    _strlen
         addl    $28, %esp
         leal    (%eax,%eax,4), %eax
         ret

(interesting: With -O1 it uses an inline version of strlen, with 
-O2,3,... it doesn't)


So this patch probably had no effect at all, sorry :-)

Christian
