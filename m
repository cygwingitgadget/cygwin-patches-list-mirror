Return-Path: <cygwin-patches-return-3258-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2061 invoked by alias); 2 Dec 2002 13:20:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2052 invoked from network); 2 Dec 2002 13:20:49 -0000
Message-ID: <3DEB5E2F.2090507@yahoo.com>
Date: Mon, 02 Dec 2002 05:20:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: egor duda <cygwin-patches@cygwin.com>
Subject: Re: --enable-runtime-pseudo-reloc support in cygwin, take 3.
References: <20021119072016.23A231BF36@redhat.com> <3577371564.20021119120659@logos-m.ru> <1451205547776.20021202133024@logos-m.ru> <1551207829817.20021202140826@logos-m.ru> <3DEB5685.5040200@yahoo.com> <1471214525305.20021202160003@logos-m.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00209.txt.bz2

egor duda wrote:
> Hi!
> 
> Monday, 02 December, 2002 Earnie Boyd earnie_boyd@yahoo.com wrote:
> 
> EB> egor duda wrote:
> 
>>>Monday, 02 December, 2002 egor duda deo@logos-m.ru wrote:
>>>
>>>ed> 2002-12-02  Egor Duda <deo@logos-m.ru>
>>>ed>         * cygwin/lib/pseudo-reloc.c: New file.
>>>
>>>I guess i should put it to the public domain, so that mingw folks can
>>>also use it.
>>>
>>
> 
> EB> Is it usable without Cygwin?
> 
> Yes. It doesn't use any cygwin functionality. Recent binutils should
> export __RUNTIME_PSEUDO_RELOC_LIST__ and __RUNTIME_PSEUDO_RELOC_LIST_END__
> symbols for all PE-based targets, including Mingw.
> 
> I'm not that familiar with Mingw internals, but you just have to
> add a call to _pei386_runtime_relocator() to the application startup
> (to the crt2.o, IIRC) and link with pseudo-reloc.o.
> 

So, should this be a part of binutils instead of Cygwin?

Earnie.
