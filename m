Return-Path: <cygwin-patches-return-3259-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5173 invoked by alias); 2 Dec 2002 13:27:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5104 invoked from network); 2 Dec 2002 13:27:55 -0000
Date: Mon, 02 Dec 2002 05:27:00 -0000
From: egor duda <deo@logos-m.ru>
Reply-To: egor duda <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <190703231.20021202162712@logos-m.ru>
To: Earnie Boyd <earnie_boyd@yahoo.com>
CC: cygwin-patches@cygwin.com
Subject: Re: --enable-runtime-pseudo-reloc support in cygwin, take 3.
In-Reply-To: <3DEB5E2F.2090507@yahoo.com>
References: <20021119072016.23A231BF36@redhat.com>
 <3577371564.20021119120659@logos-m.ru>
 <1451205547776.20021202133024@logos-m.ru>
 <1551207829817.20021202140826@logos-m.ru> <3DEB5685.5040200@yahoo.com>
 <1471214525305.20021202160003@logos-m.ru> <3DEB5E2F.2090507@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00210.txt.bz2

Hi!

Monday, 02 December, 2002 Earnie Boyd earnie_boyd@yahoo.com wrote:

EB> egor duda wrote:
>> Hi!
>> 
>> Monday, 02 December, 2002 Earnie Boyd earnie_boyd@yahoo.com wrote:
>> 
>> EB> egor duda wrote:
>> 
>>>>Monday, 02 December, 2002 egor duda deo@logos-m.ru wrote:
>>>>
>>>>ed> 2002-12-02  Egor Duda <deo@logos-m.ru>
>>>>ed>         * cygwin/lib/pseudo-reloc.c: New file.
>>>>
>>>>I guess i should put it to the public domain, so that mingw folks can
>>>>also use it.
>>>>
>>>
>> 
>> EB> Is it usable without Cygwin?
>> 
>> Yes. It doesn't use any cygwin functionality. Recent binutils should
>> export __RUNTIME_PSEUDO_RELOC_LIST__ and __RUNTIME_PSEUDO_RELOC_LIST_END__
>> symbols for all PE-based targets, including Mingw.
>> 
>> I'm not that familiar with Mingw internals, but you just have to
>> add a call to _pei386_runtime_relocator() to the application startup
>> (to the crt2.o, IIRC) and link with pseudo-reloc.o.
>> 

EB> So, should this be a part of binutils instead of Cygwin?

No. It's a part of runtime environment. It just uses some information
binutils provide.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
